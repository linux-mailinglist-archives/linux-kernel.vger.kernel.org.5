Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C07EE3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbjKPPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345373AbjKPPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:06:38 -0500
Received: from p3plwbeout17-05.prod.phx3.secureserver.net (p3plsmtp17-05-2.prod.phx3.secureserver.net [173.201.193.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9519D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:06:34 -0800 (PST)
Received: from mailex.mailcore.me ([94.136.40.141])
        by :WBEOUT: with ESMTP
        id 3dwtrfFAhvZgf3dwurp2ES; Thu, 16 Nov 2023 08:06:32 -0700
X-CMAE-Analysis: v=2.4 cv=a8D1SWeF c=1 sm=1 tr=0 ts=65562ffa
 a=bheWAUFm1xGnSTQFbH9Kqg==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=BNY50KLci1gA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=FXvPX3liAAAA:8 a=PL5bajTykxBvxVk0eB4A:9 a=AjGcO6oz07-iQ99wixmX:22
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  3dwtrfFAhvZgf
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp04.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1r3dwt-00087x-95; Thu, 16 Nov 2023 15:06:31 +0000
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     eadavis@qq.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        squashfs-devel@lists.sourceforge.net,
        syzbot+604424eb051c2f696163@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] squashfs: fix oob in squashfs_readahead
Date:   Thu, 16 Nov 2023 15:14:24 +0000
Message-Id: <20231116151424.23597-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
References: <tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfB5rOlsiGop8HRtnu0KyA/F2yLCMHDiUDEG5UIulqyatT99bi2VOXEs8vuIFxZy253GAgcp2y6YI8YCPnIU7tKO0bluGutBeM0RAaUz1hSQhQrNkii0Q
 d89UWD78/d01l+wQckM+6EduHaJAnZiE19rjcFOF6yAniL65Zx3BIlE8YjiWcgGSpOYPKqEkYlEV9eqChuZWkOZIs9zgobyBBvE5hFZo4KJzcGrhuPIg8G30
 6+cV38CbR9MEL0WDqPJAHw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [Bug]
> path_openat() called open_last_lookups() before calling do_open() and 
> open_last_lookups() will eventually call squashfs_read_inode() to set 
> inode->i_size, but before setting i_size, it is necessary to obtain file_size 
> from the disk.
> 
> However, during the value retrieval process, the length of the value retrieved
> from the disk was greater than output->length, resulting(-EIO) in the failure of 
> squashfs_read_data(), further leading to i_size has not been initialized, 
> i.e. its value is 0.
> 

NACK

This analysis is completely *wrong*.  First, if there was I/O error reading
the inode it would never be created, and squasfs_readahead() would
never be called on it, because it will never exist.

Second i_size isn't unintialised and it isn't 0 in value.  Where
you got this bogus information from is because in your test patches,
i.e.

https://lore.kernel.org/all/000000000000bb74b9060a14717c@google.com/

You have

+	if (!file_end) {
+		printk("i:%p, is:%d, %s\n", inode, i_size_read(inode), __func__);
+		res = -EINVAL;
+		goto out;
+	}
+

You have used %d, and the result of i_size_read(inode) overflows, giving the
bogus 0 value.

The actual value is 1407374883553280, or 0x5000000000000, which is
too big to fit into an unsigned int.

> This resulted in the failure of squashfs_read_data(), where "SQUASHFS error: 
> Failed to read block 0x6fc: -5" was output in the syz log.
> This also resulted in the failure of squashfs_cache_get(), outputting "SQUASHFS
> error: Unable to read metadata cache entry [6fa]" in the syz log.
> 

NO, *that* is caused by the failure to read some other inodes which
as a result are correctly not created.  Nothing to do with the oops here.

> [Fix]
> Before performing a read ahead operation in squashfs_read_folio() and 
> squashfs_readahead(), check if i_size is not 0 before continuing.
> 

A third NO, it is only 0 because the variable overflowed.

Additionally, let's look at your "fix" here.

> @@ -461,6 +461,11 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>  	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
>  				page->index, squashfs_i(inode)->start);
>  
> +	if (!file_end) {
> +		res = -EINVAL;
> +		goto out;
> +	}
> +

file_end is computed by

	int file_end = i_size_read(inode) >> msblk->block_log;

So your "fix" will reject *any* file less than msblk->block_log in
size as invalid, including perfectly valid zero size files (empty
files are valid too).

I already identified the cause and send a fix patch here:

https://lore.kernel.org/all/20231113160901.6444-1-phillip@squashfs.org.uk/

NACK

Phillip
