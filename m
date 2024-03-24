Return-Path: <linux-kernel+bounces-114340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF41888FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDB31C2C091
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389C026A18C;
	Sun, 24 Mar 2024 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9ib1DHf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F0212D3D;
	Sun, 24 Mar 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321727; cv=none; b=fGJauCfj4ut34RO6pU3QQuXwGrONWsswdqLcKjGPcCetNzrLQaSfehWSaos+k46ZNblB+hy+ehJhJqQQf+/nrxT6BxYNFJqtqFVpEz5/uw7fit+hoEnBpLvO+KxOTRQCNUFpG68VKhk7edy0LANXU0laViLr2uw7EA3X/3SAgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321727; c=relaxed/simple;
	bh=Oco3c/Bg9op619lpmtlAzub1MxgaQSQT+eBfoTPStLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCDZsEXn9Qxt4z24EakyHXw+f8c+/skPgqwsrWIej91MfQvd3Px7KDU9DPzHxu0Jy4DFLbba6eAFmnB7/zUxhD96KRSfYPujrG106f7B+lqHsUxztuACJQY92OjR9UQ2uG9bS4k80axViazunbpH/SDSLwAS7t/vI2uIUMvZImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9ib1DHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B92C433A6;
	Sun, 24 Mar 2024 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321726;
	bh=Oco3c/Bg9op619lpmtlAzub1MxgaQSQT+eBfoTPStLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9ib1DHf0XCV1RSCgdLilM/ptqiYyKstS+OikHIQ/g88M9EuqfiPv1uKcy3xIQdz+
	 xsn5GzYvIzzs1TLjkZd5/j26PqKVfxYlXKzY5jsraLbKYK9RXsJlyxsKwW8+1d9vli
	 eOBK8T1SIlWS0EYz7pPW+J+KFd5mGCNHERpmNAW4wRUibkfhMocK6QIA3Qp0QET6e6
	 wdSpicT4NVwanH6xNixtRI4pR/JicfKOb5Nv28PgQIzraoaFnMamCYQCujr4mUaxyQ
	 pXU4ffgmBTeiHUuehzxGqzR4MXV00iIhs6Tr6Upz2l+LVB6kVml0DhEm0mUVwWtFHy
	 i2zkrtAe7seIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baruch Siach <baruch@tkos.co.il>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 454/638] mtd: maps: physmap-core: fix flash size larger than 32-bit
Date: Sun, 24 Mar 2024 18:58:11 -0400
Message-ID: <20240324230116.1348576-455-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index fc87213392824..9be71b045b259 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -523,7 +523,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (!info->maps[i].phys)
 			info->maps[i].phys = res->start;
 
-		info->win_order = get_bitmask_order(resource_size(res)) - 1;
+		info->win_order = fls64(resource_size(res)) - 1;
 		info->maps[i].size = BIT(info->win_order +
 					 (info->gpios ?
 					  info->gpios->ndescs : 0));
-- 
2.43.0


