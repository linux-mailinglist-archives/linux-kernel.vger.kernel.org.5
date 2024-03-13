Return-Path: <linux-kernel+bounces-101767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5487AB67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05F828D642
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7B60BB6;
	Wed, 13 Mar 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS0zB8kR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3760BA4;
	Wed, 13 Mar 2024 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347593; cv=none; b=N9vHnKwHltCp/1Pv02iz92iaQmzXSK6YL1O41Gu2JQmT47COIjyClGeeL2hRXzn3OtoeDxnkuuYtZvI4uF0D9dp8THne1/GOWmJm3CjSOogHIovTPZeRoP7NJhZRiMijT4vYo426D2/Y6ibdKIfHfRJvuP/+QGwKgcDKcUsCVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347593; c=relaxed/simple;
	bh=LJ9Nag5joMHCRUdU2t4IyXLRCogu7QaDdQULBSXRXzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lojz4tWS/vBpmb+zgp70Jt9DLrAnFMmP+h9lL9K9GpK+vgWx1Wo3JQRgc2e2eDpX/He9guYtvkH2hL8y6dqB3LX20d3ZIcYSJvNnTEdNiOVHW5/Nh3xE2nFfNTn4RAA2Tq48LwR4BmZ93U5pbHjt6Ld8DhIz1rx0/LkN7e6g0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS0zB8kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD02C43601;
	Wed, 13 Mar 2024 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347593;
	bh=LJ9Nag5joMHCRUdU2t4IyXLRCogu7QaDdQULBSXRXzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tS0zB8kRrITskqrqeyOAniTSTWOLuIm30l6of51rfVAbgMnQ24kDKqUW6VmspysgM
	 Z4XfNHDSBEw6HMfyV2VVRHqKanT7YuAflVhDWZqdgARUL0haydAxG6bMa/6vZ3n0PC
	 aFvx1PNcBqkRKft0waiuSWaNebCOjDkQYf9/U9yL+y3OoG5eDOofGVJLyRIYSAywlt
	 HtU1RWdNjkWPv1MsC5PcPQFGIOJls7GU1x61rwYHqeReUUT+21PCuC8yUh/YnCL4b/
	 P0ojx6xOODsfX08pC8tOETmbJcS6RFV30gnpNOAZ187GaZ/X7pCpe81c2g5K5zxRGD
	 SqMoU/Gfa6K7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 28/61] idpf: disable local BH when scheduling napi for marker packets
Date: Wed, 13 Mar 2024 12:32:03 -0400
Message-ID: <20240313163236.613880-29-sashal@kernel.org>
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

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit 330068589389ccae3452db15ecacc3e147ac9c1c ]

Fix softirq's not being handled during napi_schedule() call when
receiving marker packets for queue disable by disabling local bottom
half.

The issue can be seen on ifdown:
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!

Using ftrace to catch the failing scenario:
ifconfig   [003] d.... 22739.830624: softirq_raise: vec=3 [action=NET_RX]
<idle>-0   [003] ..s.. 22739.831357: softirq_entry: vec=3 [action=NET_RX]

No interrupt and CPU is idle.

After the patch when disabling local BH before calling napi_schedule:
ifconfig   [003] d.... 22993.928336: softirq_raise: vec=3 [action=NET_RX]
ifconfig   [003] ..s1. 22993.928337: softirq_entry: vec=3 [action=NET_RX]

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 2c1b051fdc0d4..b0c52f17848f6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2087,8 +2087,10 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 		set_bit(__IDPF_Q_POLL_MODE, vport->txqs[i]->flags);
 
 	/* schedule the napi to receive all the marker packets */
+	local_bh_disable();
 	for (i = 0; i < vport->num_q_vectors; i++)
 		napi_schedule(&vport->q_vectors[i].napi);
+	local_bh_enable();
 
 	return idpf_wait_for_marker_event(vport);
 }
-- 
2.43.0


