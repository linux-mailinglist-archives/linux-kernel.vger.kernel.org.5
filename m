Return-Path: <linux-kernel+bounces-111174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7D8868B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D431C22B88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30E1B801;
	Fri, 22 Mar 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4HAH9o6"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842591A286
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711098021; cv=none; b=XzVzHvfjRiVTvHRYkVCPSkuPTKz2rtYTZQscSImT8Y0hzkV3kIMyoylxkrGZUPsw3e5jq2x5gO0/40XtNq9JYZLLB10esrIWUgjV0gdmL7ykIgLgxdfpe+30PkOD52TYorkCu/3Hj2NkaGyA6MrTApm9zzFrjIKF7E+6869onUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711098021; c=relaxed/simple;
	bh=gfR5ZkWmYbL7VYa5l06AVH1jy92OeQIWM6ab8hSNjtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a4myPWoh3oD6noXxE+/BE/NeN3ioP9UuPSGSIC4w37le7I39DJ0yg6WGf0j6Te6BGrbj08SUZf/b3NmKeufoIFDZ3MSeZm4C4nrWVyd3feFEGpvmpN10SeFStLXqGJQp8i+r0oE/nu7z50TJJm/Ht0XFk5vU9O/nIhVka0Oupn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4HAH9o6; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c3880cd471so1075913b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711098018; x=1711702818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLBtKAVMx8UeOXZQaAlRR5fkQJeKEswMH4lt55EITFU=;
        b=F4HAH9o6a+jWVwODYGtwDE0tV+xcpkEc0R1NK7B9zm2wJ+v8PIbBEKwo9EdcxlorBe
         D38xGVynbD1sn89p+MPIIKbpG2peX2qI705k2iLVV2UPS6BLXdCOze6R5YqhGqp+o70C
         ZvLfuAqs17Xzb8Z3SLte8Ezua+U87+MEa9C29Fru7mSMU7knpzBbvlgPJQ6qB3VhrSAJ
         Vn3U3SHg7nNlm9blS1HPRiCD0IGZxTWtN37soyvjz2VJJsVke1p/yS+ZTRt6kR1vylAf
         kLCN+I8MWPME12bpVz6br8Jsjv2dgy4jW1NgSElnTvn61PwisnjWHcyFb9LiwVQjTCn9
         AHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711098018; x=1711702818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLBtKAVMx8UeOXZQaAlRR5fkQJeKEswMH4lt55EITFU=;
        b=HeBOz41MEocHKN1saXG2SgAbk2SZbxqYYk/LPFtg9hWDnFr4W29aOgQweKWWW5AR2z
         KTL3ee/AxrmQ3a4cu8Pzvd22y8ZoI8FPlYByd+yJ7cNtiiqXs9BoKMhGsXYjla6dGQvI
         nCyxWGVeaXo8cMb55p6j50cGkml1KCzL4darrKZT7rDVI9I1uGzfkdefXPigSl8c/cZg
         TZylecttHcyeLY/NGWl8T2ZuBJhjlTEbJXeIe83iExtVHon93rQKv2mdkjZkhjVhNypc
         c7v/8raibsmF4GSYq/S2KWCm3/ZkBX4plzl/SWb9YJQeDZs5hvZ3vfSL5vYtsMHmJI3R
         gomQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhxcbywQDG2ygGeGPc/G0x4UnJWKMGWxmUcK09liELoBkxfD8fvVUkSocfxVfZE1v7aApY7I3upEMrzBkYCwmsGYJQa29FkuYHZCiJ
X-Gm-Message-State: AOJu0YwUcl3SNF8g/tllWlNkDo5RcQBRDhA6MmK8F/pn5sq1PCf4gtpw
	b3cE/BxHPL7aZGW85VoG+Ljdid+u0tvCzk1YUjmR4cjiKO1j1b1j
X-Google-Smtp-Source: AGHT+IHMirPgQkP3KLpcCux/Dh+nitiliB4mwcW6qcn7NeTd3JjSGKRsUEbm+KaUNCin7isX7P46cA==
X-Received: by 2002:a05:6808:2017:b0:3c3:a000:50e3 with SMTP id q23-20020a056808201700b003c3a00050e3mr1844795oiw.37.1711098018531;
        Fri, 22 Mar 2024 02:00:18 -0700 (PDT)
Received: from DESKTOP-4R0U3NR.siflower.com ([2a09:bac5:6249:183c::26a:10])
        by smtp.gmail.com with ESMTPSA id y9-20020a655289000000b005dc4806ad7dsm1001373pgp.40.2024.03.22.02.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:00:18 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: [PATCH] irqchip/sifive-plic: Fix error handling of of_property_read_u32
Date: Fri, 22 Mar 2024 17:00:02 +0800
Message-Id: <20240322090002.311645-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <qingfang.deng@siflower.com.cn>

nr_irqs will not be initialized if of_property_read_u32 returns an
error. Check the error first.

Fixes: 8237f8bc4f6e ("irqchip: add a SiFive PLIC driver")
Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 drivers/irqchip/irq-sifive-plic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b7bc4fd9517..f436b61d74b0 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -428,8 +428,11 @@ static int __init __plic_init(struct device_node *node,
 		goto out_free_priv;
 	}
 
+	error = of_property_read_u32(node, "riscv,ndev", &nr_irqs);
+	if (error)
+		goto out_iounmap;
+
 	error = -EINVAL;
-	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
-- 
2.34.1


