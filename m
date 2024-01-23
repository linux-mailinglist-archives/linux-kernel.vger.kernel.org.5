Return-Path: <linux-kernel+bounces-35425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0DF8390DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF41C21B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6CE5FBAB;
	Tue, 23 Jan 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wSR6GGTG"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D055D8E2;
	Tue, 23 Jan 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018980; cv=none; b=Eb+wXMOydszX40pkGIC9KvVuL42kNhOdAj+C3Kqw4gz8j/aHCdg1OmgOvm0i9uRQAy5rNFxmVDH5uZATaCIBcpf5vC1Rfko67Q0tWfcO81jZexC7jG6lDT5GPZb4scdy4C0rolqkOmdnpdetpZsUco8oELzM3YKJrgKLUwkCnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018980; c=relaxed/simple;
	bh=SxuTBORfGF5xuK7WaufdbTkcdXRpMj62tgVmhO2eMZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fi4Ux+S5Hkg4n10Np5hMVmxxzpVOPQZhQ5SLzssAe4Ql6x2BrxAK/cDVhMphqDHqc23KuEicEy2Yzhj6VLbmdKXiw9twr2VGOqKYyZmoGWA2YrJIdlVItXoNrbVGEOfUMV5NZ/exT+fm5JACtCp3W4O5uWrsEvQTFJoRG3H3s64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wSR6GGTG; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NE9KCH051462;
	Tue, 23 Jan 2024 08:09:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706018960;
	bh=WOE09cQw18mGzukoI/a3Ir2egN+CAwTh+Jgs3xeKW1k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wSR6GGTG/DtYAb0xxfn2+UYvmLq5BYeOUZPAE6kChLfOEV6gxyDNh+4TnZilzVqFT
	 bUgrneOT5tDSlSKAPA5IswAgSmNmL7RZ+SKAObmDltfzSzea/7UNE3SKAls1377A0M
	 HRRlDQGRcOH1aesN+AXVONR7a06n1oAJmpgdNhwg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NE9KvJ003092
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 08:09:20 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 08:09:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 08:09:19 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NE9Iut034990;
	Tue, 23 Jan 2024 08:09:19 -0600
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 3/4] iio: health: afe4404: Use devm action helper for regulator disable
Date: Tue, 23 Jan 2024 08:09:17 -0600
Message-ID: <20240123140918.215818-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123140918.215818-1-afd@ti.com>
References: <20240123140918.215818-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use a device lifecycle managed action for regulator disable function.
This helps prevent mistakes like unregistering out of order in cleanup
functions and forgetting to unregister on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/iio/health/afe4404.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index ede1e82013118..75a513a92242c 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -349,6 +349,13 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void afe4404_regulator_disable(void *data)
+{
+	struct regulator *regulator = data;
+
+	regulator_disable(regulator);
+}
+
 /* Default timings from data-sheet */
 #define AFE4404_TIMING_PAIRS			\
 	{ AFE440X_PRPCOUNT,	39999	},	\
@@ -502,19 +509,24 @@ static int afe4404_probe(struct i2c_client *client)
 		dev_err(afe->dev, "Unable to enable regulator\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(afe->dev, afe4404_regulator_disable, afe->regulator);
+	if (ret) {
+		dev_err(afe->dev, "Unable to enable regulator\n");
+		return ret;
+	}
 
 	ret = regmap_write(afe->regmap, AFE440X_CONTROL0,
 			   AFE440X_CONTROL0_SW_RESET);
 	if (ret) {
 		dev_err(afe->dev, "Unable to reset device\n");
-		goto disable_reg;
+		return ret;
 	}
 
 	ret = regmap_multi_reg_write(afe->regmap, afe4404_reg_sequences,
 				     ARRAY_SIZE(afe4404_reg_sequences));
 	if (ret) {
 		dev_err(afe->dev, "Unable to set register defaults\n");
-		goto disable_reg;
+		return ret;
 	}
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -530,8 +542,7 @@ static int afe4404_probe(struct i2c_client *client)
 						   iio_device_id(indio_dev));
 		if (!afe->trig) {
 			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
-			ret = -ENOMEM;
-			goto disable_reg;
+			return -ENOMEM;
 		}
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
@@ -539,7 +550,7 @@ static int afe4404_probe(struct i2c_client *client)
 		ret = iio_trigger_register(afe->trig);
 		if (ret) {
 			dev_err(afe->dev, "Unable to register IIO trigger\n");
-			goto disable_reg;
+			return ret;
 		}
 
 		ret = devm_request_threaded_irq(afe->dev, afe->irq,
@@ -549,7 +560,7 @@ static int afe4404_probe(struct i2c_client *client)
 						afe->trig);
 		if (ret) {
 			dev_err(afe->dev, "Unable to request IRQ\n");
-			goto disable_reg;
+			return ret;
 		}
 	}
 
@@ -573,8 +584,6 @@ static int afe4404_probe(struct i2c_client *client)
 unregister_trigger:
 	if (afe->irq > 0)
 		iio_trigger_unregister(afe->trig);
-disable_reg:
-	regulator_disable(afe->regulator);
 
 	return ret;
 }
@@ -591,10 +600,6 @@ static void afe4404_remove(struct i2c_client *client)
 
 	if (afe->irq > 0)
 		iio_trigger_unregister(afe->trig);
-
-	ret = regulator_disable(afe->regulator);
-	if (ret)
-		dev_err(afe->dev, "Unable to disable regulator\n");
 }
 
 static const struct i2c_device_id afe4404_ids[] = {
-- 
2.39.2


