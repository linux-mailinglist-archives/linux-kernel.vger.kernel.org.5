Return-Path: <linux-kernel+bounces-113449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4193988846D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2C4285B89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFF41AE8C3;
	Sun, 24 Mar 2024 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="claz7+3t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D01AE050;
	Sun, 24 Mar 2024 22:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320251; cv=none; b=UY6QF0Ls9qncYUT4aBMn2hPAik2zVbSmc2XcADXKQbYFLZHbm46/V1tfaIgrqWGZVZbR+48wFeG9Iuq6Tgad/txflrxiIj6rBLFSCSQMBxU9StmMFPkcngDcLyta2L2dfeBn100xrI6OHpm10hiHo/vFuWhyRALfGQxNv/sUEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320251; c=relaxed/simple;
	bh=j/uLWJi1N1qWK4ODXJnBPySHzNDtY9Iwe9qrdAKQqxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHpbQdSuN4lUprDr1HSorxdrajZMNus+BlXHSyEE72x+EmY18RYV0LBCLEZ6VGRk9r/NfHrvhd71Al6ALkP6pQ/XoLrG8oPWel0uVDBgWltAv8WSP3hFV8jIy2waSzVCecFXIVNOtYTLdQp5vXq2tHiRWMiclaytYdV7cFC1DKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=claz7+3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A67FC43399;
	Sun, 24 Mar 2024 22:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320250;
	bh=j/uLWJi1N1qWK4ODXJnBPySHzNDtY9Iwe9qrdAKQqxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=claz7+3tN+N2AO23aIrrHPi2HbzdGhAB7YyCqgIZe6IguXgmRDMPlDIXrtmY4b56U
	 hJahPULTcaVQiPSz4fpZTbn10tYwe7owVD6KsFINe+QeNf8lXHu+tA9UCV6x6Giybc
	 0jj9WiXD7AezJvj/oll8F71mS0E7dcO2wh+WefG+3t0XJmYcBCT8VHn9Ufnfaq5D7w
	 uIwIBrFISRJFtgtq0GxU3zl4YErEB4vpK3B6aFmlD8rs2WCXQnjGAUFfhUJdxH2vms
	 WI6n0Zh3CsSHba1jRHA6vnhKWdSdPsvhqk+j4sUlSmk68yjL+moK0+LyBZGIhVXo/z
	 8zq+5pus8eA6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 558/715] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Sun, 24 Mar 2024 18:32:17 -0400
Message-ID: <20240324223455.1342824-559-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 040234c01be4d..9632afbd727b6 100644
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


