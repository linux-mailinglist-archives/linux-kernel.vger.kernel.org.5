Return-Path: <linux-kernel+bounces-102062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2287AE15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A6EB23226
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE175644B;
	Wed, 13 Mar 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDe0zf+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8321586F4;
	Wed, 13 Mar 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348442; cv=none; b=sXp+N8uzDurLfAjJsvMds6gOfhAVl7Ltckq6dlCj7BEmT/CwIV6HGAU8ArwTBoL3WUZCKAZk86HclDP+1wMxxnsJgA3XIDPh4G9SpfB0+j6ZDjcFFFUBE5104yQ2Dr73Q+2iRmKoRqfG2uNENKkkNOvaPyuAQwKvWtQW0cugaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348442; c=relaxed/simple;
	bh=BIM2AE8RAX0nv489/q+jkksa4sAawMGwrIiGDzfIUqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7/YuRPYfoHj+vDKcHxKMW8HB3Z491nnO/If/XGKCQWje8pOVw+/GfgGkOlAz9UPWcQdGYqwLjKQHzDEiGlkC6uHLqLevwL/Q5Qom74mvMVDk/a7aI6wgRYuNwpHAvawFj7n8A9c211aK0lY2nRepvqJL3RAfwhJ4OjKryPW95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDe0zf+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A148C43394;
	Wed, 13 Mar 2024 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348442;
	bh=BIM2AE8RAX0nv489/q+jkksa4sAawMGwrIiGDzfIUqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDe0zf+zyBQTOELTbSqlk4czSITlKYbP8Js+jZI+Jo+/j0tVv0//7J0hhT3EpzP4w
	 SxUmckpfoxNTssW0vLzUt1dknNxyXecZ0p/y6fmiwehuxKJ8xKmzIDBUf6N1PPVkK/
	 wuCl2U/XlKaTkDLQIZTpxidKsrtoewc7zBcHYz19oXIhVyw2UKNCTRteN9OvSWiM1c
	 zrYnmzZQ2BkZ8XnyxUPSPvccmWQfYfqIejw8iCK2velI1IyivjTwLwBMdxsXXIKMBq
	 yX9StxgjMYz2AX6pqpko5q6U3MporZe8moErwURxmamo7gnfpDAgcKzGemlwdUI5gZ
	 IxZ1jzGlsqtAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 36/73] xhci: handle isoc Babble and Buffer Overrun events properly
Date: Wed, 13 Mar 2024 12:46:03 -0400
Message-ID: <20240313164640.616049-37-sashal@kernel.org>
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
index 883cf477a70b9..4fa387e447f08 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2262,9 +2262,13 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
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


