Return-Path: <linux-kernel+bounces-63897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB685362C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C131F26A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF055FBA1;
	Tue, 13 Feb 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oaok93SS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2409A1DDE9;
	Tue, 13 Feb 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842175; cv=none; b=i/8qNSTRK3iqf+dq5ZcDtsO41KUT+z/juH98du4ogxzGweqHQxQif2flmJNtFbEXIW6bSF1AmnouM7DdNvg6qavuyQ/FwIIEHwKK/xH+zMuiwl7zwpR5CYoEuIAyLNRNmy7ubLAYKovGx5trSsyxbf5Dyx3hz5yKK7tWAdcwV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842175; c=relaxed/simple;
	bh=Stme3NHXDHiNzytVLTnIW18XS/qOabrFsQeujcPp0/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyvCyuPbf3p/EHFl+cx5eea7ecF8RV1I9BWr5yzfBxxjrQmRjEFx5Wkj+0fwkWmgKlHtHA8SM+XPdWRyuTAYc0UJt5qiOJeoUPPYHZUg1u5vz0rgR/BqbnpiaRvCY5hIax1SNDx4y1aGhYXFarowKBT1xDqMZrRqu+vd38wQZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oaok93SS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707842171;
	bh=Stme3NHXDHiNzytVLTnIW18XS/qOabrFsQeujcPp0/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaok93SSV42mhGnPpjPmDUOuM7Kjh3aDN72Nff7oMEwyRuvLiwPOwjnLg6d8W9xUW
	 YsrHNhp/7nVlyVfzrcDoqTbXFro0ZvJBc8hGCn/9gKylRmnom4URA0vbx7bbGowFBt
	 8bzu5W/U/RLJS2j+96E7FFkZI8n5OldMxp/mnByBojsNe2sQzRQSxDQWx9PQR6sMy7
	 vNMDcq9FmrlqNy7+L4AWXagC4q0KSG8axT/yaHti0+acZvSjkJWcgHyyqJvNy5KPzi
	 8YuW+wWibcIyJ7FOt8bFTNC9SKC0I9ILA/xVg3zk+attjoCStLqZEL/E82y55JdsP9
	 FYpDvPD5YoTbQ==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5C3803782074;
	Tue, 13 Feb 2024 16:36:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id F19684800D0; Tue, 13 Feb 2024 17:36:10 +0100 (CET)
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
	kernel@collabora.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 02/12] dt-bindings: soc: rockchip: add rk3588 USB3 syscon
Date: Tue, 13 Feb 2024 17:32:36 +0100
Message-ID: <20240213163609.44930-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213163609.44930-1-sebastian.reichel@collabora.com>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588 USB3 support requires the GRF for USB and USBDP PHY.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


