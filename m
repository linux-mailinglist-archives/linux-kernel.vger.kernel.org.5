Return-Path: <linux-kernel+bounces-156592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8F08B0543
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14E31F24E46
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB49158D65;
	Wed, 24 Apr 2024 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="brXMMJa5"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3D14F62
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949457; cv=none; b=MFYnFM2smsuVD9OsGrajanyyA46bw3nm1auNyo6axFjRP9t7/BMMlrl0GXqLdQA+7H4vsvO8RnhXHldDKGz/f+HBoIbFzhg9tuSMsLQTtGFMznQ+bikmIWBN62lCA0N7ynzC9QRJG8GAcMMOTpuHG/X1okLYkZpbnJtpE/Pe1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949457; c=relaxed/simple;
	bh=qksrWxkR0vGCFklHnvkoYasBMe5RegjfrYaTlDF4BXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djwDcB1BqITf0xcMf+QkH4qNdj5mq82j83j4TEYGHOoYKlg5pQvnLCKYc/7hyE6bkPJ9IHLUnjDhvYUR0QTRdxlpbTrjmeq0TonHbkgGI3Y2ucWX5elqPXeTJQ1U4p+5RtkRZkcxO+bDqo9kAK3GqJLa/sF6+bD7bUqMVLkAFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=brXMMJa5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a5ef566c7aso5277582a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713949454; x=1714554254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYIPdENpbVZQ9HIQn9akzkzYpcsGYQETQSVXZ/yd8R0=;
        b=brXMMJa5PcIuXGXTlLX4/v/Y4U2AeoqsLdq2lXqXrNWE8htQeoxU/SUTAErW0DBH3z
         p92/rO+NqZKw+t2UzG1q/PkfxEbevQFpE5FYdVTLX7JmLsJ2T+69EXWuYh8efE4sAKkJ
         T74/nX5r+tpI33SRmTLLH9NKrnCjUBqhQGkos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949454; x=1714554254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYIPdENpbVZQ9HIQn9akzkzYpcsGYQETQSVXZ/yd8R0=;
        b=tVeXGZn27knkC8vyHbHX4KuE/khCosGF1rnDj1hj/7Ssz+9JW8aQ6cRa9okp2I5FDL
         Nl5uQCRiTO6eB4Cybbe/MmCSl6iSvLAuiaYe9rjtE+FCcb6FqusHl2VB6JL61ihMYVdn
         oIo97Z3xfaenWv7wXau/E3yLbIk0tLB16EHjv+vhIloIfrG9nVSufjxrW2guPCNNoKiv
         zHahmHDqIkDk6Yr93HwSPr5FJ7Bnsugjj2nb5fJ8a3rVQ5sd0YYMAN8PU3VkAHoD4yyP
         kQHTQh69bbpj40/i3R2OmnaFz+0iknOC3/d58kNnRB/hvNpuNeSp0VUuDa/OI6H3dArD
         gZOQ==
X-Gm-Message-State: AOJu0Yy4/Sx5ZQPeYHv4+zGS/oboKYHTIRL46DEcE0Yw04EWycartRN/
	pUEK6VVDJQqOZqclThLI25YQdINMHpM0n4do+I1yCd0RcpKab1i/CZuKgwyvH6BSdvDZyGmQsoE
	=
X-Google-Smtp-Source: AGHT+IENUPRqn7faWjquObVQs5+1JEumsYMiz7DtQ/gPSBOWxdHheoAi8Vtm9d5VETo1mlGkymFgiA==
X-Received: by 2002:a17:90a:7d17:b0:2a2:f35f:fa2d with SMTP id g23-20020a17090a7d1700b002a2f35ffa2dmr1643571pjl.17.1713949454570;
        Wed, 24 Apr 2024 02:04:14 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:7c90:7e93:6f8d:8503])
        by smtp.gmail.com with UTF8SMTPSA id y3-20020a17090a390300b002a232e4f9ddsm11748861pjb.34.2024.04.24.02.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:04:13 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2] genirq: Skip suspended irqs when restoring affinity
Date: Wed, 24 Apr 2024 18:03:41 +0900
Message-ID: <20240424090341.72236-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In irq_restore_affinity_of_irq(), skip suspended interrupts and let
resume_device_irqs() deal with restoring them. This ensures that irqs
are not delivered to drivers during the noirq phase of resuming from S3,
after non-boot CPUs are brought back online.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 kernel/irq/cpuhotplug.c | 11 ++++++++---
 kernel/irq/manage.c     | 12 ++++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

v1 -> v2:
 - Completely defer irq_startup() until __enable_irq().
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..43340e0b6df0 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -195,10 +195,15 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
 		return;
 
-	if (irqd_is_managed_and_shutdown(data)) {
-		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
+	/*
+	 * Don't restore suspended interrupts here when a system comes back
+	 * from S3. They are reenabled via resume_device_irqs().
+	 */
+	if (desc->istate & IRQS_SUSPENDED)
 		return;
-	}
+
+	if (irqd_is_managed_and_shutdown(data))
+		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
 
 	/*
 	 * If the interrupt can only be directed to a single target
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1782f90cd8c6..82124f5bbe03 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -796,10 +796,14 @@ void __enable_irq(struct irq_desc *desc)
 		irq_settings_set_noprobe(desc);
 		/*
 		 * Call irq_startup() not irq_enable() here because the
-		 * interrupt might be marked NOAUTOEN. So irq_startup()
-		 * needs to be invoked when it gets enabled the first
-		 * time. If it was already started up, then irq_startup()
-		 * will invoke irq_enable() under the hood.
+		 * interrupt might be marked NOAUTOEN so irq_startup()
+		 * needs to be invoked when it gets enabled the first time.
+		 * This is also required when __enable_irq() is invoked for
+		 * a managed and shutdown interrupt from the S3 resume
+		 * path.
+		 *
+		 * If it was already started up, then irq_startup() will
+		 * invoke irq_enable() under the hood.
 		 */
 		irq_startup(desc, IRQ_RESEND, IRQ_START_FORCE);
 		break;

base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.769.g3c40516874-goog


