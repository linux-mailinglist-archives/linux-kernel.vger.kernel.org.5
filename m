Return-Path: <linux-kernel+bounces-114582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF81888B24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9680E2902FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274921FD102;
	Sun, 24 Mar 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCgFeTkT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737C1FD116;
	Sun, 24 Mar 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322236; cv=none; b=qdLLmQ+1yDegiwRJxAmAp2+qEufm9MxBPRCFLpTIKACkqxR0rSPkx9YY4qX6lcXdKtkF+Dc90o3cVmcrZaXoSWecP4BEwrOXnuF3g0tTGGeUhLggJub40ZGWf6wmaCYMJdtZIIgfZZNaeGMvEninXgG3yjzk0eRlHjAu9X18UOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322236; c=relaxed/simple;
	bh=OvlLyEvhkroWo3e9HtWH1UTrzYNDeDm/r4YRohH6XKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqLKhhbMv7JjS0co2vCfdLypVBZQGCQX7bbdvnjGphEdnhuZ4SOF2QbpNLI96lLCVw6qXBySss/sEvk115kijEly0zfMhkR84xxWbGsbH1XmF1PqcqynlLk9tlcD3GK3H4yEsQas9wos8gAtCQz6fiSpmpwl420QTZMdge9gMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCgFeTkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85945C43390;
	Sun, 24 Mar 2024 23:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322236;
	bh=OvlLyEvhkroWo3e9HtWH1UTrzYNDeDm/r4YRohH6XKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCgFeTkTPJ7R9tZlG+c4UkVi0MpbCKE6jRVA+qTsmGRakouh1vanVyC+tS3yFs0yb
	 eHbgxeup0ydpcqYua6tTVSWm+SI+hkq/nyXICWoHOk3gPeSI2NnlqqWPLI+ORI+qa7
	 FbwIESB3MvU5rxJUQrvdaELVrPvZVVrVRSPDFEg6rr0gWqBCQOAhowJa3tMXwsFgbv
	 vohBzRatH7YZYn5H4ZGlUlpfHbN/wRPXAn8xdWU9KINPSEKZudB8kaPMG85HYCsHUE
	 kJXo1yoYwe+EDFO1brfVa4nY5EFdiCIKlBQ0uMEtKivjTj/LWSQYT0CA3S70b8B0kS
	 J0IscgxrHm3Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baruch Siach <baruch@tkos.co.il>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 317/451] mtd: maps: physmap-core: fix flash size larger than 32-bit
Date: Sun, 24 Mar 2024 19:09:53 -0400
Message-ID: <20240324231207.1351418-318-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 19dad5a23f944..8cdb3512107d3 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -524,7 +524,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (!info->maps[i].phys)
 			info->maps[i].phys = res->start;
 
-		info->win_order = get_bitmask_order(resource_size(res)) - 1;
+		info->win_order = fls64(resource_size(res)) - 1;
 		info->maps[i].size = BIT(info->win_order +
 					 (info->gpios ?
 					  info->gpios->ndescs : 0));
-- 
2.43.0


