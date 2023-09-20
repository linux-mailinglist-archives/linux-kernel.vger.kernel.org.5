Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428527A7A28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjITLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjITLMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:12:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A262C2;
        Wed, 20 Sep 2023 04:12:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A12C433C7;
        Wed, 20 Sep 2023 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695208320;
        bh=uHc4UgrN4XzoKh+DGF1PQDJ1c4JYNlGD5zoJ/jU3kDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwXGJYWnSHSBpKSFpLRbmdPXk99ikPurTLFEfQ+M+ZLK1VFlSNbhCnZ4rla+gvNfI
         i+l0nhxQCLJEpL28IZL2HcPXHYxnM1n7RLlAMcKyCauZMpChodHq2LKVvUjhIBcIOO
         fEinuKB8rxps4rQ2sL+gqnxUu9AuJlnoqJq808N4=
Date:   Wed, 20 Sep 2023 13:11:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        adobriyan@gmail.com, sjitindarsingh@gmail.com,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Baoquan He <bhe@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH stable 5.10.y] proc: fix a dentry lock race between
 release_task and lookup
Message-ID: <2023092048-posting-unlit-4734@gregkh>
References: <20230919233335.170835-1-surajjs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919233335.170835-1-surajjs@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 04:33:35PM -0700, Suraj Jitindar Singh wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> commit d919a1e79bac890421537cf02ae773007bf55e6b upstream.
> 
> Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> moved proc_flush_task() behind __exit_signal().  Then, process systemd can
> take long period high cpu usage during releasing task in following
> concurrent processes:
> 
>   systemd                                 ps
> kernel_waitid                 stat(/proc/tgid)
>   do_wait                       filename_lookup
>     wait_consider_task            lookup_fast
>       release_task
>         __exit_signal
>           __unhash_process
>             detach_pid
>               __change_pid // remove task->pid_links
>                                      d_revalidate -> pid_revalidate  // 0
>                                      d_invalidate(/proc/tgid)
>                                        shrink_dcache_parent(/proc/tgid)
>                                          d_walk(/proc/tgid)
>                                            spin_lock_nested(/proc/tgid/fd)
>                                            // iterating opened fd
>         proc_flush_pid                                    |
>            d_invalidate (/proc/tgid/fd)                   |
>               shrink_dcache_parent(/proc/tgid/fd)         |
>                 shrink_dentry_list(subdirs)               ↓
>                   shrink_lock_dentry(/proc/tgid/fd) --> race on dentry lock
> 
> Function d_invalidate() will remove dentry from hash firstly, but why does
> proc_flush_pid() process dentry '/proc/tgid/fd' before dentry
> '/proc/tgid'?  That's because proc_pid_make_inode() adds proc inode in
> reverse order by invoking hlist_add_head_rcu().  But proc should not add
> any inodes under '/proc/tgid' except '/proc/tgid/task/pid', fix it by
> adding inode into 'pid->inodes' only if the inode is /proc/tgid or
> /proc/tgid/task/pid.
> 
> Performance regression:
> Create 200 tasks, each task open one file for 50,000 times. Kill all
> tasks when opened files exceed 10,000,000 (cat /proc/sys/fs/file-nr).
> 
> Before fix:
> $ time killall -wq aa
>   real    4m40.946s   # During this period, we can see 'ps' and 'systemd'
> 			taking high cpu usage.
> 
> After fix:
> $ time killall -wq aa
>   real    1m20.732s   # During this period, we can see 'systemd' taking
> 			high cpu usage.
> 
> Link: https://lkml.kernel.org/r/20220713130029.4133533-1-chengzhihao1@huawei.com
> Fixes: 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216054
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ bp: Context adjustments ]
> Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>

both now queued up, thanks.

greg k-h
