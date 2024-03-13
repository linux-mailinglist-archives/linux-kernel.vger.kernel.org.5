Return-Path: <linux-kernel+bounces-101815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E487ABD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AFC1F213C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3082692F6;
	Wed, 13 Mar 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn9a8LA4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9C5F46C;
	Wed, 13 Mar 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347846; cv=none; b=WF5GVlfnFJxuVbuJAuSZA8M1/DxU60gVEpVu8LNZmTWuUKiV/CSR6Ncf5dLUGG+Md+SCAp0eib7ihkAQovkSYHHPFxOSIFWaKMcjHEe5+cHKko5/+Ni5z5CDMqHF4WU14KjRhDC/ogLeAflFZQPJWdzIlqACGQNn+5Fn8gw1njA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347846; c=relaxed/simple;
	bh=ehhPxOYTcUJIZMePAgzfG67jXSngClZyoOyO/+GP4Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWfCuMeyyeqiG2Dl7EQklKMyiGHq+3Ut1xqrg6KgNvmkuKvsdM4BBLOhbgQW7kJDbTIYnlyRD4TY23isUqSrRblPtrvVCd5TNRHwHcMI6W635eQk80i6xAxP9FFSUWREWiqVx1qJujoD6sp5AEaQxppAcLBbJnGiGMdENO5rIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn9a8LA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F06C433F1;
	Wed, 13 Mar 2024 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347845;
	bh=ehhPxOYTcUJIZMePAgzfG67jXSngClZyoOyO/+GP4Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rn9a8LA4uAlpeQeX31HtWS5Q+au90yejywTyA3RLJuGPhwfzCkKtFPEp4GcekHuKF
	 kbhFnXXx7qqdWifYd0eAX7RynXgyb6+kmYP9ao9yfx+8xsH8Aw70suNrRXF2uyxB8r
	 ddLWoBIMyPjsUmu1nA4qRVSsKFeg++J/F1R7kB+5lUBfqrREyuz3XqJhIxrYs9p5lq
	 6a26HfmjkkgZmmBwIG5NafWfs8B7tPUi4EmSJ/kq6yRF45gCmIi+YxCYwiSbH3nq1Y
	 5m5jcFKeO1K3HiUIt44ajEn+TqBUFNMx3YSd8OzLff6s10s20T1bbRgtWqgE8iMJzq
	 oc8Uxxn6oNo+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 12/60] i40e: disable NAPI right after disabling irqs when handling xsk_pool
Date: Wed, 13 Mar 2024 12:36:19 -0400
Message-ID: <20240313163707.615000-13-sashal@kernel.org>
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
index 9d37c0374c75e..ae32e83a69902 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13617,9 +13617,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
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


