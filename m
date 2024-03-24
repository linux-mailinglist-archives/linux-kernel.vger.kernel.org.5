Return-Path: <linux-kernel+bounces-116298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B675F889E16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FD31C34906
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AAF28FA8F;
	Mon, 25 Mar 2024 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRufjdLJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD2182F0E;
	Sun, 24 Mar 2024 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324187; cv=none; b=OWQ5dmCeBcqo0UzbZxEFfy66ZfPnuANp5F9+rwyzTic3rI/axvh8hauoLTikfKoaaShOmHFWhHVsYoosrbQOXJXsem+wA0yT842slre06usRw45OAgpUkIoxqlcCXl9+EM0XJl5uri9PD3ageW7mAFcAUXvOvv/O0FMwlhz0iLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324187; c=relaxed/simple;
	bh=6tgEHwdB/2sxObjfRMZfSDc5dC15G1jmT06In5W0jNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BL7wPMRolOljZnL1eS8vR7sqG9qHiMhqi9qQGw6M//n1s0h0CUVhcecxAC8PuytERUQoumHyGJkjz2k2AFO9Ilt4mbaWQNJGU48USymKulQeY+yIYW5jJhrvq+OdD22E+2cZ9XLid+RFWC2GDBUTTQJvvrvZMqU99t8seTikQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRufjdLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1177DC43399;
	Sun, 24 Mar 2024 23:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324186;
	bh=6tgEHwdB/2sxObjfRMZfSDc5dC15G1jmT06In5W0jNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRufjdLJPPHp7w+LhzfoIDGloWz6xLF9PPt1HwTJ0OpmaDdYDusMnsFWGa/87QsDs
	 IYRRiFasH4ps3TFMOidOvec9Uk6eDV5lw6q5aUq0uk8810EeS+zO7Tf8YMGOBw8bQ6
	 6Z+XQpWhJyhxiKUxiQzNph6WxyOHHSHaIfVxJu6kuJH/id1pZdchL2qGxlvO8yGx2A
	 FdO4Wszu2dk6vExDvNTyLXzEulRKwNKd3jeOyz6aGcyNFKWA3qerrLUQpLieZDaQF9
	 by9fVIcNBJSy/O7MMxCsz+4dkT3tGoxA28+RWP5CSNrTbB5/IIwq7x1sVjTS6ttZiH
	 gv+J+vJyFDXJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thinh Tran <thinhtr@linux.ibm.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 175/183] net/bnx2x: Prevent access to a freed page in page_pool
Date: Sun, 24 Mar 2024 19:46:28 -0400
Message-ID: <20240324234638.1355609-176-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 3f63ffd7561bf..d17731cae8634 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1004,9 +1004,6 @@ static inline void bnx2x_set_fw_mac_addr(__le16 *fw_hi, __le16 *fw_mid,
 static inline void bnx2x_free_rx_mem_pool(struct bnx2x *bp,
 					  struct bnx2x_alloc_pool *pool)
 {
-	if (!pool->page)
-		return;
-
 	put_page(pool->page);
 
 	pool->page = NULL;
@@ -1017,6 +1014,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
 {
 	int i;
 
+	if (!fp->page_pool.page)
+		return;
+
 	if (fp->mode == TPA_MODE_DISABLED)
 		return;
 
-- 
2.43.0


