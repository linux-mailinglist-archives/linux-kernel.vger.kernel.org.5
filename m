Return-Path: <linux-kernel+bounces-101945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05687ACF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE11B235D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D71361C9;
	Wed, 13 Mar 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgJ2BAxA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681B629F9;
	Wed, 13 Mar 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348152; cv=none; b=SsJS50Plu5K6lsRKTFfoeC7Zbda1WnDVbtEv1CjAtikSbrMc8ET3QY4DtAjiZcvqoRrj96nl3eitIsgPgz/8qRAuUmoiTErT2sGiZZUmVn94E2HzfdsGt8s37v0KbzRfvO27ibJlDrGs4Qu1x0L2HqsjqvhvhGZ5d1pZ5oALsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348152; c=relaxed/simple;
	bh=sBSg5rfKvh3atIZHujnBMgH/0FxhtiJyLtx8D1IvtHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHxWp71axoIT74xTwj1vN09x7bBwKPQlLvLy3Ldihd+7XOkb3cVkAOZGrJl5GnZwnjn9drXLbk2v1GapXHHlQQBiV41rFVI9PQ7SfD54rxUXhLD+0uA7PhasBRi5Quik8vSeU+FyCemEnmq5NUNsr7+92JnYlTASaqE0xxn+y84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgJ2BAxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0D8C32791;
	Wed, 13 Mar 2024 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348152;
	bh=sBSg5rfKvh3atIZHujnBMgH/0FxhtiJyLtx8D1IvtHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgJ2BAxAf9/jek3zXtxlTE6U71X8jAY5pZiXb9jTepcbR4Sp2ztDMhp35gJNhJf9L
	 KJ+Dr2FiTmF/Kt2viiFmwfm9MYUIkJsg+zC5bLR/wt+YeCrKBmMZs4hg4NPI89oUPr
	 qCg78pESq5FnkU4vNCK/HIpe1uSJhsOKs2h9VRV7KMu9EwsCdHl3rWw1N8L2qDiL/O
	 R1JSEncASYCl6hXB/S2lzFC8a3WinYZbBozuCqaK5Dld21TL3VpNRyHV8tDTlIM74D
	 Pz1DOGGMy2Z8SPZq3tQikHq1p7u+1UubTyAkFBElzQBKoHmU6Qti3tgQv8GGy6E12z
	 v/BmB/uP9wSHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 05/76] i40e: disable NAPI right after disabling irqs when handling xsk_pool
Date: Wed, 13 Mar 2024 12:41:12 -0400
Message-ID: <20240313164223.615640-6-sashal@kernel.org>
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

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit d562b11c1eac7d73f4c778b4cbe5468f86b1f20d ]

Disable NAPI before shutting down queues that this particular NAPI
contains so that the order of actions in i40e_queue_pair_disable()
mirrors what we do in i40e_queue_pair_enable().

Fixes: 123cecd427b6 ("i40e: added queue pair disable/enable functions")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3d2b92a952a65..7b522d55f3684 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13558,9 +13558,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
 		return err;
 
 	i40e_queue_pair_disable_irq(vsi, queue_pair);
+	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	err = i40e_queue_pair_toggle_rings(vsi, queue_pair, false /* off */);
 	i40e_clean_rx_ring(vsi->rx_rings[queue_pair]);
-	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	i40e_queue_pair_clean_rings(vsi, queue_pair);
 	i40e_queue_pair_reset_stats(vsi, queue_pair);
 
-- 
2.43.0


