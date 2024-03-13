Return-Path: <linux-kernel+bounces-101751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B19F87AB46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC21228A09D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608A4CB41;
	Wed, 13 Mar 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfhTLauD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85735A106;
	Wed, 13 Mar 2024 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347573; cv=none; b=qK3/hvQKV56zCymOpEROl8EyAEzB5cC3zKxhQmufwb4/ZxaHaNCWWFh90ppXRI2S48VdvwCfgd/OtUNtb8PwWj3qAPZ3juZmDOQ97QWs2auE3Ny7fD4Ikj6iTgqEIwcagcKsUBM68vJ1THK+8INaKDQMmikyfmufzhQtHgPm50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347573; c=relaxed/simple;
	bh=bt5hZPIIQvLWUkySERJJZoBFbF+byIU3qM0QFhV5Bm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZCRdFyInaNJlhShtGK+FwZ2o9OgIQaeelJKm7JGH8avl6Yi2Uj799rTtrvpv0Y5ELWPY2CB3DSKCHX9lC861OqMo0GVED2+q+375tvdsr1Qi2wq+lEuHVLXGujtsJMDySovfI+9OjOLeKm2YGxixMpIEiJNp2jOZdW3hkcbaDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfhTLauD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B220C43390;
	Wed, 13 Mar 2024 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347573;
	bh=bt5hZPIIQvLWUkySERJJZoBFbF+byIU3qM0QFhV5Bm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NfhTLauDhlleIOrcHzZgYApHlS1tvZSmURwNkr18TEUVPc2UywaATaniBQSi1EvTL
	 zQDPfD1Pt3ez6vVfH6Tr45gqkvsy4G/HiKrr7ooH8i4v+piXrFYYKRkuytEs1jSN0n
	 NUutqxgb3AjbCzQPj8Dkj12KUBAeJJcXLLLl7VFnPI4W0RtBXjydtf/dpCCZwnzLGP
	 Dj51vze7+t0yvHM8PG5YyFf9IzZ+HV3Cn2J79MtjZ8gfg84FroOE6C6YVTpHr6AYTJ
	 nbDXTx8DQGqSJ1RHlThApqotO3U0VD48m/KYbTgKkBYCEAKSKANNM9V3PPrUbVgSzz
	 jzww24FAg/sUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 12/61] i40e: disable NAPI right after disabling irqs when handling xsk_pool
Date: Wed, 13 Mar 2024 12:31:47 -0400
Message-ID: <20240313163236.613880-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index d9716bcec81bb..b0dc0fc6b1359 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13629,9 +13629,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
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


