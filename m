Return-Path: <linux-kernel+bounces-101827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB187ABF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57671C20DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C66CDA8;
	Wed, 13 Mar 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfNHZfD2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5F6BFD6;
	Wed, 13 Mar 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347861; cv=none; b=ti3b85Aj3PFJIDWw7T3ILltcVvzz5GBtX+ozeLiYmYt0YfPx5au/SPu2rCoNtg6MI6GuYTTaYZBNHYDqHXWABL4pJPIWKUFGCxdk77lcJ0LPiGjIgmf3Y56QWjR7GDLq1Bnu/BtJFPRjzcAasNrsM/mpv+Oywhdpe1PLSZK5NHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347861; c=relaxed/simple;
	bh=BPbJntuskVES4ughBqn58IDptAR3zQxTerFw4OXbovw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYIRAQ9C5iMxpiUtfA5RmN41oOfAcfkorO78+UoBBi8H/rnn3iHqEdc2dNc7BaRwwMzMJgxQ5IBhnZ+nRPmnMzOSqAganaGY0J2J/oxsnKRgCOi1fDS06GgL+UjWKrkLmtDLK1qqQwbi6t30ptKLDerENRYkxKC8Xmlv0m8faGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfNHZfD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86451C43390;
	Wed, 13 Mar 2024 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347860;
	bh=BPbJntuskVES4ughBqn58IDptAR3zQxTerFw4OXbovw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfNHZfD2e0Hge2N8aF/rDpRjxB+rPOf0O5eaFHLehyn2XODXqBtK5CffDNaumPnPU
	 JzkO/ViXi9Wmfz4bsdfMHBR1pWq6+Zb1lpgMVY+NCjQ7RjWwbC9h61a5Xoy5939RGl
	 p/6NNsOCBd6dpSv8lYLHmjxyIa2yHiUcn+NzsqWK9C/ZU+V9X0ssUSsE1KkZZXyzPP
	 F6xiCSqNChcUpCUAY13F9KeFasGgU1sOZWNh4OiLuNYSY6lKEIBQxkp4J5WmSqLrfN
	 dP1cZRtvyrObFFTOoggsYLqvZ0Rg6k8V0E8XLuleJUAxDkyn2nIlpM+2GPY+byx5AS
	 rNnx0cgH3fj/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 24/60] net: sparx5: Fix use after free inside sparx5_del_mact_entry
Date: Wed, 13 Mar 2024 12:36:31 -0400
Message-ID: <20240313163707.615000-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Horatiu Vultur <horatiu.vultur@microchip.com>

[ Upstream commit 89d72d4125e94aa3c2140fedd97ce07ba9e37674 ]

Based on the static analyzis of the code it looks like when an entry
from the MAC table was removed, the entry was still used after being
freed. More precise the vid of the mac_entry was used after calling
devm_kfree on the mac_entry.
The fix consists in first using the vid of the mac_entry to delete the
entry from the HW and after that to free it.

Fixes: b37a1bae742f ("net: sparx5: add mactable support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240301080608.3053468-1-horatiu.vultur@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 4af285918ea2a..75868b3f548ec 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -347,10 +347,10 @@ int sparx5_del_mact_entry(struct sparx5 *sparx5,
 				 list) {
 		if ((vid == 0 || mact_entry->vid == vid) &&
 		    ether_addr_equal(addr, mact_entry->mac)) {
+			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
+
 			list_del(&mact_entry->list);
 			devm_kfree(sparx5->dev, mact_entry);
-
-			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
 		}
 	}
 	mutex_unlock(&sparx5->mact_lock);
-- 
2.43.0


