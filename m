Return-Path: <linux-kernel+bounces-28024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92382F938
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889B21F267FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00A13FF8C;
	Tue, 16 Jan 2024 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdtIedEJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517842CCBD;
	Tue, 16 Jan 2024 19:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434928; cv=none; b=b3yq/jfd9D3dQzWkEE3FlovZEolsLZT9mxt48Yexb6XIxB/j7aJA6eMqRHIDUMGS/vkGcDc4+MqExMRhuvkQ7fJ9/at+48OpROaZqzKyIsZUOtSh15C522KNVc0Ujepvyp9N7Nl4yb9PQUE3csxec6ygiDEBI7775d4u/f5SCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434928; c=relaxed/simple;
	bh=+tbQBTkpmRMxHS4jp9W+NY83/ITfh1xQVkpv3pzIuvc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=CbtxxGV9xHpswJBHQUo5Y6zatOmMWEhhhXBkXs8xtByLdt+n9PsVd3cFeORq/QcLOr76qVZWePt+/ju8XtzJkqK6VTf9FqBnch9W9SaT3TSik0PQ2bP/ys1Xzf8fIgtrwTzm+VGvqMh7JO46qimgKc8phW2sc7o/ZSgIQplmOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdtIedEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01908C433C7;
	Tue, 16 Jan 2024 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434927;
	bh=+tbQBTkpmRMxHS4jp9W+NY83/ITfh1xQVkpv3pzIuvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdtIedEJUBYzdwjLkN4cuN8VNCx34gnqNSeMBw18ZGX3ZYmYD/lFCj0hf1M44ct/9
	 D8bNFePWaPJDJ3um4DM4AKfNophl+cwdNIuC2zwhlgZc0RspgzeZM/1Gtnf0/NRdom
	 2qrQGw3Xzkwkl2uSHp8RvWKBmfUn6NjddgRCL20+tUB5xNE9vqV5kbqNM/QwQhKx20
	 BoPUa9aMGVCnaAXz4/V757Z3H7aomLEvaPEmUgj1ETmZk+t3BXcratI4ce6MVl4X0A
	 8McfRBTNZjBltn4OhcVvDbX0oScybRaIpiMNtmZ9C04jF78vC3R+QR4FWBf9SOHKMr
	 6/yShWhHVR1DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tanmay Shah <tanmay.shah@xilinx.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	abhyuday.godhasara@xilinx.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 07/68] soc: xilinx: fix unhandled SGI warning message
Date: Tue, 16 Jan 2024 14:53:06 -0500
Message-ID: <20240116195511.255854-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Tanmay Shah <tanmay.shah@xilinx.com>

[ Upstream commit 9c6724abf969251af53cdae525ad8100ec78d3c2 ]

Xen broadcasts SGI to each VM when multiple VMs run on Xen hypervisor. In
such case spurious SGI is expected if one event is registered by one VM and
not registered by another VM. We let users know that Unhandled SGI is not
error and expected if kernel is running on Xen hypervisor.

Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Link: https://lore.kernel.org/r/1698431039-2734260-1-git-send-email-radhey.shyam.pandey@amd.com
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 56d22d3989bb..8293cc40047f 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -477,7 +477,7 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
 		}
 	}
 	if (!is_callback_found)
-		pr_warn("Didn't find any registered callback for 0x%x 0x%x\n",
+		pr_warn("Unhandled SGI node 0x%x event 0x%x. Expected with Xen hypervisor\n",
 			payload[1], payload[2]);
 }
 
-- 
2.43.0


