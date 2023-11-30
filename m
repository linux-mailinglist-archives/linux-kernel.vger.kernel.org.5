Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282857FFF9D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377328AbjK3Xll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377343AbjK3Xli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:38 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EA21704
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9d33f049cso12466311fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387703; x=1701992503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU2G2uffAM4O6Nhks/FhUry7Vyfirnbj/6Fsp1kfUEw=;
        b=CJZ0nT8023vEoKuowScpPmN7nUj933x4BU1+flrpiY7P+xYBmIYqfsYbSVCB/JApB+
         oRSJpqn6IH+eWSONpXFjV8xcRWtm49++4HhBWiQROzD/D/ThyOYuTPuB0OvpVX0p06Zd
         NQEhrPTEHv1lmQTvQnf0Fuo5IuDA4PsXjIGZBI0p01hsraigq/E4XtNJ9CxVpqJgM86U
         OfSdDRYya9EIl13keenl6IcmaIGjMgTln+EwMUq3H1joktHqsjppCGdC1MTMR4ARh1Ti
         kCd1I39fwP6/nuOPjHGsEK5bBzrXInW31Z9GPFXZp2V2XuGrtW7fzzAMfp0GRDmRRWrk
         /bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387703; x=1701992503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU2G2uffAM4O6Nhks/FhUry7Vyfirnbj/6Fsp1kfUEw=;
        b=DGLdL/B/uHgx7vOq0YlX9XN/V7vq7j/I2lJTh5Cq1K5Z+MHbE4cdyGvM4KWo17yXU5
         Ot82Yk7RbCyilhyR4Ye5Y/yveBDNTH4VFjO/F1eHp/K07LnrAVK2iKt2mrQUErkaBOZX
         ydvWx/NHVBXd9o+kBF1Q0iciGtOY6NNEytFwci+4t8MtyIvd0RL/sWOBgbDddG/Xx64P
         +8VtKfREqKo+U5FUnrC93rg6EY3+JlaPDiDEKqNO5oWTBqFcQAN3buJtUAd2R7JsRuuP
         I3QkCvxOd+xp5Nqd/waOmSsHUwec59Ra+kzeH7z//Lthpene/DpkSPrlyr2UbMJYSjP0
         ixeQ==
X-Gm-Message-State: AOJu0Yx4kgLaKSMA5oWDwbB4+rANcdVTmEuXfZusWa8o5zGX4SZP6DAR
        Ull5mfG/4VOeFCoJxIGUnCLQ
X-Google-Smtp-Source: AGHT+IFdkWNqgAPnv9bHsEskbc07MOcrl6nHQBDj1rVmZhR60pOrRg4jGoKCC7tcEnv2DrSZg7N8RQ==
X-Received: by 2002:a2e:9083:0:b0:2c9:bb40:21f3 with SMTP id l3-20020a2e9083000000b002c9bb4021f3mr194433ljg.30.1701387702926;
        Thu, 30 Nov 2023 15:41:42 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:42 -0800 (PST)
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
Subject: [PATCH v2 07/15] dyndbg: repack _ddebug structure
Date:   Fri,  1 Dec 2023 00:40:40 +0100
Message-ID: <20231130234048.157509-8-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
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

Move the JUMP_LABEL to the top of the struct, since they're both
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
2.43.0.rc2.451.g8631bc7472-goog

