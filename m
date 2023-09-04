Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2707911E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349068AbjIDHPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239220AbjIDHPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:15:15 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913A184;
        Mon,  4 Sep 2023 00:15:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7260fae148so951288276.1;
        Mon, 04 Sep 2023 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693811705; x=1694416505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2yK8aKcSPuezmSKFjfJ2lLtNKKiKqgsopGdmukPsnM=;
        b=UoEx8oztV24zvGOspordC+g5r5fGvQz/9tBxiH+9aHRUoDdgTBMjOyaRC7yBTwxLxi
         bhJIzJRzaFlUZUsSPJahYZOcc1EWaseb8DkvGtaIcOnMkcfjh9c88yGY17PEpinfCq+f
         o1Hsqlc93/bctIv6E9rbdxY/InfMS2BoHguE0Fb8kWAnWD4WzMCSGF9Yx1+I6qZhr87S
         p05pTqWOG/yxIeg/trwXvn11YdPjWM4XSv3DYkykms5uNKr4EBDvQNwUQGommGnLu4eR
         21v/XV0M3AsGAPJhIc9rcRFvsE8IcDiC7GqL+IvcUuyo+7HCtRs7iaeAGjzWATcQNE2D
         T8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693811705; x=1694416505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2yK8aKcSPuezmSKFjfJ2lLtNKKiKqgsopGdmukPsnM=;
        b=aBzI0eRRXcTwv4dz+sBjbl7K0w2Gs5ndadOf2wCi/22F4UNWM8qVj6ZCYDN6nJ0e+e
         +VrcA4wQDqW0KfAaOI86ZDqH/+1PsHnbwSRua+yTePKJJHja1J2k6n5BDO2j8UKSCY9G
         79uasGlc7p5sNUsLd6U05Dv3GntKix+mJGn+kZL9YryK3soScf8yACxhk2uswNP/tFRx
         bcGIsx17rKJKtcLx82YOXjVdG7wUT5VqQUVjJIAVLAoViGIoyq5995jjPMFNnSSoTwiZ
         f7vguQq/RsuAcFK3DDNGD4NGUPKYDj3CHAN2GR+afH2r2Ymz4PLDjeH+5oXPXbiI17x2
         mpFA==
X-Gm-Message-State: AOJu0YziX4/bKIU168eZ1ktxohmIGbMp0SDq+LWgIA3G0krwlRe3HHSS
        K3xt2KdedySq7bOF5jaSCCG9xvmRwjFdGQ==
X-Google-Smtp-Source: AGHT+IE1csCUdUlF4QuakGrwXb6Ni6oFHfIWmga4YqhhvWO3y8XR5ozcKXvJOUtHcSHJjQVjCGZndg==
X-Received: by 2002:a25:d0a:0:b0:d78:f32:5849 with SMTP id 10-20020a250d0a000000b00d780f325849mr8997460ybn.24.1693811704753;
        Mon, 04 Sep 2023 00:15:04 -0700 (PDT)
Received: from PLK-D0032.dom2.local ([157.25.98.166])
        by smtp.gmail.com with ESMTPSA id 82-20020a251955000000b00d74b144004bsm2207565ybz.12.2023.09.04.00.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:15:04 -0700 (PDT)
From:   Tomasz Rostanski <tomasz.rostanski@gmail.com>
X-Google-Original-From: Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>
Cc:     stable@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Li Jun <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
Date:   Mon,  4 Sep 2023 09:14:26 +0200
Message-ID: <20230904071432.32309-5-tomasz.rostanski@thalesgroup.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
References: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

This selects the SOF/ITP counter be running on ref_clk. As documented
U2_FREECLK_EXISTS has to be set to 0 as well.

Reviewed-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://lore.kernel.org/r/20220915062855.751881-3-alexander.stein@ew.tq-group.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c | 8 +++++++-
 drivers/usb/dwc3/core.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2eb27c60542a..c065d165bedd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -411,6 +411,10 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+
+	if (dwc->gfladj_refclk_lpm_sel)
+		reg |=  DWC3_GFLADJ_REFCLK_LPM_SEL;
+
 	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
 }
 
@@ -792,7 +796,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	else
 		reg |= DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-	if (dwc->dis_u2_freeclk_exists_quirk)
+	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
@@ -1501,6 +1505,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,resume-hs-terminations");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
+	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
+				"snps,gfladj-refclk-lpm-sel-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 9c421de4d01d..d4004bab4cc5 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -385,6 +385,7 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 #define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_REFCLK_LPM_SEL		BIT(23)
 #define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
 #define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
@@ -1299,6 +1300,7 @@ struct dwc3 {
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
 	unsigned		resume_hs_terminations:1;
 	unsigned		parkmode_disable_ss_quirk:1;
+	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
-- 
2.41.0

