Return-Path: <linux-kernel+bounces-27923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E2782F7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901D11F25F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189B23770;
	Tue, 16 Jan 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOD8VTQ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE7128AC8;
	Tue, 16 Jan 2024 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434590; cv=none; b=TVsCWFVHV8wUP9tIhp1oZ1kzd+KtLz+/Mu/USbc9q8WmYfBDhqwkT6AKBqkt94cl3uFjRuoXTWdJ2qcBNg9Or2zJwQPHrin8vmJwQ5bW7RtTu3MdaXRBytRa8jkhZs7151CXkMeAefXS2dxYfOZrR5f+OwnvihYc4im6Zb1X6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434590; c=relaxed/simple;
	bh=CCeMTWemlWUfpk0SsixG0QIi3JJUMfSP6X3l1mzXASc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=mGINrxgW9U/FVVmaIEUmy/W+jjHOfb5MO/8ydKDNyBqybVN/+ORfyecqBnNU0PWgGN3SQ6Qz8XB5A7orU/9UuSC4EfYqkPGuU8dVi+Tj7+Wvap2oBkwi0QCzJX5J9lVYk7Dx3faEtfXPsFJFH/tdHUvMqQgJd5unM29SSVfdqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOD8VTQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8218C433B1;
	Tue, 16 Jan 2024 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434590;
	bh=CCeMTWemlWUfpk0SsixG0QIi3JJUMfSP6X3l1mzXASc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOD8VTQ2pKsw3h+PgUxU0YfI56bwwAW7wC02PN6Mq6ScWrDFmRy3nZEr2ee7EbRfG
	 5qCdNpEHBlPkIcnTar0b2aanWDAalTpBgbgBIJoaiqoPzAmRt/NagZndT4uUX1W2RI
	 2sj4p3se3gVm1FIQzty1gvflqiMegJrxxjhdgDUZjPO1NHrXwXveeVnWSoC8pXyHHT
	 MwDj7CBGSDOVO/Kxpb4b7W/t017PG0Dv1QPqXsJFrG+Ftsnxyj8K6OTo5uwrwrqAtL
	 /2GKTfgDgJrLqGMxqR0DzmUJYxcOz6yQnVkKbqUTbSqUb+LDIOkXVfp3MKqHBSEXCY
	 TXcUarv/BuVwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tanmay Shah <tanmay.shah@xilinx.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	abhyuday.godhasara@xilinx.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 015/104] soc: xilinx: fix unhandled SGI warning message
Date: Tue, 16 Jan 2024 14:45:41 -0500
Message-ID: <20240116194908.253437-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index edfb1d5c10c6..042553abe1bf 100644
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


