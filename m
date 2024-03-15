Return-Path: <linux-kernel+bounces-104940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CED87D63A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B792282F22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE454912;
	Fri, 15 Mar 2024 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TR8k0t9H"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFAB548F4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538561; cv=none; b=lFyldYsdPLgLF1dz7pWeIetMfsxZvSQYWXjeckx8Z3krLR5Ye11KkEncuyUjCU05A5kszCEh3msqN7P3+snJtghhZ9UTMTrM6y+X/xZarHw7qXC449DAMTxooln1vsoU73fp12x2X7U/qiXKVk/dcZm9YhnVD/3MFWj/7IGF9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538561; c=relaxed/simple;
	bh=CG2MR7sO9yin4h+PbF8Oq5ga4DEY+K/45S38A5VbGSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCRi+UO5XaMTRFAo3DbyoApVGNIA24qlxl+W+fWRX3ApRFB5ZSwO5sjwzRAIm1YtCbvifxn7ShEmlDouLiYwEVJ2ZLknRmBnzkaL3rz2cDT+KSFwVXQKtK7GaT6VPig3IQpf0n/ODMwgdD+VbKX9d34lKp8N4aPUjEjaktYqFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TR8k0t9H; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710538555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zLhbNCpAsdnAMm/9yoY8p/qO8u7ebloSJXuKEpMzYWA=;
	b=TR8k0t9HMgzywrFBM7L3wdTnNZLquR0M5r0jLh9Abig5sBkYd36GADUjpcYywentdEmUNr
	9DdvV5lea2SIDb6hN//OpuPmBH5d5pLucUzqcdYpfjShUSGLtn64SkcbK0vaEqwUD3zkbp
	RFlObyIa4rSHXGt1MwbBQeenS3otouU=
From: Sean Anderson <sean.anderson@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] misc: ds1682: Add NVMEM support
Date: Fri, 15 Mar 2024 17:35:40 -0400
Message-Id: <20240315213540.1682964-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add NVMEM support for the internal EEPROM.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/misc/ds1682.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
index 21fc5bc85c5c..5f8dcd0e3848 100644
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -32,6 +32,7 @@
 #include <linux/i2c.h>
 #include <linux/string.h>
 #include <linux/list.h>
+#include <linux/nvmem-provider.h>
 #include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <linux/hwmon-sysfs.h>
@@ -197,11 +198,43 @@ static const struct bin_attribute ds1682_eeprom_attr = {
 	.write = ds1682_eeprom_write,
 };
 
+static int ds1682_nvmem_read(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct i2c_client *client = priv;
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, DS1682_REG_EEPROM + offset,
+					    bytes, val);
+	return ret < 0 ? ret : 0;
+}
+
+static int ds1682_nvmem_write(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct i2c_client *client = priv;
+	int ret;
+
+	ret = i2c_smbus_write_i2c_block_data(client, DS1682_REG_EEPROM + offset,
+					     bytes, val);
+	return ret < 0 ? ret : 0;
+}
+
 /*
  * Called when a ds1682 device is matched with this driver
  */
 static int ds1682_probe(struct i2c_client *client)
 {
+	struct nvmem_config config = {
+		.dev = &client->dev,
+		.owner = THIS_MODULE,
+		.type = NVMEM_TYPE_EEPROM,
+		.reg_read = ds1682_nvmem_read,
+		.reg_write = ds1682_nvmem_write,
+		.size = DS1682_EEPROM_SIZE,
+		.priv = client,
+	};
+	struct nvmem_device *nvmem;
 	int rc;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -211,6 +244,10 @@ static int ds1682_probe(struct i2c_client *client)
 		goto exit;
 	}
 
+	nvmem = devm_nvmem_register(&client->dev, &config);
+	if (IS_ENABLED(CONFIG_NVMEM) && IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
 	rc = sysfs_create_group(&client->dev.kobj, &ds1682_group);
 	if (rc)
 		goto exit;
-- 
2.35.1.1320.gc452695387.dirty


