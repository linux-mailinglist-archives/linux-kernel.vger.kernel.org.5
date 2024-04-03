Return-Path: <linux-kernel+bounces-130087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A878D8973EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45591C24C37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2D14A0A0;
	Wed,  3 Apr 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="QvPdXUFu"
Received: from mail-108-mta230.mxroute.com (mail-108-mta230.mxroute.com [136.175.108.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF7200D4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157858; cv=none; b=ZVdWSykYC7jjQkmEU2Jpop+uBedqq4p+/954vX9QYvusOpEqdwpXsEoU0p0zPdV89PwvKiP0RpKavzAXxD9bme+Nodnab8Ft+zVIp88MLd5ua80ZM5DaTbtv9gxbTHpbPOdTjYkO4VgGl1pwn1ZYPGISx7RC/j2CYbv/VhlupLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157858; c=relaxed/simple;
	bh=P6sFYE2RFyMP+jyTKPG/NPzsohsjE50jpPWJbVR2FnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEahYGJTgvpqWy+sLe4VYnN+GZdVNXIjFBzy6yTIxuHgjKdYfsvn8B/ulAVzmgH69k3lXRuZ4vUcYqJLccV3Vkrumgf6l6JtJkMQNV0qjQjd5Wm5mnWmtd1MpmGUzItEyaIg9z8Rg6lUd9nGnmQWOKbeVW02I50PacYK9n6/1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=QvPdXUFu; arc=none smtp.client-ip=136.175.108.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta230.mxroute.com (ZoneMTA) with ESMTPSA id 18ea48ace6d0003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 03 Apr 2024 15:19:04 +0000
X-Zone-Loop: 145612d79a4fabd7a63fe255e4f0c927b99790ad46e2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tn3xRU5mtzTvJZghODMqRw0ULnXG09wTsVZrMIwsFGY=; b=QvPdXUFuy1A7P9ydQKgHJhheqt
	WkdvfyKXwUD+FqZFlZUYxyspghJF4mEzHneCx7CQ6m4BnYfkMAOF8aZy6D9gArVw5WT09Bhsu8Hlu
	qrsgyHQrHFvHG20wAUvM88NEktefZ5yqJ8SUgXzlSzCIAaYAEiw0v2z8Lvayn8eNswCrf+7PxdxXp
	MXgwgvnct48JPZExsc1lGu/vywnnys5hasjdYaO8pXtzcUMya65yu0Yr+JDTuIbE8gKKqJysT6eOe
	9zW9Amw9H0cCF8OGSzZaMRIYWRMEDTyUAPMcL+EAJ62tC87t+xl5ANGN5r9XDpxSDqpAAzKh4Uhps
	G0NUIlrA==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v3 25/25] media:i2c: imx258: Use v4l2_link_freq_to_bitmap helper
Date: Wed,  3 Apr 2024 09:03:54 -0600
Message-ID: <20240403150355.189229-26-git@luigi311.com>
In-Reply-To: <20240403150355.189229-1-git@luigi311.com>
References: <20240403150355.189229-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Luis Garcia <git@luigi311.com>

Use the v4l2_link_freq_to_bitmap() helper to figure out which
driver-supported link freq can be used on a given system.

Signed-off-by: Luis Garcia <git@luigi311.com>
---
 drivers/media/i2c/imx258.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 4c117c4829f1..038f40a1f800 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -674,6 +674,7 @@ struct imx258 {
 	/* Current mode */
 	const struct imx258_mode *cur_mode;
 
+	unsigned long link_freq_bitmap;
 	const struct imx258_link_freq_config *link_freq_configs;
 	const s64 *link_freq_menu_items;
 	unsigned int lane_mode_idx;
@@ -1533,6 +1534,17 @@ static int imx258_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = v4l2_link_freq_to_bitmap(&client->dev,
+				ep.link_frequencies,
+				ep.nr_of_link_frequencies,
+				imx258->link_freq_menu_items,
+				ARRAY_SIZE(link_freq_menu_items_19_2),
+				&imx258->link_freq_bitmap);
+	if (ret) {
+		dev_err(&client->dev, "Link frequency not supported\n");
+		goto error_endpoint_free;
+	}
+
 	/* Get number of data lanes */
 	switch (ep.bus.mipi_csi2.num_data_lanes) {
 	case 2:
-- 
2.42.0


