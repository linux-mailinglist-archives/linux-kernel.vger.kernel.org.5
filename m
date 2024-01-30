Return-Path: <linux-kernel+bounces-44467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE485842270
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDEE1F2A732
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1366B54;
	Tue, 30 Jan 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qt0nsFEZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C5664AE;
	Tue, 30 Jan 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613197; cv=none; b=ZZTncZ47W62MGa2Wc7ABxCURX8/bdOu1VXiRuE5AbJqknVhiZWxVJnKyi5cTc32JMuFFlnA760DiyqE8TjOhZ83OwCrhGZI1PjZfxZ27ZHgPVAlp3wRHcxEPzI1Q7fARAEmWt932tnbhnKaUdYxkWEZcaQt5qnCLTLddnznG1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613197; c=relaxed/simple;
	bh=NMhqSFdRSjNI1p1vyp5dOffkk1ADZ0MeWiy+ifEvnrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6A+YXIeqtedJSq1x3qSAwDSBg17IFFcZu0iFAc1qPE1fm8iu7FoWRPTrzn8d7GB8bak/k9QxmQtSrJ3LNYtr3tMuDKkxULbL4OW6rVWIESSECkeUb0/neYZQmQTMyH4pV4ldI0fTVLzJYngnDBVTZFm89ECfo4UrZCfjjgU1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qt0nsFEZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613192;
	bh=NMhqSFdRSjNI1p1vyp5dOffkk1ADZ0MeWiy+ifEvnrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qt0nsFEZO5QpPc8PT9E0Lm/cgu375vY8D/mR9k7Z3W1Wv+myVR0nC/5GsZAjx1uOg
	 IOPezeLBWscheyDiOgrc/qZAVxW2SIrVUutDo7DZ63z9zUaXkaOq4XWiQV+cYY6Cb/
	 a6gCdWmh3IEA5qY5GYnH3bdWQBTID73s0OeKIN3eC0naUOfwNSfz1+7Gn+mzXamZZ1
	 LbYglX3oHMZWJBash/KF827A8A2VN09xGuA48AaHftWY8fjbotKGMviiOHH6Ui9Wl9
	 +4O3dOIUxOrUpnxr2lKSbzRngscGghNZAZQNMEs9YlAtIaUx9luxx0GphbKNcEdKnI
	 Xff/+eqNdXpPA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F116F37811F4;
	Tue, 30 Jan 2024 11:13:09 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	support.opensource@diasemi.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	niklas.soderlund@ragnatech.se,
	srinivas.pandruvada@linux.intel.com,
	angelogioacchino.delregno@collabora.com,
	baolin.wang@linux.alibaba.com,
	u.kleine-koenig@pengutronix.de,
	hayashi.kunihiko@socionext.com,
	d-gole@ti.com,
	linus.walleij@linaro.org,
	DLG-Adam.Ward.opensource@dm.renesas.com,
	error27@gmail.com,
	heiko@sntech.de,
	hdegoede@redhat.com,
	jernej.skrabec@gmail.com,
	f.fainelli@gmail.com,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 01/18] thermal: core: Change governor name to const char pointer
Date: Tue, 30 Jan 2024 12:12:33 +0100
Message-ID: <20240130111250.185718-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users are already assigning a const char * to the `governor_name`
member of struct thermal_zone_params and to the `name` member of
struct thermal_governor.
Even if users are technically wrong, it just makes more sense to change
this member to be a const char pointer instead of doing the other way
around.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/linux/thermal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index b7a3deb372fd..65d8f92a9a0d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -214,7 +214,7 @@ struct thermal_zone_device {
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
-	char name[THERMAL_NAME_LENGTH];
+	const char *name;
 	int (*bind_to_tz)(struct thermal_zone_device *tz);
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz,
@@ -226,7 +226,7 @@ struct thermal_governor {
 
 /* Structure to define Thermal Zone parameters */
 struct thermal_zone_params {
-	char governor_name[THERMAL_NAME_LENGTH];
+	const char *governor_name;
 
 	/*
 	 * a boolean to indicate if the thermal to hwmon sysfs interface
-- 
2.43.0


