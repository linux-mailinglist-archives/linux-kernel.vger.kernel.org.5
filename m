Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289F80ABF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574650AbjLHSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574646AbjLHSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:20:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B310EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:20:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5451faa3aa7so545885a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702059606; x=1702664406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoMxh9Soo4aEQSXS16TywESmqL58qNmWTbQ/HnkwzzM=;
        b=Fugx/t7Ooo+1Et2bbw1VQpIqu7Up4MglEoMOwhDzbDUB3gyPNqV9U192uSB+/uNvQe
         xgUNBblZ0Kcybh9lL1FZPIgByeOKe/m7vjrLSb75xCnyhd9LOryi9839aDnZe9MtorlZ
         VsZUtGFftDxexcD1I2o3ORagEy8CvNm4eqj7dW8RkLQkBVePCFxluraIpx8dDIT1e17W
         CQi2i2z0FVWAmoAZv5cYyDXQxnyZzltH+GwvGGT8Im+oJe8PzLmDQA8gWxQYT9awaqm4
         As4+zZw2dM7yT3fDWA+iokrneFvJ8buOYv1aERnWciMWFM4uk9LMuVQy+U/oQP2W9R/t
         aQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059606; x=1702664406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoMxh9Soo4aEQSXS16TywESmqL58qNmWTbQ/HnkwzzM=;
        b=XiH06RKfIVI/edNq/ZkWdWVW7hRRZuc3fP5uLGtSXLvZTHy3wRlPTh6tsVGjqM2Z5r
         AOnoKabhZmJHI6eGsUEhorXK7nH8TkepqEcHUdNj5LbyAKb+1K5L0/fG5bm4Dik7ehSS
         I4tzUj9Jx8zvaY1t7Z2LXDPbsBybja9Civ61DFAJlwsCKE6ZTHZU7hZcV8nXJCpZ+Syd
         xzuI91pVNXvtxgRM5b8KDMxK5Ci2zals3bEVLHuxmgJAqxo3SUHzY9DZezGRB/w3b66E
         oWffd5VHJZm0IkE2H71lRudZ546ZBb3brAephGVA9JLt8/4SsBJwTRtpXEsV2GdWppHJ
         amUQ==
X-Gm-Message-State: AOJu0YwJXhd94ceJtju3wr3bncnjMKkRP3bNOUaY9KO5FEUX+0Zjo4An
        n1WT9esXB1X4V1uMvi1eDaA=
X-Google-Smtp-Source: AGHT+IFMn9cxeKoi5L9gzVrLQAnO6MVj8mKG3A52AQuQQ6B5/EPfEH5iwi0gBIiQYToZFEEiafDLpA==
X-Received: by 2002:a50:cc8e:0:b0:54c:fed1:81cc with SMTP id q14-20020a50cc8e000000b0054cfed181ccmr666882edi.1.1702059605919;
        Fri, 08 Dec 2023 10:20:05 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id di5-20020a056402318500b0054cea9f91e9sm988808edb.20.2023.12.08.10.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:20:05 -0800 (PST)
Date:   Fri, 8 Dec 2023 19:20:04 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] staging: rtl8192e: Remove files dot11d.c and dot11d.h
Message-ID: <ed7de82ade0fde1835bbd88aafba74aeb128beed.1701989555.git.philipp.g.hortmann@gmail.com>
References: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove files dot11d.c and dot11d.h as they are empty.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/Makefile            |  1 -
 drivers/staging/rtl8192e/dot11d.c            |  8 --------
 drivers/staging/rtl8192e/dot11d.h            | 21 --------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  2 --
 drivers/staging/rtl8192e/rtllib_rx.c         |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c    |  1 -
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  1 -
 7 files changed, 35 deletions(-)
 delete mode 100644 drivers/staging/rtl8192e/dot11d.c
 delete mode 100644 drivers/staging/rtl8192e/dot11d.h

diff --git a/drivers/staging/rtl8192e/Makefile b/drivers/staging/rtl8192e/Makefile
index 6af519938868..a1492215dab1 100644
--- a/drivers/staging/rtl8192e/Makefile
+++ b/drivers/staging/rtl8192e/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 rtllib-objs :=			\
-	dot11d.o		\
 	rtllib_module.o		\
 	rtllib_rx.o		\
 	rtllib_tx.o		\
diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
deleted file mode 100644
index ec71bae05c1f..000000000000
--- a/drivers/staging/rtl8192e/dot11d.c
+++ /dev/null
@@ -1,8 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- ******************************************************************************/
-#include "dot11d.h"
diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
deleted file mode 100644
index eeefbfa96938..000000000000
--- a/drivers/staging/rtl8192e/dot11d.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
- *
- * Contact Information:
- * wlanfae <wlanfae@realtek.com>
- ******************************************************************************/
-#ifndef __INC_DOT11D_H
-#define __INC_DOT11D_H
-
-#include "rtllib.h"
-
-/**
- * struct rt_dot11d_info
- * @channel_map: holds channel values
- *		0 - invalid,
- *		1 - valid (active scan),
- *		2 - valid (passive scan)
- */
-
-#endif
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 546c8a33dae8..1d6d31292f41 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -34,8 +34,6 @@
 
 #include "../rtllib.h"
 
-#include "../dot11d.h"
-
 #include "r8192E_firmware.h"
 #include "r8192E_hw.h"
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d9517dbc5593..62d02576b441 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -34,7 +34,6 @@
 #include <linux/ctype.h>
 
 #include "rtllib.h"
-#include "dot11d.h"
 
 static void rtllib_rx_mgt(struct rtllib_device *ieee, struct sk_buff *skb,
 			  struct rtllib_rx_stats *stats);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 3c92eb401e8c..5c89744b2bbe 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -18,7 +18,6 @@
 #include <linux/uaccess.h>
 #include <linux/etherdevice.h>
 #include <linux/ieee80211.h>
-#include "dot11d.h"
 
 static void rtllib_sta_wakeup(struct rtllib_device *ieee, short nl);
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index b48c89d2e7bf..5d165d0b134d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -14,7 +14,6 @@
 #include <linux/etherdevice.h>
 
 #include "rtllib.h"
-#include "dot11d.h"
 
 int rtllib_wx_set_freq(struct rtllib_device *ieee, struct iw_request_info *a,
 			     union iwreq_data *wrqu, char *b)
-- 
2.43.0

