Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4878F7FFBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376611AbjK3UI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376564AbjK3UI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:08:58 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728EB1AD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:09:04 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41cba6e8e65so7776431cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701374943; x=1701979743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Be1KAg53A/Objdu3EOp617iDWrhswh7WogUdBagnrZg=;
        b=b5FIJOpVYc3V2YCNIasCpGTREL3vAWocW8+79kcTkTMx0nfDV+HD1T2xJmBet1i9pu
         rVyOq8XG7n6Y/YO4R9V6zuM9DjmwvNKMyeMoWrsmjDuN3tINbzflZJPjwVf+jr4PbdZa
         yukFQo/OaZti3gowl5KJ5X3bJHheD0ukYFVwvOlxjgip4PrdFNyJAZajeCT1qRgZHCpo
         Ria6nd/mH3TdWGxB+WsXFnBUSNOLBMzlkjOF4waX+eeEAC6dcHAA1b9aylAVkWsGekpC
         4/LqhrdnoCeNX27w376QS/KneCBtzpm67TgBRyPc1Un7CiwmwzpDC9OHN+EaTjmTqEm7
         9mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374943; x=1701979743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Be1KAg53A/Objdu3EOp617iDWrhswh7WogUdBagnrZg=;
        b=knhTxD7uodUcuq18n/25PoI7/KyoZYeYnKBqnmvU5FNA2RHQxAAyebmPjEkTJHv/Dl
         wdxdNFbg4JedkjQ86b3v3faeTLcv8m27wFsFhOatyq0ylogiODk/xmCMPgjX7vzczkGq
         EyBW9mqCSIzSOV+FOPmbjj0stXmMnSwx4RSF+G6GUVAmL7tl2VVsuoHYSJ8RzMYCQgQn
         qRNt33XBKZ1BUaVhSEH80WYT1MMShWbg6MA3MeXjBE/Q+xPWucWNqnS1tajatW1bDOhm
         ETBu3lT/+BrgmtICn7ALILSz+4e8xD0mZcNCF3Rf9zoNK/TN/jhB7JDxXV0XZgmZmKSs
         PLFA==
X-Gm-Message-State: AOJu0YzU+HxEIx6MZMTE5g8UVHxut+wL4tI2mCrW9Jm7hO2+Qk5tTG7e
        JOc1/ToQLdfvkwUqqi0ydXYRuBtIhpKYmj+L9MM=
X-Google-Smtp-Source: AGHT+IGyZ1MVJbpF5QMDxLNeNlkaL79u3htakyAB6E9jsA5aoQ8faIPkDh3Pm0do6EH90LCTcQ3f/g==
X-Received: by 2002:a05:622a:1389:b0:41e:1d15:69a6 with SMTP id o9-20020a05622a138900b0041e1d1569a6mr28803241qtk.31.1701374943507;
        Thu, 30 Nov 2023 12:09:03 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id c7-20020ac86e87000000b0041cb8947ed2sm786258qtv.26.2023.11.30.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:09:03 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        pasha.tatashin@soleen.com, alex.williamson@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vfio: account iommu allocations
Date:   Thu, 30 Nov 2023 20:09:00 +0000
Message-ID: <20231130200900.2320829-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/vfio/vfio_iommu_type1.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

This patch is spinned of from the series:
https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index eacd6ec04de5..b2854d7939ce 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1436,7 +1436,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
 				npage << PAGE_SHIFT, prot | IOMMU_CACHE,
-				GFP_KERNEL);
+				GFP_KERNEL_ACCOUNT);
 		if (ret)
 			goto unwind;
 
@@ -1750,7 +1750,8 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 			}
 
 			ret = iommu_map(domain->domain, iova, phys, size,
-					dma->prot | IOMMU_CACHE, GFP_KERNEL);
+					dma->prot | IOMMU_CACHE,
+					GFP_KERNEL_ACCOUNT);
 			if (ret) {
 				if (!dma->iommu_mapped) {
 					vfio_unpin_pages_remote(dma, iova,
@@ -1845,7 +1846,8 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain, struct list_head *
 			continue;
 
 		ret = iommu_map(domain->domain, start, page_to_phys(pages), PAGE_SIZE * 2,
-				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE,
+				GFP_KERNEL_ACCOUNT);
 		if (!ret) {
 			size_t unmapped = iommu_unmap(domain->domain, start, PAGE_SIZE);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

