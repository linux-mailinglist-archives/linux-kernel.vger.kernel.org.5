Return-Path: <linux-kernel+bounces-102033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A438987ADC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45213B227BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F61504EF;
	Wed, 13 Mar 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRWLkwlF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD767C69;
	Wed, 13 Mar 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348413; cv=none; b=KjbqC15IWgkqVhnhPWvXYG8pwGsXS8inKBzHdHK5kiZcp6Tcfk5RWQh+Fkcg/UYQEdtq2hB2EMaNNvFXA+Ffy+etE8izoW6u+PjRN2TsORyE65HXclXdC8g/n545llo1T2wZBt/OJkoOcK1FU+2hL5OdqQunBvWkftjZnOJ+F9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348413; c=relaxed/simple;
	bh=JuUzgWLjbmAIbnZtPpwLIN0qTxIT2Lp4qIMEXgEOX1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgqWHwTVH5a2leWJ/UmXKvpA6zHaaQLiwk9lNvT+rc4sEgQ/KvOxkAA93I409Bvy9HUJKYsh4HZmUrqhpAZuNtDux1n9XLF7AOY9O/VQLHm9pmPlZ1w8WbkcEN3dJ7N3SiyWyfdnS0eOAy2ncBZZon24BpYQjpoe2fuIXcTvK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRWLkwlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B38C433C7;
	Wed, 13 Mar 2024 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348413;
	bh=JuUzgWLjbmAIbnZtPpwLIN0qTxIT2Lp4qIMEXgEOX1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRWLkwlFm97TN163cmPIUUgx6qQvS31hP2BAmTMFTGRK1PtPpvh95Bs/sG/2krNZ6
	 Q1YScPA+nr+Ub6NpTN/FyTL7ek0JYxBAAgqC6Yx9NKHrHrxxHon6a4tE6JkpOUaDeZ
	 yczUUmD/Tkjp0j8vOVdLRiynjF65T+meIhMnvF6j82tXIkqaUtwHMABC1Laul1eCEa
	 mhrk/Ea59/yZD/OXU1fxS7AWnYTlo+SySxDPcM1vJCph6FYJH4gBF83s4BqK8f8Pg+
	 Os27cR7GtHVikH8an1RU3l2EN84Rnhz0+fWQE2FXxHhElXeNt95FZ3tFm8J7Ju8Z9u
	 M9RG8RjZVKD6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 09/73] i40e: disable NAPI right after disabling irqs when handling xsk_pool
Date: Wed, 13 Mar 2024 12:45:36 -0400
Message-ID: <20240313164640.616049-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 135acd74497f3..58c87d79c1261 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12944,9 +12944,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
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


