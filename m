Return-Path: <linux-kernel+bounces-113546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D428888531
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7691C247D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC41513E415;
	Sun, 24 Mar 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml5OwUuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C713E3FB;
	Sun, 24 Mar 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320348; cv=none; b=oQCyos0eb08QkLZDi5Jb2m5VnWkkl+b5mkQquhJSvIBywaLk2GKWA6k0PbXfJMndRJLcex7YB5NPsENFOTzaoQv49BZZrutGqYTiE4LEEF9GU+Hn8iDuOEYpguDDQ8+atv2MxIyHtQlKXla1tsuOQiyzTdEHyq36gDCfcSl7G2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320348; c=relaxed/simple;
	bh=R6+pwYJu5540Q/E08e6Ek8CPjxUBkUAUJJIrsGu+qDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anXmFMMTAxjc7wek9Yw+pepVtOgLEgE1ZrKIlthv9V3/4EaL0zTbWy5Xq2cuBRM/j86EdCQBgEfJoXnXtgQwwo3ozA70L+A5cGhu6Z94R50jzQ0MCr/NG4la4rCOvpdEH0A0w8fUUJYp9N6AwG2qRLOswwpcipNVAm3zrLi2IR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml5OwUuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5019DC433A6;
	Sun, 24 Mar 2024 22:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320348;
	bh=R6+pwYJu5540Q/E08e6Ek8CPjxUBkUAUJJIrsGu+qDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ml5OwUuy6yuii+OBjEWJ/sw6QaMkbjy/0oJzuR0YI7BnysQJbywPI48auDkGL3nd+
	 QhQhJ/h2gCqKOVS9tB1ukoVRFNhk9wkLE7sxr9PhlwSN6mmBkcFX8zTAh7qaoD4OaP
	 1HgmiYrIO6H7ZrdGiGfmPVCK5ajmKZFz2yzpA2D9Tvn38uelaY/UpaVsmtB8BLmsqQ
	 LOo8WqJ7YlSYmVzmvkOK9GbPnoq23KnkSkIp9JRBEC6dmgtueRA82lwDgQ3ndAHRy3
	 +F6b1Ke0AmKMashfeW7TIGcNZ1RAeBg5VK7ccgUhSRx07TynZ/L8v4K+TPBz15PzId
	 ozN3ByF6PQDMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Tu <witu@nvidia.com>,
	Martin Zaharinov <micron10@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 655/715] vmxnet3: Fix missing reserved tailroom
Date: Sun, 24 Mar 2024 18:33:54 -0400
Message-ID: <20240324223455.1342824-656-sashal@kernel.org>
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

From: William Tu <witu@nvidia.com>

[ Upstream commit e127ce7699c1e05279ee5ee61f00893e7bfa9671 ]

Use rbi->len instead of rcd->len for non-dataring packet.

Found issue:
  XDP_WARN: xdp_update_frame_from_buff(line:278): Driver BUG: missing reserved tailroom
  WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 xdp_warn+0xf/0x20
  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O       6.5.1 #1
  RIP: 0010:xdp_warn+0xf/0x20
  ...
  ? xdp_warn+0xf/0x20
  xdp_do_redirect+0x15f/0x1c0
  vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
  vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
  ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
  vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
  vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
  __napi_poll+0x20/0x180
  net_rx_action+0x177/0x390

Reported-by: Martin Zaharinov <micron10@gmail.com>
Tested-by: Martin Zaharinov <micron10@gmail.com>
Link: https://lore.kernel.org/netdev/74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com/
Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: William Tu <witu@nvidia.com>
Link: https://lore.kernel.org/r/20240309183147.28222-1-witu@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vmxnet3/vmxnet3_xdp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 80ddaff759d47..a6c787454a1ae 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -382,12 +382,12 @@ vmxnet3_process_xdp(struct vmxnet3_adapter *adapter,
 	page = rbi->page;
 	dma_sync_single_for_cpu(&adapter->pdev->dev,
 				page_pool_get_dma_addr(page) +
-				rq->page_pool->p.offset, rcd->len,
+				rq->page_pool->p.offset, rbi->len,
 				page_pool_get_dma_dir(rq->page_pool));
 
-	xdp_init_buff(&xdp, rbi->len, &rq->xdp_rxq);
+	xdp_init_buff(&xdp, PAGE_SIZE, &rq->xdp_rxq);
 	xdp_prepare_buff(&xdp, page_address(page), rq->page_pool->p.offset,
-			 rcd->len, false);
+			 rbi->len, false);
 	xdp_buff_clear_frags_flag(&xdp);
 
 	xdp_prog = rcu_dereference(rq->adapter->xdp_bpf_prog);
-- 
2.43.0


