Return-Path: <linux-kernel+bounces-114417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D6888FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077642908A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB4F176FD8;
	Sun, 24 Mar 2024 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8g7lh46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904913F422;
	Sun, 24 Mar 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321829; cv=none; b=V83aReekkv24FCRcAUN1jVg9A+yhst00XjtFT8UiSKa5ZlUfGf4Q3xyp8L5v/iciSjrtQPC2MvUgHBJHec/XxKBwb/J1VVUVxfN3ygkT2hiBXuRxigSbmWRRjVOQixoCUSwKM9CMuIzzw3B9cqY71Ld9EFQ5V+LVHCN5WunxX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321829; c=relaxed/simple;
	bh=YKSk4417jnkaegNrpdi4LwpmOOlK3FepNJNTBW4pIRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHJjEF2oZJW2awmEF9frQbDAkbgLNT+CYGXdNSXAzxaJqBgcaFqnpJ0FcWJ8CfAKO4B8mvxAHuhoTN9pE+uAbWjN7yO5hwFCs7r0PYePawFHICjYtF8cY8GdGDDvm19gGwNer0TlP+vBJaEXsYI5uXNsBjBwvXClxATV06iCkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8g7lh46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC54C43394;
	Sun, 24 Mar 2024 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321828;
	bh=YKSk4417jnkaegNrpdi4LwpmOOlK3FepNJNTBW4pIRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8g7lh46du48XnVdh6RKZyYrXqECCKqt+m2P4gwrjMLZ0GlPVZ+WH1kKm8FXKTySk
	 RxUriwd2RhvaNERnUGjBu8JmfoNdNtjndfHNtYkN369BHVTEHpWLN7EtztBlKg2QF/
	 Iwzu5azLwS9I7cd+KimM9CqaDQjlLinC8cyDyGbyMDjgacUYnAJNVjstmqSkWnM6HT
	 ROJoyJzZVJkCF0jzijKdCDJXicp4mI2yPzDW1P0RUJRZMUjrQeJTjpIi4gDVoWmNAD
	 CSr7CNPw7tnKPuQcjFe7V97ZFnNxyiV5jxY25hD8bH1RTNoh793HNrA+EuSz1MzgPm
	 vAhF5o39CNXMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 557/638] iio: pressure: mprls0025pa fix off-by-one enum
Date: Sun, 24 Mar 2024 18:59:54 -0400
Message-ID: <20240324230116.1348576-558-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Petre Rodan <petre.rodan@subdimension.ro>

[ Upstream commit 9e65506ca9c7ff716c8441a33417820ad61d3a16 ]

Fix off-by-one error in transfer-function property.
The honeywell,transfer-function property takes values between 1-3 so
make sure the proper enum gets used.

Fixes: 713337d9143ed ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Link: https://lore.kernel.org/r/20231229092445.30180-5-petre.rodan@subdimension.ro
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/mprls0025pa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 30fb2de368210..e3f0de020a40c 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -323,6 +323,7 @@ static int mpr_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct device *dev = &client->dev;
 	s64 scale, offset;
+	u32 func;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
 		return dev_err_probe(dev, -EOPNOTSUPP,
@@ -362,10 +363,11 @@ static int mpr_probe(struct i2c_client *client)
 			return dev_err_probe(dev, ret,
 				"honeywell,pmax-pascal could not be read\n");
 		ret = device_property_read_u32(dev,
-				"honeywell,transfer-function", &data->function);
+				"honeywell,transfer-function", &func);
 		if (ret)
 			return dev_err_probe(dev, ret,
 				"honeywell,transfer-function could not be read\n");
+		data->function = func - 1;
 		if (data->function > MPR_FUNCTION_C)
 			return dev_err_probe(dev, -EINVAL,
 				"honeywell,transfer-function %d invalid\n",
-- 
2.43.0


