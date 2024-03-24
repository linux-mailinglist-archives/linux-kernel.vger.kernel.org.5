Return-Path: <linux-kernel+bounces-113144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DF8881CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3590B1F2187D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9316F8E5;
	Sun, 24 Mar 2024 22:39:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF916EC04;
	Sun, 24 Mar 2024 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319951; cv=none; b=nS8U4+psogbVSQVJIyclIs9g3Frb0MxZ2NtnAvEtEPTpD7VWmiMQYHvyL903f1Yei1GDS5VAO4MmydoKb2p8ZkCPdtfohalCmKcJOJ8fEUW27sprFsA7H73x5eg1gnGRAkyiW8N4Vd6xvVDUHGkm38bzrZ+Dr0r3WNGXUjkbeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319951; c=relaxed/simple;
	bh=8a8yUbpxmH47E3+zw0R/B+Uv/KODFRMskQlpXkg9AKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNE/WnYM8tkEkVX9N22e1mtrsh4EVextQ62eN9SNEvHt5GbxpySOtZd/YBwxECdwXethPNJTP2iK7oFMa9OXcqOP2CmmWeDisB87rKNJHaYASGiZNZndMMg0JpyxYao/CPCd5ZS+r9IO9Ek+QTgoXfQbMyySUrNThaFsFj7qaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1roWUV-0007sn-Gi; Sun, 24 Mar 2024 23:38:59 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	erkin.bozoglu@xeront.com,
	mithat.guner@xeront.com
Subject: Re: [PATCH] arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f
Date: Sun, 24 Mar 2024 23:38:52 +0100
Message-Id: <171131986741.918919.17715253575566956746.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240314-for-rockchip-mt7531-phy-address-v1-1-743b5873358f@arinc9.com>
References: <20240314-for-rockchip-mt7531-phy-address-v1-1-743b5873358f@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Mar 2024 15:24:35 +0300, Arınç ÜNAL wrote:
> The MT7531 switch listens on PHY address 0x1f on an MDIO bus. I've got two
> findings that support this. There's no bootstrapping option to change the
> PHY address of the switch. The Linux driver hardcodes 0x1f as the PHY
> address of the switch. So the reg property on the device tree is currently
> ignored by the Linux driver.
> 
> Therefore, describe the correct PHY address on Banana Pi BPI-R2 Pro that
> has this switch.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f
      commit: a2ac2a1b02590a22a236c43c455f421cdede45f5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

