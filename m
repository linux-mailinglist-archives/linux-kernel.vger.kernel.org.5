Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46127FFF99
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377369AbjK3XlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377355AbjK3XlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:13 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B9B10DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9fa2714e828so214621766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387678; x=1701992478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYdbYF0m94fsC3GTgjOmD6mjqqKWFRCLzjA+YcCvaKs=;
        b=cZF7xIF9GljMKbHz/rGeGQE4VJNRC3iGVNmzxYaJZlrvuaPzCdhYyykqok8RB+/UN0
         KlG64NrKA/cWyDSWhCxb8Qayu4afLNLEfcGx2uX4mNzc9y/W5BXM/ti2ciXLTYVkHAdF
         MPzo83M8Ls/yX8W7JeGPzbXIFjIcGpF7gMPNOHf2CtfBZOFkNu68i2XUCzYwv7s8Aj/G
         gW2imEd2nbgf7bpXUBHaGF6i0ssoVpbTQKLod24JresUWiM0cxJm3h2zsVRwa/YcqRU7
         4+LkQYRWpg1734tGVqgrMUQTJP4dekbDfTZ4G7noYtIe5xUEx1Tqjn83tLOUR9Dh3QOs
         hXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387678; x=1701992478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYdbYF0m94fsC3GTgjOmD6mjqqKWFRCLzjA+YcCvaKs=;
        b=MHjZJ4brmZz2XbbFFxS9peuohqOQBmLaiQ24KU5oCZIjL3O3+oW2IfcJRYkU2RIzU+
         JcIbiYMMb0mqECOag+5jv4QKMAaBxNAHo3h4uKD1PlSQUx/Zpz8h5LgnWi2GCkk6G2f5
         MBc2qMGkbIccT0eS0TD4IhyFlpA4bHmzLy6hXAOUba6p8kdvAqFS7FGulidZCmmAL0lJ
         PnDF61GT4JajaZowu279IekdHeJ4n09kTXDDwVKjYI18YERT68nob40LMHx+EHL4S23f
         364nqC9UBu/T/TztJkGUHipL/Qo9OEu2Q4Lwp/WTFtkVvtQQCcrJV/g1gR9g6o6xBd4A
         4DSg==
X-Gm-Message-State: AOJu0Yycq1ebITC1timhLJi8aQl6ldAqaltPAemyTevib6LHXpHEmpMJ
        eg1IDHUwR6kNFi2k/UXYh1U4
X-Google-Smtp-Source: AGHT+IHN0IPJ7Eyb9vhCMmNNf6va3wVZuR3X71zSqgrDvVS+M45K9JFejLE5XG9EMpHFm5Btjy3+ag==
X-Received: by 2002:a17:907:9009:b0:a19:a19b:55e4 with SMTP id ay9-20020a170907900900b00a19a19b55e4mr199024ejc.116.1701387678210;
        Thu, 30 Nov 2023 15:41:18 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:17 -0800 (PST)
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
Subject: [PATCH v2 02/15] dyndbg: add _DPRINTK_FLAGS_TRACE
Date:   Fri,  1 Dec 2023 00:40:35 +0100
Message-ID: <20231130234048.157509-3-lb@semihalf.com>
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

Add new flag, and OR it into _DPRINTK_FLAGS_ENABLED definition

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 7be791af7cf1..497130816e9c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -33,6 +33,9 @@ struct _ddebug {
 	 */
 #define _DPRINTK_FLAGS_NONE	0
 #define _DPRINTK_FLAGS_PRINTK	(1 << 0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_TRACE	(1 << 6)
+#define _DPRINTK_FLAGS_ENABLED	(_DPRINTK_FLAGS_PRINTK | _DPRINTK_FLAGS_TRACE)
+
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
@@ -44,8 +47,6 @@ struct _ddebug {
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
 
-#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
-
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
-- 
2.43.0.rc2.451.g8631bc7472-goog

