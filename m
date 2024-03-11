Return-Path: <linux-kernel+bounces-98783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CB3877F58
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE72128210B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7D73BB23;
	Mon, 11 Mar 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAiuxXTE"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B438394
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158045; cv=none; b=EhUR0kDpI+bMe+ya2M4gf6CT/Mn0daNH/yeebqV9mpilc0IEogWiRqCUzmg32ihutgOf/q7IKYvMSD21SvXFBvTtFMS7WXhXm+tosHxi9McWXLvn73ZnZwv8331IoFICy+uky2Ggbyjy2C/+ePmWss1+8RXTwQIGnYetm0kD0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158045; c=relaxed/simple;
	bh=PVtpCKCkBtvEJIf9crFa+TlWcqX/82F7MF/jC7ddjwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dzN6nLWDWelyC4DfsQ/ltxp/fzWi5T2/HV0ai6QVz66nZRAv9ksfDBd826o5BpDKS83wUfkDLcJMuC1UevHLiMX7bD3UNGGvvGL0dvdqwgjdAThoLhf3+4zGT6VGGzxGl7S3/0DIDlwBbpoLFgD1sF8FOiLeVmJCJJMgKuj8D58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAiuxXTE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd9b6098aeso6887335ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710158043; x=1710762843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UPNazQlGmkQf9hVivO3Ny38z32q6y/PMgomiFB9Ohpo=;
        b=QAiuxXTEO3POtQxNlMwqmp/6NvlOWeqCaHJIEvHFuQdZgUkfF+c8J0o8qtiOQKlSik
         YRj23Z29hUiIis6KkUvF3zK73jATvaYreeIdflJLuARanKm54cGQivwNweE8UL61pa0/
         +U66RpMQ2IR427mqwbUvB6NgfqE8i+MDk18ObgD9BldEcvFdFQO3ANBiFm1iCaayscIp
         G5+nHAo+ObySG1a0dHHWHdtiYEijji4DycWR/czV6Kd7CrSseRyxKsyAix8SEMlx6DDz
         50loOSul49zzW3cLccF0QeOAKXUZfIzjvipGVNoNQ8q493cJUrSG5hIueyZnHCSqAu1f
         tECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710158043; x=1710762843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPNazQlGmkQf9hVivO3Ny38z32q6y/PMgomiFB9Ohpo=;
        b=KdGsfKAdtjg8atU7iT9iqqmnOe8EXVXi1G8Ptdah7R2YE3496apyT3xVbZMF2PdaDI
         VDS6N2/44yRrL7VfhiQO8QhPx8int++GMkHbAZvWgev0+6rPIahpaw+2FMoWziH9y9dF
         evcQDAADYsGTQWvpg9Z3rLf5gc7axhPBhAA2a60+5o1al7zkpRGT2aTqVRStHGCSRWlF
         aaYYwdL+RE/Xb89stNVmDiE52uqoFPmFElbsQ7aYJwB0LmGHQey2cMza0vGCcUTZbjR6
         nl/tdJjS+MsmyeRPdWgJmRgXlJ4rFmdKG+Ns9HY0Os56K/wEuuTN/OowBu8f0GWvqk/Z
         lB4Q==
X-Gm-Message-State: AOJu0YwCUjmfO3GxHxlx+ysaRp9+3189pv7onK/d8MPqoQKSh/Cgiydk
	aDik5xGHbsinCakGvfZ8L5GvIyTJKXvJ5VLhhtfLrc9i4oJrtt2kOkZSy76Ki3Z6qg==
X-Google-Smtp-Source: AGHT+IEaq9G5ibgjW5cuECRa2zEfUpHa4myqNxMYTPShI90FZx5rwodmCZG0vXfcmR9ZorJexVL7ew==
X-Received: by 2002:a17:902:ec87:b0:1dd:96de:83c3 with SMTP id x7-20020a170902ec8700b001dd96de83c3mr4092124plg.11.1710158043030;
        Mon, 11 Mar 2024 04:54:03 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([203.145.41.11])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b001dd6958833esm4627682pla.242.2024.03.11.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 04:54:02 -0700 (PDT)
From: Keguang Zhang <keguang.zhang@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH RESEND] irqchip: Drop the custom fixes for the same irq_chip name
Date: Mon, 11 Mar 2024 19:53:44 +0800
Message-Id: <20240311115344.72567-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 021a8ca2ba23 ("genirq/generic-chip: Fix the irq_chip name
for /proc/interrupts"), the chip name of all chip types are set to the
same name by irq_init_generic_chip() now. Those custom fixes for
the same irq_chip name are no longer needed.
So drop them.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/irqchip/irq-sunxi-nmi.c | 1 -
 drivers/irqchip/irq-tb10x.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index e760b1278143..bb92fd85e975 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -192,7 +192,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].regs.type		= reg_offs->ctrl;
 
 	gc->chip_types[1].type			= IRQ_TYPE_EDGE_BOTH;
-	gc->chip_types[1].chip.name		= gc->chip_types[0].chip.name;
 	gc->chip_types[1].chip.irq_ack		= irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask		= irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask	= irq_gc_mask_set_bit;
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 680586354d12..d59bfbe8c6d0 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -150,7 +150,6 @@ static int __init of_tb10x_init_irq(struct device_node *ictl,
 	gc->chip_types[0].regs.mask          = AB_IRQCTL_INT_ENABLE;
 
 	gc->chip_types[1].type               = IRQ_TYPE_EDGE_BOTH;
-	gc->chip_types[1].chip.name          = gc->chip_types[0].chip.name;
 	gc->chip_types[1].chip.irq_ack       = irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask      = irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask    = irq_gc_mask_set_bit;

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.40.1


