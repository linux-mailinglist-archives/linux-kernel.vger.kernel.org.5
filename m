Return-Path: <linux-kernel+bounces-157382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375048B10DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2107CB29A05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BA16D4D5;
	Wed, 24 Apr 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="iaanVBV+"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCE16D31D;
	Wed, 24 Apr 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979321; cv=none; b=bM0FVJVfEictH0rw4FDotZfATpwljdeANu/XnoU/MuzO0sCqVOvilZ1Le8uT0blk51Qd/QEvTe7XMSvNC6/6iou7rORVBFC1S57wgSXgVFSBjAjw6Pc5OXUIQZ673Mve+Q7I2BXzPdjfW1A4JVKAGZ3fFwvFKR2cvn+P1BEISfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979321; c=relaxed/simple;
	bh=zLif1hX+czKPUsRcvswLouOVPMD7tHxaoC1HIRsJvRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVtwp4z6yM7qi4i/9pVSC9hJ9spt649Np6tbVawcwdk1j/n00v/qvtTVgCqwb8q/PEVr6gR+w1unr/LFHuPJPpAj571lwYkZskXJCcVSwb9mqbKA2s6zNdXBNy74ovzMwK1zIhl52zLnl8GLG0OkjDTKtpjnQDcdpDtjqEnouXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=iaanVBV+; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713979318; bh=zLif1hX+czKPUsRcvswLouOVPMD7tHxaoC1HIRsJvRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iaanVBV+Hg8q6YRbW74muLfCWBcKwNbSzwso3Z/bEe7lu/axBnbhHz5Nams94CDY0
	 1FKDwwmdDGhOLrldsb+I+6x5iiNVgTUC0G/k3KRIt7RZjR8XtIDO/R3OxtY9QDulY9
	 pfWd2rFR1f6yfLhM5gWVQFDpW1zWonsIuY24bW+o=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 19:21:52 +0200
Subject: [PATCH RFC 2/2] soc: qcom: smsm: Support using mailbox interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-smsm-mbox-v1-2-555f3f442841@z3ntu.xyz>
References: <20240424-smsm-mbox-v1-0-555f3f442841@z3ntu.xyz>
In-Reply-To: <20240424-smsm-mbox-v1-0-555f3f442841@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4176; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=zLif1hX+czKPUsRcvswLouOVPMD7tHxaoC1HIRsJvRw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKT+zg1nPeyPSTrXlYPNyJmTNYWLF0xdzkg49J
 EC0OazPK2iJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZik/swAKCRBy2EO4nU3X
 VsUCD/0XM+HSyWSyGrsarpzG2hemXVWx1S1JV4MiT5qTm278IAmgbmGD0cfACZwJTpBK5NQBd4j
 R0CXOsgdasq+4BkBenaNpdXb+m+ALepMER8D5gCJktt9IbCno7K+FwSZZIeBwu/7p4bolQXcMlK
 EnWwUg4wvAUh6GTRwRw+jfqU41EyDhanj3b/hVJ35SBf3f0AUAPCCz+gb/zV78nBlyofpTKCKTB
 XiVBRRwavaX/rwn0YlPtXcgQsB7FOskSoEEt8zjpM89jJULXBvUOnEytenKVr/7Nn27NbG/M9WG
 rCsZRo6eZ15afHVCcfok5IhhNf2v0dEUx3sLhIZesISKmpblNbpH/UZd/jr1Bzz3H0kcl9ZhOFk
 oAiiFz33kE8rjRySOPxwqsyfA3XOl2cdQjgI9si3aE2gVCp6GkhjANVWDlu/5/kDAEVyPNL7pbN
 MqrrMKzroLwl3M5YNaI5HaM5TkVFflq3OaiDQdpSOrtud4rO9ithmOotkj/1n3NHE4TbflBkx5t
 QMdZZ4Yd0vtiQcBHghcHLJfKzwiaLlOjFP/NjcjsUlcokIXBynI4kzQQ2cTGaStskvgLpwnjhqL
 A+TzQWMPrPHOWPKvxt1mDhxUi/W5/qcKl/JAXZKPIiQjeaLcRciFxZgnjZF+lAwUH34dp0+KhTa
 cW+SOSOYWdGHsyQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add support for using the mbox interface instead of manually writing to
the syscon. With this change the driver will attempt to get the mailbox
first, and if that fails it will fall back to the existing way of using
qcom,ipc-* properties and converting to syscon.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/smsm.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index e7c7e9a640a6..ffe78ae34386 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/mailbox_client.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
@@ -71,6 +72,7 @@ struct smsm_host;
  * @lock:	spinlock for read-modify-write of the outgoing state
  * @entries:	context for each of the entries
  * @hosts:	context for each of the hosts
+ * @mbox_client: mailbox client handle
  */
 struct qcom_smsm {
 	struct device *dev;
@@ -88,6 +90,8 @@ struct qcom_smsm {
 
 	struct smsm_entry *entries;
 	struct smsm_host *hosts;
+
+	struct mbox_client mbox_client;
 };
 
 /**
@@ -120,11 +124,14 @@ struct smsm_entry {
  * @ipc_regmap:	regmap for outgoing interrupt
  * @ipc_offset:	offset in @ipc_regmap for outgoing interrupt
  * @ipc_bit:	bit in @ipc_regmap + @ipc_offset for outgoing interrupt
+ * @mbox_chan:	apcs ipc mailbox channel handle
  */
 struct smsm_host {
 	struct regmap *ipc_regmap;
 	int ipc_offset;
 	int ipc_bit;
+
+	struct mbox_chan *mbox_chan;
 };
 
 /**
@@ -172,7 +179,13 @@ static int smsm_update_bits(void *data, u32 mask, u32 value)
 		hostp = &smsm->hosts[host];
 
 		val = readl(smsm->subscription + host);
-		if (val & changes && hostp->ipc_regmap) {
+		if (!(val & changes))
+			continue;
+
+		if (hostp->mbox_chan) {
+			mbox_send_message(hostp->mbox_chan, NULL);
+			mbox_client_txdone(hostp->mbox_chan, 0);
+		} else if (hostp->ipc_regmap) {
 			regmap_write(hostp->ipc_regmap,
 				     hostp->ipc_offset,
 				     BIT(hostp->ipc_bit));
@@ -352,6 +365,28 @@ static const struct irq_domain_ops smsm_irq_ops = {
 	.xlate = irq_domain_xlate_twocell,
 };
 
+/**
+ * smsm_parse_mbox() - requests an mbox channel
+ * @smsm:	smsm driver context
+ * @host_id:	index of the remote host to be resolved
+ *
+ * Requests the desired channel using the mbox interface which is needed for
+ * sending the outgoing interrupts to a remove hosts - identified by @host_id.
+ */
+static int smsm_parse_mbox(struct qcom_smsm *smsm, unsigned int host_id)
+{
+	struct smsm_host *host = &smsm->hosts[host_id];
+	int ret = 0;
+
+	host->mbox_chan = mbox_request_channel(&smsm->mbox_client, host_id);
+	if (IS_ERR(host->mbox_chan)) {
+		ret = PTR_ERR(host->mbox_chan);
+		host->mbox_chan = NULL;
+	}
+
+	return ret;
+}
+
 /**
  * smsm_parse_ipc() - parses a qcom,ipc-%d device tree property
  * @smsm:	smsm driver context
@@ -521,8 +556,16 @@ static int qcom_smsm_probe(struct platform_device *pdev)
 			     "qcom,local-host",
 			     &smsm->local_host);
 
+	smsm->mbox_client.dev = &pdev->dev;
+	smsm->mbox_client.knows_txdone = true;
+
 	/* Parse the host properties */
 	for (id = 0; id < smsm->num_hosts; id++) {
+		/* Try using mbox interface first, otherwise fall back to syscon */
+		ret = smsm_parse_mbox(smsm, id);
+		if (!ret)
+			continue;
+
 		ret = smsm_parse_ipc(smsm, id);
 		if (ret < 0)
 			goto out_put;
@@ -609,6 +652,9 @@ static int qcom_smsm_probe(struct platform_device *pdev)
 
 	qcom_smem_state_unregister(smsm->state);
 out_put:
+	for (id = 0; id < smsm->num_hosts; id++)
+		mbox_free_channel(smsm->hosts[id].mbox_chan);
+
 	of_node_put(local_node);
 	return ret;
 }
@@ -622,6 +668,9 @@ static void qcom_smsm_remove(struct platform_device *pdev)
 		if (smsm->entries[id].domain)
 			irq_domain_remove(smsm->entries[id].domain);
 
+	for (id = 0; id < smsm->num_hosts; id++)
+		mbox_free_channel(smsm->hosts[id].mbox_chan);
+
 	qcom_smem_state_unregister(smsm->state);
 }
 

-- 
2.44.0


