Return-Path: <linux-kernel+bounces-116038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACEA88951F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4533B294BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E97180B89;
	Mon, 25 Mar 2024 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW4+6R0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACCB176521;
	Sun, 24 Mar 2024 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323428; cv=none; b=AHlhv38RGRiLw9Ji1ngi9xiVVobjT6AfsFDxbjBFWj3/TW1TLsXByrQ24APEqD6xrUBNQijWE7NkwIBmCaExkgtcQW1EMKKjsuZxUlKeFxNdHGCH8v+XObm2k6SILJcM+5AiWlCvgFFDQK/YFQXa5gww2sRzwspC0RcVFYOrceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323428; c=relaxed/simple;
	bh=Kh+pXPrwm31EcD9O+J7RWqTAjnpuybOzZzdnDPK5kUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfH63p1XxvWr6wc2LJH5Ww8jhnOXhq6/4g9cMOlf3cf7aVMwOLOOZBeJjM2nVerWxpdgq/Jk3xe/NXv+v3InYZGNGG2ZhV9JR5gKCexxTWqhXp5Z4Wh2TTGg+nGvmDYoKjAijYJX6RzqxFFgLq8zZoAjNy1xz3CMr45ZbsruQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW4+6R0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8E5C43390;
	Sun, 24 Mar 2024 23:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323428;
	bh=Kh+pXPrwm31EcD9O+J7RWqTAjnpuybOzZzdnDPK5kUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mW4+6R0KOYfEtzuXWW0+CckxRrvJLWpshUO23VZQZQqUSf6bo8xKkc5DWxu+UwxlD
	 tkl3l4uVnzYYqYgNnib6piuwzfxdGjlxIxLV7CKEG2GMpDyT1aJROHPQzNvzAm783p
	 ++T2lIowG17Grluwbk7VEn5eg8+NFs1swNaXjxFyw6D15tk5RjdFEmdUxaaoGgg6It
	 vUfbuNamSlS6uo1TmAJFwfmBcDOkfuEx9PZNUKFZ2XnsG28fm/JwerQ6oozrKn9Y0n
	 l93v2Rc+pUuPkTpZFcLvYls1s0G870/nldEFR2ffyAjxT4mChyZq3nhLveSk3Fs3cw
	 271YWRc7/tKGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 130/317] Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
Date: Sun, 24 Mar 2024 19:31:50 -0400
Message-ID: <20240324233458.1352854-131-sashal@kernel.org>
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
index 7c641cabea7c8..d5f408851a005 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2087,7 +2087,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en) &&
+		if (IS_ERR(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
@@ -2096,7 +2096,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
-		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
+		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855))
 			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
@@ -2120,7 +2120,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
+		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}
-- 
2.43.0


