Return-Path: <linux-kernel+bounces-55037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D3A84B6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E8828833F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A9133292;
	Tue,  6 Feb 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFd525EK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF5132C3E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226854; cv=none; b=aCvUCRWIEs9wEBC33SPuF/0gFa8ss/mlLmy94UAWesQKTyRFr2zEEqxyQCU4Pyn/pjxtxXStQy3KrL3kNaThmZ8d1dmTD971SmCPIqRDL2tH6DzASWzGiC/ZEDOunsDVWCbGwnIAv9ntu/n4U/oUPxL8g+KpOAJMGbqkQeUiS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226854; c=relaxed/simple;
	bh=TowMgeLUGRs1hnMQjk19y8O1hjjTxf8YbaaZY8r8KoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPMjxRo0+wdvSBQesmOvPiZVbCgbTrk35DFqadeDrNVAuW772y0+tddM3Um5IgLCPezDfOm/XN9XRayW1RIqnOlEQZ7YkPn3in+EseehgJyUIREdxYMJii+ztw2xn80muxe7BJngNAhAMG8hA4QUsTQmBvLN2D5dc++5mWlrfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFd525EK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707226852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7AZZPeDLSIQhGpyqdXYj5Wako5b4bPLUCKUFeVUAK8s=;
	b=XFd525EKNU941PY4TR7tWf0fqCh5xH/+RSJCoUnI6btaiRGKfaforjM7am0AYUqYBHuHNT
	2kPIi5Y8hal9KZhvCtuQ24PXaIxgSZfiG/HiG6BEezN4oHpmZP3vK+U4ApeO9RSe7WJXqY
	mTzmckK2v1D0nn0J4k0KnmXQi/0KPPY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-cvgGnh0fONqZ-uptnKCWIw-1; Tue, 06 Feb 2024 08:40:51 -0500
X-MC-Unique: cvgGnh0fONqZ-uptnKCWIw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7853449295cso25887085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226850; x=1707831650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AZZPeDLSIQhGpyqdXYj5Wako5b4bPLUCKUFeVUAK8s=;
        b=AKBKcCobXVN6RUGUzwQrtVikA/sDtaCA1innv5U0H2VjWQlqy/iMjrJdOg/hbi7tna
         OIKBIa51cRNlvkhXylIshauU34qlHNNv3BUT5vlSg2cOQJwro95R32f4gVR58vG9BwTF
         5qezUnZ32VOXyeUzxKMjhfAFvvJmvoZZC5yS5k8QZPf8gp3088EbpLAyQwLbECdAZluK
         Gdni2ha/KwK1PlylPe1cuekdxz4EnXm5mYqA8zabhbxNRqionXrSYqGJCdxpRNg9Wuh6
         1dZ4Fp/KGRmKQ/p44i7Dz7dOM3zkbmx/PEEHHD9ljXWnP1rHHPSXHciTEw248mlwTEJR
         peaA==
X-Gm-Message-State: AOJu0YxpjAVTY8fGT8SbK9JwLrSXiMNJsWJArMR5JC9oxKumX74yRBTR
	FRX1olDk1fWvgOITpTBqbZM2e+Ls1uik+9e+ubhCR2vGybNl4AoueC+KVuhfpEWr+fHaVJ3cZO5
	SuXksmme7OMpiLvd402TBXokG3iiA3KjSbXJRMx8+SgO6HKonmACp/oL9sFB+V2C5nuYq5w==
X-Received: by 2002:a05:620a:4714:b0:785:65bc:6cc1 with SMTP id bs20-20020a05620a471400b0078565bc6cc1mr2808221qkb.5.1707226850503;
        Tue, 06 Feb 2024 05:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGA3J2SmhDbLIkmBgpnKC5JdiwJtMw1ckxnT3hwEWV0axzm5SHplj8KnispOqMd1RbncWsow==
X-Received: by 2002:a05:620a:4714:b0:785:65bc:6cc1 with SMTP id bs20-20020a05620a471400b0078565bc6cc1mr2808193qkb.5.1707226850162;
        Tue, 06 Feb 2024 05:40:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWxKz2AS2kCg26W1YFQSCC6cN1TQFyl00vI8SJusbemv44LJDN294ZNx81ZJTllVzo6lrDYzd9cB9u2oUv/09MqwrPZMkh+cmCIjsyWL/V5LIkRYx150ArqnQekZaEu9Gw4ZKQmIPFG9mFjy2eFjaoHxoZpj9Wqas5mrNDPaAXdH9g0P2JNNqXBvb7aD1Df5LmUywY3BqqckFtKGmHWfGl8JxXokTkpbxqEo2LGQmOidzl6+nkC5S7gyDkomYtorhMcYCQVaRM8RTMnAqh8VFdCPAeK8I/tAPufT5yUwq22SxbR/clnAu17itZMQbSGnNxW4FjnviRCGUWOqd6zxcI/CtVYyCazSInsFGpRzGpoO9yDr58I+rPaTOhNNcGAS2YJojI3
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vu4-20020a05620a560400b0078544c8be9asm903791qkn.87.2024.02.06.05.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:40:48 -0800 (PST)
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
Subject: [PATCH v3 07/10] PCI: Give pcim_set_mwi() its own devres callback
Date: Tue,  6 Feb 2024 14:39:53 +0100
Message-ID: <20240206134000.23561-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206134000.23561-2-pstanner@redhat.com>
References: <20240206134000.23561-2-pstanner@redhat.com>
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
index 628cde665e77..89d2d6341b19 100644
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
index 586b2047c275..eaec3b207908 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -813,7 +813,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.43.0


