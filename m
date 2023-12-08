Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0BC809702
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444180AbjLHAP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjLHAP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:28 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED9172A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:34 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b3a8366e13so53452739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994533; x=1702599333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5Gf2fb1AFpGALyaBrBoOEEUKTRvi2Ij2/XB6Namp4w=;
        b=PZFVODvzYgrLhq932SkBVLwXo37XO99HeUsVrzAH5yVGx8DK3EYG2DuRWxhAcod3qP
         UKiTvna+W3NJJPBrRsBAOXiUz1MYueRrM9yO25kvFDqjXlk+R9eMsIFggA9V1uzPM5Ps
         zQK3xAGMJQFrULocoZ8UmXGcMkeKb++fyX10ZDH++0JsNEwNa/h4rVYRpNsnySTRGsWl
         Y6G1FCwGPSyBW/lf+HL7cde3yzr/jEeCSNuu0FZcSw4rvnPV2HmUjLC52T6yYDNGw0Iw
         HAzo/0D2UJb/xoV6Ew/sCfit1R15y2ED31e0BgTT2fclItPhN8KshnwmJ54V44nIkR8j
         BA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994533; x=1702599333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5Gf2fb1AFpGALyaBrBoOEEUKTRvi2Ij2/XB6Namp4w=;
        b=phH+gc1jnppNLW0gcHQQO4TzlASbBkY3bxY/wlzzHDVwlASr41PQvGieXIdRRnuWFk
         tzysGXWytXivOsy44y/3eynjXt8moz451vwuAQZjgd0qDhnyxQwPblgw1/Xoc42u1RqR
         uRqgosWWxAed84RS/X9X9YvuOAEuOyJJt9yMs9CdtAxyn2+C9O/asmvEJbO7dsvCO1Vs
         Qnk1vMMYm8IR9OUm4cDG/IS4HqEAM9qdMPdiOWeFqCKvplFZlV6MkXbWBGxDr9HrHy5u
         eV/URNdMpllMiImoIIYCRWRDyD0BMkzhLqQloWKklyjoNZW/5QZ0yfrrL1z/TQYkW1ey
         ealA==
X-Gm-Message-State: AOJu0YxHy201cQt6/RCpmhIVIHyBaIDM+nDpA6xrAh/Z5oZYJccZnv5j
        d0L2AKoJtVNet8HEwvBV54Q=
X-Google-Smtp-Source: AGHT+IG64oKSY1icRf1p0kJkdyHkzKelAzGiKhTPwepsNLT1L/HCXcSb03wQhTGzYwChaJjQcyOCRQ==
X-Received: by 2002:a05:6602:15d4:b0:7b4:28f8:1dfd with SMTP id f20-20020a05660215d400b007b428f81dfdmr3772175iow.28.1701994533712;
        Thu, 07 Dec 2023 16:15:33 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:33 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     lb@semihalf.com, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
        daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
        jbaron@akamai.com, jim.cromie@gmail.com, john.ogness@linutronix.de,
        keescook@chromium.org, pmladek@suse.com, ppaalanen@gmail.com,
        rostedt@goodmis.org, seanpaul@chromium.org,
        sergey.senozhatsky@gmail.com, upstream@semihalf.com,
        vincent.whitchurch@axis.com, yanivt@google.com,
        gregkh@linuxfoundation.org
Subject: [re: PATCH v2 00/15 -  09/11] dyndbg: reduce verbose/debug clutter
Date:   Thu,  7 Dec 2023 17:15:12 -0700
Message-ID: <aab7ecd9f213a890c0d0727438428de97e469fce.1701993656.git.jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701993656.git.jim.cromie@gmail.com>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com> <cover.1701993656.git.jim.cromie@gmail.com>
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

currently, for verbose=3, these are logged for each query

 dyndbg: query 0: <class DRM_UT_CORE +p> mod: <*>
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff
 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch shrinks it to 4 lines:

 dyndbg: query 0: <class D2_CORE +T:foo > on module: <*>
 dyndbg: split into words: "class" "D2_CORE" "+T:foo"
 dyndbg: op='+' flags=0x40 maskp=0xffffffff trace_dest=0x0
 dyndbg: applied: func="" file="" module="" format="" lineno=0-0 class=D2_CORE

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0ca3ba9e2032..fc903e90ea0d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -845,7 +845,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		 */
 		query->module = modname;
 
-	vpr_info_dq(query, "parsed");
 	return 0;
 }
 
@@ -870,7 +869,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -890,7 +888,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x, trace_dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -906,7 +903,8 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x trace_dest=0x%x\n",
+		  op, modifiers->flags, modifiers->mask, modifiers->trace_dst);
 
 	return 0;
 }
-- 
2.43.0

