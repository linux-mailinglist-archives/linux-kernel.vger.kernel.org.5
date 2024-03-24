Return-Path: <linux-kernel+bounces-113501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A98884D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BBA1F2332D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A913D60E;
	Sun, 24 Mar 2024 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3519hdf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA051B9DD7;
	Sun, 24 Mar 2024 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320302; cv=none; b=TDSM3ZAow8AXbZB7aT7fN1GDv/lJ0p/mL67t3fw7MKtVGxgqYl1p9p/a38Q3nIN4rnPnWw4HPhbBMrQ79idYGt4ZSan4P0no4ALO6GcRK6XfC59AQHj7q1clkb9kFJmgaxRi8WQdDjT63S5w4BsHi7ZQf/Wd9/vIp9wE8I3T4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320302; c=relaxed/simple;
	bh=YKSk4417jnkaegNrpdi4LwpmOOlK3FepNJNTBW4pIRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHyokJ7ZtVcWNXaz3P2sHOmc6TAQ9SMsmivS2j1YICdONOgmP5wEaPBGEtUDyBde5Mq1lE08SN5Ji8esH1zNtKIug32OG294/cPhyAYPQ4uCSPPhF5L/6iUJG0SWotXWDCKCm3GmRJz450NbtVEaCfISg0QfU6iCXExNhZalDHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3519hdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF966C433C7;
	Sun, 24 Mar 2024 22:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320302;
	bh=YKSk4417jnkaegNrpdi4LwpmOOlK3FepNJNTBW4pIRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3519hdfksTryieY8M0TLD24sLDxSwpWuh2vDbPfmABKbweix+0Mcsybp8qbHWMFI
	 u6x0crL8UXNo/AVvNjdzAoZI6QRXRhcsTHDdP/i97ZxhAAikD34e17bB6Fy9kBu+77
	 qgVF3qtHGkhmAcQPp2beFKsrTMesr9rx7G+lp9W7swidX8bc9182lpoZ1jpJ4QCjex
	 Du+1UtRAoKraEgBYMVpFP8K48i0zH7aFvPFcxvps1vcS9UIuS+slh7rKqtXczHrArg
	 /gSM8lXkOcaCNf8062RDFUQpUB1AOW7GnqkjzSIt0J0gpa4HxAJX9UlbK7HC3QsmXe
	 WhwXH9nsgjWQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 610/715] iio: pressure: mprls0025pa fix off-by-one enum
Date: Sun, 24 Mar 2024 18:33:09 -0400
Message-ID: <20240324223455.1342824-611-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


