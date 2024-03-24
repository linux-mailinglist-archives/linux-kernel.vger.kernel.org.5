Return-Path: <linux-kernel+bounces-114891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5928388925B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38C2B31A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46442CF02F;
	Mon, 25 Mar 2024 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFzJQPgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212FF27CBF3;
	Sun, 24 Mar 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323547; cv=none; b=dsWYAGN0pmXNe/iLhsUhbUSvm6LKbwnkVda5GE1TJKHPhYrj2KIkucUelOSNIaE/DKvAXDtLd2ZqEj21PLl+cWnCLVWYiyvu2ZfM6j6yytcSH77GvzMxEzOutwqnyRGgTItyEGXrTChOT7Y3gkGtDtgB4B9/vTISUTytftt4+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323547; c=relaxed/simple;
	bh=fjM6vof3XjpYnzJ3HZjB4SSWGQ7zcn+LI18Tle961iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2JZn1+zDCuwzXHpODdCZttzxEDr9PeaVBaX1Y8xVtghBnAv1oFfuU7oh13xFMmf7JPfoUAw70XbSxBSXrDyD76e1GaKRQV7JRnEAr0AXHO9XoTOA1mEOIgroKZ8hIUH9kLDslHgoLbB1lFRoYGvnl+dkC0ECOM/IdtnxTH2t6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFzJQPgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A17FC43390;
	Sun, 24 Mar 2024 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323546;
	bh=fjM6vof3XjpYnzJ3HZjB4SSWGQ7zcn+LI18Tle961iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BFzJQPgIEZ1vuq40rdgxNZ3xGzRUPjYTaQpBcxSnBpZXqb9Q5VN96Y7qNR0jgPoRF
	 g96eOCvMANBsAWlW/h9MpMrkAyOffm0Q3Fa15hRGKLzoMY+btNXP+5kyA3NHtniOOS
	 p7VFbaGXRlBwbfY4VSc6Fu3hfJdAqvSgs/khPSxN/OWWzWaYVF96LNk88UM8ePWlXG
	 XYNy7/+0GWsl3yXRHGaVxXufyRjIH7sOAzaZkWfWeohOGH0t/z2txtzFg+3ls+jNcm
	 PEnu6a3vurpw3JZC13rcBFqHBjsuVryia0+T5WDhl91oJ8hj/Y/2X5Yero0wbc2reS
	 Ooglz27b4YCjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 254/317] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Sun, 24 Mar 2024 19:33:54 -0400
Message-ID: <20240324233458.1352854-255-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: William Kucharski <william.kucharski@oracle.com>

[ Upstream commit c21a8870c98611e8f892511825c9607f1e2cd456 ]

Upon rare occasions, KASAN reports a use-after-free Write
in srpt_refresh_port().

This seems to be because an event handler is registered before the
srpt device is fully setup and a race condition upon error may leave a
partially setup event handler in place.

Instead, only register the event handler after srpt device initialization
is complete.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
Link: https://lore.kernel.org/r/20240202091549.991784-2-william.kucharski@oracle.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 60f9c612eb3c3..1b44ce0ac991c 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3209,7 +3209,6 @@ static int srpt_add_one(struct ib_device *device)
 
 	INIT_IB_EVENT_HANDLER(&sdev->event_handler, sdev->device,
 			      srpt_event_handler);
-	ib_register_event_handler(&sdev->event_handler);
 
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
@@ -3232,6 +3231,7 @@ static int srpt_add_one(struct ib_device *device)
 		}
 	}
 
+	ib_register_event_handler(&sdev->event_handler);
 	spin_lock(&srpt_dev_lock);
 	list_add_tail(&sdev->list, &srpt_dev_list);
 	spin_unlock(&srpt_dev_lock);
@@ -3242,7 +3242,6 @@ static int srpt_add_one(struct ib_device *device)
 
 err_port:
 	srpt_unregister_mad_agent(sdev, i);
-	ib_unregister_event_handler(&sdev->event_handler);
 err_cm:
 	if (sdev->cm_id)
 		ib_destroy_cm_id(sdev->cm_id);
-- 
2.43.0


