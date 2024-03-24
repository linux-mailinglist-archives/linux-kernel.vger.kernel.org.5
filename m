Return-Path: <linux-kernel+bounces-115502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80D88940B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113C71F2B8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA1234D71;
	Mon, 25 Mar 2024 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM8/10Ho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC481EC62F;
	Sun, 24 Mar 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320945; cv=none; b=g0JQweE5xq+mnnNIm/T196l+vYNVsOBH+BhabcppI+iGMOuCLgetcf/DAtyrCtlAT6agOqtZiPMzfFNSTsSZ8PorgcWcAu1y1x77TQhChF13FSvCMFzKyzj+nQbxXcKnUjCXNOXaCWTWXXgFHhD++bQ3gjNBdZcaJVkn88P36Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320945; c=relaxed/simple;
	bh=sWyVu6d3FCExpe2I4sev1PhrNYX3DKWSnHtNndgvNy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avBuT7Ph1GPh7uLEpvMBRFOMQk0VvWxb4ziTXM4f4ks0yRf3SE5kmrbWA7Wu3N3sQdB7R9JBoBLBgP3+w40OW2PkwW2q+DU4By9I3zO3AbOLCDiSH5ojmPN43yVAjr2a9kDV7N6sXwlbhaJwa4x20Ra/SLNuOdtZrqiRXnRPjKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM8/10Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B1AC433F1;
	Sun, 24 Mar 2024 22:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320944;
	bh=sWyVu6d3FCExpe2I4sev1PhrNYX3DKWSnHtNndgvNy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DM8/10HoZZL43wB7eFXLL4kEWlhDq8xzTTnG/YCu4x8j6tvqhJn9zwHKnvThPlomV
	 Yk5YAcx3Qnjon6Sts/wPQVbWZgt0ow69nq+5Veg23R9V49q3ybGxKQiQ6U0bqzv0n/
	 oJir2TLedZW5VEPMDp33rtF7/ARaCs/1y2TjOz480+boPD04LOK4u7L/6Io9UB9GM2
	 AlB81Xc0YnC4WyNivlpOmMN7srI+uDKwhqY+ierrHd5bc7ZNXrAHZrC5fXZvBfAo3w
	 S3xNumNnsOqUF+ogqihw6qzLMSNr+0QKe1WRm2to1Mi1fdf7G/JK1p8xsammG0cjx1
	 BOpYbaSFFxZYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baruch Siach <baruch@tkos.co.il>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 508/713] mtd: maps: physmap-core: fix flash size larger than 32-bit
Date: Sun, 24 Mar 2024 18:43:54 -0400
Message-ID: <20240324224720.1345309-509-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit 3884f03edd34887514a0865a80769cd5362d5c3b ]

mtd-ram can potentially be larger than 4GB. get_bitmask_order() uses
fls() that is not guaranteed to work with values larger than 32-bit.
Specifically on aarch64 fls() returns 0 when all 32 LSB bits are clear.
Use fls64() instead.

Fixes: ba32ce95cbd987 ("mtd: maps: Merge gpio-addr-flash.c into physmap-core.c")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/9fbf3664ce00f8b07867f1011834015f21d162a5.1707388458.git.baruch@tkos.co.il
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/maps/physmap-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 746a27d15d440..96eb2e782c382 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -518,7 +518,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (!info->maps[i].phys)
 			info->maps[i].phys = res->start;
 
-		info->win_order = get_bitmask_order(resource_size(res)) - 1;
+		info->win_order = fls64(resource_size(res)) - 1;
 		info->maps[i].size = BIT(info->win_order +
 					 (info->gpios ?
 					  info->gpios->ndescs : 0));
-- 
2.43.0


