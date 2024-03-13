Return-Path: <linux-kernel+bounces-101876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76C487AC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BEE1C209A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A376F1A;
	Wed, 13 Mar 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpVvKH9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB376C97;
	Wed, 13 Mar 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348010; cv=none; b=fdhgMXFX4/6SqDZP7Xv5IoEmKNVGycUIaVuijvLpx3erR3Fe9RHqFdw9/QbjRf29bzcYn0XHlB7EwUe+5Po3rTmI65VeWnS+65GxtRlkudDSrDUUi5fZUr+pMbo05w4+xFXy83HhV6OBu1525nfomTUWGEAy69rUJZVpEhhxeKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348010; c=relaxed/simple;
	bh=BPbJntuskVES4ughBqn58IDptAR3zQxTerFw4OXbovw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnFn/RK/2OBvTGLxfinL822/JetEINbRlgeHzhiyVkkOoCpJPxFV3DFRTMn/ufbWDqKM9hlTi4ZX9qN7YJnbgmb60xeeqwg3Q1KTpB11uSlFFbYaDv0Gd4TDsJ/XLIPllg7j6RDKUxE8FaPmtg0uPJ3rgmXVL+M4A/7b2vWrwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpVvKH9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4304CC433B1;
	Wed, 13 Mar 2024 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348010;
	bh=BPbJntuskVES4ughBqn58IDptAR3zQxTerFw4OXbovw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TpVvKH9J9U1RHwkNpqwVzQ4Vua/1k6oqsnU8/5auj7110dov2ZOg0IPp2uTOKoDr/
	 45PMH/toF1JZncter90l7J+rKwWv582MTGUCaQlGdNB3wm2i/fEwsEwvO4vJHY7GaR
	 ztZTgrq2GOsHWyDBBJJEwksH3elO+CehWXxtM1dNqcZHOFxq/GAti3niq0Cz8qtJdC
	 KgFsZ6rRTYpSHwB/8Pv+CLEf7izD3vYJ4FRuMyEahJYzfeyMxzvU/0tKvlrhaXONiO
	 Qigc5LiLEobHRUisYPnTcMETOWG3xopMWuT/Uss9qDmQwB/F06L5a2hnd4W/TN3E5B
	 e94Kw2bJzt2wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 08/71] net: sparx5: Fix use after free inside sparx5_del_mact_entry
Date: Wed, 13 Mar 2024 12:38:54 -0400
Message-ID: <20240313163957.615276-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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


