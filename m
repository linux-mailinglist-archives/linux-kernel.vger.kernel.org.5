Return-Path: <linux-kernel+bounces-60893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DFE850AAF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBCC1C217E5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6BA5F484;
	Sun, 11 Feb 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc3tKS7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2AA5D73E;
	Sun, 11 Feb 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673423; cv=none; b=RZCvmYWZFc8yHqyosMcCO8uw5R0XjJZxk/STw+VW0yGYIfWSmcBdib8WhhYS9bQF+TBMdePDkxqUVu7Nd/8K+wpXaBxccdAxUU4cz1TgorpXz/L9BQsGvdSvYwB8epk5C6j7SBndnxBxM+HHKLpTVhiZkztg2CDnbQKnYS72HC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673423; c=relaxed/simple;
	bh=oP7Cqkm/5T3pGBvjae33JMVHKBsSoCzjAMOiZeqVCQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uk+d2XyLnwDl29lpVzxbtv82pgbY/6iwHBpYjVO3SKVsIiFTGosXOgQHtzZF5BEs1JXhT+dN+wD7va49uPrcPRAcktj4Yz1zMU+HEIRLSH/hvdPUmwpnFdzmwkH/09ysny8v27eZscf8LvAC5SqptVnHAFOHZACZsgGDhsoFAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc3tKS7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96E8C433F1;
	Sun, 11 Feb 2024 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673423;
	bh=oP7Cqkm/5T3pGBvjae33JMVHKBsSoCzjAMOiZeqVCQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nc3tKS7Cfm2B/aaEnOZz/NuKLMPYUqycHKpE821Nh54RAULRAh8B9c2A24fgokQCN
	 mSouTJKqU7l8Xy35as8W/rK1xvuro0pmX+9zAsMlxBMnGRU+Q0rY6oVbgYe/rZuZjg
	 hAMKM5XFu8F6EyP25nlWb81GKSZPuE/tDLhuCWx4y9fOzJV5gPx0+2a3puYGwHE/vK
	 3D2DDBybvc3hf7bz/eJP8ul93rejo+UpKblluzFuw303o1Yfc6b2PpOP7u5s1WhzL6
	 MpU6A0FVRYRefT7sIJsOuRZkWFOXQDv2UIqmBCvMzKlF/Ic/PBTC+CSWFXjg2onKJr
	 OSB2XFbLyNwog==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 8/8] iio: adc: adi-axi-adc: Use __free(device_node) and guard(mutex)
Date: Sun, 11 Feb 2024 17:42:36 +0000
Message-ID: <20240211174237.182947-9-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211174237.182947-1-jic23@kernel.org>
References: <20240211174237.182947-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Avoid need to manually handle of_node_put() or the unlocking of the
mutex.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/adi-axi-adc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c247ff1541d2..3c85e8a6467b 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -248,19 +248,19 @@ static struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
 {
 	const struct adi_axi_adc_core_info *info;
 	struct adi_axi_adc_client *cl;
-	struct device_node *cln;
 
 	info = of_device_get_match_data(dev);
 	if (!info)
 		return ERR_PTR(-ENODEV);
 
-	cln = of_parse_phandle(dev->of_node, "adi,adc-dev", 0);
+	struct device_node *cln __free(device_node) =
+		of_parse_phandle(dev->of_node, "adi,adc-dev", 0);
 	if (!cln) {
 		dev_err(dev, "No 'adi,adc-dev' node defined\n");
 		return ERR_PTR(-ENODEV);
 	}
 
-	mutex_lock(&registered_clients_lock);
+	guard(mutex)(&registered_clients_lock);
 
 	list_for_each_entry(cl, &registered_clients, entry) {
 		if (!cl->dev)
@@ -269,22 +269,14 @@ static struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
 		if (cl->dev->of_node != cln)
 			continue;
 
-		if (!try_module_get(cl->dev->driver->owner)) {
-			mutex_unlock(&registered_clients_lock);
-			of_node_put(cln);
+		if (!try_module_get(cl->dev->driver->owner))
 			return ERR_PTR(-ENODEV);
-		}
 
 		get_device(cl->dev);
 		cl->info = info;
-		mutex_unlock(&registered_clients_lock);
-		of_node_put(cln);
 		return cl;
 	}
 
-	mutex_unlock(&registered_clients_lock);
-	of_node_put(cln);
-
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
-- 
2.43.1


