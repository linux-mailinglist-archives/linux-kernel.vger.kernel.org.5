Return-Path: <linux-kernel+bounces-120721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1505088DBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469781C27D3E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F952F94;
	Wed, 27 Mar 2024 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHJYEbsZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F012208A8;
	Wed, 27 Mar 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537521; cv=none; b=W6pVEMdW8uuTUdEAje72zijW4vQtoQ3+8inFqRdtRyGoCnfKVyZ3qpLAUiwL9wiyZTbAyrqnIup5BE01j1dXBd3AtpVavC38HXeQ4CAsw+DCOwfT1yQaTJ2ilb8fBksy+suQjQ5r9pxW9EooA5e3VxHo7POIPuhOW3Fh7g2qJUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537521; c=relaxed/simple;
	bh=2ybKd7wRmjS3EUGpteosq0iA1MFDnreqoLF22JlUHHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=frNU4QkDBYVrihC7kNZV5o/Eou6FpJjRUpJGuEvGQ/9G8iOVA3cs05u4eucSh+Ek1daZXLsZxb6YpXzAK2LwKKzgXNlbED/yJdca3gOVcOH/l5IWksbOmqu0GA4Ia71NbCc4vG0FUhqVwLXgKPgNvOv8JzHZoud3uo/MsrPi3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHJYEbsZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41495c4a8f6so1667715e9.2;
        Wed, 27 Mar 2024 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711537518; x=1712142318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=014p56NXkTx8ykc7/eVqJqevMHd3n2lLs/kLUplg5o0=;
        b=eHJYEbsZonPI/9eIkv6IyPyX8AdWZthqRab5PfK6NniOtFXlid1e6jzJYgZCJKZGre
         vhmyMstkzmsEoAi8CiThK2RPgaDv02xMrcvPS6kNm5DguAj21T2BvxdYXq5QtFu6ad6U
         GD4WMpzF8EwNNjk8oiWVKoYnaZAdZrYWKDYbk2IyqieaoOJS7c6fGqQzGWLbDZvsV4fw
         Q4sQwQ59s6iz3hUlsg3jX32Zj69CiZfqMtsaFoTmoXbmvLhoSi2a6tbU1zKBx6zyvH0n
         Nb8qs8YHETPuk7rcD7Vn2fvivW1m1OaKjZUzpusCG/btrkSR4D1zBrVngva5eo3D10uT
         xZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537518; x=1712142318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=014p56NXkTx8ykc7/eVqJqevMHd3n2lLs/kLUplg5o0=;
        b=PzPTDld3ROAMWnqejZdg0KmueCpEzZjPj+lA6HrUIzn/nmA3CRnOE6GUU6Wz2GDtFL
         fjMT1YkLAhqZhFNVaPvCa8LLHxSPJrm4ObZt87Mf7KJRunLGemMKcx0aZVLcV3q12HRz
         XkP6b6zVSe6O61guskd1NIBzBHYkz9NF4Hw0fFwhDjNluzxNrNAs2xJ1AP2BWqcEvRtV
         VfMkaMBogbtVAw84JVwz6BmP9WyRDCcq8w3HrLWoDlyGUWbMzabwFjLsCvdiJXfh34LC
         xYXRRuaqyvRPsPYlrGHSBoX+5OGMfrnMP+r8rr+VC8cItC4AGe8YdiOy8ZrQaJnMNzrA
         T+cA==
X-Forwarded-Encrypted: i=1; AJvYcCWWCrCI6II08sCqqfIo8kTZPl1f8Z+TeJwQ47MHsyAfKr2cse1Z5BxeLFatBaSGX4pv9r/hdS0/BYieJExPTxky6qM8uztukCYM0/VU
X-Gm-Message-State: AOJu0YxXGFvZY3JV/RJJkbUde3kpoQtkMatdzJxaoi2uV+KotpYaflmo
	FcZl4qBbPeK2gvIVOkvLEQznvmkdw4le19JaMhPXzrVo0PSL6hLN
X-Google-Smtp-Source: AGHT+IELU/7JO+2Zja+aj+L6RZpytn4mXOMjoQiGw3A+Qqveb4jzvTJ5TixVDe6G93XhZRpnua7/gw==
X-Received: by 2002:a05:600c:358a:b0:413:f290:c747 with SMTP id p10-20020a05600c358a00b00413f290c747mr1671154wmq.33.1711537517652;
        Wed, 27 Mar 2024 04:05:17 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id dx23-20020a05600c63d700b00414887d9329sm1775106wmb.46.2024.03.27.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 04:05:17 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] irqchip/riscv-aplic: Fix spelling mistake "forwared" -> "forwarded"
Date: Wed, 27 Mar 2024 11:05:16 +0000
Message-Id: <20240327110516.283738-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/irqchip/irq-riscv-aplic-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 36cd04a5057b..028444af48bd 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -251,7 +251,7 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 
 	/* Advertise the interrupt controller */
 	pa = priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
-	dev_info(dev, "%d interrupts forwared to MSI base %pa\n", priv->nr_irqs, &pa);
+	dev_info(dev, "%d interrupts forwarded to MSI base %pa\n", priv->nr_irqs, &pa);
 
 	return 0;
 }
-- 
2.39.2


