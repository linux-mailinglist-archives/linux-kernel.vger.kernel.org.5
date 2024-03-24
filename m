Return-Path: <linux-kernel+bounces-115927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6437F8898B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C861C230B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D838BD12;
	Mon, 25 Mar 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHDDKc+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B875227E15;
	Sun, 24 Mar 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322123; cv=none; b=hQU3mYzs6Otbq2KaVewWFUb9ykf0swlt3jCpctAZ0gxFP0tko/gOLQf7UR4BOvgs8LGelcp3StBJzsdH3lqeQzc8Ox8aaTXrSxTfJYiqy6Jw0BJS5jM5BEUoL/y/WvEWV5LIBQIFbj0fTe9P/L8BioXdOHVlEPCK/RakS/tgSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322123; c=relaxed/simple;
	bh=7SWI23WUhAkr2nCTc7cnWgEVIPpewP0e2j/EvO2BqdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL/QTx9XN4iHDs3FP2sX9kvsMGU53LwgnYZXBztLezblr7jJIay1hPCofnIwcceDZv/zcBGr8/EKwVf7iJau5cpnrJWii0NSGHqjd2UZvraSmhnfkaq2YA7neLPoF4hoR3TKAZRK/ZwTICZWVUdMzs54sEpqRCjPyCbhgiPniGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHDDKc+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CFAC433F1;
	Sun, 24 Mar 2024 23:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322122;
	bh=7SWI23WUhAkr2nCTc7cnWgEVIPpewP0e2j/EvO2BqdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHDDKc+n6JDLCHupfHPpgqN6V0yq4uYFPTbcs8DCZkcM2wbFeV7c/xTMl6/gN0+JP
	 0zuYCStep9pkr+nOWki9arRIBcrklxdvReqEmrCozC52df5PmOJ6cBKWgH7cDVR3MM
	 4FpSpug4VSRXtZgrlwFBDpirHVkN/a/QcPZHyKEml8a+SoMouhX0EELmE3NaosP02S
	 1IhK9ymH6O4DRt5djhDWIU42v00bqN1HPcYvvpShLI3+JnJqIJSm65XWoGAIC+rQfw
	 4y1y6/95rhd3XkkI/LHBo0JXPLW26emLJvGUXWt6cgUK0HbjvuVmBEzbiq0TPPcTPj
	 4X/9stprLujAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 197/451] Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
Date: Sun, 24 Mar 2024 19:07:53 -0400
Message-ID: <20240324231207.1351418-198-sashal@kernel.org>
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
index 8bfef7f81b417..2acda547f4f3e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2254,7 +2254,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en) &&
+		if (IS_ERR(qcadev->bt_en) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
@@ -2263,7 +2263,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
-		if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
+		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
@@ -2285,7 +2285,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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


