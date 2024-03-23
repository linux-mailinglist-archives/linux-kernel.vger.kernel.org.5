Return-Path: <linux-kernel+bounces-112381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C0887923
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D0D1F21A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ADD405F9;
	Sat, 23 Mar 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eagpGKDt"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15299347C1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711204953; cv=none; b=LDgzvjRcECguTibZW8E8Atj4fb8egmEdpQEKZl9mH7YCLywRknmfRvVSmiWSeiGYC8vxIUIhz8ffTs7UR1sCs5WYnZfgcVrZc3hHg5QGznpxY4OsMtT1wjhRm4eMzsDT3XuOAfiqIcl/pRY5wjq6EhDBKETYapn0hUalDb+1mX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711204953; c=relaxed/simple;
	bh=lpdWzs0G4QkbLHY3oSNIfGbDa/O741uDlcjYxbFyk1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jjSiylojJzAuiykBHTiRRi/osFeq1wQqn82L9FBLkN1PCtRnsFgrwzDKmW9lCacXgGsFr3ByR3e8H4/fs6fVt+DOlcDdcGAi31MK4fml+gRlUmcrK8JL+qwbH8yHfyrO1djXHt9c5NEdZxVG/rFJCnp+EWGzHVKTppYo3MQaEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eagpGKDt; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a4df75138eso1588681eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711204951; x=1711809751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7PBHdfeipzLq1tbOj5Iklwb0R2q7e/8MO1Jub1NAFcM=;
        b=eagpGKDtwjotIzmNAUF3Ad+lJkMmEaI+RHbP0QRQEejTSpL8rCicjG9kYvi3wZ3jxK
         OjCDScrXY/ueg+YWOEA8KBPgobKammwHp01oyyuV2klyUpBhcIVLSUCctVMKfclzjhdj
         3DJ7FWJSH7Habrqa6jbZCo6wfH2cDigfAJFa5aQfWdvxWueyppd4rwYpoOuDbm5roscX
         se+5UJXU5Zi7MjDBUH3iRRJ+Lwl2BfmCQeTvVJm/zI8jnF1Ubp8i3jNToVnF5RCZiTiP
         EqXPEJjOUn1DGatz2I7nmlFqwfIheSBfCQOINQBUBuswFHyqOnLEqETKpMRt4QYYzhk4
         E46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711204951; x=1711809751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PBHdfeipzLq1tbOj5Iklwb0R2q7e/8MO1Jub1NAFcM=;
        b=JkyVkN5eeC+c1NQvf/kMooZfGenfMJJNT7YcdACc6Lv7SOyCdlkQVxFYm+CwXjnlfk
         r+DL3NSw0EYZt9XpQHEjbVJ16QpJGi0IY2FVJQQT9q51OihDsa7dFth84rzuZIj0JELS
         6Q4zwXes5mMLUHK4bWBnuzz8kGiHPe09XeAq9qlvZYkS/k1y0OIX+sm31bhf5dtLdM9H
         5E6Mo//CCvSy9F5OPf6ewyXdCMr2qrX8pRgIlt6A1gWoh7KmTLYyDGmCl+aAKwj9nw36
         kagw7JLmdNl1apzRrJElP1exFo3nvQx1af70JBov9PdBZb4rfba2ARaKw8jycyTj7Fr7
         CMBQ==
X-Gm-Message-State: AOJu0YzwBoQw5W8XZBIuMEAjbAYzJQb76kwE0BqYNIvdBmFAqPKnd2l6
	KssnCSzpuW5cJZIKnOKyu0av88c2Ub28tWy8+AUHRRz9Z7mJAHMr
X-Google-Smtp-Source: AGHT+IHbYaaRhRcqU9EE7SOy1QZ90rrmJQzV28faEYHpQP4Uv/OSB67Ybm4hn13H7nSTHL/QsZlIrg==
X-Received: by 2002:a05:6358:7e54:b0:17f:5ed5:a684 with SMTP id p20-20020a0563587e5400b0017f5ed5a684mr2761197rwm.13.1711204950974;
        Sat, 23 Mar 2024 07:42:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o26-20020a63921a000000b005dc89957e06sm3276031pgd.71.2024.03.23.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:42:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Nilesh Javali <njavali@marvell.com>,
	Christoph Hellwig <hch@lst.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH 1/3] uio_dmem_genirq: Fix build failure on 32 bit builds with 64 bit physaddr
Date: Sat, 23 Mar 2024 07:42:26 -0700
Message-Id: <20240323144228.3924542-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Builds on 32-bit systems with 64 bit physical address fail with

drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_open':
drivers/uio/uio_dmem_genirq.c:63:39: error:
	cast from pointer to integer of different size

drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_release':
drivers/uio/uio_dmem_genirq.c:92:43: error:
	cast to pointer from integer of different size

The conversion itself is safe since sizeof(phys_addr_t) it in general equal
to or larger than sizeof(void *). Solve the problem by double-casting the
conversion.

Fixes: 019947805a8d ("uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion")
Cc: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/uio/uio_dmem_genirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index d5f9384df125..ac793e916f80 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -60,7 +60,7 @@ static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 
 		addr = dma_alloc_coherent(&priv->pdev->dev, uiomem->size,
 					  &uiomem->dma_addr, GFP_KERNEL);
-		uiomem->addr = addr ? (phys_addr_t) addr : DMEM_MAP_ERROR;
+		uiomem->addr = addr ? (phys_addr_t)(unsigned long)addr : DMEM_MAP_ERROR;
 		++uiomem;
 	}
 	priv->refcnt++;
@@ -89,7 +89,7 @@ static int uio_dmem_genirq_release(struct uio_info *info, struct inode *inode)
 			break;
 		if (uiomem->addr) {
 			dma_free_coherent(uiomem->dma_device, uiomem->size,
-					  (void *) uiomem->addr,
+					  (void *)(unsigned long)uiomem->addr,
 					  uiomem->dma_addr);
 		}
 		uiomem->addr = DMEM_MAP_ERROR;
-- 
2.39.2


