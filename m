Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38A27F62A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbjKWPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346051AbjKWPXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:23:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171010C0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:23:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA4CC433C9;
        Thu, 23 Nov 2023 15:23:33 +0000 (UTC)
Date:   Thu, 23 Nov 2023 10:23:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5] eventfs: Remove eventfs_file and just use
 eventfs_inode
Message-ID: <20231123102349.110e4525@gandalf.local.home>
In-Reply-To: <20231123112548.9603-A-hca@linux.ibm.com>
References: <20231004165007.43d79161@gandalf.local.home>
        <20231117142335.9674-A-hca@linux.ibm.com>
        <20231117143829.9674-B-hca@linux.ibm.com>
        <20231123112548.9603-A-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 12:25:48 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> So, if it helps (this still happens with Linus' master branch):
> 
> create_dir_dentry() is called with a "struct eventfs_inode *ei" (second
> parameter), which points to a data structure where "is_freed" is 1. Then it
> looks like create_dir() returned "-EEXIST". And looking at the code this
> combination then must lead to d_invalidate() incorrectly being called with
> "-EEXIST" as dentry pointer.

I haven't looked too much at the error codes, let me do that on Monday
(it's currently Turkey weekend here in the US).

But could you test this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  trace/core

I have a bunch of fixes in that branch that may fix your issue. I just
finished testing it and plan on pushing it to Linus before the next rc
release.

Thanks!

-- Steve


> 
> Now, I have no idea how the code should work, but it is quite obvious that
> something is broken :)
> 
> Here the dump of the struct eventfs_inode that was passed to
> create_file_dentry() when the crash happened:

