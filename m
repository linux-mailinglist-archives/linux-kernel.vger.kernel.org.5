Return-Path: <linux-kernel+bounces-114611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06799889085
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F361C2C4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A713CA81;
	Sun, 24 Mar 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtlMDhBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C7233170;
	Sun, 24 Mar 2024 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322269; cv=none; b=JDw9R36rzw+5DJ3KvYYFbaizMBOwWQxB0WYmMYuAUMADuDbcR9bsbSqP3igPip8nYQuS5yY58jKodNN8imB+h5fLCiPhr/L2c5Vc6csgiJB+5wN1GV+ym6+TsvEXhpHWSSbI7/oJeY5b6SVyKamQWNBSw8EP1zaqoeNo/0LSedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322269; c=relaxed/simple;
	bh=5/0SWd2FIWOxQjyYPdIx12XaTo4jFbbKMPaFyB7RhE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrSLGXKZjbLCLPuqIkI0GXcSFNqemySqPCc95E+X7YvTCeFrDPEmlMxVubuisf9Dme/sPxvnXVcsGxagx0whganwN4e9FjN5KxF2Kmqu1x/6+QIew24nd9FVZk9OnqtK+K5y/tr5/FZS58oYT1r0z/1DiOU0IbQS+VG4Fa5hQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtlMDhBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3542C433F1;
	Sun, 24 Mar 2024 23:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322268;
	bh=5/0SWd2FIWOxQjyYPdIx12XaTo4jFbbKMPaFyB7RhE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtlMDhBflnranEelDoFYRvmbx1LrwQsijzEHqxos4c1ucYtYvFEwtRihUrs1KSami
	 sT9iuGcuzN3t+X2FMB/0QVCsjOsNQfhLNNpadf2fa+v0wS9DNwFcu2hiEZ8/NEjL8A
	 g+VuM75JGEsiqpoaPFhPpo+olA8wzO0+foW/hpymB2h9Svyl6GhwNdvbYCiaoTLIv0
	 FX8krPtV7gUWjWl+OAGMfXluTmvptJWM6ka19C+0z707VGvP+sWw1M4Y2DUhkS2cCH
	 dJtH3NtelQGYtVr6/HuicoYmLoD2FlLt/c7ISaCoGf2UvksFZoD++jCiB4CpDuvegj
	 byM7LxZepQmlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 351/451] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Sun, 24 Mar 2024 19:10:27 -0400
Message-ID: <20240324231207.1351418-352-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index cffa93f114a73..fd6c260d5857d 100644
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


