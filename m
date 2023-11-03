Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC067E0367
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377663AbjKCNK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjKCNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61596111
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507bd19eac8so2575376e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017022; x=1699621822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc5ZJr+XZL17m3pVsUYEvFhpTqfft7OhKC8WZHCW6XE=;
        b=RmwMeWxBocntJ4o8D4jsOmlsc464F2oBSCW/PHzreT0wdvWku1WmxNbt+5BcSvkNI0
         fYuzQhXi7qeLZQW46f+nM6HW/AOZDnFKjqtDrCvCJ8vktNOpHwU1L9Xvh9itEL8JUd7g
         As60TGBCJ/c7IWKHISJp1hUvkcBtks+k2K0XR0tahqD5AxcgvXbwWduHKcHsNGZ+hoI+
         QvFUFGBrISrONI8QHClaWwK2H7S4mfXyEUNAGj6Ea/OmWMTgjdv1ddGh5fj43raBYcZB
         GB/rb+VDtb75O4vVzB+CsAXd1EHIUwWRg5+efEOE+50t6FivN0yGtSU1R17pLpCuoxTm
         U+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017022; x=1699621822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc5ZJr+XZL17m3pVsUYEvFhpTqfft7OhKC8WZHCW6XE=;
        b=KwPxsRS1IlEth/zfrVS0myPF3cndsCnayhxaiuXxjP9WjBrvQEWCiJ7dAx/Mvk7xZU
         pa2+EMGb8f5mqHjlzL6MzQTTQktAFuCwQdk6bMJtwfjlxmObLyAAytxcqilqEAh3EW/c
         8m8DbZhSx6UReolEhotH98IjUjMLB0MCWLAJboOMvJVnvHPmq7KL/svsZnXzAw+X8j1G
         o4rOEJbys7j9vwYwWiOG4GVVY6YbHrtFjh/k0eGXwasmOx0tIs7vss3S7Of4/WkAvmOO
         kT8K3bltSfRCCpcNEzDve2N/tYI5UV6UrYYotlerID+rUnu9c6PYjmZBWYb9Stj46PXT
         dLgw==
X-Gm-Message-State: AOJu0YyY/0NxCbEenw4JyuhDK42FYy1nJs0vYDGCO8XD7NGruvALsw3p
        +2J7Nh6BEyGNDwhqih+nL/orepsYZJq6OyFw+QiF
X-Google-Smtp-Source: AGHT+IElnpyQy29sPvTzg8mqakBpuZJ6Jr+S6YEN7aqgmQ+8cZ56ylKgHtdPCshxX8I//qWTsUBBoQ==
X-Received: by 2002:ac2:446e:0:b0:4fe:2f8a:457e with SMTP id y14-20020ac2446e000000b004fe2f8a457emr16338981lfl.43.1699017022670;
        Fri, 03 Nov 2023 06:10:22 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:21 -0700 (PDT)
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
Subject: [PATCH v1 07/12] dyndbg: repack struct _ddebug
Date:   Fri,  3 Nov 2023 14:10:06 +0100
Message-Id: <20231103131011.1316396-8-lb@semihalf.com>
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

Move the JUMP_LABEL to the top of the struct, since theyre both
align(8) and this closes a pahole (unfortunately trading for padding,
but still).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 497130816e9c..b9237e4ecd1b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -14,6 +14,12 @@
  * the special section is treated as an array of these.
  */
 struct _ddebug {
+#ifdef CONFIG_JUMP_LABEL
+	union {
+		struct static_key_true dd_key_true;
+		struct static_key_false dd_key_false;
+	} key;
+#endif
 	/*
 	 * These fields are used to drive the user interface
 	 * for selecting and displaying debug callsites.
@@ -53,12 +59,6 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
-#ifdef CONFIG_JUMP_LABEL
-	union {
-		struct static_key_true dd_key_true;
-		struct static_key_false dd_key_false;
-	} key;
-#endif
 } __attribute__((aligned(8)));
 
 enum class_map_type {
-- 
2.42.0.869.gea05f2083d-goog

