Return-Path: <linux-kernel+bounces-114445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A27F888A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DA61F227C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B327F0BE;
	Sun, 24 Mar 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuv7bIHi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380421E349;
	Sun, 24 Mar 2024 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321863; cv=none; b=nABwtDOvzDATXlWAr+/Thb9wH13Ti/fTbt6ayH5STy9VI8uuUYhaLRnq2xfGhBf+nAsenmNT02YLxXc+787+tbBReARGHyThCnQzHjw/y3UumhoGR9qTHa8lMVyEnYXfkLpGqVl7mKjZSYr92UBQyTTGOnePHskxPzo4uFhhEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321863; c=relaxed/simple;
	bh=R6+pwYJu5540Q/E08e6Ek8CPjxUBkUAUJJIrsGu+qDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AArtWBgGtZTerKCN0bwRkMc/A4tTwdpTZuwZWCGg3qrQD48mIWxJGKNjYP46Km6JO2/FSaboxt+OV4/IUkbYv0MHhCEHtAcmjm3v6x5/Zntg8s3N6SkXyJ0MsMuEcC03N8/SUK0OO2YqlJsIQ036SJOdkdwP+KC0evJ+CPToamo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuv7bIHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCFBC43394;
	Sun, 24 Mar 2024 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321861;
	bh=R6+pwYJu5540Q/E08e6Ek8CPjxUBkUAUJJIrsGu+qDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuv7bIHiW1Y4/vYpU9nwuLjbi62Y43P6G09V0M+A+fhPCbmLq2eXDJBwXedfGaICQ
	 jyhyyOz3yBf63kdy44GtRwjfFyWRtIcN49z5V8SLTbiSXrjOih8mWzvmuzqcHijkqH
	 eePKb7JhHi/4U2Iim4Ycc9wJrNTNU2wZ0PZK/s/lXHHumm/LvWhXrqPoG5Jzjhzyml
	 LberT94dwkMNNoFzmN88vMAOiYd7Q8ykZxZ2yK/MnfHWUwhThzTfdLJE2uZN69SV6a
	 9e62qQuHrwWukIN0aFMQAgEwGQft3/vocx8KdiHL8MSm0BEai0B9brz1mP0IyUttiJ
	 +qjB/2oKU7G2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Tu <witu@nvidia.com>,
	Martin Zaharinov <micron10@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 590/638] vmxnet3: Fix missing reserved tailroom
Date: Sun, 24 Mar 2024 19:00:27 -0400
Message-ID: <20240324230116.1348576-591-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


