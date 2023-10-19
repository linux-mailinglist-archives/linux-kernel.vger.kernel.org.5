Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF397D04A7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346634AbjJSWJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjJSWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:09:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AFC116
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:09:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E260AC433C8;
        Thu, 19 Oct 2023 22:09:05 +0000 (UTC)
Date:   Thu, 19 Oct 2023 18:09:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        oe-kbuild-all@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kmo@daterainc.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/1] trace: Move readpos from seq_buf to trace_seq
Message-ID: <20231019180904.70e623f1@gandalf.local.home>
In-Reply-To: <202310200523.ggyHvT6w-lkp@intel.com>
References: <20231019194514.2115506-2-willy@infradead.org>
        <202310200523.ggyHvT6w-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 05:59:36 +0800
kernel test robot <lkp@intel.com> wrote:

> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  323) /**
> 9dbbc3b9d09d6d lib/seq_buf.c          Zhen Lei                 2021-07-07  324   * seq_buf_to_user - copy the sequence buffer to user space
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  325)  * @s: seq_buf descriptor
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  326)  * @ubuf: The userspace memory location to copy to
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  327)  * @cnt: The amount to copy

When you resend, I guess you should add the @start as well.

-- Steve

> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  328)  *
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  329)  * Copies the sequence buffer into the userspace memory pointed to
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  330)  * by @ubuf. It starts from the last read position (@s->readpos)
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  331)  * and writes up to @cnt characters or till it reaches the end of
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  332)  * the content in the buffer (@s->len), which ever comes first.
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  333)  *
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  334)  * On success, it returns a positive number of the number of bytes
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  335)  * it copied.
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  336)  *
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  337)  * On failure it returns -EBUSY if all of the content in the
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  338)  * sequence has been already read, which includes nothing in the
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  339)  * sequence (@s->len == @s->readpos).
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  340)  *
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  341)  * Returns -EFAULT if the copy to userspace fails.
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  342)  */
> 9377093a882be0 lib/seq_buf.c          Matthew Wilcox (Oracle   2023-10-19  343) int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25 @344) {
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  345) 	int len;
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  346) 	int ret;
> 3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  347) 
