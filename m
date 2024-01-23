Return-Path: <linux-kernel+bounces-35028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831E838AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D53A1C23A26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E08C5F574;
	Tue, 23 Jan 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvnBSLBv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1105D8EB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003105; cv=none; b=FRVa9ETRk86/khQsSmmkPL2ZD8+g9385k3UfSP9Nl1+CyrVM18nLEv/AjU4IlEY0Iu0EuHTkOtLpc/uBr9eStkLAIvIo3xd8Fw4wflTzHcN9rH04CmDv9gh+sionHbQprli6+juDxUEWCYWj7W+xfO7bngCEmyPQIVgI6AGXq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003105; c=relaxed/simple;
	bh=02ujaudo3KSmsF5K5ztuR/Ql8u25boOsUld4kW2EV8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiRV+fKDO2O8ZnPcIQOpQuRnakb8mcyggq79+7413nYT2r3NA3mIo3u6cu6NaBYSPFPiOGbUcqQhS9l9AzBDQFQxdVbOR4XQkbpn761bzJlvFmZVQzqio+jiuijUYOekrhBfjiEYla/2X68DdqAV5yYvPjpYz5l1OtVqRpWnAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvnBSLBv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706003103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXd3AZjPKhslGVevCwKeJnsSWxdJPCffQSFxc+gLUxI=;
	b=UvnBSLBv0X+1YozQjUoIDzYpwRHs043yZdi3CiTybDFWBfZlVRCQeGYb6/GDY5ZUdLhSsw
	Bh9yezYPl/kId0UkgrFMJpyV9+wR58ZAHhjHneI0LRi1XbsQkOHBxDyZQwVixbBT1EDpdx
	USp/9OYpYdjpuqv/FdAEvh7O7c2LpIU=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-INwfz9d9Mz2jq0z7ydNXEA-1; Tue, 23 Jan 2024 04:45:01 -0500
X-MC-Unique: INwfz9d9Mz2jq0z7ydNXEA-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-46976c07c39so454085137.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003101; x=1706607901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXd3AZjPKhslGVevCwKeJnsSWxdJPCffQSFxc+gLUxI=;
        b=Oixpse5c38NS/gt9O9cDAWNinZTZRST5cAbIBsTNUOG6ZoDLLl9E9kcCD+dxoyvdOS
         hlD3LrvGyr93IX9meqzUZ+NOFErc02GxjEUa0hyqpqw16StZtTkUUB/xJ6pCnB9Vl4kX
         zfiWCbz/LQw5FRhx2tZ5LDvrv4gs+td6/gHDc6m8nJSzaGafZiwDYXKyDukX2FkdCLjH
         IoL2tzOpwjKd6//ufUvl4ZbzuYCMu2IpMDEx8vYA0Jj8F08MLVh5ze9adVc7DL8t1BWM
         0aDWk2CG2inZsrQOucRmm9VybDvmpZOhxkvbgBbCIH+Scjdf00urFUxxFJXkzUwyaP/B
         X/ew==
X-Gm-Message-State: AOJu0YzMiVE97LCsjmqvfea4ZpsjewkD6YxryE0AvA/4WRQBy/JR3ghf
	havh69pMVZUxKVw6tWAahc/9fUpTO6uZJgiYxYoc/SRKKQnvQtML5ZVOwkNsI7sEAQR8uvzlqBa
	dadyEPwU0ECt1LhlsKGp7bL0j+C3SbUxMPHZ5kmZjdsIogZA12g+vwhqJh7T7Zw==
X-Received: by 2002:a05:6122:1684:b0:4bd:4151:936f with SMTP id 4-20020a056122168400b004bd4151936fmr409258vkl.1.1706003100845;
        Tue, 23 Jan 2024 01:45:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRoL1ahcR75vBLXWQC/4Tfk26KCchDZ9UlSe50TIl+tMW6CAPN/T2lwZOJ68o/lL+18tX5pQ==
X-Received: by 2002:a05:6122:1684:b0:4bd:4151:936f with SMTP id 4-20020a056122168400b004bd4151936fmr409238vkl.1.1706003100567;
        Tue, 23 Jan 2024 01:45:00 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id nc5-20020a0562142dc500b00685e2ffcaf5sm2958704qvb.38.2024.01.23.01.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:45:00 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 07/10] PCI: give pcim_set_mwi() its own devres callback
Date: Tue, 23 Jan 2024 10:43:04 +0100
Message-ID: <20240123094317.15958-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123094317.15958-1-pstanner@redhat.com>
References: <20240123094317.15958-1-pstanner@redhat.com>
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
index 03336a2f00d6..d396d672a6f4 100644
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
index 3d9908a69ebf..667bfdd61d5e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -811,7 +811,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.43.0


