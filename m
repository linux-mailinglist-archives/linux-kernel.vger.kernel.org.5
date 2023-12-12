Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAFF80E52A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbjLLHyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345971AbjLLHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:54:04 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2512D0;
        Mon, 11 Dec 2023 23:54:10 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so2978486a12.0;
        Mon, 11 Dec 2023 23:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702367650; x=1702972450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Shdip5yjqGroTxQL7MptUpcQ2qzzAlYoyVTOz3Rc4nM=;
        b=NH+bbvMHLYxTnSahVCREvE2DTNvqg7JhcXv37IU6kqZUwgnlabbw8gXjJLj8b/cMzP
         0gUvs4cM/mjGogSZkJLttdKNaOn6I33FJAPwDkqu5k1SW6pdouP0i/Q5wPCjZE3bZv9S
         MTwqChG5MfYoMLHxI9udChQyV1a3El4SMWH6/odxfTspxX0tDC8G9Y6+dNHb/sxm+vNP
         BLagsjYgeHEvniPMfwFph+0fZj4WqV5BbsgzAj+fOhkaDwu/3mVBWD0qfflExuvBicAq
         caoBQPLomwIOeJfcxCFOPSl8XDAkGtqVmSrZjg8Wwj2p1DdCeTGm6nU+OxWMBvnrFSYC
         +emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702367650; x=1702972450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Shdip5yjqGroTxQL7MptUpcQ2qzzAlYoyVTOz3Rc4nM=;
        b=InXhJ2lgQx//CHjQOBOnO95bF7iqWG7eH2qxcvpfNceQHgdFSIVpZpAmZWW2nWQeUt
         DbGJgeS/AcVOg1oUTMvXh1Hm2IGbBaQEpWhV7ukG57+LHZ1Ay2fQ6YwyUwyUQDxPgK6o
         DhuJw5ZAPXII9bo1mA7i0g8Ce4XYvaSeKmMDbpNskp4Cl2sSfKjy+ug/cmjgiN6C9JBo
         MWgz7UzKLFESmDHDl/xXuroqONIjV5Pdkyu8u6rD4u0HNL/RRxe5/cgCItEkvwiVBX/Z
         rJhA9mui1nv7PKtDShG5ogTTP6G6ujpTvKKyv0s1Js+Hok2pSfgJtqDRc+5y+vEBxQ8v
         dMiA==
X-Gm-Message-State: AOJu0Yx9s7mB3cic4QqtBjK3jpXeEwwdrXbgo0fSjKTox8uioTRj9YHB
        yo/fhyR5xZowuAZGPXzcaTo=
X-Google-Smtp-Source: AGHT+IEmhZs4mI8QYXlU+ypM3O08Mx6ko1LYMi5VkKIviUfPwcBJLVuPc2M6YBUukdoUvVEUh8jg0w==
X-Received: by 2002:a17:90a:65c5:b0:286:76e6:7b26 with SMTP id i5-20020a17090a65c500b0028676e67b26mr2956223pjs.36.1702367650226;
        Mon, 11 Dec 2023 23:54:10 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id qi9-20020a17090b274900b0028a28ad810csm8144319pjb.56.2023.12.11.23.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 23:54:09 -0800 (PST)
From:   Yang Chen <yangchen.openbmc@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        patrick@stwcx.xyz, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jerry.Lin@quantatw.com, EasonChen1@quantatw.com,
        Leslie.Tong@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 02/11] ARM: dts: aspeed: minerva: Modify mac3 setting
Date:   Tue, 12 Dec 2023 15:51:51 +0800
Message-Id: <20231212075200.983536-3-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
References: <20231212075200.983536-1-yangchen.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unuse setting and fix the link to 100 M

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index c755fb3258a4..9979dba1ef0e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -48,10 +48,13 @@ &wdt1 {
 
 &mac3 {
 	status = "okay";
+	phy-mode = "rmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
-	use-ncsi;
-	mlx,multi-host;
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
 };
 
 &fmc {
-- 
2.34.1

