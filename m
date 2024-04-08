Return-Path: <linux-kernel+bounces-135069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FB89BAA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3507B226A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ED94F1E4;
	Mon,  8 Apr 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2RTvCl0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C484EB37
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565893; cv=none; b=XMBcxDOaqFwMjGQdqVINXrw70LNVmGIwuOlXO/aUAMb/Nex3nvaHFuyeczoT2wd4ev3m63pa5Wu2DFYWUM3xDE3gWKVW1CHeSwZtMr6o/w/ds2bvNQcFmBmTVdrKF7uYMyS849pMtguIKKz3S1UxbaCuE5s+n79U+RdoymD7tQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565893; c=relaxed/simple;
	bh=OSX8DiwC7JJUNzRzeW1OOkPWOeyv5OusvgjKcUnS2qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqmZXXi2hJxX/xPBE7aa72JNcUnBZHhq0MSAzY94rpTLUDEyfQvFtHwspb49yqzqCvdvqpdDo71k/JohNh4FhRL91i0zXD0PzuaMcggJK33u5zhjEIi9JJRNYBWwtaBhuNtG8OQDAZT+57QJaRV5lI8C1QShWe1WokWsA/4N0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2RTvCl0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIKnJtHF26OJHg4kpBO8DHHyo5/AIkRLYVzYG0l0EPg=;
	b=N2RTvCl0J5pkTGWgL3b/l4hLCUglXX7rVrBSQ2iewN6FlrwBpBAyk2tHGJI6RTgzjVEiWl
	/CFg1+qwfK1/UiuaXoApinYLueHYdL9hGh7ASZuAdL3tR8HZvvTfjhqTCInL2suX9cCBni
	Szaotzx1RbCKteGMyS3ByW2YL2mTjPA=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-tDCC8OtAN9Wgi1xx-3LxEA-1; Mon, 08 Apr 2024 04:44:49 -0400
X-MC-Unique: tDCC8OtAN9Wgi1xx-3LxEA-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-479e1141539so22154137.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565888; x=1713170688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIKnJtHF26OJHg4kpBO8DHHyo5/AIkRLYVzYG0l0EPg=;
        b=PkdS0X7HNBhQtWOg6s7VnLQ23htkKQ6oBwviAfdnujekSjIVwL8LVogMUX+QL9ErIk
         qDvfW2Jhz4miwCiexGT26cu2+hzn4UAxv8tSvm1kQRqnDE2TlPSbmGiwveK+BgkykWtk
         En6z/X94+5/IDC/HfA8En9DOdQzYJ2Cy1qCx6vFbNXuCc7ddPALVByC1yKZ2E1dWzaNi
         NbU098irp11sgv6rQDU0dhSuOE29YauivI5Pqf0OFurF8qAbXwjFTlWjevN30DtLDbPt
         LWM5zvH8Obd1bd8srHdn1uZWjYAcKQRNa3S+150vF+f8ndtGFB4CiU8/qygVkKRtn28a
         iuZA==
X-Forwarded-Encrypted: i=1; AJvYcCW99O5W618hS0Riggz8fJV1YT45vZFBYkswFINnTT1B24zEtTPoBfZ9YQpBRZ4TFcZnUX54PbGZ/yS7Qo2rhEEFY0I0by/3nwrqEpom
X-Gm-Message-State: AOJu0YwaVvhdo+WjkTNiGZRM9Cay2AUiwT1rVH8GGbrFgmwNVBbDFzBI
	lpH5Z1qfSXkYkCII0xsVRYnalfHHxdK3iW7ax9zzKPVWJ7jsLPebHdVgCCKHN7AgR36A0oD0kj4
	SclqpxyygUx9kxDHiB2/qRhcXRi2iNv2XtcmE/kILJYPX4+A1pgaCj4PaQHdPuw==
X-Received: by 2002:a67:f610:0:b0:479:dedd:565f with SMTP id k16-20020a67f610000000b00479dedd565fmr4684466vso.2.1712565888598;
        Mon, 08 Apr 2024 01:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL+VVRQtoyNoPL7BOIfq0nBVbWMHsJxHqXPuBD7jjNvaEZvxqdDMSuVChpXM2urhBCQM1pWA==
X-Received: by 2002:a67:f610:0:b0:479:dedd:565f with SMTP id k16-20020a67f610000000b00479dedd565fmr4684452vso.2.1712565888186;
        Mon, 08 Apr 2024 01:44:48 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:47 -0700 (PDT)
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
Subject: [PATCH v6 09/10] PCI: Remove legacy pcim_release()
Date: Mon,  8 Apr 2024 10:44:21 +0200
Message-ID: <20240408084423.6697-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408084423.6697-1-pstanner@redhat.com>
References: <20240408084423.6697-1-pstanner@redhat.com>
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
index b81bbb9abe51..1229704db2dc 100644
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
2.44.0


