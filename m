Return-Path: <linux-kernel+bounces-76997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8500B85FFD8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE85DB25A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C615B10D;
	Thu, 22 Feb 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="o+5TmM8G"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C51586E3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623604; cv=none; b=MNsgbumkshSWhWIFfnPNptTAyUjEYlRMVTGEAwjod+xjHAcHfSf9fQN+WcjfBeBuFoOcqH7oL0Z6n6HYF7aZC/GWf4/4323jmWNpaxGEO/c+/hJNlQ9LnxM2NfhjWSj03q1TPZBw/Sdd84RY6LcpI+zUf52UZCnsEmP/MUjpymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623604; c=relaxed/simple;
	bh=hdLpspnbEGp4kEuYunjFJ86S1uZvH9wpW0yn7Y14D/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r75ZPOfZARiitxW4qg+JAO2px8ZxeQNNFGR7I8EeKAQiOqKAO9swE+dShiV5YR4y0kZrPcjj5h7rTANedB4FlJrY9gQsqJbDAtSn2d3TzvTQZ8kRtluTyGRbbWpm6V0K7glg5WPbx2dQUxfZOC43BWoro0cPxkS+K7fXsC29v8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=o+5TmM8G; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e5b4a91f9so1954961cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623593; x=1709228393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEqwPir77gZiomgrLUuNDH63tTDpLGc+7y089oTBF1I=;
        b=o+5TmM8G//XEyI/pvIdUZ5kZPAx1GYWud3Py5Ja+J810QnLcljpHtHIiTUKitE/3W4
         7g2uUPtBZp1ivALzHWfQbtcatEsEhLAkhHz4s27bk0T2su0neaoUDeggrgJpGprQXDPZ
         s8XJft2DnLbUNcruZKHJuJFsz6is8keLXKhvxUGTrutzYzggXFTHSeMtvB+2F2/1C7l5
         I59R8gd8rx+SkZHQPNrEy5HgNVnX56rGb5HZ5MBK6rIDiekk+5ZHZH6N9W+ITClTHru+
         LSZxELhZQF0ahkPQ7D92/F8QmbCDaiNK2aigaq0OIsaWr6tI/Hrjh96dYKZQtNJAbgou
         0SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623593; x=1709228393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEqwPir77gZiomgrLUuNDH63tTDpLGc+7y089oTBF1I=;
        b=Dm36mdiN2l7w85laLnqyOknZSCdDUEDuvcihIwtBmJJgxwu2YC+Aq/B07ixkid9HDv
         IzqqjQhS5PVjNG4/lvzNkyWPDt716G0FJZtLXWElYlewtz1IZmFrNqfp7C1WfbpwQ2rL
         yhKwQso9VDfR82zk7/HGDOoAtk1V4PFSMsQ/VMN5ZV0JvzjAuHf4kTLEcxcVnrtgV9BR
         ylytFEzcn+zIczyeGEFGMBjGSpXMuFttdMP3Bajj7vhvX3l160Kk/XlfXV9IY5vgGVx4
         gxrULJvMa+I/ReqpAgXXFLkmfdTfgA7DO5VXfX2sSuU2LKMrstJPZj5C2eBgRt8Rmkjp
         uRvw==
X-Forwarded-Encrypted: i=1; AJvYcCVzQM+33Q1ZrjOccs5Ba9TwgMMUeCII+HjdWuKrFR77tfv4NF/rxDum1tRA/uxMoAru+yDrGyDs22feHYedZeHgx79dH8+Pse3LUQVD
X-Gm-Message-State: AOJu0Yxgffsc5m/brxvvIEuhegpy2giiUpVYiBrE7xLAGvnZx307NOFF
	mlcoBVU/dFJkJhHYhM00Xfxik+K5yHBTV8VSLLa47aXNaAcgwOt0oB/ve2nTuoI=
X-Google-Smtp-Source: AGHT+IHWgbe6ipO8HL4XSLjafpdpzGiSGfQct8NtUqWcRWqXLU3Gq7aLBUbxfLYc4BAno8BAqxzaSw==
X-Received: by 2002:a05:622a:11d0:b0:42d:feeb:64df with SMTP id n16-20020a05622a11d000b0042dfeeb64dfmr18277023qtk.36.1708623593054;
        Thu, 22 Feb 2024 09:39:53 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:52 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v5 08/11] iommu/sun50i: use page allocation function provided by iommu-pages.h
Date: Thu, 22 Feb 2024 17:39:34 +0000
Message-ID: <20240222173942.1481394-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert iommu/sun50i-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 41484a5a399b..172ddb717eb5 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include "iommu-pages.h"
+
 #define IOMMU_RESET_REG			0x010
 #define IOMMU_RESET_RELEASE_ALL			0xffffffff
 #define IOMMU_ENABLE_REG		0x020
@@ -679,8 +681,7 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
 	if (!sun50i_domain)
 		return NULL;
 
-	sun50i_domain->dt = (u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						    get_order(DT_SIZE));
+	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
 		goto err_free_domain;
 
@@ -702,7 +703,7 @@ static void sun50i_iommu_domain_free(struct iommu_domain *domain)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 
-	free_pages((unsigned long)sun50i_domain->dt, get_order(DT_SIZE));
+	iommu_free_pages(sun50i_domain->dt, get_order(DT_SIZE));
 	sun50i_domain->dt = NULL;
 
 	kfree(sun50i_domain);
-- 
2.44.0.rc0.258.g7320e95886-goog


