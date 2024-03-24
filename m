Return-Path: <linux-kernel+bounces-113776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B2888E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA61F31FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C91E2EC1;
	Sun, 24 Mar 2024 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvCE0toy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1421E2562;
	Sun, 24 Mar 2024 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320787; cv=none; b=HMPiDgoED8VvZ6x3vb5nxcpDSrRk9TjWlg3epS7GJpoJyJubtI8uBipPf/jzh0j6GyzP1WDJd3nphKuBiJdbjtwcM0hcFIWj23ddbJbhQ8npaGiG1a03jpUe9C1TaVWxKyOfxARGRKuvGMOedpJZudNh2PCsUDgGfW/Ti1PPR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320787; c=relaxed/simple;
	bh=tRgyfE1J4Fe3Y0cCshJvvPBauQhSZVEKNuiHqQIpNmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQguc1tnYoVRr9HcacGe5L35qp+oN/UtwkWM75HYSRGyEBSFZazRbwMshvA0hcBE6JcrQamaQZQ/Gke20Xm5i5x8CG5t66lylxG1nF49SN8Kk8D/dtIAAjKX1ZRVJHGAESGzm6vDXw5nzb9IB/CQOJjwneGYbVFBtIqARK7yzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvCE0toy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D82C433F1;
	Sun, 24 Mar 2024 22:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320785;
	bh=tRgyfE1J4Fe3Y0cCshJvvPBauQhSZVEKNuiHqQIpNmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvCE0toycz3jDkENuZb9KRi/u2xX0ZykpMdmiNKIltt89oPYsroliwqiUZ050QzfZ
	 ePOf7kMjcG9EO2L1VN0kBNJiGG995hdIJQNFyz8Mxbz72ibYL6MgnHKrM+K1350WaJ
	 jX2awdKhcdih2SWJCqPyTjcj8R/xnTtJum1IeK3UbH8mvB/KOxC7GQ3FemxQyU0+84
	 V2dA4E83UvHuzuLpZRE3S2tYfH2c1zPaSKruMGkzUJ4t7ObqjRcWZHgPcLe7ItuMTH
	 6aPkCSxrSDrN/HSTSxtYn9gmBWE2PMWPU68P5pS0YPfjJd4WE2E6l3sxqGQtx3TL8P
	 Jo8CP6c+S09Tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 348/713] Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
Date: Sun, 24 Mar 2024 18:41:14 -0400
Message-ID: <20240324224720.1345309-349-sashal@kernel.org>
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

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 56d074d26c5828773b00b2185dd7e1d08273b8e8 ]

The optional variants for the gpiod_get() family of functions return NULL
if the GPIO in question is not associated with this device. They return
ERR_PTR() on any other error. NULL descriptors are graciously handled by
GPIOLIB and can be safely passed to any of the GPIO consumer interfaces
as they will return 0 and act as if the function succeeded. If one is
using the optional variant, then there's no point in checking for NULL.

Fixes: 6845667146a2 ("Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qca_serdev_probe")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a65de7309da4c..bb69b7ea8119d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2304,7 +2304,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en) &&
+		if (IS_ERR(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
@@ -2313,7 +2313,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
-		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
+		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
@@ -2335,7 +2335,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	default:
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
+		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
-- 
2.43.0


