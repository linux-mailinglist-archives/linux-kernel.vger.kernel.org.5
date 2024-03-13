Return-Path: <linux-kernel+bounces-101987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D287AD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56E11F29152
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F7F1487F8;
	Wed, 13 Mar 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3yKTJJ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D21487E1;
	Wed, 13 Mar 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348199; cv=none; b=sCJbz6ZKCAc+TuloSJXAiZejEuyTwMqdUP1DhMV44Z1X788OdJJAnO/t5MjAP7cQfYvSu3DZ0e1gZjOmxUNtwG7Pp0J++AnsJwWW0Si4PbGtYk9l7e2DXTVWmB/B2tCZjxHLen8bLbfnunf1UA8kCIncnvTXXITqCkO54jnVY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348199; c=relaxed/simple;
	bh=H/BEk14QfxxwzVTPYhHlI6B6JlzJZBjZ/A9OkanOfRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuCM7MpCo2r9RA9hs7Xhxf3aYByWAiR6xFOsX4iDSVY7yME6bNwr7Cyvh9l23PkzfQ4HYkqNYyrAmt0zTwireveQotraRhkusATyeIC3UMV8Kfq736HMNdG+IdQ8CXApJOCDyJZdgzD5zkYbbDOEzPqjnnDtr8fwMNjgNnxt/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3yKTJJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD9CC43399;
	Wed, 13 Mar 2024 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348198;
	bh=H/BEk14QfxxwzVTPYhHlI6B6JlzJZBjZ/A9OkanOfRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3yKTJJ+ERKYk3btlyzFfdPIuCR84FbEuFP/iB3NhZp53HwyqnhNflhUmsKj/6FK1
	 QrtsaPupj8Rd9l9Jnw4BEsKNzcD5vO8wq8QOqYMJ9N+M/zKuRXXyJGnv0x0Oh6s45Z
	 64sRvyOeqEdfA89Q/owUy6Bfdv4+vbwBL+BCC8UqOEidxHtOzWqk/0iNC5jAUk6PDc
	 qU8iMswFUGw/MpbIRr3ua77Gy7h+D3xPrGZ4OVgSKM0jdOD6gITpEtMxwhvcjmepjL
	 kTVWA3KFtIVu26cX5FCAkDnCUfyA88WA7LANKqdi0wUiUBIXbZK4m6hYOrRk98bwYN
	 Z5LDnUJkCCWPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 47/76] xhci: handle isoc Babble and Buffer Overrun events properly
Date: Wed, 13 Mar 2024 12:41:54 -0400
Message-ID: <20240313164223.615640-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 7c4650ded49e5b88929ecbbb631efb8b0838e811 ]

xHCI 4.9 explicitly forbids assuming that the xHC has released its
ownership of a multi-TRB TD when it reports an error on one of the
early TRBs. Yet the driver makes such assumption and releases the TD,
allowing the remaining TRBs to be freed or overwritten by new TDs.

The xHC should also report completion of the final TRB due to its IOC
flag being set by us, regardless of prior errors. This event cannot
be recognized if the TD has already been freed earlier, resulting in
"Transfer event TRB DMA ptr not part of current TD" error message.

Fix this by reusing the logic for processing isoc Transaction Errors.
This also handles hosts which fail to report the final completion.

Fix transfer length reporting on Babble errors. They may be caused by
device malfunction, no guarantee that the buffer has been filled.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240125152737.2983959-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 7e88b65b694ad..31d355613933f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2446,9 +2446,13 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	case COMP_BANDWIDTH_OVERRUN_ERROR:
 		frame->status = -ECOMM;
 		break;
-	case COMP_ISOCH_BUFFER_OVERRUN:
 	case COMP_BABBLE_DETECTED_ERROR:
+		sum_trbs_for_length = true;
+		fallthrough;
+	case COMP_ISOCH_BUFFER_OVERRUN:
 		frame->status = -EOVERFLOW;
+		if (ep_trb != td->last_trb)
+			td->error_mid_td = true;
 		break;
 	case COMP_INCOMPATIBLE_DEVICE_ERROR:
 	case COMP_STALL_ERROR:
-- 
2.43.0


