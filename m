Return-Path: <linux-kernel+bounces-70861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E619859D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0302833AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64388219FC;
	Mon, 19 Feb 2024 07:46:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757220DCB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328801; cv=none; b=qf+MsOv3qMh0kj+KdwPFTctYkHWVomvHmUWYqNWlfiNKKGs2n8spZeKCppRsZpHTqysvvB+MlbrFRlOjKcXuxYDK/xCrX3XsHmhHdwIkR9iKJJ9gBKODIc0HBT2hN3aSnorLnwBUOHkN0A+HO07XGANTICARi8XpLFYqZWwu3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328801; c=relaxed/simple;
	bh=5n374oK69anYKzr186W3GbJnE/m/Yv82dp/vgrHEbcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rg6lbBhxSbDPV5wcQLxcgY198dSSimFTucwfFpSwDGK9aoAZGBgyE6r5IOjQV/zddafMvb+1ndpfRP2j+yN+8o54zt8gu2TYdturRdULU1xHpvNR1gM9TZJ5/maVSPhV7a2EvsEpb2zk6TIIjWiFsMzyuaLuIbE0bxslKLWg5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMI-0000Qa-9v; Mon, 19 Feb 2024 08:46:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-001bI0-TH; Mon, 19 Feb 2024 08:46:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-007bwV-2f;
	Mon, 19 Feb 2024 08:46:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thorsten Scherer <t.scherer@eckelmann.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] siox: Provide a devm variant of siox_master_register()
Date: Mon, 19 Feb 2024 08:46:31 +0100
Message-ID:  <e961dfb3e94f106b16f5eacff2110fc7fa0cab13.1708328466.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5n374oK69anYKzr186W3GbJnE/m/Yv82dp/vgrHEbcQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0wdZMfEcZi8q8rmWm9FEXF5CfGlEFTwMlt1RD K8+7NIunyeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdMHWQAKCRCPgPtYfRL+ TiczB/96bCoLprpEiH7fVeWwFAW3Q/3nTdWc1kdgE57eBPs4YlwkF9uikIJEJeVvTX/CNQaN+Ym pVTGAwCs85cff4iLQsIh1wLLv1oE4jXSQRCd3hNlFlfP1bkyoZfL13hpK+6tm3MOxln/VP4isO4 V/qlMUMVr12V7STOVPjdFbexomt+JBrd3p8V06/dLC73YIaixjB7+mATDlXSuMXVasqSKJSQu1K dOz33blyY3o73Ec992k/c42yerph5eQ+UncZNrq6fhlwH5S+tc/V8Q9i4WSi3Vmurqdhostg+Fb D0uiKPCn3goewnjV3sYcrJezTgKF9G8Xn3B8/7gxL0tNSsas
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This allows to simplify siox master drivers in the next step.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-core.c | 19 +++++++++++++++++++
 drivers/siox/siox.h      |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 9dd0bda03db3..8d7cb9e24efb 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -794,6 +794,25 @@ void siox_master_unregister(struct siox_master *smaster)
 }
 EXPORT_SYMBOL_GPL(siox_master_unregister);
 
+static void devm_siox_master_unregister(void *data)
+{
+	struct siox_master *smaster = data;
+
+	siox_master_unregister(smaster);
+}
+
+int devm_siox_master_register(struct device *dev, struct siox_master *smaster)
+{
+	int ret;
+
+	ret = siox_master_register(smaster);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_siox_master_unregister, smaster);
+}
+EXPORT_SYMBOL_GPL(devm_siox_master_register);
+
 static struct siox_device *siox_device_add(struct siox_master *smaster,
 					   const char *type, size_t inbytes,
 					   size_t outbytes, u8 statustype)
diff --git a/drivers/siox/siox.h b/drivers/siox/siox.h
index b227e18b697a..513f2c8312f7 100644
--- a/drivers/siox/siox.h
+++ b/drivers/siox/siox.h
@@ -49,3 +49,5 @@ struct siox_master *devm_siox_master_alloc(struct device *dev, size_t size);
 
 int siox_master_register(struct siox_master *smaster);
 void siox_master_unregister(struct siox_master *smaster);
+
+int devm_siox_master_register(struct device *dev, struct siox_master *smaster);
-- 
2.43.0


