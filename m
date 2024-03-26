Return-Path: <linux-kernel+bounces-119516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB6988C9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0671C36B84
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61DC1CAA6;
	Tue, 26 Mar 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r07DPXCb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415211BC39;
	Tue, 26 Mar 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471957; cv=none; b=JC2xDTeyrzA88FO9hkWMxnoZERn6vtm/bCCqjkz0Jwp3t9YOVl44OSML7glRtd1ddBmTmyTTZj91LBJ6Y27B/nEIskeivFfznPAvfwRQRVzHcDPNQVggCcT2ncllXvM6EyGX+TAjZ+KTxRxCWdSzJp0PXdxxeFQwnKAc2HIz69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471957; c=relaxed/simple;
	bh=I3p4Ib0ISW7IQcsOO8wa91qosPmVrlgxRcCilUELSWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEC3jVlFQPZFZWHwGSLNA4ijd7VOHQrqa2b8EGTmxW4UyhlOQxh2tn621g1dCKPJ0QoK8nZ9R9vXePNlF1ZWQAvufjA+epBlOt35DsRZaawoz0FlcZyEZ18ofHnJhcfELmeI9S8sMVNWSEGnrkjJkZI5rjxERSM0opOc1EsbPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r07DPXCb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711471953;
	bh=I3p4Ib0ISW7IQcsOO8wa91qosPmVrlgxRcCilUELSWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r07DPXCb3eSsJ+fTABB6u4byIZ15gIFRrWsVgKw+7Z/pyO2WwsSWPSYMip/RrclC1
	 wdUa9U35P4fIjxYNtmQtqPPIsclLTk4Mp2ATMqI2v9/UvqA/ucbKiw6UJNQ86fky+Z
	 O49SjWs1zaKf4YrNObTczT2rQp+41lULnmHyUxWfowbWne0phPvULFFwNnDiqyDN91
	 HEM5safl4msA3icuRiE7noHGu8wkesy3YRBg9FdCPjy4uWrgkILCyCmzsAWLYnD8qO
	 jM/alM0iWltubxyxgUyP/SgCrupC9255lLfen0xRkTF8PVzKl0hlP5ChlwMQyRckpF
	 6vSijGRZBph9g==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6A0B137820CD;
	Tue, 26 Mar 2024 16:52:33 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 1188E4800CB; Tue, 26 Mar 2024 17:52:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 1/4] arm64: defconfig: support Mali CSF-based GPUs
Date: Tue, 26 Mar 2024 17:52:05 +0100
Message-ID: <20240326165232.73585-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326165232.73585-1-sebastian.reichel@collabora.com>
References: <20240326165232.73585-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable support for Mali CSF-based GPUs, which is found on recent
ARM SoCs, such as Rockchip or Mediatek.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..65e33174f813 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -907,6 +907,7 @@ CONFIG_DRM_MESON=m
 CONFIG_DRM_PL111=m
 CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
+CONFIG_DRM_PANTHOR=m
 CONFIG_DRM_TIDSS=m
 CONFIG_DRM_POWERVR=m
 CONFIG_FB=y
-- 
2.43.0


