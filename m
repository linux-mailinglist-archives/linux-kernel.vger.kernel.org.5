Return-Path: <linux-kernel+bounces-59783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72084FBB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517FC1C242A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4082866;
	Fri,  9 Feb 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HkFuhZL1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A57EF0E;
	Fri,  9 Feb 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502716; cv=none; b=KvISTlNLYy1+p6Mt/c271qBk5oONXGSQ/PAZF2Z/8TwbMXdN/+xmsOwARKCSq8S8uJzKSInHcX99zo/F6hWvtuq01JTQIk7jWTPav4njZ+bSdDxzcSBZlPYTOf4mQUA6uNEyC9jCGD0JBQ65Q4QgUfTX/o3eaRZJhUAJxZyASrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502716; c=relaxed/simple;
	bh=MpboPBc+N4LaDq5m0T4vAFnpYG6z/CneePQ9zzqz5/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd3TXg2EeI7752XOpGOmPl+i2q3loPY6JmjS9w+njLuBo4oSCLFShh7ERklNrRDb2Y2yY9o26Or+SYgHdV+ufPFHOgBhfEp0wQ5yG8BINHfpfb2qj+WIN54ayqRUKNI5t6mjAhQhXCWFWO2/AWmTSaOuqQk8FirPlqd9Tw3v2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HkFuhZL1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707502713;
	bh=MpboPBc+N4LaDq5m0T4vAFnpYG6z/CneePQ9zzqz5/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkFuhZL1qFCQBpdaVTY/tAV4eh9SR49iN/g13SDf6IYoVfwscaqvPphx2VNMv6NTW
	 dOAcaPW3XYnxTFT4fJMiALVv+hQOR+KokkBXI8ApCe/Ap2VCjsohJOMBlhPX1o6Ohf
	 xUGlY+BLutLYQyCnJRr/ZdRPZYdchKn/52ZntDSVY9E5ZdGoiPBnaITi5aIlrRbBKS
	 yV1H9x6oxygrX3H5JTueONSnURVILzxTsHZtYeU8t6YIyIEEwR2PsJPinwybxZfcpF
	 GXlrbH4dByQTlNmJqNa54Qoal8NpuWOQYekry6B7+JJEzaA8yiYazAKKySLxfX9MtA
	 I2ynmsgmBawoQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0545E378208C;
	Fri,  9 Feb 2024 18:18:33 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8FDF54800D0; Fri,  9 Feb 2024 19:18:32 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 02/10] dt-bindings: soc: rockchip: add rk3588 USB3 syscon
Date: Fri,  9 Feb 2024 19:17:18 +0100
Message-ID: <20240209181831.104687-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209181831.104687-1-sebastian.reichel@collabora.com>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588 USB3 support requires the GRF for USB and USBDP PHY.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 20bc1f46384c..12e7a78f7f6b 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -28,6 +28,8 @@ properties:
               - rockchip,rk3588-sys-grf
               - rockchip,rk3588-pcie3-phy-grf
               - rockchip,rk3588-pcie3-pipe-grf
+              - rockchip,rk3588-usb-grf
+              - rockchip,rk3588-usbdpphy-grf
               - rockchip,rk3588-vo-grf
               - rockchip,rk3588-vop-grf
               - rockchip,rv1108-usbgrf
-- 
2.43.0


