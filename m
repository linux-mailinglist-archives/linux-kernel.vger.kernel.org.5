Return-Path: <linux-kernel+bounces-101603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3287A939
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF451C23537
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42658119;
	Wed, 13 Mar 2024 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V30hA1Qa"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4254F8D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338952; cv=none; b=q0TG9Ow1lGVV4zbH7POph7cPm1laYBeJOZp0EmFstrO6Q5ByPdhi7ftZvyTYWUE755UbtQwVOd6AQ1z03Rjirw+ioHhwl0IqTL5CUCGKzLQOPb7+vlAUfbKwaQvgFHWwEdoJeMLnZk4bYBgRb4d26HYS0Ckukfv3KnS5r98KGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338952; c=relaxed/simple;
	bh=kVdZlNo+N/KnAT/Z2kOTskJN7eca2zSo5mLfoyTSMUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpjUd8GYpnrpyPwaYj7Ko6/gHdGmJZhrVbr25xCOznusESek8IejOi5YP0iA2YOhYzo93w/vGmsSP4L0tAdeMf/1OUhhNPUEbpo32IbIiWIyrGVtlqFJ8mD6v8RFPKdPo/U5JWIVmNYrwY9JdW/C3xXVTh+rcfN4iuKn/BIJFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V30hA1Qa; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-568307fe62eso7246721a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338948; x=1710943748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZRpUUNRnIq77pI2eAogF8VwCXAgFL/1g3LqDmhWq/Q=;
        b=V30hA1QaJl/pohCPP2spu8V8TnfLYQFGL9b5M9aaNJn6LFvmUsA9B6YAtWeBA/dpx7
         Vgnay6FkJdGmznWb7C6LELOEq4djOfr/bORVf0z0Lxvu0kAS7Cbex0ToFx7BP9xlzq6k
         qlA/e706OyPG50TN2g/FJltK6NmkIXaQX73OqD8brHKlAuiLXi9WJ8o6hO2YYNRZlmsu
         wSxn5fxKAnwD/PE3LdxDv4R6qHoIaaO0niz0pt6dF4i9j/knuKyQHVj7G/zV1ypnEUgk
         C3XfUud7yj/AAOhUJBRuXmLs/TXr8ohGaMa+eh4R7oxRIaViMGFTWwqKWiywZLvbkDuJ
         BWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338948; x=1710943748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZRpUUNRnIq77pI2eAogF8VwCXAgFL/1g3LqDmhWq/Q=;
        b=duaVrwrFJ/JPH8iAq+sZFa4Dqtp3Py/m//kX3ooFMnHSuT+wTRkdLJjyMH+IpK6++h
         khu4MciQZiqTQbPig6WqGReXL654jLxES29IDltv++MiR43HACVvtPo3UT3L8Iw1TmVG
         510VrMQ/VHI42CSWZhZ0EMOEnrTdk9kEY4nRiBT0GOT402Fr6SGKTWsfs09Fn3mf0gpC
         lHO27i0ivIYpQH6l3yoxgiZfpGvgv9/81mM91MQtnLMPn/UO4kuIKuuzNmAIIwXBmftM
         K+xJ+pnuKI/JesRzlu+BKZGnLYU1sQLpKCwnmwv0LEbj7NtdeHX8Kmv3fnWVSSBPUpSN
         6yPg==
X-Forwarded-Encrypted: i=1; AJvYcCXyTN8i5/lb0+Ti2CtLMzSurj4XevbTrecS0Y/OfAjR22mckrw71fFML5S/YAY0sA8MJQMSHd9gvMaUTnWjyu/pl38Pk92BLAuEYLZd
X-Gm-Message-State: AOJu0YxE4gcsGzIrRy/y/ADtFeXNHVBcPfZTYao1/fdGaATkf8hAfp2P
	MEHF/OqGBvZj79XU4s7p/WnmWs3vhFDHzOio/hnVDqmOuqphlbDHBKuf830gDuc=
X-Google-Smtp-Source: AGHT+IHXP//swNkKDNyDphpeA3YlUW8pirt81Yn5DGc/hQTDcD01ShGZgqiYGBU6e4PUzoyKglVJzQ==
X-Received: by 2002:a17:907:1819:b0:a46:5941:8927 with SMTP id lg25-20020a170907181900b00a4659418927mr1199309ejc.68.1710338947965;
        Wed, 13 Mar 2024 07:09:07 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170906ae4800b00a4657cad7e8sm701392ejb.127.2024.03.13.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:09:07 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 15/15] ARM: dts: bcm2711: add bcm2711-dma node
Date: Wed, 13 Mar 2024 15:08:40 +0100
Message-ID: <c1ef1ba7cd9153d607e6130277e560b139056fd9.1710226514.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710226514.git.andrea.porta@suse.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
to access the full 4GB of memory on a Pi 4. Adding a new node to make
use of the DMA channels capable of 40 bit addressing.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index 22c7f1561344..d98e3cf0c569 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -552,6 +552,22 @@ scb {
 		ranges = <0x0 0x7c000000  0x0 0xfc000000  0x03800000>,
 			 <0x6 0x00000000  0x6 0x00000000  0x40000000>;
 
+		dma40: dma-controller@7e007b00 {
+			compatible = "brcm,bcm2711-dma";
+			reg = <0x0 0x7e007b00 0x400>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>, /* dma4 11 */
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>, /* dma4 12 */
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>, /* dma4 13 */
+				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>; /* dma4 14 */
+			interrupt-names = "dma11",
+					  "dma12",
+					  "dma13",
+					  "dma14";
+			#dma-cells = <1>;
+			/* The VPU firmware uses DMA channel 11 for VCHIQ */
+			brcm,dma-channel-mask = <0x7000>;
+		};
+
 		pcie0: pcie@7d500000 {
 			compatible = "brcm,bcm2711-pcie";
 			reg = <0x0 0x7d500000 0x9310>;
-- 
2.35.3


