Return-Path: <linux-kernel+bounces-164887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6168B847F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9C11F23CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525629405;
	Wed,  1 May 2024 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQJDmZtw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB81BDC3;
	Wed,  1 May 2024 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714534435; cv=none; b=uAjfo0jzghZrENzzvbXnE+gIoexV+4Csyq3n4BeFlq5XAbw6mFW1zduvUTiuFNSn19Vah8nWE3MIt4HW/e2Qy2mzHQrwXub2r5RxMlfMwXVKxta2tleseTGiEUaNJMyS9OumAyG7WxByklEeC90yvoUf0xF3cOo8lsGgAk21m08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714534435; c=relaxed/simple;
	bh=qabpSfLrHZ8yY23+xfb8YBr/5AsMrlrsYJIMWSZLp3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I/qZNtFRaaDG4i3hlQee3YWszlGOCsxlLb4i6GuHNZkBz4UCLcTW5vkLLWv+20b4aZIIJJ8/VKym3KPjMBiE/vPMBimGJ5NvVgkRN/eQk0hRXmKpBDq5W8UWP62D8XyS7o1eV8mdFV2OG0JosTAQaSfR8XfDmMnTuT+mz4YH8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQJDmZtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDDDC32789;
	Wed,  1 May 2024 03:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714534435;
	bh=qabpSfLrHZ8yY23+xfb8YBr/5AsMrlrsYJIMWSZLp3g=;
	h=From:Date:Subject:To:Cc:From;
	b=kQJDmZtwUEurZt1lZr1IIecBEGFze2KBarzkicFoVPNhBNiTxLu29BII4yeEQJjmt
	 UfF0RajAVmjNR0rMKSsxjhLwYcmR9t4T206eobMo/X8CRkNCtgtoPPyYGetNDZzxC7
	 ZENn79CkCFbMLSbzFlZ1WB9q6ISz/uv3kOP0JB76pj/0AdJyXSNpAQNF8hfdvbtNaN
	 kO+QNYdgT32i9VKBvjsb0uMqbQKcRZIsehwEnuAhDxFRwikVlZRyQra3saAiu2ePNB
	 Zsgf9EWA7UA2pF1A7q6LzGt59SVvsuNYJ/Fqy0LIlLhI+m4QXhCKFprFmKq+85ISDW
	 nBqTqKquzU7+g==
From: Bjorn Andersson <andersson@kernel.org>
Date: Tue, 30 Apr 2024 20:38:57 -0700
Subject: [PATCH] soc: qcom: pmic_glink: Make client-lock non-sleeping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-pmic-glink-sleep-while-atomic-v1-1-88fb493e8545@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFC5MWYC/x3MQQqAIBBA0avErBswtU1XiRaiUw2ZiUYF0d2zl
 o8P/4ZMiSlDV92Q6ODMWyho6grsbMJEyK4YpJBaaCUwrmxx8hwWzJ4o4jmzJzT79gWnldXStsY
 5AeURE418/f9+eJ4XyZOKtW8AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4626;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=5Okqqvc+uPrucYooncyQft1LkqnSxU7//QfoENy5k2Y=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmMblT96FOWK8laYL689pXrhn8i7xVexRY/hmKe
 Vp6CDEotiuJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZjG5UxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUu0A//SY7PHvz0FY4C99ikvtRsAnSJ5DHgd4TPcMBKqbY
 X6BIQeCmLFN8/GD6gFkYBI1kV37wor+7SoDTJWb+c1zfRx3tUZ1o5xcLf2ArSgs6qVaD2/6TSvz
 Tx8eugUDuK90MEwCwEkroryXuA5aPbj3cxV6QJVm4ooZXrAzINPajD9MB9T7T8Rga+NreCIYUFA
 8bmIP1+cHRv8Ism32nGynoiS4FH920Ud6AUciw7lQi2CsPqM8Snm3nObmNDw+L6wJvjtb7wWu/k
 F+Ilcxd2v1Wn6WOR0hQkYETTI3b+0x9hWEJSZlPygcGhFBPWb++W6HQhIC+qs2rMgyOlhl6yIWy
 SH+GQBmV9VmMmmMW1yQOyL8++eVjGiPrZwgT2gNkRcxcClINOlFMeUJcrRaZNwmd+FY03MUyl5H
 JM8r7DlR0XEB4HaXY5PZx7QjNP1no4j3ztN3YiYbBmolRwrBNrO5PZ14dfsfQnB5E5oTkXJ4Jkz
 pI4ErWkXK1JEuP7rpquKaPyEEPAelqoSuxiFri4/T9Z2YXM286jQVikHrerosyMSpbPn2+AqOYR
 xMFIBEKgVFdXU3DsNH/ylRoQ72MLv55dOOPisyajR1jjaeDQjn8pqq1WtMyVfu1P+hg9vITRbPG
 K1GbeF/mkl4s0eVu7suz5MXJioyiISxs1FT+89FxiHHw=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

From: Bjorn Andersson <quic_bjorande@quicinc.com>

The recently introduced commit '635ce0db8956 ("soc: qcom: pmic_glink:
don't traverse clients list without a lock")' ensured that the clients
list is not modified while traversed.

But the callback is made from the GLINK IRQ handler and as such this
mutual exclusion can not be provided by a (sleepable) mutex.

Replace the mutex with a spinlock.

Fixes: 635ce0db8956 ("soc: qcom: pmic_glink: don't traverse clients list without a lock")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/pmic_glink.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 9bdbd8944c4e..40fb09d69014 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/pdr.h>
 #include <linux/soc/qcom/pmic_glink.h>
+#include <linux/spinlock.h>
 
 enum {
 	PMIC_GLINK_CLIENT_BATT = 0,
@@ -36,7 +37,7 @@ struct pmic_glink {
 	unsigned int pdr_state;
 
 	/* serializing clients list updates */
-	struct mutex client_lock;
+	spinlock_t client_lock;
 	struct list_head clients;
 };
 
@@ -58,10 +59,11 @@ static void _devm_pmic_glink_release_client(struct device *dev, void *res)
 {
 	struct pmic_glink_client *client = (struct pmic_glink_client *)res;
 	struct pmic_glink *pg = client->pg;
+	unsigned long flags;
 
-	mutex_lock(&pg->client_lock);
+	spin_lock_irqsave(&pg->client_lock, flags);
 	list_del(&client->node);
-	mutex_unlock(&pg->client_lock);
+	spin_unlock_irqrestore(&pg->client_lock, flags);
 }
 
 struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
@@ -72,6 +74,7 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
 {
 	struct pmic_glink_client *client;
 	struct pmic_glink *pg = dev_get_drvdata(dev->parent);
+	unsigned long flags;
 
 	client = devres_alloc(_devm_pmic_glink_release_client, sizeof(*client), GFP_KERNEL);
 	if (!client)
@@ -84,12 +87,12 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
 	client->priv = priv;
 
 	mutex_lock(&pg->state_lock);
-	mutex_lock(&pg->client_lock);
+	spin_lock_irqsave(&pg->client_lock, flags);
 
 	list_add(&client->node, &pg->clients);
 	client->pdr_notify(client->priv, pg->client_state);
 
-	mutex_unlock(&pg->client_lock);
+	spin_unlock_irqrestore(&pg->client_lock, flags);
 	mutex_unlock(&pg->state_lock);
 
 	devres_add(dev, client);
@@ -112,6 +115,7 @@ static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	struct pmic_glink_client *client;
 	struct pmic_glink_hdr *hdr;
 	struct pmic_glink *pg = dev_get_drvdata(&rpdev->dev);
+	unsigned long flags;
 
 	if (len < sizeof(*hdr)) {
 		dev_warn(pg->dev, "ignoring truncated message\n");
@@ -120,12 +124,12 @@ static int pmic_glink_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 
 	hdr = data;
 
-	mutex_lock(&pg->client_lock);
+	spin_lock_irqsave(&pg->client_lock, flags);
 	list_for_each_entry(client, &pg->clients, node) {
 		if (client->id == le32_to_cpu(hdr->owner))
 			client->cb(data, len, client->priv);
 	}
-	mutex_unlock(&pg->client_lock);
+	spin_unlock_irqrestore(&pg->client_lock, flags);
 
 	return 0;
 }
@@ -165,6 +169,7 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 {
 	struct pmic_glink_client *client;
 	unsigned int new_state = pg->client_state;
+	unsigned long flags;
 
 	if (pg->client_state != SERVREG_SERVICE_STATE_UP) {
 		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
@@ -175,10 +180,10 @@ static void pmic_glink_state_notify_clients(struct pmic_glink *pg)
 	}
 
 	if (new_state != pg->client_state) {
-		mutex_lock(&pg->client_lock);
+		spin_lock_irqsave(&pg->client_lock, flags);
 		list_for_each_entry(client, &pg->clients, node)
 			client->pdr_notify(client->priv, new_state);
-		mutex_unlock(&pg->client_lock);
+		spin_unlock_irqrestore(&pg->client_lock, flags);
 		pg->client_state = new_state;
 	}
 }
@@ -265,7 +270,7 @@ static int pmic_glink_probe(struct platform_device *pdev)
 	pg->dev = &pdev->dev;
 
 	INIT_LIST_HEAD(&pg->clients);
-	mutex_init(&pg->client_lock);
+	spin_lock_init(&pg->client_lock);
 	mutex_init(&pg->state_lock);
 
 	match_data = (unsigned long *)of_device_get_match_data(&pdev->dev);

---
base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
change-id: 20240430-pmic-glink-sleep-while-atomic-d43c42c5add0

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


