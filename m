Return-Path: <linux-kernel+bounces-129274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A449089681F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E96B27E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99FE13698F;
	Wed,  3 Apr 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK9iS950"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB3135A63
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131659; cv=none; b=OoAcRdUPmlQ3PxU58w9vFkdPbIvDFZvz8NgCBfvZ0nxJ4dBiNjHnWYI3lYw2NgzYrcpJxKgpGu2EmGi2v1qOm0wS7/y/bt+eUkum4m+XXV8AATSuo+r+je0IYfn97RM2G34ZWlRwPh9Koawj/tylDExe/o9C2i/8Zu87MrnzIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131659; c=relaxed/simple;
	bh=wdifhxcYVgvFvkwDimJfk1VsoeCbE293Al3KAyg7D2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtTQpS0DI7+xgnHwp5YutrHGZlT0UhgqOfq+RPn30gjSMp20X8U6IySk7OcrdcT+sibn1EixG9hiC+l79jbSabt8bZqtfi+a/qhOPuTyFUeG+Xy1CU9eRpOKmVGj2qpUtHw/NCCCDr+E6ecbVlcOkwdxi1wWOM96GONdwe3fREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bK9iS950; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712131657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cue9RiOq2u8xaSRa3oZ0BA3tVb1Vqx6Ro2Uj9/y6Eog=;
	b=bK9iS950qgdKBXebQ7PXb5d55G8W8IM/692JxzuLR8C6OivlTXlOA1CcXCiPt4ZPmLaVTF
	0S77aZFHSBI7jal01RMSEKVRmo+T9JKiggab+h93Pdn1Z2IeT/I39+oc3QVJWImxM5srFG
	XmLC/Rls0TGcsDfwUr75pyVdgwLMCvk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-RebRS4aSPm-ic_8Dpz029A-1; Wed, 03 Apr 2024 04:07:35 -0400
X-MC-Unique: RebRS4aSPm-ic_8Dpz029A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-516b89a9304so137713e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131654; x=1712736454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cue9RiOq2u8xaSRa3oZ0BA3tVb1Vqx6Ro2Uj9/y6Eog=;
        b=NADMVqVzLUogt6dlN2aAM5MtN688sjp5q0zIcQlfEdOr5ze+QPOcB0JKe1Y1LH2UTJ
         XqDQoo/84F+YqLDfjX4b8smk4MTS+BsdQMB2bpgqkS+JU6mPYb4hcvMuwA010IwywTUZ
         6YGdHF9ddMvwJ99yLbGqg5g18AQ05j/SS8Yg3jBJSKRyn/OejSKonUpadsocIZ/zs1Gx
         TKSgqGoOdZgS4peZ1LIDAaeMf8P43RUE8sr8dN8iKEqmK0dXD7svJbawjxaYrACjDVX2
         XPWqkUjXkEUpETCzgeLd1ixP86+kZfh/y8g2y2H3JjM4hOFEGsCiHNyy6yDMUtF05ZyJ
         thhw==
X-Forwarded-Encrypted: i=1; AJvYcCUMg6HxUuXbZoROC10im4nDnFLSspqXKBm0UvakVszOHOoR+xR5xWrWGxo+QZcTQ+kVY8NX4/x/jHWp0ht6i5LA9u+vWxrMSoSfeqUk
X-Gm-Message-State: AOJu0YyNk0uNFRe4kn4+BE32HmeziCuCZp6DN4ikU6rO0bt26w1RKVT2
	E4Ob0ivFQo12a3S51fEli0HImRTZtjnXBJ/mi9tD9S/VZsPao1ywl9GI6T/IblE7/jJeUcp5x51
	0ACNNvzPmn04eoPEuugjUtWRolklokNTeNJKVDe+7Z5uBki2rvP3mE04prRhWNw==
X-Received: by 2002:a19:6408:0:b0:513:ec32:aa89 with SMTP id y8-20020a196408000000b00513ec32aa89mr9634496lfb.2.1712131654436;
        Wed, 03 Apr 2024 01:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZr6Moc6yeNkVktye+4f5uvCTSx03uQs8gFxj+LYLLOGMp3Q773YJIcp1E3B3wobP5BG7d+g==
X-Received: by 2002:a19:6408:0:b0:513:ec32:aa89 with SMTP id y8-20020a196408000000b00513ec32aa89mr9634474lfb.2.1712131654077;
        Wed, 03 Apr 2024 01:07:34 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b004159df274d5sm5504535wmb.6.2024.04.03.01.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:07:33 -0700 (PDT)
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
Subject: [PATCH v5 07/10] PCI: Give pcim_set_mwi() its own devres callback
Date: Wed,  3 Apr 2024 10:07:08 +0200
Message-ID: <20240403080712.13986-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403080712.13986-2-pstanner@redhat.com>
References: <20240403080712.13986-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Managing pci_set_mwi() with devres can easily be done with its own
callback, without the necessity to store any state about it in a
device-related struct.

Remove the MWI state from struct pci_devres.
Give pcim_set_mwi() a separate devres-callback.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 29 ++++++++++++++++++-----------
 drivers/pci/pci.h    |  1 -
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 076362740791..e417bd3ea96f 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -370,24 +370,34 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
 }
 EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
 
+static void __pcim_clear_mwi(void *pdev_raw)
+{
+	struct pci_dev *pdev = pdev_raw;
+
+	pci_clear_mwi(pdev);
+}
+
 /**
  * pcim_set_mwi - a device-managed pci_set_mwi()
- * @dev: the PCI device for which MWI is enabled
+ * @pdev: the PCI device for which MWI is enabled
  *
  * Managed pci_set_mwi().
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int pcim_set_mwi(struct pci_dev *dev)
+int pcim_set_mwi(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
+	int ret;
 
-	dr = find_pci_dr(dev);
-	if (!dr)
-		return -ENOMEM;
+	ret = devm_add_action(&pdev->dev, __pcim_clear_mwi, pdev);
+	if (ret != 0)
+		return ret;
+
+	ret = pci_set_mwi(pdev);
+	if (ret != 0)
+		devm_remove_action(&pdev->dev, __pcim_clear_mwi, pdev);
 
-	dr->mwi = 1;
-	return pci_set_mwi(dev);
+	return ret;
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
@@ -397,9 +407,6 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
 
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a080efd69e85..c98de280b16e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -825,7 +825,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.44.0


