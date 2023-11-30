Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF97FFF9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377382AbjK3Xla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377348AbjK3Xl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521010E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9fa2714e828so214648566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387691; x=1701992491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUSou8Y9ftMqf1PK2crHmzfoy35Q5/lR0Dintg0xKiY=;
        b=Ee9srPmwlV6fdxvXNR5bmxtguX+6J3llt1jRsWEJbiO0cRjkdzIpYcx0Gl2vrkPWGT
         xQ8L6rVgS/z1r647hniawq3ZIPhYt8Rz4iYyudFBYSG3qVemPr/ejK2hjLVlFX1AvXax
         y6/IPqTZHeCN1RvZZcdNfGnmzY92PFPIDXhnyHPu8K1AWaEvjD/+vCNSfRsfjZhxMVeN
         9OWsTReahmWLDufof35Dzr23HYAEwZYb6bNX78DL8yWNRGOTLJqIZ+HE/eivwfNU0IoV
         shxAJwe6v/Uh63efCHvascVqLUs5fOneJi6EuoG0OAilAdcdfnIIBqTl0SYR2xeIYuJo
         /07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387691; x=1701992491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUSou8Y9ftMqf1PK2crHmzfoy35Q5/lR0Dintg0xKiY=;
        b=fzsgoEVEMfgFTIsUB5kGHJAzP34gyGZo6cgauRMFsgO9FFSA3PX6f6BBsH/gpeUAhQ
         ZXhWUsrnjaace2Ehb1pjHkLHJ0ZxumW4CyGCBfFNTPCZ5qg9SRFOMCSMT5n3QJoCUYpo
         9hmNpOVjp4ssPaibofnCgKSNt62HhfUlOIPeomUd8VwAMtFcLx+em6VggkPlzmW1JKAH
         hma72Oewf2KS72Nddps5Upws6eows5WUgms0cD7JGZXwfiP8pz0rxBcITsXS92ILsTNo
         76lCyx4qiBFSik6tKThSMjuuGgGY3DvBAGnpU+20WBMfkZakBX0J5Vcvxv24Vtv41hFm
         aQ0w==
X-Gm-Message-State: AOJu0YwyvzZYxYd+W9qaFxsl2aHPoZ6ToqwWmIMGBsvsE49GdcuXmbL0
        /xybarUw19ONDFBZtVUDA8zu
X-Google-Smtp-Source: AGHT+IFkGWramd2t5xJhUKE8Jp9wBXauti88roVFzzLwDBicH9+vwNIMDElnnVZgXyIse1zMLPq3+Q==
X-Received: by 2002:a17:906:10ca:b0:a19:a19b:55f4 with SMTP id v10-20020a17090610ca00b00a19a19b55f4mr217903ejv.132.1701387691072;
        Thu, 30 Nov 2023 15:41:31 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:30 -0800 (PST)
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
Subject: [PATCH v2 05/15] tracefs: add __get_str_strip_nl - RFC
Date:   Fri,  1 Dec 2023 00:40:38 +0100
Message-ID: <20231130234048.157509-6-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This variant of __get_str() removes the trailing newline. It is for
use by printk/debug-ish events which already have a trailing newline.
It is here to support:

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
               if (len > 0 && (msg[len-1] == '\n'))
                       len -= 1;

               memcpy(__get_str(s), msg, len);
               __get_str(s)[len] = 0;
	),

That trim work could be avoided, *if* all pr_debug() callers are
known to have no '\n' to strip.  While that's not true for *all*
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
Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/trace/stages/stage3_trace_output.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..92a79bd5c0cd 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -19,6 +19,15 @@
 #undef __get_str
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
+#undef __get_str_strip_nl
+#define __get_str_strip_nl(field)					\
+	({								\
+		char *s = __get_str(field);				\
+		size_t len = strlen(s);					\
+		if (len && s[len-1] == '\n')				\
+			s[len-1] = '\0'; s;				\
+	})
+
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)					\
 		((void *)__entry + 					\
-- 
2.43.0.rc2.451.g8631bc7472-goog

