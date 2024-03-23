Return-Path: <linux-kernel+bounces-112382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3CD887924
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB96B2846D7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B43D39B;
	Sat, 23 Mar 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEqOVxFB"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447443D96B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711204954; cv=none; b=ce+4HYty2ec+hQWMmLG9nrkDr+3uPNGBoMhRisxzPBCjUnwDxIJLbunNxBXBXUpP8ZCSlpCPp1nXG/f/WhMb1s8Y2Uuxkcdrv2KhZG4pYtyxXZiZo7YYZJzZw/9bj7BISufQmVN/52paoQmS1RPbInNh+kAHga7enTvgTPLnpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711204954; c=relaxed/simple;
	bh=G42hL2OMQmrXqiY2pVYKoPqohkY9rp3JnSHV/l56CIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTN5UecRcjb40cZ76/4OUfz86KMja+UVNsF/VT52eQsjrRI91HY8kq04YJBcjSkdWMqdjH20GovHNCpHul824JPc15Niq3GVIVDwRZ4BZq9W1Z67R5qtlcxl7orfRSVGXtArzbwZtzid5i1gppVIJ2GIFMRxYXt0cIe1Ef0MusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEqOVxFB; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2216392a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711204952; x=1711809752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHcPGqYQ65DRWqf/JlnuKXwAOlhG9RgJuQmpBww8loE=;
        b=OEqOVxFBwauRQI77ahiqea/2iYwuqSv4K8SzRFjz1+j1A6C4uZZqBZCbodwLaxnLrL
         zCI8htz9cccob83JQaPPAkRXNPp2NFaiN9z8r104STytWIqDrlXSMpcjZb7Bmwyddp9u
         w3HAeB9VgCMc+GqU60x2GDGyLBAVW/jpvNT/Te11QD4jiiOWfF37tzDp3imABw6HTH90
         BnzvJK3kTRxa/CzbQOxrBQeSz9hy7sEptXvyVdXaMcOjrV9uXZQZL1Y4b1p4WcA8Z19w
         tqUSqu1Ap2Yq14LDzlZXyTCSEO31fx8bixUgcZafV8XaYd7f0BdHfM/mYKRvzxRqA5n3
         vRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711204952; x=1711809752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHcPGqYQ65DRWqf/JlnuKXwAOlhG9RgJuQmpBww8loE=;
        b=GSldq5ycVyF4QVqxEVtPogJpNiy+AltodP6Sc0jIp4SELGoWOKkcC7NdvsrKeZ03T9
         SCstYync0Rk6zfy+qitpiqGRmA4VRKteHsPcw3zDiPYmsn2O+clfNnDjsPICtd4rblzy
         6l+JreuRHZIJn7Jjee0afjx46AIapp4Rgou4mSGAaSVMyHAr0JKQm1n0+XI9leUCxV1w
         EymA2S+PDf9T8x/PlJkR3W7iaSE/5YpBGNMxoKAxsyynFToC93WofXENjp9WL8kcf45l
         ELBOEwr5pJNQRsOvT8H/aZINv3kewVXf5xcooeMCfVzSDK0OWY4wXW+Ht0lfErFP/xx1
         xKTg==
X-Gm-Message-State: AOJu0YxprGNlp4Yj92du86DZkxtVuCB/zyx0i/6eAnThLR/H0xlFwmIR
	1pDu1wninmRywCglrOwJToHgUlu0z4WGF/ieq+KytQKU99Ps4r+R
X-Google-Smtp-Source: AGHT+IF31mFC0vChwAabYd200+gZfp46jBFxkPRX21lF19s2ITHoDMxjXpyDCa0WAEs/wDpc+/J65A==
X-Received: by 2002:a17:90a:ce09:b0:299:3f5d:b5e8 with SMTP id f9-20020a17090ace0900b002993f5db5e8mr2170106pju.20.1711204952437;
        Sat, 23 Mar 2024 07:42:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090ade0900b0029bc9c34a39sm7354486pjv.50.2024.03.23.07.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 07:42:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Nilesh Javali <njavali@marvell.com>,
	Christoph Hellwig <hch@lst.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Chris Leech <cleech@redhat.com>
Subject: [PATCH 2/3] uio: Fix build failure on 32 bit builds with 64 bit physaddr
Date: Sat, 23 Mar 2024 07:42:27 -0700
Message-Id: <20240323144228.3924542-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240323144228.3924542-1-linux@roeck-us.net>
References: <20240323144228.3924542-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Builds on 32-bit systems with 64 bit physical address fail with

drivers/uio/uio.c: In function 'uio_mmap_dma_coherent':
drivers/uio/uio.c:795:16: error:
	cast to pointer from integer of different size

The conversion itself is safe since sizeof(phys_addr_t) it in general equal
to or larger than sizeof(void *). Solve the problem by double-casting the
conversion.

Fixes: 576882ef5e7f ("uio: introduce UIO_MEM_DMA_COHERENT type")
Cc: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/uio/uio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index bb77de6fa067..1935b0f16477 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -792,7 +792,7 @@ static int uio_mmap_dma_coherent(struct vm_area_struct *vma)
 	 */
 	vma->vm_pgoff = 0;
 
-	addr = (void *)mem->addr;
+	addr = (void *)(unsigned long)mem->addr;
 	ret = dma_mmap_coherent(mem->dma_device,
 				vma,
 				addr,
-- 
2.39.2


