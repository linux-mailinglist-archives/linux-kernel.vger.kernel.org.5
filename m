Return-Path: <linux-kernel+bounces-149671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94548A945C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72191C21008
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A2370CAA;
	Thu, 18 Apr 2024 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="denq3Bp2"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0C3B79F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426443; cv=none; b=p136Do3duHpGNv6RssviwTpkXtRSPEVTZIGHTHGwiO09bCblZIEn8rqmieocmcHT8BuijwZqZXTWsd1DJWFHmLdHiPNA6X1SM7SFJd2RY+T3B/Eo4xc2WRf1+UOTg8r7/+Qx3+xhW2385CYCO8btHA6xaGfPRTIC9/UX2g9zegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426443; c=relaxed/simple;
	bh=QRRobUsIJJ76UXSL3DBQXDncJLCTWNk34A68JkiiqmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4CtWdgzTXCfymqI3/ddyWpYgbLeaeHLAHOsCsHtOK9qs5kU/Ax8pHyim0hXpaAJU+HYz4EPG5bJCkKB0B5/KNIu3gZx2yDgFolaDvOny8M3vupvAoVOvQpnooXECbXLmcTJw/5lbTqAoKmAxWcPC/W5zQgrlhdBTRqQ/OAbZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=denq3Bp2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecec796323so627106b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713426441; x=1714031241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhdi+OIm4ie6yhqkj7c+BFH/TdKVj4WDg6Ic5P2zvrY=;
        b=denq3Bp2TD9mYgrBDCVaXaolbOG5lLNbtRJqscF6abFl0Q57xRP8ARIrA6LsD6wD+b
         XAaqkVxFzLS/ut9foRU7WDHy8vVAtzn3VCUGogXKLvXq937lh/KrlW016MNwxqVBjUKv
         dKdkVNM/wfx3Jc9doaYJX2MGLW9TsTWqeAWoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713426441; x=1714031241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhdi+OIm4ie6yhqkj7c+BFH/TdKVj4WDg6Ic5P2zvrY=;
        b=AdEaJ+8LudJW4aCndAJkOJ3Agdt/W/pjaojCDL28YRB709nDFLDUJv6ZA9TiCaoe3G
         3+DzgmrXaRBwhHunyqOtQheNqTnSJ97XYaxyZB7Q4ycJABo0Y0xDHTxuCA9KjS4zUZFz
         qHszbeVch0sbMTgPT12kI9f17bHniaBPsfwX7v53cIgzFU1JhSDt2R/EjL1zk11+4skr
         j2c2rQrDTIoeFCeXs5qFiP5ymgZJnoSyzCIx2y+zDkJmnW3F08/nL92BXErMqnPEvrgP
         s0lZ2SZgoHk9jCbz0rKc2ovqm6RfNd6HhY/yvNOZtQ5Ts62xAzfW4IikM5QZuTJ7APPe
         vOFw==
X-Gm-Message-State: AOJu0Yz3NKXGIVQoHGVM5wNZ5uZdNiMVIaAn061Z2fJwvi2DzKAfGARf
	aZNx2UaUPZaKmPUVcCk8na2ealpE17qFhsPdoEmcnEew6AVLJr03fsI+U1Toqw==
X-Google-Smtp-Source: AGHT+IEmvK0jTNwaZDAqiM95Oud987xeKKnEzpiDrrqIuqJMFGOvGiQpVT6icJwlZ0dYUBFqO4Ud+A==
X-Received: by 2002:a05:6a20:9492:b0:1a7:4b3f:a66c with SMTP id hs18-20020a056a20949200b001a74b3fa66cmr2094209pzb.49.1713426441620;
        Thu, 18 Apr 2024 00:47:21 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:dc1b:764b:ae0a:3904])
        by smtp.gmail.com with UTF8SMTPSA id km18-20020a056a003c5200b006efbc365de9sm869384pfb.121.2024.04.18.00.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 00:47:21 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH] genirq: Disable suspended irqs when restoring affinity
Date: Thu, 18 Apr 2024 16:46:52 +0900
Message-ID: <20240418074652.126355-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In irq_restore_affinity_of_irq(), after initializing an affinity
managed irq, disable the irq if it should be suspended. This ensures
that irqs are not delivered to drivers during the noirq phase of
resuming from S3, after non-boot CPUs are brought back online.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 kernel/irq/cpuhotplug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..c00132013708 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -197,6 +197,8 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 
 	if (irqd_is_managed_and_shutdown(data)) {
 		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
+		if (desc->istate & IRQS_SUSPENDED)
+			__disable_irq(desc);
 		return;
 	}
 

base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.683.g7961c838ac-goog


