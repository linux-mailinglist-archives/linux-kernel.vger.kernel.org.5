Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B647F0622
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjKSMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjKSMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:13:53 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F4311D;
        Sun, 19 Nov 2023 04:13:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507962561adso5081620e87.0;
        Sun, 19 Nov 2023 04:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700396027; x=1701000827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRvQu7v2aw6b3c6XSPxt/GFQ2vthRnfEbysoDl+IjOE=;
        b=So/Q3q6CX1GQh4TRr/h61jWDX1ugqisPkJ0FBbYplxRBIkCLITqOiKoWNMq1Qw0HLr
         ejDZ9QEKEAbFFqaCDB6mGxp11wi9wEy8Iq8QZNwUvNQnvvX/F3/DjO2jF3c6OouXCwwR
         swx8BtWPvOBXlVFtlt3FYhd93NQJkHjula2r8EcsUm69dko1jk7b/OTzURRYEy4t4885
         T6z21CTkU0WGLv0RsPdPVBX0QMSdjMzXPpL4oY8VeQhpY5ePAgLiPNHAIu/tvdSHtiaH
         OG3wFSy22QXI6nJ9cwxehvXCNYG7fUIlZ1PildkDRhXtEoGi2IIZoy5ZQuaBJEcQ9C8m
         grHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700396027; x=1701000827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRvQu7v2aw6b3c6XSPxt/GFQ2vthRnfEbysoDl+IjOE=;
        b=XliKHWCSZAWKMsFsO6pYnTkYk6/u3TTtul3rGjQxZYnjqrnx3GS5RDEeLdoMtnKoTR
         qc2TTqYPdhr9pSGI7ewFJ0c4OUJpx3PWSxFir9PL6NFIBYaWb9BsfClDkTt+pH4wQY4i
         w8rDl4yW3/K6X6aA6ZaQsryULZGZL2Vh9Z9bE21sNVi2Fvs4jGH2jK52nAISav9Fz6bi
         5pX0Zw9TlZFPGwWaaRZYbaRCYbAJu+sNmcLShaJMZs41ljYvxFmFR5fjbkmMkAghKLVy
         BrHXbYnFCoILPD1eS5wdNK2UoHxMiI4jY4HQO0/rMRQVBdaAA3v+2Mbc2/6d5u2zTyfk
         6onA==
X-Gm-Message-State: AOJu0Yzwws2B4iBPAzInUolCjxFGSEIxZOeHgfcEslJTj9zOBZorY/3k
        Tcw4uwKHF8NfJNPG4lFySQ==
X-Google-Smtp-Source: AGHT+IFclIkGd4gUltycd20mO39V01aWQkCtlOGJQGc8SY39GQWh+136ifIDd6KIpOUu229lqj1sxw==
X-Received: by 2002:a05:6512:485b:b0:4fe:1681:9377 with SMTP id ep27-20020a056512485b00b004fe16819377mr3313345lfb.44.1700396026949;
        Sun, 19 Nov 2023 04:13:46 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7017:f42c:e243:8c57])
        by smtp.gmail.com with ESMTPSA id r5-20020a056402018500b0053dec545c8fsm2523634edv.3.2023.11.19.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 04:13:46 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 5/5] ARM: dts: rockchip: Make usbphy the parent of SCLK_USB480M for RK3128
Date:   Sun, 19 Nov 2023 13:13:40 +0100
Message-ID: <20231119121340.109025-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119121340.109025-1-knaerzche@gmail.com>
References: <20231119121340.109025-1-knaerzche@gmail.com>
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

Without setting the parent for SCLK_USB480M the clock will use xin24m as
it's default parent.
While this is generally not an issue for the usb blocks to work, it becomes
an issue for RK3128 since SCLK_USB480M can be a parent for other HW blocks
(GPU, VPU, VIO), but they will never chose it, since it is currently always
running at OSC frequency which is to slow for their needs.

This sets the usb2 phy's output as SCLK_USB480M's parent and it's users
can chose it if desired.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
Changes in v3:
 - moved parent assignment to the phy node

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index c8844e0024dc..61b292c7c4c3 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -266,6 +266,8 @@ usb2phy: usb2phy@17c {
 			clocks = <&cru SCLK_OTGPHY0>;
 			clock-names = "phyclk";
 			clock-output-names = "usb480m_phy";
+			assigned-clocks = <&cru SCLK_USB480M>;
+			assigned-clock-parents = <&usb2phy>;
 			#clock-cells = <0>;
 			status = "disabled";
 
-- 
2.42.0

