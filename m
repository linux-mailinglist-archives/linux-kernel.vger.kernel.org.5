Return-Path: <linux-kernel+bounces-13708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F20820B73
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344361C213BA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430F5395;
	Sun, 31 Dec 2023 13:29:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B04418;
	Sun, 31 Dec 2023 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ucas.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ucas.com.cn
X-QQ-mid: bizesmtp72t1704029295tp77jwnr
Received: from localhost ( [222.129.36.236])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 31 Dec 2023 21:28:13 +0800 (CST)
X-QQ-SSF: 01400000000000E0Q000000A0000000
X-QQ-FEAT: 4LPFn8ee8koCpu0RO5WhWZFMz3Uy8coMUXK3Fsz01rHjpcEfi5sk9UU9nt6yY
	8MqBIL19uFs/8LH+wjAwsbHmoZ7ODSD/nLeIketFaKb3z3kvNHu+VQXFjEeLb71NdFUL+p9
	EHNxJW0ETplCTTc4wbX6ul8lkhcQwOiNc66KfTSeihqTm/Hv4RCzxMmXBjT/YnltOmNxk1y
	K6YLmBkroCDYacTd5LO4ZfkMfmpcOnoJFdQFyYPPcivg9G7HASTOZ59h78yn9GMMg6T4P+Y
	It0nz/ymF1IuKuPO+fJccQKawfoGsqB4FzwdwxsOhK3EqLIFPKtmUupfP2VZfy0no5u0FG3
	nOYSV/d+9nWNgjkJDGIU9HiGmbaIQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13934946956939124387
Date: Sun, 31 Dec 2023 21:28:17 +0800
From: "zhili.liu" <zhili.liu@ucas.com.cn>
To: songqiang1304521@gmail.com, jic23@kernel.org, lars@metafoo.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drivers/iio/magnetometer/rm3100-core.c:add boundary
 check for the value read from RM3100_REG_TMRC
Message-ID: <60D6AC11DAAB99DB+20231231132817.GA130@LAPTOP-9C7JTT8O.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:ucas.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

From d985bd979df3f1c4327e1374f1af953a1024de33 Mon Sep 17 00:00:00 2001
From: "zhili.liu" <zhili.liu@ucas.com.cn>
Date: Fri, 29 Dec 2023 19:52:40 +0800
Subject: [PATCH] iio: magnetometer: rm3100: add boundary check for the value
 read from RM3100_REG_TMRC

Recently, we encounter kernel crash in function rm3100_common_probe
caused by out of bound access of array rm3100_samp_rates (because of
underlying hardware failures). Add boundary check to prevent out of
bound access.

Suggested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
---
 drivers/iio/magnetometer/rm3100-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 69938204456f..fc50b6d4a334 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -586,6 +586,12 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
 	if (ret < 0)
 		return ret;
+
+	if (tmp < RM3100_SAMP_NUM || tmp - RM3100_TMRC_OFFSET >= RM3100_SAMP_NUM) {
+		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
+		return -EINVAL;
+	}
+
 	/* Initializing max wait time, which is double conversion time. */
 	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
 				* 2;
-- 
2.25.1


