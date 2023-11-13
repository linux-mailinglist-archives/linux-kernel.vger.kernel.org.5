Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B97E9F40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjKMOxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjKMOxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:53:37 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D71732
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:53:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507962561adso6975245e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699887212; x=1700492012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xhUueshKstjuF7T+PvYpgtmmmU0JX7LuXbXVkaBcbA=;
        b=lv0+zchxhNZqoGbBL9qahOnzuJ6h1gAwvKdLpdmFteRWRjg8SklqeMj8Ud+8DQu9HF
         fybXoYo7EDvBicjSS6t4a1X15LyM/+OQw8D3SCWi5rCYXRkVaMmSJcyFq2NIrRU0Cy+A
         dqYe1Dd+cpwJ0mWs71JQpyTkS52sZMTHXt7kGaLEl9v/5xc3jpNfatdW50fTy/OO6H5p
         /HI58O7yX91hoNEQ4tCVXIIuxL2ezXR8vA9pDr0xtg5pM0tL+Sq7ohFV88nCGVPwSW+f
         hUdPMNYSsOBcziazi242A3V32xVMDVAxTWof44xChmeDja2Qrwdwli2x/TkdRTY/yhAV
         rAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887212; x=1700492012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xhUueshKstjuF7T+PvYpgtmmmU0JX7LuXbXVkaBcbA=;
        b=krMXEndnbIaKr4meO/zZYeHsM4Zozf5wm5Oblh/nRbgBxlH4Bg3QHyA7hK74XZ2c+5
         IBYpjVebZZ2bBLOc5axA/nztowM2DscnVt7FoIiPp0V5neJHFhOws2c8Px3G2c5VwYpX
         d0N+OjYs5A2nRBBxnipc6l8Yb/Tm6tVwkACxcPufp7+PiR0IaDrQc9b+VPQKntWFkepd
         +CCmfpow6fiIhBibNpp0rC8CCzFONJLeiFEty1LVG+1S1bAZPFTJADzGiKEnWXALG4DD
         t8nAY1wpiPn3sNE8GuQTJiI8OGUR0P6pHbqe8hHK7+Y+IQpJBye9in3kstR2IvmDuMGn
         AmAw==
X-Gm-Message-State: AOJu0YyhAapnsPZexosdcl11Zeb7PEbBoyU8qyIcLNNaTdeCz0jSiDhH
        cYM1kRQi1Kxif0YhkHBEsfreGw==
X-Google-Smtp-Source: AGHT+IFjbTelwXsX6I7IEtJnCOEXdhWdUITLUYWGVGg27FEvoMIr9jUiUXGIawMQ2APipbh2OsIqHA==
X-Received: by 2002:a05:6512:388f:b0:503:778:9ad2 with SMTP id n15-20020a056512388f00b0050307789ad2mr4273107lft.19.1699887211871;
        Mon, 13 Nov 2023 06:53:31 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x24-20020ac24898000000b0050794b05c8asm991429lfc.42.2023.11.13.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:53:31 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/3] usb: typec: change altmode SVID to u16 entry
Date:   Mon, 13 Nov 2023 16:33:08 +0200
Message-ID: <20231113145328.42575-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
References: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the changelog for the commit 7b458a4c5d73 ("usb: typec: Add
typec_port_register_altmodes()"), the code should be adjusted according
to the AltMode bindings. As the SVID is 16 bits wide (according to the
USB PD Spec), use fwnode_property_read_u16() to read it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/platform/x86/intel/chtwc_int33fe.c | 2 +-
 drivers/usb/typec/class.c                  | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
index 848baecc1bb0..93f75ba1dafd 100644
--- a/drivers/platform/x86/intel/chtwc_int33fe.c
+++ b/drivers/platform/x86/intel/chtwc_int33fe.c
@@ -136,7 +136,7 @@ static const struct software_node altmodes_node = {
 };
 
 static const struct property_entry dp_altmode_properties[] = {
-	PROPERTY_ENTRY_U32("svid", 0xff01),
+	PROPERTY_ENTRY_U16("svid", 0xff01),
 	PROPERTY_ENTRY_U32("vdo", 0x0c0086),
 	{ }
 };
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 6ec2a94e6fad..4251d44137b6 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2238,7 +2238,8 @@ void typec_port_register_altmodes(struct typec_port *port,
 	struct typec_altmode_desc desc;
 	struct typec_altmode *alt;
 	size_t index = 0;
-	u32 svid, vdo;
+	u16 svid;
+	u32 vdo;
 	int ret;
 
 	altmodes_node = device_get_named_child_node(&port->dev, "altmodes");
@@ -2246,7 +2247,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 		return; /* No altmodes specified */
 
 	fwnode_for_each_child_node(altmodes_node, child) {
-		ret = fwnode_property_read_u32(child, "svid", &svid);
+		ret = fwnode_property_read_u16(child, "svid", &svid);
 		if (ret) {
 			dev_err(&port->dev, "Error reading svid for altmode %s\n",
 				fwnode_get_name(child));
-- 
2.42.0

