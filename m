Return-Path: <linux-kernel+bounces-122327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF5188F542
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8DD2A3161
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D72D03B;
	Thu, 28 Mar 2024 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db/WrUVc"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42072BAE9;
	Thu, 28 Mar 2024 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592555; cv=none; b=lXsxODaZjtzqItSfk/rJ7WTG1SySmVRIcxhS6V+r3PBDgDIf4wPDl4lwXJAIGNp4MoTEUq0YiqxND7bS0oTg8e7e0mhdVvqPp5d+99o6uSZgxm4g0Sz1oDSvPJbUBzmPxTix9X76I4h+6wVsDuQiBXXIZbA83dyUCXbn28N7XLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592555; c=relaxed/simple;
	bh=hlV16x9s1VgpN3rneCt58Bz2nH8s6XYCByPKSUcnHsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yz43BJtHxyOcri5O+MqMPjQw8bb0Z4LRTmSjINPqJYm9K4BxzZRkJdGoB6o9VatwUHyeZuCFeWiXo/w3omKUcSwls/P/OdhdsAzG5MSlZqnOKd4fCWYQomBGBYlf2JJdHx0RlSVrZYmgF4xkUfJ4R7QFud40Yd4U3sBNkuhHHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db/WrUVc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3417a3151c5so258246f8f.1;
        Wed, 27 Mar 2024 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592552; x=1712197352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vz8/eKL4Qc16uyUzocMqz1eYlvRo+Wlh+LXhdKk42Vk=;
        b=db/WrUVcA1NMh2XmT1FSWSzSBF66AcM/e/fSXtGjkMeac+oJA7t2cJI1HwkitqQw+k
         L0G9KWIpiwnm5MpBgqWDhKncKNE0lfjHhcEF5Qke/DStshq4hbq+QC+cyjN4OcYQZIv0
         5G6w9YWitF5fg+CPzFTHF4eukCNiYp3xBKMhNeLRcwfENp4DEHXdbq8BsgbLANKaor3T
         bsamR6dnFrYHKdTp+L8k+CVkoWR/fJPOXXoncDikN6+tSnE5TUsACyHgQvsjV3le50E3
         a1255JF9woKg2Oh99nyqOvd9tF9BZjCzwgefdJem82/ToBRYDj3uB9l6nAjxKgEBZtaV
         mpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592552; x=1712197352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vz8/eKL4Qc16uyUzocMqz1eYlvRo+Wlh+LXhdKk42Vk=;
        b=gAG/q8MT5Oe9WFsbIaPXVU9Z2A0Jl2VMBlbrm+58gSsvr0Nh+ZOjzozckhi9yfNK+C
         PqHl0meECpjqmxjl6A/rInMuZrojAsS2g1e0sjpeNuFMMNbNO0HJyhs8z+SMD5kBfWey
         W6px0GAVmfZq7z36T7fxKPvInqNnEJ2wkjPlJNVbLGenN0c6DKHYDXw4esuRDOcNrBPu
         E24iSQygfaQFJTFOJoEkcwnjWesPvktFVHKCMsyR5p5U3ICvFUeNoq/IVLlw4pDfAfM+
         GBhnGPN6n2fUP5ylGp7m64ykN8qNXlyP4aGQSzh53Opq30LzPJB6Ec6VlVwIbHksW4NO
         Zsgg==
X-Forwarded-Encrypted: i=1; AJvYcCUWioAEDnCAM7y/eozJQpvT7jeemYXBoGT8JOiVh9B88MNuQ6QkyNPAKF14rs3TIhjgUsP0ijN4zZLCaRDvk8r1OCbfec1t5xoKgmefxGEEnciFJxZdxzvVA4DGjYylkAPJetOxuxcLQp2ZGWsNXezVs26JnA4BK5T7hJRowC4VRCDfbQ+ay30=
X-Gm-Message-State: AOJu0YwJy7QV5AnPUkQxOX/NHz7bvxjj4s+M8bjLrheXEt+dJeN0U2Ks
	eZdPRkAVVJF9FM481cTLIUBLYEuQaC9ruxOl7iwvyjtHYdE6QhM1
X-Google-Smtp-Source: AGHT+IG/kQ7HgIB7yny3Sgwvv+yRvE90Rwt2hW959iJeqgdjeLR3S7GS5kp2cH1vRpnqdCYNwFbWzQ==
X-Received: by 2002:adf:cd10:0:b0:33e:bfb8:7320 with SMTP id w16-20020adfcd10000000b0033ebfb87320mr1366619wrm.7.1711592551977;
        Wed, 27 Mar 2024 19:22:31 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id y13-20020adfe6cd000000b00341cfa5f16fsm448961wrm.30.2024.03.27.19.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:22:31 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc8180x: Fix ss_phy_irq for secondary USB controller
Date: Thu, 28 Mar 2024 03:21:57 +0100
Message-ID: <20240328022224.336938-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI DSDT of the Surface Pro X (SQ2) specifies the interrupts for
the secondary UBS controller as

    Name (_CRS, ResourceTemplate ()
    {
        Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
        {
            0x000000AA,
        }
        Interrupt (ResourceConsumer, Level, ActiveHigh, SharedAndWake, ,, )
        {
            0x000000A7,     // hs_phy_irq: &intc GIC_SPI 136
        }
        Interrupt (ResourceConsumer, Level, ActiveHigh, SharedAndWake, ,, )
        {
            0x00000228,     // ss_phy_irq: &pdc 40
        }
        Interrupt (ResourceConsumer, Edge, ActiveHigh, SharedAndWake, ,, )
        {
            0x0000020A,     // dm_hs_phy_irq: &pdc 10
        }
        Interrupt (ResourceConsumer, Edge, ActiveHigh, SharedAndWake, ,, )
        {
            0x0000020B,     // dp_hs_phy_irq: &pdc 11
        }
    })

Generally, the interrupts above 0x200 map to the PDC interrupts (as used
in the devicetree) as ACPI_NUMBER - 0x200. Note that this lines up with
dm_hs_phy_irq and dp_hs_phy_irq (as well as the interrupts for the
primary USB controller).

Based on the snippet above, ss_phy_irq should therefore be PDC 40 (=
0x28) and not PDC 7. The latter is according to ACPI instead used as
ss_phy_irq for port 0 of the multiport USB controller). Fix this by
setting ss_phy_irq to '&pdc 40'.

Fixes: b080f53a8f44 ("arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 32afc78d5b769..053f7861c3cec 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2701,7 +2701,7 @@ usb_sec: usb@a8f8800 {
 			resets = <&gcc GCC_USB30_SEC_BCR>;
 			power-domains = <&gcc USB30_SEC_GDSC>;
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 7 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 40 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
-- 
2.44.0


