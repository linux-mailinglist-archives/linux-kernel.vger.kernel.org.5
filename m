Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CE7D06F7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346934AbjJTDgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbjJTDgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:36:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E361D6D;
        Thu, 19 Oct 2023 20:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WfKRtL+woloB3dddf3P1CucPKoaPRM2IbXvVDmydebU=; b=qsjanOQ25ZZ+EF8xMP4u3iSGv2
        LZXH6RfOFO6QJagtYHRhDSvtfZorpAQ4l4wZICFB7yDCBzR0D+OpWyKMam9q4JgylqVtYqBh16W4K
        9Bsv9DqudQzPiHj/X6vNJu4jtucJ0aebuDqKbUxS6WNpa7QDcsNbW3oDSzX9SgonObpdcl7TmMzgp
        4ezxo7nPSNjHVH47FuUm1NqjYocKLLu0R5IV0HpvwF9wVzQfJiRgvas6kTvzqMn2J99bbtKbey82g
        iE06uJKW0wYaqDsDfHjngC/DzAeAIV21R1j3OX1Sj0S2+ehKWttDSlDg2Mk6K4tCuSm7A4ooyC8aJ
        xuwZFVTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtgIe-00Ar8z-KN; Fri, 20 Oct 2023 03:35:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] Put seq_buf on a diet
Date:   Fri, 20 Oct 2023 04:35:44 +0100
Message-Id: <20231020033545.2587554-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prompted by the recent mails on ksummit, let's actually try to make this
work this time.  We need a container for manipulating strings easily,
and seq_buf is the closest thing we have to it.  The only problem I have
with it is the readpos that is only useful for the tracing code today.
So move it from the seq_buf to the tracing code.

We should go further with this patch series, including using seq_buf
within vsprintf, but if we can't get over this hurdle first, I'm not
going to waste my time on this again.

v2:
 - Add linux-trace-kernel@vger.kernel.org
 - Fix kernel-doc

Matthew Wilcox (Oracle) (1):
  trace: Move readpos from seq_buf to trace_seq

 include/linux/seq_buf.h   |  5 +----
 include/linux/trace_seq.h |  2 ++
 kernel/trace/trace.c      | 10 +++++-----
 kernel/trace/trace_seq.c  |  6 +++++-
 lib/seq_buf.c             | 22 ++++++++++------------
 5 files changed, 23 insertions(+), 22 deletions(-)

-- 
2.40.1

