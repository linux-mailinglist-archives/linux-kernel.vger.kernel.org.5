Return-Path: <linux-kernel+bounces-88353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD7A86E063
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E671F209AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002326D1A7;
	Fri,  1 Mar 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2VOC9hE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9EA6E607
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292633; cv=none; b=FBcr1FDS+bGE9VIDC8Cab9P1LdSyNU2UmCNsMjagQTfc1pp6zQHsP3unjpInR8DS8eFvB8t6xsE157S/UlH3RFFvgsl0spG9cJzIZWTZze1I+wQ4vi5Zd6AOxZv8pK4YufVlTOkGaRImbTVKPbOHb3ZNXKiGAzkrvVP2TaPxXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292633; c=relaxed/simple;
	bh=TeuRzMDENTP+mrbhGHtQfvvCYg0RN9gxYq3N6G/Xkt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WR4UTOeoiVO/Z+KUgJOLMBAbO4cG31MiwxqigotGVfggKFl4Yna5HyETAHLKO4si9AwQEfVc14TYBpSwjnbha5S/WvvjfZZH1tLLlaXRlTsTB3lOD/tyFTeDo0ceLDBFixEF3KlWb26EC2l3UP48cQ8BSugVpwLFGqa0/nNWLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2VOC9hE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDrBrW1QyBkIZW9XXC7FxnbgE53QwXCFFfi0uuWv0Ls=;
	b=e2VOC9hE8hrsx4DDQYGvLVwYH4m0wlWXWKJWoA+Aq8VvtQO6cPPMqBwCdMzQTP9K+goW6v
	lX7PuuC/QMsENJzN7arf1iDTdyWJhgEvflZfhBsisDo98g24trlh3OtaRbDIzHqZPMDk1q
	Pay60vTwEROUNUJ1awzTwIDYYsKcmHk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-HuSFKZ3MPEemUGLuWjPqYA-1; Fri, 01 Mar 2024 06:30:29 -0500
X-MC-Unique: HuSFKZ3MPEemUGLuWjPqYA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f5e085773so4419526d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292629; x=1709897429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDrBrW1QyBkIZW9XXC7FxnbgE53QwXCFFfi0uuWv0Ls=;
        b=vm4Y+57Iok6yIrzA4bIsxjw3mqKaJtHAnusKN0/OpoeY66Dvmb+EuC1L3KoUrk4DVy
         +CHm/qJ4lXp0k0S2WpIfoIl912uqODfzKJajhxVyuomw/iqEiwfsde8X4lO+FxAmRpVd
         s3RkzzNrI/G028WNpTYKLxrC5FttggwHXpsAZxim405O/2FI4UiHa30VYDa5Efr51VOl
         BQioTjOTmS5wyx4E732uSEpzePhQn22B4j0wOB6I75Z0La2Z1IpQpV0KKMz03GAWjCQN
         aYEojvAJ22/jgEbn7T86X7ul/RI2u+HbwHEs6vYEE/38A91nuHl+EcPxFfVkC+N2Jsig
         NN0A==
X-Forwarded-Encrypted: i=1; AJvYcCUkKYayjV+jnUOgy1fFGJT3CXS/cCBSbNOWlx2WFFz1X7E4w64CQV1imrxCemHVo9JynzE4im1BxHdALibSUWloSHKefedaoCV4Oenj
X-Gm-Message-State: AOJu0YyFdasgT8kk8Q2bYesa28+F5Z1vWDLNvO9ubKhcCJU6s4e5muM3
	Vpw+/SbS/ivvuIR3Rq7h+mdJIKoPo5OnNf10gDlY5Rm0VtYaQzVhD0g4bfuqQj6t6h6bg33W8Dq
	3RedIPrSDT+Du5JfNQR4B4foWx8rgXUwgPZAWUtp/FhXvcGkIDVPFufQXcarDHA==
X-Received: by 2002:ac8:58d0:0:b0:42e:c9b2:5846 with SMTP id u16-20020ac858d0000000b0042ec9b25846mr1388317qta.5.1709292628960;
        Fri, 01 Mar 2024 03:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0USADji0WQ4vStz8axm9yU2LeR4404cTuRyF3UBhbQb+Uq0hGVzuRwtUe65EkPR+o7q1ATQ==
X-Received: by 2002:ac8:58d0:0:b0:42e:c9b2:5846 with SMTP id u16-20020ac858d0000000b0042ec9b25846mr1388291qta.5.1709292628661;
        Fri, 01 Mar 2024 03:30:28 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b1-20020ac86781000000b0042eb46d15bbsm1596239qtp.88.2024.03.01.03.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:30:28 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v4 09/10] PCI: Remove legacy pcim_release()
Date: Fri,  1 Mar 2024 12:29:57 +0100
Message-ID: <20240301112959.21947-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301112959.21947-1-pstanner@redhat.com>
References: <20240301112959.21947-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to preceding cleanup steps, pcim_release() is now not needed
anymore and can be replaced by pcim_disable_device(), which is the exact
counterpart to pcim_enable_device().

This permits removing further parts of the old devres API.

Replace pcim_release() with pcim_disable_device().
Remove the now surplus function get_pci_dr().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 49 +++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 8a643f15140a..3e567773c556 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -463,48 +463,41 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 	return 0;
 }
 
-static void pcim_release(struct device *gendev, void *res)
+static void pcim_disable_device(void *pdev_raw)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-
-	if (!dev->pinned)
-		pci_disable_device(dev);
-}
-
-static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
-{
-	struct pci_devres *dr, *new_dr;
-
-	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	if (dr)
-		return dr;
+	struct pci_dev *pdev = pdev_raw;
 
-	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
-	if (!new_dr)
-		return NULL;
-	return devres_get(&pdev->dev, new_dr, NULL, NULL);
+	if (!pdev->pinned)
+		pci_disable_device(pdev);
 }
 
 /**
  * pcim_enable_device - Managed pci_enable_device()
  * @pdev: PCI device to be initialized
  *
- * Managed pci_enable_device().
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * Managed pci_enable_device(). Device will automatically be disabled on
+ * driver detach.
  */
 int pcim_enable_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-	int rc;
+	int ret;
 
-	dr = get_pci_dr(pdev);
-	if (unlikely(!dr))
-		return -ENOMEM;
+	ret = devm_add_action(&pdev->dev, pcim_disable_device, pdev);
+	if (ret != 0)
+		return ret;
 
-	rc = pci_enable_device(pdev);
-	if (!rc)
-		pdev->is_managed = 1;
+	/*
+	 * We prefer removing the action in case of an error over
+	 * devm_add_action_or_reset() because the later could theoretically be
+	 * disturbed by users having pinned the device too soon.
+	 */
+	ret = pci_enable_device(pdev);
+	if (ret != 0)
+		devm_remove_action(&pdev->dev, pcim_disable_device, pdev);
 
-	return rc;
+	return ret;
 }
 EXPORT_SYMBOL(pcim_enable_device);
 
-- 
2.43.0


