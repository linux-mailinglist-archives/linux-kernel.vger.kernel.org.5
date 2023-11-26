Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73D7F9502
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjKZTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:18:48 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B1BFA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 11:18:53 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r7KeS-006khP-Q1; Sun, 26 Nov 2023 20:18:44 +0100
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1r7KeS-000Slf-0U;
        Sun, 26 Nov 2023 20:18:44 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        johan@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andreas@kemnade.info, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: [RFC PATCH 1/3] gnss: Add AI2 protocol used by some TI combo chips.
Date:   Sun, 26 Nov 2023 20:18:38 +0100
Message-Id: <20231126191840.110564-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126191840.110564-1-andreas@kemnade.info>
References: <20231126191840.110564-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments uses something called Air Independent Interface (AI2) for
their WLAN/BT/GPS combo chips.
No public documentation is available, by looking into captured data, it
becomes clear that you can either raw data or encapsulated NMEA after some
initialization commands.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gnss/core.c  | 1 +
 include/linux/gnss.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 48f2ee0f78c4d..cac9f45aec4b2 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -335,6 +335,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
 	[GNSS_TYPE_MTK]		= "MTK",
+	[GNSS_TYPE_AI2]		= "AI2",
 };
 
 static const char *gnss_type_name(const struct gnss_device *gdev)
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 36968a0f33e8d..16b565dab83ea 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -23,6 +23,7 @@ enum gnss_type {
 	GNSS_TYPE_SIRF,
 	GNSS_TYPE_UBX,
 	GNSS_TYPE_MTK,
+	GNSS_TYPE_AI2,
 
 	GNSS_TYPE_COUNT
 };
-- 
2.39.2

