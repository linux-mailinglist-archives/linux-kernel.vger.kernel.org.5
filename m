Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B702B7E2EA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjKFVHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjKFVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:07:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB7D76
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:07:35 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699304854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krH2QkxdJALvXRu9Bq+Fw3gs7PqsPIKkUheQqZKkVK0=;
        b=QMdwCTBCqjbEWs3BE4hUb1Y9Hym3aJ4RR2/J7tmD2m4kRWoI3l0B2B2psbP22JClESL9J7
        ZgTv1JSFlm1LMLVKTaFpw7IaDmsVLLf+0+uSwWIoOPLJJXsxF7EQhdtPbqLKfbedcoSYOK
        oHLZo/QR8v6WlnUWfFhhUVBD8elhrD+EvlaYd84rX8j0QT+FjLqTl1eClLY2I6+tVxji0L
        4NQ7PndmDJtqPTPCPnCe7RdXMERG5rqkuhtN6rNzxXPsr2mvRbMxQ5cDtAdiyWDs0DE2e2
        yWxsRwU8mUaCACmX/UKN1m+uk8AwUbGpAK220XDYe7nr8JyAO6G6a2g9XpTAAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699304854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krH2QkxdJALvXRu9Bq+Fw3gs7PqsPIKkUheQqZKkVK0=;
        b=mlP0P/xItlPB8rJI+B2aSLZNJdPxPRLp0Ee10WmEDPUHH+5vxuKYEC22SmOHkCwAKvaP7M
        JLdzZZH1TEVxRECw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 3/9] printk: For @suppress_panic_printk check for other CPU in panic
Date:   Mon,  6 Nov 2023 22:13:24 +0106
Message-Id: <20231106210730.115192-4-john.ogness@linutronix.de>
In-Reply-To: <20231106210730.115192-1-john.ogness@linutronix.de>
References: <20231106210730.115192-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently @suppress_panic_printk is checked along with
non-matching @panic_cpu and current CPU. This works
because @suppress_panic_printk is only set when
panic_in_progress() is true.

Rather than relying on the @suppress_panic_printk semantics,
use the concise helper function other_cpu_in_progress(). The
helper function exists to avoid open coding such tests.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index be95a6851164..22bb45d8f2f2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2270,8 +2270,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.39.2

