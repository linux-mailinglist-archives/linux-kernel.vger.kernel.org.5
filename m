Return-Path: <linux-kernel+bounces-40060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C702083D98D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053E01C24402
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BBF18EA8;
	Fri, 26 Jan 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K29DYwpM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F618B1B;
	Fri, 26 Jan 2024 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269542; cv=none; b=hsuG/veogbI4kDtlSPbYwjdofUuU8GzLmfI0k6DUmqYE0R0xvM7MiO4y5H9+0ykj8FU6IhXv4UKZ7hn2gbe3jvKRkODOZ8e4sUJzk50RVLngLAovN1Cc6tKtU+BjxrOJsU7UanLTFIwvKcGQyHvBVNiAyZ06WG9qLtiqUthlxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269542; c=relaxed/simple;
	bh=K0qDA+Am+Tz962izVo3NCN/SRqAQtuKwQmE4TQD42gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iubpu+9QZziY2AidS3cx1MRbN2glASwLpq2EP+zF4AJVRf2jdcjJGZmbiDhw4VgtxfH98UHO/Plc64dxN+qAjTACKjS/i3Rq/y6Iw4Ui08AvIhicgdLCYiSGJtH+wMcYHkKqyn7qyLisOP0/1Zk27Eoi+agqC1SMj9pjggPvgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K29DYwpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5412DC43390;
	Fri, 26 Jan 2024 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706269541;
	bh=K0qDA+Am+Tz962izVo3NCN/SRqAQtuKwQmE4TQD42gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K29DYwpMl4LPagwOcrAwiS0H8lcWK/iFhL5UdrrM85oVhr/96jeRqObVOy1SIBaVF
	 D399lzb5SVmui48GE5P5bDQGegZuR1h/8AKfWKsgbBS3mgJA7MzsaEq5tbVHaSMkgI
	 Uegc0cMftyBh77+Mv+L8eDDsNukzV9IFubo3b7LWcLjePO2gFwi2JjVq3EnjtIw3lQ
	 UJAEPUfdOOGLnG4BfbhJyBpkEi08nvYx4Cbhxe3egqcMktYzu8Q29Y2lH7iAfY0Z4A
	 JGa5q/OPVbHXMOlkw6TgEZ5Og9T2oecJ+WfLpEHuficuBOQ6EOvBCwlBJuTlJ06F0g
	 MWTHlbnI0zegA==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	a-bhatia1@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/3] arm64: dts: ti: am65x: Fix dtbs_install for Rocktech OLDI overlay
Date: Fri, 26 Jan 2024 13:45:28 +0200
Message-Id: <20240126114530.40913-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126114530.40913-1-rogerq@kernel.org>
References: <20240126114530.40913-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the overlay dtbo file to a Makefile target so it can be
picked by the dtbs_install command.

Fixes: b8690ed3d1d1 ("arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 52c1dc910308..08ce34d21d5d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board-rocktech-rk101-panel.dtbo
 
 # Boards with J7200 SoC
 k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
-- 
2.34.1


