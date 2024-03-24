Return-Path: <linux-kernel+bounces-115009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6B888DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1477AB2F638
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32171C09B4;
	Mon, 25 Mar 2024 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxuGGTwb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5328454B;
	Sun, 24 Mar 2024 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323791; cv=none; b=MNMyTHTwdJ3mJNHPFyF9sDkrBlEcTNJ/rNeLGb3/MRoy8j8ZGCVDYmLLbhXBYaLzTtuHgpdM2YBqb8C2KrqlMOYRWGg3PEa3c1xL1Gktlvqm9ZCq5mKJQ/l2LzohBBru9SisVHptobtAeVBXpRj04seOZBRp84Ger4TcQTcP4fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323791; c=relaxed/simple;
	bh=Ne5JUfK0bvfx027NwHX7WBuLWU4K3WaQyRAFp3b+FPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWfYBXsNg8WlSsYsx0oah0HZgJvaIdAGXScU9YiQc61O7yszzaJniOQDg9oMzRgYt6hQ4aNWawRg8sSIO45m5Qwn5k7E9sy913cerPP927IGlpAIY9kQmkBIWxd6+18V0LkvJ9j+lZ1FvoLXg6a50FlwHQmKy5OzrczAQ2udtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxuGGTwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC93C433C7;
	Sun, 24 Mar 2024 23:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323790;
	bh=Ne5JUfK0bvfx027NwHX7WBuLWU4K3WaQyRAFp3b+FPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxuGGTwbPrjuTE2BIQNXf0Si6xOT1Pz4nID8I/UXN/iVRmrkT/LJnHCNfb070PhW5
	 WGmyK93T6IcVYWgXYwKmjhbPh6oBfOwZx0dcJPL+W0Ab/CIPokcnLbQJVa+Rz609j+
	 bxMX0YyFwCkZYZqd5U5Z3LcjtgcOPC7f19pTg7cuFwshTu5CBM16GavKlaMIckrcor
	 bndwyWKOuZk3R0cUBY9HxZbJfzJfUWZvZEUDJFO2/00535CTi5mvTq+w9IghlvjEZs
	 eIFQ0sxatfcktShEwXld0fG20PCixEqkvprpCS25zp9OquVwACfQANVkDIiiBPYzBM
	 zFG8saruQ1z/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baruch Siach <baruch@tkos.co.il>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 167/238] mtd: maps: physmap-core: fix flash size larger than 32-bit
Date: Sun, 24 Mar 2024 19:39:15 -0400
Message-ID: <20240324234027.1354210-168-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 9ab795f03c546..e5552093585e2 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -528,7 +528,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (!info->maps[i].phys)
 			info->maps[i].phys = res->start;
 
-		info->win_order = get_bitmask_order(resource_size(res)) - 1;
+		info->win_order = fls64(resource_size(res)) - 1;
 		info->maps[i].size = BIT(info->win_order +
 					 (info->gpios ?
 					  info->gpios->ndescs : 0));
-- 
2.43.0


