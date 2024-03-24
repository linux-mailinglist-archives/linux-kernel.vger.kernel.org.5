Return-Path: <linux-kernel+bounces-116217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C22889D95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65582A7193
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30883BF8D9;
	Mon, 25 Mar 2024 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEc/OYWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55EB17DC3B;
	Sun, 24 Mar 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323851; cv=none; b=Ab8P97EOnDwehidUu+74dYKv8jg7LmcXFCQriCiiid9SfcdnxROPkcax2Q8+aGRAHIHQVKUVqR/7EuQxOUFLbGiDUUEKcAAEsqb3tFf/l5+Cr1rrJW/VeuLSqeowmBbpfRFl+pVH96JhTe91v3ayUhx/FVof+qH1kg1w8jihv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323851; c=relaxed/simple;
	bh=ImYJx3//S3lb8pzEBjnxmyZSCu8/oqDudWFtAKGWTJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfxLLcdb3+U202IObQrNPdDuV3SxVoiNJFpRMzHmULgz5gQgQLNwiKc+X8+caVNDaUiyBXjEQErw7+tXYM3fqJqTAJtgmMtjGV5S349KtY3Qt+wMFI3zRTRUjZfRlgpdMDA7XS1hoJ73ZQH1ikDJsfjGTh3R7NVGrECTbHpL/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEc/OYWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCDAC43390;
	Sun, 24 Mar 2024 23:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323850;
	bh=ImYJx3//S3lb8pzEBjnxmyZSCu8/oqDudWFtAKGWTJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEc/OYWvRUdcpmMmGq3Auo6M0fOj6jrO4Gx45FCvi5kNOgFYiEl2dtOEcXPhrmZFJ
	 F4DAuPLoHTruByRPx1HVsXrphuAHKFKQDcH6osrh+T3b/vnSZKbHY8SIgzWYawNtLq
	 +NvFDZOOAgTqw0409V1GiFV2gbkFSsCj4zo3fYMjO11FgRBsnfGccyCvP4F5EHuTJ3
	 y/409WLPFlYt9adPRdjsDcanK34stH+EYoMA3FEBg+tfAeeqo1FbIgHE9NIsvNhwPy
	 r3EnsugcWP+6pVLwmYpw7AT0p4+0Rl3A3tRlig3jWjV5tvQpbEcbYJYNOyqZxYzz+M
	 P+Gy1FHgIxMag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thinh Tran <thinhtr@linux.ibm.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 228/238] net/bnx2x: Prevent access to a freed page in page_pool
Date: Sun, 24 Mar 2024 19:40:16 -0400
Message-ID: <20240324234027.1354210-229-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Thinh Tran <thinhtr@linux.ibm.com>

[ Upstream commit d27e2da94a42655861ca4baea30c8cd65546f25d ]

Fix race condition leading to system crash during EEH error handling

During EEH error recovery, the bnx2x driver's transmit timeout logic
could cause a race condition when handling reset tasks. The
bnx2x_tx_timeout() schedules reset tasks via bnx2x_sp_rtnl_task(),
which ultimately leads to bnx2x_nic_unload(). In bnx2x_nic_unload()
SGEs are freed using bnx2x_free_rx_sge_range(). However, this could
overlap with the EEH driver's attempt to reset the device using
bnx2x_io_slot_reset(), which also tries to free SGEs. This race
condition can result in system crashes due to accessing freed memory
locations in bnx2x_free_rx_sge()

799  static inline void bnx2x_free_rx_sge(struct bnx2x *bp,
800				struct bnx2x_fastpath *fp, u16 index)
801  {
802	struct sw_rx_page *sw_buf = &fp->rx_page_ring[index];
803     struct page *page = sw_buf->page;
...
where sw_buf was set to NULL after the call to dma_unmap_page()
by the preceding thread.

    EEH: Beginning: 'slot_reset'
    PCI 0011:01:00.0#10000: EEH: Invoking bnx2x->slot_reset()
    bnx2x: [bnx2x_io_slot_reset:14228(eth1)]IO slot reset initializing...
    bnx2x 0011:01:00.0: enabling device (0140 -> 0142)
    bnx2x: [bnx2x_io_slot_reset:14244(eth1)]IO slot reset --> driver unload
    Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
    BUG: Kernel NULL pointer dereference on read at 0x00000000
    Faulting instruction address: 0xc0080000025065fc
    Oops: Kernel access of bad area, sig: 11 [#1]
    .....
    Call Trace:
    [c000000003c67a20] [c00800000250658c] bnx2x_io_slot_reset+0x204/0x610 [bnx2x] (unreliable)
    [c000000003c67af0] [c0000000000518a8] eeh_report_reset+0xb8/0xf0
    [c000000003c67b60] [c000000000052130] eeh_pe_report+0x180/0x550
    [c000000003c67c70] [c00000000005318c] eeh_handle_normal_event+0x84c/0xa60
    [c000000003c67d50] [c000000000053a84] eeh_event_handler+0xf4/0x170
    [c000000003c67da0] [c000000000194c58] kthread+0x1c8/0x1d0
    [c000000003c67e10] [c00000000000cf64] ret_from_kernel_thread+0x5c/0x64

To solve this issue, we need to verify page pool allocations before
freeing.

Fixes: 4cace675d687 ("bnx2x: Alloc 4k fragment for each rx ring buffer element")
Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20240315205535.1321-1-thinhtr@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index d8b1824c334d3..0bc1367fd6492 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1002,9 +1002,6 @@ static inline void bnx2x_set_fw_mac_addr(__le16 *fw_hi, __le16 *fw_mid,
 static inline void bnx2x_free_rx_mem_pool(struct bnx2x *bp,
 					  struct bnx2x_alloc_pool *pool)
 {
-	if (!pool->page)
-		return;
-
 	put_page(pool->page);
 
 	pool->page = NULL;
@@ -1015,6 +1012,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
 {
 	int i;
 
+	if (!fp->page_pool.page)
+		return;
+
 	if (fp->mode == TPA_MODE_DISABLED)
 		return;
 
-- 
2.43.0


