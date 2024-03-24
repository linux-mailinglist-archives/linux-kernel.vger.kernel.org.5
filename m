Return-Path: <linux-kernel+bounces-113911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA9888750
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A37294391
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92750211D04;
	Sun, 24 Mar 2024 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+hTCMTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2296149C5C;
	Sun, 24 Mar 2024 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321005; cv=none; b=Ry7llv1TW16bv4IiO+zHY/TNetTN572o7ZbUEqm8T/g1Y6avFA1rphMJaS9bXwCjiFRVqaDre/tdvo6TyCjsVcdkPPJjU3192cKMO3m4xkj0lp0rhBNZPnUgWprp8186xABNinMc/oRsB6YXfLgkSV2V8PK2viSPAQCQheqsKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321005; c=relaxed/simple;
	bh=j/uLWJi1N1qWK4ODXJnBPySHzNDtY9Iwe9qrdAKQqxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IageKZeHE3FxaKvaR17PLMsxd7YSwfLGQZZeQ8ldFHyADfeeNpHi+m3etbCfV+rXVZXQUCLZSmfZOjBuP6I78RZBLlDZhoz+k3bHn3EEZxKuTysmGRcniDnhw/YqRig4plzRbPSkZ0mTV0tKAqH7RiII1+Q0ztU1rNaS3sh31IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+hTCMTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254BDC43399;
	Sun, 24 Mar 2024 22:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321003;
	bh=j/uLWJi1N1qWK4ODXJnBPySHzNDtY9Iwe9qrdAKQqxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+hTCMTK38irp4yjo7aRexYKmahxneDJR0+SKeD7iiVoO8Hqk0msij/dZk6N5x2sp
	 /BfvKKGydbBVYOS+PvVr4r9y6caZ6pOmczmPyaKQMwgdsrn+KkEuxxTp/shospS6UN
	 ePPoZXoIRD3HBQM8Z1lE0OljJYBADpF7Qr6UqH8BHK0jmKNZO6tMloigMcMmL8A0yL
	 fecJXi0w3sH5+Zs4dVDOZe+EkZ0s88FSLWzS+1RbdEWsmcah582cCZ4ahZiS/HOEKY
	 iN7ICIMSdGZtAcJGwvjklBDQRJjrF+tPYATJRlRBs0iau7/JbsTP9xn15ziP1VkSA0
	 5Vwm3/RtFZz9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 566/713] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Sun, 24 Mar 2024 18:44:52 -0400
Message-ID: <20240324224720.1345309-567-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


