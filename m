Return-Path: <linux-kernel+bounces-144391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868A8A4557
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252F02818B6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99C1386C7;
	Sun, 14 Apr 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="oTIabP6q"
Received: from mail-108-mta91.mxroute.com (mail-108-mta91.mxroute.com [136.175.108.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793D1384BF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127308; cv=none; b=DlNAsN6q4mGabobBb/rFtQ61Ne4/0ZtX0pj072iIqbwWvn8yFyQjtHwDbQv+0AzTLVV1XiZWgkCMT4wNEbo730q1eX9nxhDnhBvZkIlilyTvhkcqc6ilsRVLCxv94NYGhVGYyt9VoP0eOxXEpPKq13UwtyFOFRZxS7Nwr7Znsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127308; c=relaxed/simple;
	bh=DW93lC9rSeEtaobf7itjE64XnEYnqZ7qSOk+RzOJB00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgUox1hJPmHyIRdDRzBXrIPIxamqx9C6K/LP4nNe4VoCyOQaMy0M/qlkKCZesY1HQP4smPmQezGCJ/i4sI9HFXzAXU7xLvAOa6mrPHHm3OWOKmbmbTa/9HdeBlmKtmfh0LRGVOv2Ul8+WvoRyunD+A+ll1p9fqHdaUhX8iYFlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=oTIabP6q; arc=none smtp.client-ip=136.175.108.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta91.mxroute.com (ZoneMTA) with ESMTPSA id 18ede528fc90003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 14 Apr 2024 20:35:36 +0000
X-Zone-Loop: a96ddb51466d70be8df5f120cc3968df8c1d9dbd7e73
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bZhiRPeL9jOMw1N4B5HoYuhr3z7xt+xH2s8wek/zi98=; b=oTIabP6qCAiNi1yrWNsKxv64Mk
	74GdHmJa+OSzZRE8qC0eL4GvS+3ydx1TGts8Kr3QxeeEQaDXDofugAHSszLQF1rk/UOdl1yqDxaP2
	euZoFEHdMczB1cR7j8kFhHHM74WxUloHcp1BvvFamuQZJZWV6/T9R8Z8EpMo39dLHg9Og8K15Bw6N
	cTVMT0h2R7Kr2YvYNDoVfCaGE3hmZ67k10rqqZVoS8O9f9/dIpBBxsXa8rMtb95vcrDcJtiPsQYXd
	+3L5L7rZfz6yrO07NXIZD20T2U56p4Wa1qXKQa/ACdhtZX69qi4gtaqcqi2fjBUmoa0UaEbGRmXLp
	RR7EUyHQ==;
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
Subject: [PATCH v4 12/25] media: i2c: imx258: Allow configuration of clock lane behaviour
Date: Sun, 14 Apr 2024 14:34:50 -0600
Message-ID: <20240414203503.18402-13-git@luigi311.com>
In-Reply-To: <20240414203503.18402-1-git@luigi311.com>
References: <20240414203503.18402-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The sensor supports the clock lane either remaining in HS mode
during frame blanking, or dropping to LP11.

Add configuration of the mode via V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
---
 drivers/media/i2c/imx258.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 59a78a4cfe44..2429eb7b55c6 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -72,6 +72,8 @@
 /* Test Pattern Control */
 #define IMX258_REG_TEST_PATTERN		0x0600
 
+#define IMX258_CLK_BLANK_STOP		0x4040
+
 /* Orientation */
 #define REG_MIRROR_FLIP_CONTROL		0x0101
 #define REG_CONFIG_MIRROR_FLIP		0x03
@@ -632,6 +634,7 @@ struct imx258 {
 	const struct imx258_link_freq_config *link_freq_configs;
 	const s64 *link_freq_menu_items;
 	unsigned int nlanes;
+	unsigned int csi2_flags;
 
 	/*
 	 * Mutex for serialized access:
@@ -1066,6 +1069,14 @@ static int imx258_start_streaming(struct imx258 *imx258)
 		return ret;
 	}
 
+	ret = imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
+			       IMX258_REG_VALUE_08BIT,
+			       !!(imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK));
+	if (ret) {
+		dev_err(&client->dev, "%s failed to set clock lane mode\n", __func__);
+		return ret;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx258->cur_mode->reg_list;
 	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
@@ -1438,6 +1449,8 @@ static int imx258_probe(struct i2c_client *client)
 		goto error_endpoint_free;
 	}
 
+	imx258->csi2_flags = ep.bus.mipi_csi2.flags;
+
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
 
-- 
2.44.0


