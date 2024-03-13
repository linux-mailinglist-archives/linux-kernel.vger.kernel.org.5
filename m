Return-Path: <linux-kernel+bounces-101948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC3487ACFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1058D281AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E01369BF;
	Wed, 13 Mar 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpJd3Ut1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A81369A3;
	Wed, 13 Mar 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348156; cv=none; b=oIrzD13+206j+spYwVFQ+XFkIyxEfu1zolF0iiRonjF52nwi2S6X00j67RlvXYnoLiZ66GhNYyj6/mncevF1EMqsCxsqHaz+++JvsAUhJyXNU1U555UUZcKYXvi6s+DGDVWn75MtJ5hGi0Zw8l70T+eXtgwz8Pu0iYDinz4lHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348156; c=relaxed/simple;
	bh=bxywz7gfC5Zr9syRS/KzdmYrKoUf25nSuiCn3skB54w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7QL9PNk2esBedNCPRdWxdoG7BM4Kh5yUKHr4VFkkIDZAGS5VnEjeg3mp5AqTIkZJAngf770I6+vxlo7KWxcNvntL2UOSPO0vJJuliCpqQpEh/JmeeFwXPH5OsmdTZ/ipSCyn97GqCY9DZPdKheqQW73b5oNNObQgHxIhvLhCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpJd3Ut1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8BBC43141;
	Wed, 13 Mar 2024 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348156;
	bh=bxywz7gfC5Zr9syRS/KzdmYrKoUf25nSuiCn3skB54w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DpJd3Ut1mNg9pdAZvTIPCGNWXo6Gh9Pc2+j3qthgZgmKRlPdFViSaGiT4P5IyBzAe
	 LqPr5w4FxfpZn+GmAgiTXej1LQpl2CNS10eaf7GVgGp3eyrkADXnvkNGMQ9PqDxMLO
	 b4bjAdsnJVaPhizAE27dTTLToMrO3jfohU+Xn7dSp/EuOQpdBe3JcvrTJ/Gcjm6Hz9
	 +tG4uCflEvnyeOIfn82GhdT1cUwG8HzFL6kwRuLcaWz/7jrC7+OKEamBlpHcdUuyL2
	 UGSx5Nr04//H4LJYskq8SP0czEzBp6Y93OTT8OfpSYQ9XR1RArFYvKhVBaaJIFmvR9
	 cx/8n9WM4EXXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 08/76] net: sparx5: Fix use after free inside sparx5_del_mact_entry
Date: Wed, 13 Mar 2024 12:41:15 -0400
Message-ID: <20240313164223.615640-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 9a8e4f201eb1f..6ba93fa984f26 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -344,10 +344,10 @@ int sparx5_del_mact_entry(struct sparx5 *sparx5,
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


