Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA6D7E0363
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377623AbjKCNKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjKCNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411DD44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507975d34e8so2868423e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017020; x=1699621820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1hLBvLmxlsarhNkg045kA4R/S40xhthmR4CQ92gt1U=;
        b=CPN9tCW4kuzleWO+1i/XGz6m3ZDLioOgoh5kBOy5gn+ZsHsJy1MJJ+wMbQTvSOQ4eK
         iAg6BUUZiaWCk4XjLw85XFsj/B+0x3Xo9iu4UCmQ3JHelmj82gO4sWdB0TWvXLKOrErA
         rry3r0+EQt0WOemNeNTpA16GEfds1OJ4Gt9+yrQgFBG6bbTLD12IegL0hHg7qGnfoGfw
         2klSsHXIYI2ooqXU8plIgBrQG8+9ij9lwE4BcHbGu1c9pTzQgRpWYdRPceFUEKCQ9lx8
         YGCpFiGbUKAIJzFkc8jD+gMb4wEW+6j544BfEBF1JIsY3GmEDe042Pv7LmPT5jxTP7fh
         Cp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017020; x=1699621820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1hLBvLmxlsarhNkg045kA4R/S40xhthmR4CQ92gt1U=;
        b=xLuhBaEG9zNHepPyeJS8Ier/UekVtf6R7Eg+gwvalApD6WFNewFH7aLasFtabhG1ie
         f+MHCmbcb3bjkoZnDMlhf4dWlm6BlXIV4HTuMRbz9NGrkSAu5yf6p050aPp3Fa2x1vJ8
         X9CJ9+DD5RhRirHJLLn4irMZVs5zfMDLv2tLWgE+3mIyPX/peCZOpQMYlXTiISGgEvvT
         ba/gdEU8fc9HXWf4VceNpuFxgDhL3LB1LiJfKWUjn6fT9/tPYb2X+GcASzPKlDznwmI0
         2I1VBDsOZEDzblOKCkcQdafQ2IhFn6Stgxl+2th0AP5Y6HnaZfSvA7nC9SWHs/d2Y0fy
         iFKg==
X-Gm-Message-State: AOJu0Yxeotjo4gH71GmF/64YiaUtFJjI0WScA68hlsFwPpguQwL2aPWb
        uKiSznVBQvwDq8UTytf6KhGg
X-Google-Smtp-Source: AGHT+IH2scTAuhVH9MtIF0BPPwbGKKY1k6lgQKh/oeZwWn+jlMZchiS8DO/dkPDeYMOxKQpDa/SF4Q==
X-Received: by 2002:a05:6512:10d6:b0:4fb:9168:1fce with SMTP id k22-20020a05651210d600b004fb91681fcemr20368234lfg.59.1699017020190;
        Fri, 03 Nov 2023 06:10:20 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:19 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, john.ogness@linutronix.de,
        Simon Ser <contact@emersion.fr>
Subject: [PATCH v1 05/12] tracefs: add TP_printk_no_nl - RFC
Date:   Fri,  3 Nov 2023 14:10:04 +0100
Message-Id: <20231103131011.1316396-6-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
In-Reply-To: <20231103131011.1316396-1-lb@semihalf.com>
References: <20231103131011.1316396-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Cromie <jim.cromie@gmail.com>

This variant of TP_printk() does *not* add the trailing newline.  It
is for use by printk/debug-ish events which already have a trailing
newline.  Its here to support:

https://lore.kernel.org/lkml/
20200825153338.17061-1-vincent.whitchurch@axis.com/
which taught dyndbg to send pr_debug() msgs to tracefs, via -x/T flag.

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
2.42.0.869.gea05f2083d-goog

