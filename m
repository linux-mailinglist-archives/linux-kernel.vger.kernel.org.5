Return-Path: <linux-kernel+bounces-149956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B013C8A9854
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B796284261
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07915F3FC;
	Thu, 18 Apr 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPxptB+i"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91B15F326;
	Thu, 18 Apr 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438668; cv=none; b=ThHP+LMZey+WFLIKkJDjGoaCbmbVCxJlfLYXbkueUMTHENZb5KzT5itEt57v135MO22561X5GljRTWANHSGAER3EPz3w3S3c8eve3SynsyUdoLCmCwU8L/WhSXY2loXkdbFofR/+GO8WAk7UFYbYruwXHIrSMUSCkIXLoIPl8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438668; c=relaxed/simple;
	bh=MkWEyyE0Nhw0JoHKbE3hW1kmGt0W+ifC+nyPrGRuBmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ov6oL9cJITIvew9ujj+84FCXfFGtdjW+IJoM7Hovb8majR645VBMTw8sjq1HoeM9PJbPsIkXcEsrItimoMJ5EewN5AmpHDWPmkPt2aigQlLPhALHKBkuFWYIGV6L+4/D1ceNC5VNCjIcwiQ5BAP2dJFG5ysK+XXb27s/ir+3q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPxptB+i; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e86d56b3bcso6764065ad.1;
        Thu, 18 Apr 2024 04:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713438666; x=1714043466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lxb2yFQOzOHStfCQA/m2P7fU2z/qbCohGERMxV0x4sk=;
        b=WPxptB+iur2mi30cg+k4hq/rIlYgk0VW6zdPnDuGYUic/dNo600iD9zcals928OpGz
         m9gvxnVVrftJaao2EjK8fcPpgsADfHSPHGZP/t/d4RKjVG4+/osOvhr4omrT17uoPaj2
         1VnNrlPzpcNjEUHujjCzGMGr7054W/FaqIEdAOnmPHDOMUg+YvRgz8utfFA0GwqOH1bo
         QXQAqrlX5UjoD1bfUEipRkqS4qWxQ/EagYX4jT5kjsCJ5clTUKErlVnzHQVnK/3Z92AI
         dat7P28rhNqa9maPCEMZx8H+tFhLfPqRvTBrEGGhfTYu5DFhp2fzy43WmFuQojKq9kNW
         rdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438666; x=1714043466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lxb2yFQOzOHStfCQA/m2P7fU2z/qbCohGERMxV0x4sk=;
        b=wdW725d1yAfqNDKpRqPOTTAmUiM6QGbD/sOy+vAYqDa8F7NtHGq9M2H7X+pOO5dUe0
         qUjRGg7b0c2PYFoqp+eJqW1WOtHiikKKDidNzLTZPIjv7qyDOn8a6pEEFe7Uc4G8kCxL
         ygjs+FhVDLFEo4xEjcALPJsssvc7iU62VFhj7pfV8v7wfmWB+WLcBqmsCQuU1qEzHH1V
         rIlUYJEfO3bmVtqJ5jczK6fuWNLE65VJmWf/5Ft4kw7oqgYOZ2br9IQrB9zHCnJ3QnAX
         6/nAhX5j+r4bqqr1zElhACQ9RIvonEFNkg3ycvh9Al9anl6Lwb71DKamtWyltSVld4do
         LVtg==
X-Forwarded-Encrypted: i=1; AJvYcCUCOrjQVx3Y6slaS43v+28ThFNN0ZqZpT1BfcXQJD2/bj5WJrqBKlsQvd9Uj3AkXvNtA097MI5IbTNMzMGd2/BP2Qtje8B5l5KVUILas0GT6fJoEQIaEcvSIvRk6JP7oW4xd+53CIn9+Q==
X-Gm-Message-State: AOJu0Yz+JUFg5jy2V5CXSl2dSfmAeTYpEm5laSIuT0LsokqCcJcnYoPi
	kYaDRiSkTQ84Qp5M24Ifcpy692kYRQfgCkc5E3ou9DApX9tm9dbv+0A+FDytnts=
X-Google-Smtp-Source: AGHT+IFslWsdauAw3+GK4AxaZnWnbDcqaOOWdRddILDSGXxdvFx/EDWKsSl4+dq3Al/RraRAbXnS5Q==
X-Received: by 2002:a17:902:c185:b0:1e3:e0a2:ccc3 with SMTP id d5-20020a170902c18500b001e3e0a2ccc3mr2740474pld.30.1713438665941;
        Thu, 18 Apr 2024 04:11:05 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e4d22f828fsm1051159plb.33.2024.04.18.04.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:11:05 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	sebastian.reichel@collabora.com,
	sigmaris@gmail.com,
	didi.debian@cknow.org
Subject: [PATCH v6 2/2] arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
Date: Thu, 18 Apr 2024 19:10:02 +0800
Message-Id: <20240418111002.83015-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418111002.83015-1-liujianfeng1994@gmail.com>
References: <20240418111002.83015-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Hantro G1 video decoder in RK3588's devicetree.

Tested with FFmpeg v4l2_request code taken from [1]
with MPEG2, H.264 and VP8 samples.

[1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multimedia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index b0a59ec51..b0817382f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1135,6 +1135,27 @@ power-domain@RK3588_PD_SDMMC {
 		};
 	};

+	vpu: video-codec@fdb50000 {
+		compatible = "rockchip,rk3588-vdpu121", "rockchip,rk3568-vpu";
+		reg = <0x0 0xfdb50000 0x0 0x800>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vdpu";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk", "hclk";
+		iommus = <&vdpu_mmu>;
+		power-domains = <&power RK3588_PD_VDPU>;
+	};
+
+	vdpu_mmu: iommu@fdb50800 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdb50800 0x0 0x40>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
+		clock-names = "aclk", "iface";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		power-domains = <&power RK3588_PD_VDPU>;
+		#iommu-cells = <0>;
+	};
+
 	av1d: video-codec@fdc70000 {
 		compatible = "rockchip,rk3588-av1-vpu";
 		reg = <0x0 0xfdc70000 0x0 0x800>;
--
2.34.1


