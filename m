Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E17D02B1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346448AbjJSTpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJSTp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:45:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3FE8;
        Thu, 19 Oct 2023 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KGIZiCh3I2puEjMBUYwvCQelWbqXwxdHlCPHjymv0t8=; b=cuX6J2ORzOUZ0wbZ2WnmGhDz1F
        VFZ0dGQZrqIqTq6U5/assyPd8ScZNlwZv9gsaOuipu1SsUNsXY9JsJx/OROdrtMKiyiAy0HNPgp/f
        DU9oGjGxlbaFAs3vN3dXbiDMiZb+hzftMPGtqWOOkIMFqhTElYWFIyF23qQjdIzR0ne3KbY5MehtP
        GEQqKNR+SmZ/9ZhqCdFBr+JyGEAU9aBYEpIzhTrkD01ANS6Y1hYcyMcSJErGKXSaF0NIa8mD57ohy
        JIFOfJquScUW42sadjLN9576p829H+45yUdMecK9L0Sd6L/0uHWRnBSyDyRNTfuttyckrpijeaNik
        NhtuZCvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtYxH-008sLH-Qh; Thu, 19 Oct 2023 19:45:15 +0000
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
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/1] Put seq_buf on a diet
Date:   Thu, 19 Oct 2023 20:45:13 +0100
Message-Id: <20231019194514.2115506-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Matthew Wilcox (Oracle) (1):
  trace: Move readpos from seq_buf to trace_seq

 include/linux/seq_buf.h   |  5 +----
 include/linux/trace_seq.h |  2 ++
 kernel/trace/trace.c      | 10 +++++-----
 kernel/trace/trace_seq.c  |  6 +++++-
 lib/seq_buf.c             | 13 +++++--------
 5 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.40.1

