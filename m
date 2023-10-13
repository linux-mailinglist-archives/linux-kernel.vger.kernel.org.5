Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1FA7C8810
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjJMOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjJMOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:44:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F7DA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3232e96deaaso433248f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697208253; x=1697813053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm9Boe/IQ1CKHp5Z4OotYOocbOOmHzj4fbuWIiiw6vc=;
        b=YGgN47LwEW41wv09+lrcTOKCWba+JJfw/Eh0fznfHGQK79bGwJukCOw52QoRssNJ/O
         zrd7DMdKAS4b0Oe/JW3fefUoH0VKnx6FmOVpEBf5brGNX9VXiqVRZwNZRG4KKbGNx7ey
         ohdrL9lhzEnkKFVDP8it3Vi0m10rNbBHmsC1t2xUI2RAbVf2y7JL8P1ZqQqhl3zWaMJ1
         SFGwudh/jH/tSb5HmEi0yB0DiHGBUZEmMKhuMH6y2R48I1hd184WW9gxulKxWrdLM3p1
         Ez0p6XhcDgpLtz77WEtnXGGZqMHO4E6p/KuLGEhCmHwHiaB6Sk5b0eIyFiS/3Vqigfuk
         Slmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697208253; x=1697813053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm9Boe/IQ1CKHp5Z4OotYOocbOOmHzj4fbuWIiiw6vc=;
        b=nPYmitoa8pmnmoMkEHZMnI+6Ldmu67J5eJ0Hig0MMMKDBkAtRfS+nZkdpqxF7Ol0h4
         ejEhuld7L3zrP2pJGs5NmfweffC7ywSUTQZXmle41AU9TO2dBvONC1lcrRvbKjsmf0/T
         eFGCwcYA8H07Abu69Puij2zN6/RBTu2hXfsJdSYeWuXZYU1BphWIUX5QbG4igs+mK/Hf
         zwN3G/a6BKjCwWu1wQxUfBWowNB84AmGtcWiEvaPiEeW6i/cFljVIVvpOHnjlAYnYnWQ
         QFwsFTFUsBiD3SHaCov7gq8pzcUKCImEoJAJQL7lTwHsmco6AgHB2caFHHQONmlgO+pV
         zU8Q==
X-Gm-Message-State: AOJu0YyR5WYdgXSyDMIx419qoWJc4WAihPUx1g348KJb9UX18MqumyX6
        VlK0L+kZK1GxbSSpP4ibfb0=
X-Google-Smtp-Source: AGHT+IH48KHg/LzodbjMHv7fJ3mhlY9Z6dAer1u3kPbEDpMrh+GBR9WyOudn2nEe1Np50VTK4aCYNQ==
X-Received: by 2002:adf:ab49:0:b0:32d:974b:6dde with SMTP id r9-20020adfab49000000b0032d974b6ddemr2356312wrc.0.1697208252846;
        Fri, 13 Oct 2023 07:44:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b00405bbfd5d16sm337950wmq.7.2023.10.13.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:44:12 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:44:11 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] staging: rtl8192e: Remove unchanged variable
 dig_algorithm_switch
Message-ID: <a76d8b86f2591446a071b4f614adf628b0fe5c93.1697127817.git.philipp.g.hortmann@gmail.com>
References: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable dig_algorithm_switch as its value is set to 0 at
initialization. The equations result accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 18 ------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index e69c22e5d205..0bd9211500ac 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -911,8 +911,6 @@ static void _rtl92e_dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	dm_digtable.dig_algorithm_switch = 0;
-
 	dm_digtable.dig_state		= DM_STA_DIG_MAX;
 	dm_digtable.dig_highpwr_state	= DM_STA_DIG_MAX;
 	dm_digtable.cur_sta_connect_state = DIG_STA_DISCONNECT;
@@ -962,8 +960,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 	u8 i;
 	static u8	fw_dig;
 
-	if (dm_digtable.dig_algorithm_switch)
-		fw_dig = 0;
 	if (fw_dig <= 3) {
 		for (i = 0; i < 3; i++)
 			rtl92e_set_bb_reg(dev, UFWP, bMaskByte1, 0x8);
@@ -980,8 +976,6 @@ static void _rtl92e_dm_ctrl_initgain_byrssi_driver(struct net_device *dev)
 	_rtl92e_dm_initial_gain(dev);
 	_rtl92e_dm_pd_th(dev);
 	_rtl92e_dm_cs_ratio(dev);
-	if (dm_digtable.dig_algorithm_switch)
-		dm_digtable.dig_algorithm_switch = 0;
 	dm_digtable.pre_sta_connect_state = dm_digtable.cur_sta_connect_state;
 }
 
@@ -991,10 +985,6 @@ static void _rtl92e_dm_initial_gain(struct net_device *dev)
 	u8 initial_gain = 0;
 	static u8 initialized, force_write;
 
-	if (dm_digtable.dig_algorithm_switch) {
-		initialized = 0;
-	}
-
 	if (rtllib_act_scanning(priv->rtllib, true)) {
 		force_write = 1;
 		return;
@@ -1040,10 +1030,6 @@ static void _rtl92e_dm_pd_th(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	static u8 initialized, force_write;
 
-	if (dm_digtable.dig_algorithm_switch) {
-		initialized = 0;
-	}
-
 	if (dm_digtable.pre_sta_connect_state == dm_digtable.cur_sta_connect_state) {
 		if (dm_digtable.cur_sta_connect_state == DIG_STA_CONNECT) {
 			if (dm_digtable.rssi_val >=
@@ -1100,10 +1086,6 @@ static void _rtl92e_dm_cs_ratio(struct net_device *dev)
 {
 	static u8 initialized, force_write;
 
-	if (dm_digtable.dig_algorithm_switch) {
-		initialized = 0;
-	}
-
 	if (dm_digtable.pre_sta_connect_state == dm_digtable.cur_sta_connect_state) {
 		if (dm_digtable.cur_sta_connect_state == DIG_STA_CONNECT) {
 			if (dm_digtable.rssi_val <= dm_digtable.rssi_low_thresh)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
index 15af490d2dcd..12b7d426b6b9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
@@ -50,8 +50,6 @@
 
 /*------------------------------Define structure----------------------------*/
 struct dig_t {
-	u8		dig_algorithm_switch;
-
 	long		rssi_low_thresh;
 	long		rssi_high_thresh;
 
-- 
2.42.0

