Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00A768915
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjG3WVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG3WVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:21:41 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D910F2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:21:40 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7907d03b0aeso90640339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690755700; x=1691360500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v6sXvL+4NhCJx1KHyGUnBGwLgagdAPRwzE5mdbZT8XY=;
        b=Tkd4q14qRESRdFYnJY9kblnFhjZ/tWbOiMW3zdK4uKrWZol5LSkDkmdbbEa6kxHPxD
         MUN5lmdzRxhOJ01lgiiWU7zWaQB4LnVAiA7sWLGB5ahhwEKgr1FtDmy70fRNBgz2Jd9F
         g3NjYcISXfsAH4yLnrskPQ5cLONz+n5+1Q55EpXt4mGpqGnxS1NJRr6eAG90bAn6GyTZ
         XxjM6AKeUTSeRiLzA439n3Z8+uCxPzN381ES7M0T1oo3zTLdoX/6kpGapcnIiH2HFHN/
         QsKkYe2IpUpwWLKQaX825z7WOe04JtnWzOZ3aCS7tm7doU7OX2RFRUY/68XRGNpz331u
         vMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690755700; x=1691360500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6sXvL+4NhCJx1KHyGUnBGwLgagdAPRwzE5mdbZT8XY=;
        b=HlXn2Dhh4VbU0sYqt1h/TnwTY6LCiOENpryc1MZyy1UmnKFJBi75iQQoNQdu+7kjiF
         zCtygRsYZFJEXpydhpGQtnGxqTEhwYiwXV3Z1t8Pl8xrDsRRX2HQ2MYJ4Hiq+1NUI/Ik
         bU5PEBPoN83hy94ExcFQWaHWxrUHyX4LpPFgQ1qJKkIBn+aD2HY068UZucFlh2ouVt53
         6519H0G0VcHat955mctR1J+f51mWO89ktCSCGRenyucJtOUFVTvqCEj4dLFD59MKTRNB
         kcjwyhh1vgxLxMvB5fYggWel2VpHS5e/FnFCzI4bB9h6v/rt/+QETT3OjYVdvqX3tcBE
         FPYg==
X-Gm-Message-State: ABy/qLa1aaFPsV7i6kgy/XSE6gQbvd1Zu8VXXHKlXyeL2n2whjlyE1ic
        i5ix/zinPAbff0h5R27EzLY=
X-Google-Smtp-Source: APBJJlEq/Ivdg83ATcdfAZ3UV1J/9BE7R9wNgAz0g01K9W//Ha3hsiLUoR3+MCXe4P0YQq8K2Y5aVA==
X-Received: by 2002:a5e:9810:0:b0:783:49ec:8115 with SMTP id s16-20020a5e9810000000b0078349ec8115mr6891087ioj.5.1690755699833;
        Sun, 30 Jul 2023 15:21:39 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y11-20020a6bd80b000000b00786582eb9fbsm2801056iob.15.2023.07.30.15.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 15:21:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        daniel@ffwll.ch, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        john.ogness@linutronix.de, Simon Ser <contact@emersion.fr>,
        Sean Paul <seanpaul@chromium.org>
Subject: [RFC PATCH 1/1] tracefs: add TP_printk_no_nl - RFC
Date:   Sun, 30 Jul 2023 16:21:34 -0600
Message-ID: <20230730222134.54547-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variant of TP_printk() does *not* add the trailing newline.

https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchurch@axis.com/

taught dyndbg to send pr_debug() msgs to tracefs, via -x/T flag.

It "reused" the include/trace/events/printk.h console event,
which does the following:

	TP_fast_assign(
		/*
		 * Each trace entry is printed in a new line.
		 * If the msg finishes with '\n', cut it off
		 * to avoid blank lines in the trace.
		 */
		if ((len > 0) && (text[len-1] == '\n'))
			len -= 1;

		memcpy(__get_str(msg), text, len);
		__get_str(msg)[len] = 0;
	),

That trim work could be avoided, *iff* all pr_debug() callers are
known to have no '\n' to strip.  While thats not true for *all*
callsites, it is 99+% true for DRM.debug callsites, and can be made
true for some subsets of prdbg/dyndbg callsites.

WANTED: macros to validate that a literal format-str has or doesn't
have a trailing newline, or to provide or trim trailing newline(s?).
Should be usable in TP_printk* defns, for use in new event defns.

Cc: <rostedt@goodmis.org>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: <daniel@ffwll.ch>
Cc: <pmladek@suse.com>
Cc: <sergey.senozhatsky@gmail.com>
Cc: <john.ogness@linutronix.de>
Cc: Simon Ser <contact@emersion.fr>
Cc: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/trace/stages/stage3_trace_output.h | 3 +++
 include/trace/stages/stage7_class_define.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..5f5c1374fa10 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -8,6 +8,9 @@
 #undef TP_printk
 #define TP_printk(fmt, args...) fmt "\n", args
 
+#undef TP_printk_no_nl
+#define TP_printk_no_nl(fmt, args...) fmt, args
+
 #undef __get_dynamic_array
 #define __get_dynamic_array(field)	\
 		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index bcb960d16fc0..8247e4478f19 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -37,3 +37,6 @@
 
 #undef TP_printk
 #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
+
+#undef TP_printk_no_nl
+#define TP_printk_no_nl(fmt, args...) "\"" fmt "\", "  __stringify(args)
-- 
2.41.0

