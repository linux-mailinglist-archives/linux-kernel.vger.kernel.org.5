Return-Path: <linux-kernel+bounces-115134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C71888D57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A812E1F2A1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D361C6FD8;
	Mon, 25 Mar 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/lySQEG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B50229BFC;
	Sun, 24 Mar 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324133; cv=none; b=tyR5zJv28SAyOsyCeBaRqbT1E1yZRMzwKuPmEaWfa9SXoXCEglYqA0Wfg3mQKTCbvHY0zs3vGBFedRjE+lIzDL8vtiEpF+6YjEbOZFdiXT6V/uWn9C7xKy5UGHNBuK56yNMrrPF17rJP4xApG2np67u5iOF6QV8nCpSn/qZsNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324133; c=relaxed/simple;
	bh=MA3h5jTrsIKATIHVkASldqtCcIv3oJwBvd1pfRey8s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ts+5B8F2vllQDzBtbHuP+Zq7zOJH40GC0AgLInN6QOKRewF+QK9PXw5IXgN6RDJdFyYQfE7bgjdoGZQBVjNLEOc++mwAoe1OnFelrFBo6wjxGqc3PHz8w+MAFWdnM/wbnDotObcV1fcca/ekwq/iHNAxBvJmP6WuO2dFToQ5uiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/lySQEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D64C43390;
	Sun, 24 Mar 2024 23:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324132;
	bh=MA3h5jTrsIKATIHVkASldqtCcIv3oJwBvd1pfRey8s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/lySQEGZy0gl2AWmPbVC26yWzvj+Vt4tXnRFEQhMRLJNU8OCb5Xs2yXGR8K+QcdF
	 Oy159PfHUStgDa8X0IPYiDKfFKK0j3YUtG7g+ITJgutyaVuVp97f0QTWfiDKKU70r6
	 rgW0HYc0FooRgpbStAlZCmwBvTIgiIHfNKKHISUpZL9/flhKoFhlGcdz8P7e2F+6XE
	 Yed1J2REg838nUQd+0xPWamXJFpn5rcJSMbXPiEKoUpkldngNMWq0+bgqPlSHsFUxq
	 6FkASqixQg/Sva7sS7Hi7dyLNOYmqSnN4v87mqnIq4fhJxyiwvW7Hrm1ih46G5b2/K
	 YnyN21R+TuGiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baruch Siach <baruch@tkos.co.il>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 129/183] mtd: maps: physmap-core: fix flash size larger than 32-bit
Date: Sun, 24 Mar 2024 19:45:42 -0400
Message-ID: <20240324234638.1355609-130-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index e4f72b2df8039..fa7e1c0b70c64 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -505,7 +505,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		if (!info->maps[i].phys)
 			info->maps[i].phys = res->start;
 
-		info->win_order = get_bitmask_order(resource_size(res)) - 1;
+		info->win_order = fls64(resource_size(res)) - 1;
 		info->maps[i].size = BIT(info->win_order +
 					 (info->gpios ?
 					  info->gpios->ndescs : 0));
-- 
2.43.0


