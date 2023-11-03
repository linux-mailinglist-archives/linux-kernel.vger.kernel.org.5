Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE5E7E0364
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377641AbjKCNKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjKCNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B483
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso2858580e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017021; x=1699621821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=362uKh5thKodTsSqUkKccYKgkHYaZgwTi2ojZA+0hQQ=;
        b=pOdj9leRX+4Y4ZCb1PCbBEcNhqrce4XUb9lrYfHGNG1e5ATcokTjf82QqN8f6Mq/f8
         xB8S6MX4RvvGCqkL3DfeyBA2j8DjdPJXM7PC7CRzV/3fCdE0eIzC2ZfRluh5TdaFfZ3K
         CLXeR/BniTpls+Pkpcj45zV/qjfkPulTW9RaAuXh9qS6tL8wtnAuOPEkC6Qo2ZZT6UWx
         5erm87jIHN17OHlJ1IbUJMx5cs0w1x/jHtYYNT4ItZ0HSEvcdXs4hl84O58moHluO3lK
         H0bVi70TlW3YmR/QnWBiVYMeYM70BS1QEnO1GniXAyvB4FocUQaKIuo32KfcSD5sgn8g
         yJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017021; x=1699621821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=362uKh5thKodTsSqUkKccYKgkHYaZgwTi2ojZA+0hQQ=;
        b=BLFEEind69VFje7ZVqP1QfZt0njj9x13d869SWEP/MkBw2520JpDfvir3SKqyAHuWr
         x1/+vBGZpUD8UYSEohl5+t5A0yZABjLBZMA4PA0IYs+VHrG6MSXHzi2NzTPPQXIA/+hJ
         zVWk5BmhsYJKXU8vDZ3iyF51TXeVJ7qaQVa3b5oUMCfsLzQMCMa3/92N4vu1tdo0ePUJ
         IFlrwFW7zQj98yJaSCe6+oO9q7HvFSHgqS3Vd1dLU7x9Cvk6+6TcwnKgdsS68ffLPDXY
         NGWJFuQM8MC1rtIXtoh0DXAz64kTooaJnCFPDkjUkg+L/uRJffRlcJGqZSh/GDIb1lU3
         CZNw==
X-Gm-Message-State: AOJu0YyH1jKQM2dAAt20kPJHSQjwaOJ6CrJeKIDP09SLZHDhpP6Hgp0+
        pYUnpyfMn32sNxLDcciE6+nFESZINV2N4KtA5sJz
X-Google-Smtp-Source: AGHT+IFT066k55t3iRFJhgHYAe3uu9kJzeoLRIL6+WxQNbNGd5ibZlkro5xxwEKreXLWfkhmTRa2OQ==
X-Received: by 2002:a05:6512:3e12:b0:509:488b:4de4 with SMTP id i18-20020a0565123e1200b00509488b4de4mr5540331lfv.1.1699017021108;
        Fri, 03 Nov 2023 06:10:21 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:20 -0700 (PDT)
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
        upstream@semihalf.com
Subject: [PATCH v1 06/12] trace: use TP_printk_no_nl in dyndbg:prdbg,devdbg
Date:   Fri,  3 Nov 2023 14:10:05 +0100
Message-Id: <20231103131011.1316396-7-lb@semihalf.com>
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

Recently added dyndbg events: prdbg, devdbg have code to strip the
trailing newline, if its there.  Drop that trimming (minimally), and
use the new TP_printk_no_nl macro instead.  Also converting to a
vstring is deferred for now.

This use is slightly premature/overkill, since some pr_debugs do not
have the expected trailing newline.  While those lacks are arguably
bugs, this doesn't fix them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/trace/events/dyndbg.h | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/dyndbg.h b/include/trace/events/dyndbg.h
index ccc5bcb070f9..91dcdbe059c0 100644
--- a/include/trace/events/dyndbg.h
+++ b/include/trace/events/dyndbg.h
@@ -20,20 +20,10 @@ TRACE_EVENT(prdbg,
 
 	    TP_fast_assign(
 			__entry->desc = desc;
-			/*
-			 * Each trace entry is printed in a new line.
-			 * If the msg finishes with '\n', cut it off
-			 * to avoid blank lines in the trace.
-			 */
-			if (len > 0 && (text[len - 1] == '\n'))
-				len -= 1;
-
 			memcpy(__get_str(msg), text, len);
-			__get_str(msg)[len] = 0;
 		    ),
 
-	    TP_printk("%s.%s %s", __entry->desc->modname,
-		      __entry->desc->function, __get_str(msg))
+	    TP_printk_no_nl("%s", __get_str(msg))
 );
 
 /* capture dev_dbg() callsite descriptor, device, and message */
@@ -52,20 +42,10 @@ TRACE_EVENT(devdbg,
 	    TP_fast_assign(
 			__entry->desc = desc;
 			__entry->dev = (struct device *) dev;
-			/*
-			 * Each trace entry is printed in a new line.
-			 * If the msg finishes with '\n', cut it off
-			 * to avoid blank lines in the trace.
-			 */
-			if (len > 0 && (text[len - 1] == '\n'))
-				len -= 1;
-
 			memcpy(__get_str(msg), text, len);
-			__get_str(msg)[len] = 0;
 		    ),
 
-	    TP_printk("%s.%s %s", __entry->desc->modname,
-		      __entry->desc->function, __get_str(msg))
+	    TP_printk_no_nl("%s", __get_str(msg))
 );
 
 #endif /* _TRACE_DYNDBG_H */
-- 
2.42.0.869.gea05f2083d-goog

