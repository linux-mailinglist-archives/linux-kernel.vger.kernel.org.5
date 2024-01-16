Return-Path: <linux-kernel+bounces-26852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F9A82E6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C30C283105
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BF922EFB;
	Tue, 16 Jan 2024 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poF/O7c0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154720B16;
	Tue, 16 Jan 2024 01:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF2CC433C7;
	Tue, 16 Jan 2024 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367209;
	bh=zGlrILAiEH94oEbspkLLHGT5h9srxYCl3j+nD/WetFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=poF/O7c0HhvcHkI9JXygH3xSLcj+LZNdffwvIePGX+0bqVlj8Yhx0JyO3OVABLzEB
	 5YcNwPU6tuhvwlv/ZYhLeQyZH403kCwzgYCVgdLdzAJRbnERKIaqCZV+pVwKT66fTo
	 DB34DPF++SYFFGP9OpS/q5j89C29enZePd4rhPTXgJsPQIbt0EVj/UjhIe0ISDX5pk
	 Cg+nL3XdZLl2eIefY2Dyr1M2vs3aM+eoOU2m1XuSIOhLgqor2d8Ml3w4rbzQARKTX1
	 ZBQjn0Y9Q3wFuoTyU9k0DwE9u8Gae6IWzRToseLKCAVzo8ENRV2gtzrDr1ExWbSoTU
	 3bTK4vb4rZBqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjherne@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/14] s390/vfio-ap: fix sysfs status attribute for AP queue devices
Date: Mon, 15 Jan 2024 20:06:04 -0500
Message-ID: <20240116010642.218876-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010642.218876-1-sashal@kernel.org>
References: <20240116010642.218876-1-sashal@kernel.org>
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

From: Tony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit a0d8f4eeb7c4ffaee21702bcc91a09b3988c5b7a ]

The 'status' attribute for AP queue devices bound to the vfio_ap device
driver displays incorrect status when the mediated device is attached to a
guest, but the queue device is not passed through. In the current
implementation, the status displayed is 'in_use' which is not correct; it
should be 'assigned'. This can happen if one of the queue devices
associated with a given adapter is not bound to the vfio_ap device driver.
For example:

Queues listed in /sys/bus/ap/drivers/vfio_ap:
14.0005
14.0006
14.000d
16.0006
16.000d

Queues listed in /sys/devices/vfio_ap/matrix/$UUID/matrix
14.0005
14.0006
14.000d
16.0005
16.0006
16.000d

Queues listed in /sys/devices/vfio_ap/matrix/$UUID/guest_matrix
14.0005
14.0006
14.000d

The reason no queues for adapter 0x16 are listed in the guest_matrix is
because queue 16.0005 is not bound to the vfio_ap device driver, so no
queue associated with the adapter is passed through to the guest;
therefore, each queue device for adapter 0x16 should display 'assigned'
instead of 'in_use', because those queues are not in use by a guest, but
only assigned to the mediated device.

Let's check the AP configuration for the guest to determine whether a
queue device is passed through before displaying a status of 'in_use'.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Harald Freudenberger <freude@linux.ibm.com>
Link: https://lore.kernel.org/r/20231108201135.351419-1-akrowiak@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 934515959ebf..37d8430df32b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1749,6 +1749,7 @@ static ssize_t status_show(struct device *dev,
 {
 	ssize_t nchars = 0;
 	struct vfio_ap_queue *q;
+	unsigned long apid, apqi;
 	struct ap_matrix_mdev *matrix_mdev;
 	struct ap_device *apdev = to_ap_dev(dev);
 
@@ -1756,8 +1757,21 @@ static ssize_t status_show(struct device *dev,
 	q = dev_get_drvdata(&apdev->device);
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
 
+	/* If the queue is assigned to the matrix mediated device, then
+	 * determine whether it is passed through to a guest; otherwise,
+	 * indicate that it is unassigned.
+	 */
 	if (matrix_mdev) {
-		if (matrix_mdev->kvm)
+		apid = AP_QID_CARD(q->apqn);
+		apqi = AP_QID_QUEUE(q->apqn);
+		/*
+		 * If the queue is passed through to the guest, then indicate
+		 * that it is in use; otherwise, indicate that it is
+		 * merely assigned to a matrix mediated device.
+		 */
+		if (matrix_mdev->kvm &&
+		    test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
+		    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
 			nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
 					   AP_QUEUE_IN_USE);
 		else
-- 
2.43.0


