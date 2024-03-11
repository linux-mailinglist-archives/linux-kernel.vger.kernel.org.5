Return-Path: <linux-kernel+bounces-99375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3064F87877E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB1E284C32
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041256473;
	Mon, 11 Mar 2024 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFlwFl/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F456B81;
	Mon, 11 Mar 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182185; cv=none; b=qV0rGQ+8Sg8xRi94ZbcAI43dQyiTsnfKJVTghkT0xNggr7miX8eeAszLNxg0AxSTnLJ8aV7upMU7HGq620/krM+sJEJqVTNGzeD8nFKvo4RIiilKh7T1b4yqWkvHx6vQCe4ZziVOQqZCXYmeqvpHBPxEsuG1AVWs9cqZx35VLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182185; c=relaxed/simple;
	bh=Y+UHlDiy8uvUENg5cAI0NilWxjZPgayU30fDLGY9yY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBHBjYmDA9MIk42ycB9x9VOU8lHTdc94xwyuOCEUT/MDx9dghUzVmnIf4N3PHgXLm5u6fb9hgtgaATPTYKZxYwLZmmXh2LEjzkfcMIPX5az0yTYuL9PCbHPyXReH9KO0zY113OVH6vT18xiEkkZfpR1Wj/0/n5AiRoAc+y6PmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFlwFl/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC534C433C7;
	Mon, 11 Mar 2024 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182185;
	bh=Y+UHlDiy8uvUENg5cAI0NilWxjZPgayU30fDLGY9yY0=;
	h=From:To:Cc:Subject:Date:From;
	b=lFlwFl/tvCfqrxj0C7qZ8DfCnNiaH5dMxXjn3jrUOKh96FOLWLHR8w5yrb+3QR09Z
	 /NcryFYsYGnoM32NjGLfyHMt44+MdR1DjrJEESejlVIkr8EgefQGNzvNVU/rNYQmm0
	 /SRlB/fAap0SlIsdO5Hfylcqag6RBA3VXrjy0XTqxQJsDPsUvDCcd0x4S8YX602DMF
	 OG4ufA7DvJ62gX7KB840LIPq+h6PtrlomHIUSXeVO8bKhLGcsWHafBBV2tH1HvTUa3
	 TiTGdODiE/Ad6yCji88KTeToNmq23Y5qfJCM5Eh9OQtgq2AvxhXaPyLJDCbIbtLBjb
	 A+uxICoOYQYcQ==
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
Subject: [PATCH AUTOSEL 6.7 01/14] arm64: tegra: Set the correct PHY mode for MGBE
Date: Mon, 11 Mar 2024 14:36:04 -0400
Message-ID: <20240311183618.327694-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index ea13c4a7027c4..81a82933e3500 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -175,7 +175,7 @@
 			status = "okay";
 
 			phy-handle = <&mgbe0_phy>;
-			phy-mode = "usxgmii";
+			phy-mode = "10gbase-r";
 
 			mdio {
 				#address-cells = <1>;
-- 
2.43.0


