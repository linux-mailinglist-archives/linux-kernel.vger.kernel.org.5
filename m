Return-Path: <linux-kernel+bounces-135067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742189BAA5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9FD2816BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC44D9F4;
	Mon,  8 Apr 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVN6U0Gg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFA4CB45
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565888; cv=none; b=utlwHNRhzHksX7SS8lVlGPc8XvCL5/qHpsWpn/1vLxfjziBlGBq9/4OD7qcEAFtdjc77rLdGcmTLYbTP5CoukTen0+9FC1CQcCWdeTLqBNYObW9lHrCzYeayToeIqjhrS1ZmTDuWQdqg1ez9VhtFFlWPgaldTHDhxBTSZT+Eh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565888; c=relaxed/simple;
	bh=jtMfRJzrGj6Hya59/CapvknY9OFyyO9+qwkwlnNChyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp5w8glPQHtpb0RoO6za7OVi0XJR07LxI5MyWvWCGXcMQBuxrDnJUvlQjCRmhe/3O9u5pmeQHcr/cb5Z6PBtm1K+QPspnYUhxogDP4ImADxBKLkD0W8t6XO5zsvfkze/FroysrXM4hBrDlUGvkES95eCfmPhFw8gv3aaFTxlLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVN6U0Gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712565885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQbNzzWRGbAMJ/ZvXVtvXB/7D5Q8r5XT3mcCvFUlfNA=;
	b=YVN6U0Ggsr2srExWLrgjbzZxG0LHofCGu2j8R7Mni2x0bGFIdE/DWJBUBL8Tu3zfw6f1rT
	8/7PmClJS7JvsJicOKZ/+U1tnGHAsRJsQXsiJDJvg9+jvnd0t25ksN3kNWSP4fqbgUu+yC
	ui4y+jRIn7CUNW+nbUN7wXkYrCClKGs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-9AerEZ7gNf2pXyXBnZp_3Q-1; Mon, 08 Apr 2024 04:44:44 -0400
X-MC-Unique: 9AerEZ7gNf2pXyXBnZp_3Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78d5267ae96so8518885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565884; x=1713170684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQbNzzWRGbAMJ/ZvXVtvXB/7D5Q8r5XT3mcCvFUlfNA=;
        b=wV70/0HHyioxM/PHYKUmIg7k20D9tc0CXHcrwxteFjIavw3vSbehHye1ewVj60JVyV
         BV4+Efia7wVNvzJCF5Ec424Cu8jmKpaLZMoYnxJkcqUpwbq692N8BpQL1SzYl61SkbLg
         EpWepY+sYbB6smneYaOnWPTyplsJvIQnkbfcF/yacIMC2K/6oMm6w1Y4eO7gz974bpQo
         Z6N/PPcmFlsCUwU7fppdY3QyyI0iMWBQdC5yCEA+q1gvhtjZudoh0nclTnJV3sDR7HNU
         VzxLVq6vzdYE6FwDOn73f6C+zDy4ECEo9I9AzrahyS7GsC1X9lg/gUTzeP7gJoVY8kN7
         /quA==
X-Forwarded-Encrypted: i=1; AJvYcCVTQLWSXDKBSRuZ6mwt+z8KKErA99VwvyZkKH/5YA2rQ3W4PegXQbfaroDQrPWcqANYYGKowQ4hUOTnSKbKqwc3sDIwRFBwcZUQxAZQ
X-Gm-Message-State: AOJu0Ywl5ueyWoDo2uOKttE/ALJpODzGFtVqEKPnMo247P2NjERpGO8n
	fX8U9hK8gEcd7/mp3Ratmwovd9KObYAm5slT0qUEOrnrdISE6pBAYry8B49fsMxcxR1mtOnIXob
	mQvkdW1A8STO95xUGfn8GiR5yT6YnVca9MEo92bIn7cYHNpOWXmhdnfoSD56I9Q==
X-Received: by 2002:a05:620a:19a9:b0:78d:6439:127d with SMTP id bm41-20020a05620a19a900b0078d6439127dmr3282083qkb.0.1712565883929;
        Mon, 08 Apr 2024 01:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0qa1JgWscwtLKGJLtJEsFGCHRLEHSbkg6kELrSv9oOSNF02qqh4zCKM10yPLZo0wFlJ4eGw==
X-Received: by 2002:a05:620a:19a9:b0:78d:6439:127d with SMTP id bm41-20020a05620a19a900b0078d6439127dmr3282068qkb.0.1712565883582;
        Mon, 08 Apr 2024 01:44:43 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id oo15-20020a05620a530f00b0078d54e39f6csm2036989qkn.23.2024.04.08.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:44:43 -0700 (PDT)
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
Subject: [PATCH v6 07/10] PCI: Give pcim_set_mwi() its own devres callback
Date: Mon,  8 Apr 2024 10:44:19 +0200
Message-ID: <20240408084423.6697-8-pstanner@redhat.com>
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
index fb9e4ab6bcfe..e257c212cd9c 100644
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


