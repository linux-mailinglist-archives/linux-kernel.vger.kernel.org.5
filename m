Return-Path: <linux-kernel+bounces-101872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA90D87AC52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085971C21E31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069A76C6C;
	Wed, 13 Mar 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ey1j1qAb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DC76413;
	Wed, 13 Mar 2024 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348006; cv=none; b=JTQ3NiUjCndQTaQGHvR85I/Syq4LtX+G/0Lln0prwfdtKGyDrYdNnUu+xPeLJdqRXqnXtAjr+y4ymjp8V6mxBRoKUi5vWwriFhmk0apiwkV/EqI8ghIK1owVTDe3AM/AWrpnRvdZ11mAbF60BnBJp+eYSDG6dIpwzTSjj75tby4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348006; c=relaxed/simple;
	bh=8d5m77e6ga+gCaL29BY+ZDFfwb/hlYaFwFR1jgHVycU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbDQkZYWRLN2KFi26dJCpq35+7TtsI9lWQkFKgkVhGrWHC4A7aXDBpjDfEAxR2UJySjYjxSSJHmsZx7K6MJx4AHsCbLqwCEfciHEYkTDxXOPm9W6uWtl8u51jHRWVTEaCJ6sarwsbjYjeUJst4aVlXHY5iQMKr3eWJlBb0H85iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ey1j1qAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756E2C43142;
	Wed, 13 Mar 2024 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348005;
	bh=8d5m77e6ga+gCaL29BY+ZDFfwb/hlYaFwFR1jgHVycU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ey1j1qAb5CRDBFiP0mZQOSW3vLUIhsiWShEBgBqB72g3i5j/n7O1usqpoqNVFJ/lt
	 w+Ook2QNkMzGkABSHobGjh/+lQUgYrtfXVY+fIF33WvUbsOGzD3P9G0l1H5yPD+rop
	 twxLWprfC4LM7o8Kxi1yM8Vbczm5wV8zfKe/WNee9WwE0NgJ6EBE0MwF3v8+2G9+Ky
	 wwf/4GjGwPtBxa49dj/0V+7jdgAdmkk3L4QGw2FBvfSF3GjyYSa8DAKG+eaDarmSVX
	 bc22jdpZNFM93CVv36mBgoZAP7TqPXpzYzO439a8M2hDI+NgIZKQYKDZP0L0+lYgNW
	 u7vGNy79Vt2IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 04/71] i40e: disable NAPI right after disabling irqs when handling xsk_pool
Date: Wed, 13 Mar 2024 12:38:50 -0400
Message-ID: <20240313163957.615276-5-sashal@kernel.org>
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
index 76455405a6d8e..d8a7fb21b7b76 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13569,9 +13569,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
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


