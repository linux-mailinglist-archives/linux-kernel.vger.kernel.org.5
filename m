Return-Path: <linux-kernel+bounces-99389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF8C8787B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DCA1C219D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED49756B6F;
	Mon, 11 Mar 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNdpZjFM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D15D737;
	Mon, 11 Mar 2024 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182258; cv=none; b=sZRg1tvwHUjKB3FSLD5IJZ1UKcmVN5pNoYMPNWOggHxFPCOzKOgYGAUX6BoCXHRtpFNhvfnC1mv/IoKmkk7+Z/kEcEIW9k7zftta9nayEwGReZUFGxtyEMC/wSY/dSgEniRXo9CnzcJ5Jk05GyoefXaTKAhjbJXN+7/7YNZnd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182258; c=relaxed/simple;
	bh=JWZSCtt1oiChp96aTaaowdnbk4pXnRycjc/puS98gYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+B+IQPKfdp9qPkVJNew8JKEBmxGOVnT4qgx7D/z0ZLFNKw1WS44UdLRWIGSlf8wUxjznlzFZTEPTKdDrlFZi/7CoBgCaNIUbrQoxxn69TSa329j6FLGq9iv/wb3EH9cKRoD8QZ/dEW6UKhfW+cHXSm1RHTeLWPT6wdoCKjoqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNdpZjFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28ABC433F1;
	Mon, 11 Mar 2024 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182258;
	bh=JWZSCtt1oiChp96aTaaowdnbk4pXnRycjc/puS98gYc=;
	h=From:To:Cc:Subject:Date:From;
	b=GNdpZjFMHjqA6RRZDBFgzc6sDfgiJwonFToGcsj5A1JQIWPPNc+m3bhxYBA9CS5lt
	 U5OlUnbSK4HzMyEcJRRgIHGJ7CAZaffYy2LR87cM+sdNKt4Ko6xsttkjYmwd5Xp1r4
	 5EL3EB/kELBcsSp0uaOF1/xV0DtTCux6ZWyvlKON5ZERSIjro7dqDNH9FfqVVznkZp
	 0v8+6S3FnUhmAo/90UYjNQj137ly33lJ57Ki8bGMgktkOrgJvoPqcGpk8Kie4Nk8Ur
	 nOmVTjBMsRyy6qopmHtahh3XfCAsBx2HS8yn2kW+tNVSzJKZgcGjg5wQN/gnMMlyba
	 O/lJVruSjlf9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	thierry.reding@gmail.com,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/12] arm64: tegra: Set the correct PHY mode for MGBE
Date: Mon, 11 Mar 2024 14:37:15 -0400
Message-ID: <20240311183727.328187-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 4c892121d43bc2b45896ca207b54f39a8fa6b852 ]

The PHY is configured in 10GBASE-R, so make sure to reflect that in DT.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 4413a9b6da87a..bf2ccc8ff93c4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -174,7 +174,7 @@
 			status = "okay";
 
 			phy-handle = <&mgbe0_phy>;
-			phy-mode = "usxgmii";
+			phy-mode = "10gbase-r";
 
 			mdio {
 				#address-cells = <1>;
-- 
2.43.0


