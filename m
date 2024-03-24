Return-Path: <linux-kernel+bounces-115036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0488894CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A1EB2DAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7782EC89B;
	Mon, 25 Mar 2024 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaKYjLSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B25C8EE;
	Sun, 24 Mar 2024 23:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323815; cv=none; b=PFrv1lMyVYOvL7ygDnSrBVOlt3oKNBCxroiSs0ZmnlmK02Nl47YeTvNHcyDfSk30zJvB2Ndk7tGP7olH39st7tRgCBapCue/zpwfnF6BAOODo5xiBf8BmtMcZyX0hBwAPGph9bPeOHwex4qfFwtcM+EgNqGdHkpDj+xZ72Rnz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323815; c=relaxed/simple;
	bh=5Vvzadg7BRa7CY/F9uhxQqP4Lu/caTEExk1oVFIzAaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjGl8Wy+0dNPzVr1812UDym5x2E7bStUL8yZ0ZDha9CWXP4bjnj4BToxRpnbP1NnIUQ2HPpOjAzqDC1ZvU3EeB5g3sEN3Y84Uq59ULzGjBvtCTQnWOuXdL0hB6Rd0IlYsJ7ZmflQoRgpD4lVC7/Yb1fiOarx8yXnyXrqJ5XQFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaKYjLSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81B6C43399;
	Sun, 24 Mar 2024 23:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323814;
	bh=5Vvzadg7BRa7CY/F9uhxQqP4Lu/caTEExk1oVFIzAaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaKYjLSBJF7tExBGOQp2SoOEs0BXoLzMLRs7utQaRbdb+w01NuUsNs+4spRGmXZ+4
	 y0Vc8gFqR3Rv3ozqLUy7ZsLUtv4eOKepMy6VhExNnFFo7RWGhdQTLbhrjRKv04dbjF
	 b4eY1ODDWvUFHyBt/Nk0n92LgbSWeA/x6DeEIlA9q7iiswGCDuyCjtsL9g+OSbOzPy
	 Z/hbpmdUeC1GX8SRDHHNloMHWfeqi//Qqy/1IZ411zXmGfEwyEBv/tDKaDj+En5s1B
	 tzHcFwpwh3Cj6m9I0aTHbQ5lYMeiu8sLRRnjRjBPQV/yrO4t5yDCwkerrjgqM2MRa5
	 dNq/4zKKAEOHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 193/238] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Sun, 24 Mar 2024 19:39:41 -0400
Message-ID: <20240324234027.1354210-194-sashal@kernel.org>
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
index 41abf9cf11c67..960f870a952a5 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3205,7 +3205,6 @@ static int srpt_add_one(struct ib_device *device)
 
 	INIT_IB_EVENT_HANDLER(&sdev->event_handler, sdev->device,
 			      srpt_event_handler);
-	ib_register_event_handler(&sdev->event_handler);
 
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
@@ -3228,6 +3227,7 @@ static int srpt_add_one(struct ib_device *device)
 		}
 	}
 
+	ib_register_event_handler(&sdev->event_handler);
 	spin_lock(&srpt_dev_lock);
 	list_add_tail(&sdev->list, &srpt_dev_list);
 	spin_unlock(&srpt_dev_lock);
@@ -3238,7 +3238,6 @@ static int srpt_add_one(struct ib_device *device)
 
 err_port:
 	srpt_unregister_mad_agent(sdev, i);
-	ib_unregister_event_handler(&sdev->event_handler);
 err_cm:
 	if (sdev->cm_id)
 		ib_destroy_cm_id(sdev->cm_id);
-- 
2.43.0


