Return-Path: <linux-kernel+bounces-87536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A7A86D5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A0728D97A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7315145656;
	Thu, 29 Feb 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xxy4KQYy"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBE144044
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240165; cv=none; b=rBONfnTVDwn/UB1OSnBO1gXKPSNDT0daHH0aPusTA7Qazra/7O7Iyie6U8AFmUra8Kc1GCx8G0iXRhuhbolxNCzJ9sC/5Mdu2FWMp43kW7LnG2RQ3p03jXWbNzI2z2YIjk2AG7XN6Yz9o30YgA5YFSrtALOskisp6Ejeob1OFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240165; c=relaxed/simple;
	bh=FDSlKNUB8yAuzsdtIKb1kKDg1IzUCFaxWW4Ug8df6gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZqBwQZxbSwwNcMZh6ZMIDYha1U35rap59LXvtW0lLOTHECV3d6J3wXOAv+nIETc14K12BCSXn94U5IrMPd2OKvNOB1Ag5gWQlHCl3Jr+ndpxczJT4nxRi+G6hYuAK1y6Ulv3bArWo039muv5+d+06EUn0dSpdiDVrSoajwq+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xxy4KQYy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3657dbe2008so6784145ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709240162; x=1709844962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFAkZ9ZdIx7DYJ4QiNOc9lo+FzdYYDRog98IZKbIYpw=;
        b=Xxy4KQYyEODV2aMjoc4wxsIdFRiMne6eVTIyCqq3WKDsTTokDQbkOr+yQePS87Z9v2
         nAbBCTPBBnTVLiDL+Lfbef4pMgx9hJ4v8KBu20f8DZkq8Ng9MvV9/Q2Q81WMJRVfS/bp
         JHtdBwAGoX+3PJQvWOhpeBurYUGVk81MNyR/pQoIeaUdC/f9T09Reqn5xmhbr2pR3d55
         ubke961Aw0nVh0sWYyWITmqLrQKxcE8yyjMlBoOFfuyWrCITAyPA1Q8c7Pi9KQGO+P2g
         ehPScjCy4riHiPRu64gfzoH+BKbgnxRy2RTITWazFMdJftM7x9HnKpVgVZOkMZND0Sy0
         lKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240162; x=1709844962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFAkZ9ZdIx7DYJ4QiNOc9lo+FzdYYDRog98IZKbIYpw=;
        b=gALaY/8XduOKZE0WJSSxmfro5jyd0GvbXo7NZ7jTM40zsJJOVaNnNKCmCz90C+0JgC
         g6BgtMiOcxPKiqe/rvgvHrKiunEOHtIKnWlKGoehT1Mdm0WIo/4xRrxLt2IspQcP3LWS
         VP3fujLFf6oIC7werc7ED7D80vCZ5Eq5fRWRdsNmuyxm7OU04Dh52UoJUx7lwsLOxRIX
         QZk4FQQaxIm82kvicsVD+ttJJN/PlcTRuQv3BktG1uMBQxCmEN25MW50a366igNRxLV3
         LDTBpeqmWF/aTtqTPeJqnhZ68oM1l4NvTEQe9cKDS934B3kAhHuTvDcYQiyT35pGEzZm
         QMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgHkHTWAAEITyK6MsrprHgfys/Lt7E6IIOr7Dz/v/Tgr+nuug5qGWeh+E5BBzG4N/k+EqfmjbfkQkbgwkNgmyuZlRMH8IpKguGn5Zv
X-Gm-Message-State: AOJu0YyVR87rnDmEe/Nsu9/5yEe8X7ipQ0NaojH7S8BOUS54OCg0xNkT
	6O8LwgpOYc6zaGMPu7hctGjDT8IdO8fOo1sqNH2qzq3gx9r4HcDVua15I/IF66I=
X-Google-Smtp-Source: AGHT+IEKKxW/LV+o0zAsVvesg0GcPXgpiUqdeuj3zxgMS7BJbamqwjIinASTSCOBzwuam5Dt8/Fjtg==
X-Received: by 2002:a05:6e02:2148:b0:365:c748:57cf with SMTP id d8-20020a056e02214800b00365c74857cfmr247482ilv.13.1709240162366;
        Thu, 29 Feb 2024 12:56:02 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id h14-20020a056e020d4e00b003658fbcf55dsm521551ilj.72.2024.02.29.12.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:56:01 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: ipa: introduce ipa_interrupt_init()
Date: Thu, 29 Feb 2024 14:55:49 -0600
Message-Id: <20240229205554.86762-3-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240229205554.86762-1-elder@linaro.org>
References: <20240229205554.86762-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new function ipa_interrupt_init() that is called at probe
time to allocate and initialize the IPA interrupt data structure.
Create ipa_interrupt_exit() as its inverse.

This follows the normal IPA driver pattern of *_init() functions
doing things that can be done before access to hardware is required.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 50 +++++++++++++++++++++------------
 drivers/net/ipa/ipa_interrupt.h | 14 +++++++++
 drivers/net/ipa/ipa_main.c      | 28 ++++++++++++++----
 3 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index a298d922dd871..26e84a5c30bff 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -19,6 +19,7 @@
  * time only these three are supported.
  */
 
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
@@ -238,29 +239,15 @@ void ipa_interrupt_simulate_suspend(struct ipa_interrupt *interrupt)
 /* Configure the IPA interrupt framework */
 int ipa_interrupt_config(struct ipa *ipa)
 {
+	struct ipa_interrupt *interrupt = ipa->interrupt;
 	struct device *dev = &ipa->pdev->dev;
-	struct ipa_interrupt *interrupt;
+	unsigned int irq = interrupt->irq;
 	const struct reg *reg;
-	unsigned int irq;
 	int ret;
 
-	ret = platform_get_irq_byname(ipa->pdev, "ipa");
-	if (ret <= 0) {
-		dev_err(dev, "DT error %d getting \"ipa\" IRQ property\n",
-			ret);
-		return ERR_PTR(ret ? : -EINVAL);
-	}
-	irq = ret;
-
-	interrupt = kzalloc(sizeof(*interrupt), GFP_KERNEL);
-	if (!interrupt)
-		return -ENOMEM;
 	interrupt->ipa = ipa;
-	interrupt->irq = irq;
 
-	ipa->interrupt = interrupt;
-
-	/* Start with all IPA interrupts disabled */
+	/* Disable all IPA interrupt types */
 	reg = ipa_reg(ipa, IPA_IRQ_EN);
 	iowrite32(0, ipa->reg_virt + reg_offset(reg));
 
@@ -277,7 +264,7 @@ int ipa_interrupt_config(struct ipa *ipa)
 		goto err_free_irq;
 	}
 
-	return interrupt;
+	return 0;
 
 err_free_irq:
 	free_irq(interrupt->irq, interrupt);
@@ -297,5 +284,32 @@ void ipa_interrupt_deconfig(struct ipa *ipa)
 
 	dev_pm_clear_wake_irq(dev);
 	free_irq(interrupt->irq, interrupt);
+}
+
+/* Initialize the IPA interrupt structure */
+struct ipa_interrupt *ipa_interrupt_init(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ipa_interrupt *interrupt;
+	int irq;
+
+	irq = platform_get_irq_byname(pdev, "ipa");
+	if (irq <= 0) {
+		dev_err(dev, "DT error %d getting \"ipa\" IRQ property\n", irq);
+
+		return ERR_PTR(irq ? : -EINVAL);
+	}
+
+	interrupt = kzalloc(sizeof(*interrupt), GFP_KERNEL);
+	if (!interrupt)
+		return ERR_PTR(-ENOMEM);
+	interrupt->irq = irq;
+
+	return interrupt;
+}
+
+/* Inverse of ipa_interrupt_init() */
+void ipa_interrupt_exit(struct ipa_interrupt *interrupt)
+{
 	kfree(interrupt);
 }
diff --git a/drivers/net/ipa/ipa_interrupt.h b/drivers/net/ipa/ipa_interrupt.h
index 1947654e3e360..f3f4f4330a597 100644
--- a/drivers/net/ipa/ipa_interrupt.h
+++ b/drivers/net/ipa/ipa_interrupt.h
@@ -89,4 +89,18 @@ int ipa_interrupt_config(struct ipa *ipa);
  */
 void ipa_interrupt_deconfig(struct ipa *ipa);
 
+/**
+ * ipa_interrupt_init() - Initialize the IPA interrupt structure
+ * @pdev:	IPA platform device pointer
+ *
+ * Return:	Pointer to an IPA interrupt structure, or a pointer-coded error
+ */
+struct ipa_interrupt *ipa_interrupt_init(struct platform_device *pdev);
+
+/**
+ * ipa_interrupt_exit() - Inverse of ipa_interrupt_init()
+ * @interrupt:	IPA interrupt structure
+ */
+void ipa_interrupt_exit(struct ipa_interrupt *interrupt);
+
 #endif /* _IPA_INTERRUPT_H_ */
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 0c6e6719d99e3..6cf5c1280aa4e 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -803,6 +803,7 @@ static enum ipa_firmware_loader ipa_firmware_loader(struct device *dev)
 static int ipa_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct ipa_interrupt *interrupt;
 	enum ipa_firmware_loader loader;
 	const struct ipa_data *data;
 	struct ipa_power *power;
@@ -834,12 +835,21 @@ static int ipa_probe(struct platform_device *pdev)
 	if (loader == IPA_LOADER_DEFER)
 		return -EPROBE_DEFER;
 
-	/* The clock and interconnects might not be ready when we're
-	 * probed, so might return -EPROBE_DEFER.
+	/* The IPA interrupt might not be ready when we're probed, so this
+	 * might return -EPROBE_DEFER.
+	 */
+	interrupt = ipa_interrupt_init(pdev);
+	if (IS_ERR(interrupt))
+		return PTR_ERR(interrupt);
+
+	/* The clock and interconnects might not be ready when we're probed,
+	 * so this might return -EPROBE_DEFER.
 	 */
 	power = ipa_power_init(dev, data->power_data);
-	if (IS_ERR(power))
-		return PTR_ERR(power);
+	if (IS_ERR(power)) {
+		ret = PTR_ERR(power);
+		goto err_interrupt_exit;
+	}
 
 	/* No more EPROBE_DEFER.  Allocate and initialize the IPA structure */
 	ipa = kzalloc(sizeof(*ipa), GFP_KERNEL);
@@ -850,6 +860,7 @@ static int ipa_probe(struct platform_device *pdev)
 
 	ipa->pdev = pdev;
 	dev_set_drvdata(dev, ipa);
+	ipa->interrupt = interrupt;
 	ipa->power = power;
 	ipa->version = data->version;
 	ipa->modem_route_count = data->modem_route_count;
@@ -934,6 +945,8 @@ static int ipa_probe(struct platform_device *pdev)
 	kfree(ipa);
 err_power_exit:
 	ipa_power_exit(power);
+err_interrupt_exit:
+	ipa_interrupt_exit(interrupt);
 
 	return ret;
 }
@@ -941,10 +954,14 @@ static int ipa_probe(struct platform_device *pdev)
 static void ipa_remove(struct platform_device *pdev)
 {
 	struct ipa *ipa = dev_get_drvdata(&pdev->dev);
-	struct ipa_power *power = ipa->power;
 	struct device *dev = &pdev->dev;
+	struct ipa_interrupt *interrupt;
+	struct ipa_power *power;
 	int ret;
 
+	power = ipa->power;
+	interrupt = ipa->interrupt;
+
 	/* Prevent the modem from triggering a call to ipa_setup().  This
 	 * also ensures a modem-initiated setup that's underway completes.
 	 */
@@ -986,6 +1003,7 @@ static void ipa_remove(struct platform_device *pdev)
 	ipa_reg_exit(ipa);
 	kfree(ipa);
 	ipa_power_exit(power);
+	ipa_interrupt_exit(interrupt);
 
 	dev_info(dev, "IPA driver removed");
 }
-- 
2.40.1


