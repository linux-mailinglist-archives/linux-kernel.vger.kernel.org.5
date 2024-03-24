Return-Path: <linux-kernel+bounces-114873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496C08891EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0388228A2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0727BE16;
	Mon, 25 Mar 2024 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZL+rg3f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42B177AA5;
	Sun, 24 Mar 2024 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323519; cv=none; b=jnqtAMQ7ctROsL7ezkM3vTdxyFRE5o0DGevoPdk/O8rhF0Wxl0hquE72xOCktjeUIR6HtPu3Rvhp7Es27+KsyQGGUcdP+OjH9GPScgx7wtA1Ip/1kEmApFR7z4JnzYZbjw7IOC+E3rhLsuOSxWOWntTAN2KZBANkapNv1ralHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323519; c=relaxed/simple;
	bh=Ne5JUfK0bvfx027NwHX7WBuLWU4K3WaQyRAFp3b+FPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiVGBg2c3g7M7/2juchuWeIKk3Ze6BiuirvT+w+ThCe5xGJW2e9C7PDh2C0YZ9Ogsx8b29LgWfZlBkqfr2l04GPk719Cm/N1rlSNcM/T6fU5T0+BUo5QUEmUA/+aqdAlJZOsGVCrEC3ZFqoQScgt7gDyKKBbtYgerMvEwEFzX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZL+rg3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF18C43390;
	Sun, 24 Mar 2024 23:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323517;
	bh=Ne5JUfK0bvfx027NwHX7WBuLWU4K3WaQyRAFp3b+FPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZL+rg3fFH0ioPiKiu5qe2bqbo1lg+3t8tL9GLzjVGf6iDqM5st6u82Ut8l1JDSao
	 BLd01hjz9voGA+ibAma1GdKEgo++yT/QKZeBkrp1v+svb/MySKQH5SrFXf8PZH8+os
	 IP1/nNn3feWDRhK6Co2NQiR4onWGC3eTNBkBdW+UCoceE2N3s3MBUbEop5UZfW+X3m
	 ul9bLkeQhaaG6nmxPqO/9elUeIEKUkgXTe3ezH70fJvG/hMwxH2GjIrFZm7a+x5RfZ
	 3HVHg06GTKgYmqBRXEggnC374sLJB5ZfkwhcM+pcby7GsSVlwte3YARKKt1oi/LgMW
	 GOqELSQxlcqfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baruch Siach <baruch@tkos.co.il>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 224/317] mtd: maps: physmap-core: fix flash size larger than 32-bit
Date: Sun, 24 Mar 2024 19:33:24 -0400
Message-ID: <20240324233458.1352854-225-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


