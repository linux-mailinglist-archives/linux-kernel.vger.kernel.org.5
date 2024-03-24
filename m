Return-Path: <linux-kernel+bounces-113368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 283398883C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB8CB2185C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB0419D8D6;
	Sun, 24 Mar 2024 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ6SaNS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4ED19D8B9;
	Sun, 24 Mar 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320169; cv=none; b=fTuDT0FOCLRqzHeACZBcQBpqEqFLIihjNUL6jbzByzeeSKpcVSppW1ZYgf1ws/6ASK44g3SNbHSDRGX7kBA0MHZlCCvhpRCWUkD9xn4T0daJ4+5bMYvv51aWeRmc8lbvo80ysoXDKioNfTOz2vW+NHtGaJ5owPsC2evkuTsu3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320169; c=relaxed/simple;
	bh=sWyVu6d3FCExpe2I4sev1PhrNYX3DKWSnHtNndgvNy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ph2bDchILfmdllziYF4bHIo+cij/cZhPe9TwkqmTpfHIODHFl5wBH31d6TWSCemEghzJWxfk3p8YP7eyQ/aOA5WQQ17yXY2Vyw4IonqcrgpF4/A5BPfNEPCsXU4PHUB7vVt+cfd+jtt1pNMbST9Jp5YG4Ib4hGo7Z5jbZANU37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ6SaNS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C422EC43394;
	Sun, 24 Mar 2024 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320169;
	bh=sWyVu6d3FCExpe2I4sev1PhrNYX3DKWSnHtNndgvNy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZ6SaNS/WsMCDndNMHQD3Hk3NzX9QB1wlM4YaThO7NZH+GK8WuL2fKQyHJePDwB9W
	 laFUDAGl/XVbaHMQ6nkLrbj0oNV+VKW5ycTIsjn6GAD/0axBO7eWPL1RxnjvtWAxEl
	 LyDUW0uM5ZDaF9DqxoDN4MmiBq9+EkQ0Cw+VbC5s80n4OpPvz2wUn+WW6kE+TrMSyf
	 KuFboiegc+BrhVWZNqwOTldqH142FSYLqafD4z04A/cUt31oaAuO4BX28iv+NW56Dl
	 Xrt1m+Q5z0kNzTeoIJWIqNbkEhzmQmw5JoralIYwi/88N/KLAwYHeDkwoXmkJPOEkG
	 zmTpgtQLLXskw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baruch Siach <baruch@tkos.co.il>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 477/715] mtd: maps: physmap-core: fix flash size larger than 32-bit
Date: Sun, 24 Mar 2024 18:30:56 -0400
Message-ID: <20240324223455.1342824-478-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


