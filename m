Return-Path: <linux-kernel+bounces-27785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D782F5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9071C24085
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4C2137B;
	Tue, 16 Jan 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGsUwNiQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A721370;
	Tue, 16 Jan 2024 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434193; cv=none; b=ec4YeAvC2FnRKEmSWwOzEeXo0ijM9Q5Pj3JTEy4r5jTF1k8CSCmZ6vi5ZE9ToYQNYL0K1pIDrsJT1S8NcR8P4ppTmOmHAB6WL2qsid5HqMKl0xGrAwmW3PIoAk1GXqkLsyhI47LdOv0Lx2d+yEOcIrUBerQKZOh6xBTHgg8reHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434193; c=relaxed/simple;
	bh=CCeMTWemlWUfpk0SsixG0QIi3JJUMfSP6X3l1mzXASc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ubkUdVPDBenPNBSs+IIlcNhpsBmVcz7c1jVzZr+7oSApzPENiVwbPls3x/5PaqNhm7WvcNPiW3Xkvb5OUZcsxCidWmUAs0YckSRbnZUmTTo04cqIMrf3z72M7YTLSOG0+o4AokBKAGdLw+QimJ3f9nP/QpoTxVyO0vnj2F2cVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGsUwNiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3F6C43399;
	Tue, 16 Jan 2024 19:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434193;
	bh=CCeMTWemlWUfpk0SsixG0QIi3JJUMfSP6X3l1mzXASc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGsUwNiQ+oRcJ1wxcdDqC7amQux4s6ruPZT30JaeqwArL8BhfI3dfwxg7WZqRNh+1
	 ih8GN/dMWlcQCmbHEEO4s5IEOYiWtGR6D15cPsrubn58kvu5LnSTN+GIhCX7/njV3w
	 BphhdAc/RGKsnFqO50d88E5jGcjhjtMkAiXHEcBhyO4nGKiPcZn5JVdybl92SFvMIN
	 8FnxtynYm2JQCCPb/dKywGSBJ9n6CDhV7oPxgml0Z0YoP6AZe22rvlIzo4xtN3reRb
	 Iwad0Enr0nVGw12/igkPxXahmhaMGe34KX6z8KQeomhWKoRnmlT6w8Lw0E0kCGYyFs
	 0lBHWGWR4q7Ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tanmay Shah <tanmay.shah@xilinx.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	abhyuday.godhasara@xilinx.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 015/108] soc: xilinx: fix unhandled SGI warning message
Date: Tue, 16 Jan 2024 14:38:41 -0500
Message-ID: <20240116194225.250921-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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


