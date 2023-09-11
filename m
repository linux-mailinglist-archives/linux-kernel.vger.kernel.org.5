Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8479BD61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbjIKWfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244061AbjIKTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:02:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D56AD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:02:27 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a63b2793ecso609846466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694458945; x=1695063745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3y2BGukH6url/m3nyh3PLmZ/imBVQiEyAeDipRiBwe0=;
        b=AN6YndW/Np2q2tcsDs/903LWHEL0+QOulH27K4irwcekwLVgq/DK61a036SIFmeeE4
         4uDRTrS7po/MoNAmAc4pfAITfyg9H/D29qEhBp5xPMEuZ+Jxlg+xhAlmvHh4Ym2Mn28J
         DEZRJyEXuzV2W+nMf9KO8UmHp1PY4hDOVh89QUQhEcfEKosmTXtSbCbxh6a75nB/TfNN
         GjnWpYVHeUHnUAwL2m+HJK28DAFWP9Fqkd1XHshMLvAGD1Pz2JhoENS0p85eHM/rr7Wl
         4eYX2b0ihywTLGOlUvhzwtNYNlBLjNLnwugqEQEXnHv+9fO4u3FeLLQBzNJy2zTOl2Yl
         EbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458945; x=1695063745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y2BGukH6url/m3nyh3PLmZ/imBVQiEyAeDipRiBwe0=;
        b=GJoR2bWDj2g3rDLqCSH9/jFn+gqNRdkpRuRTBLVXyp2MwrJq9c1s4zmsPz1fJshTuf
         OUvkT7scKTadetnjZLV7gKDYGdYn/wTXAVBQhKvxcVG64wpg40CicfMKhe4SpZXtCb9P
         QHBN/4DMSkgpzQT74TZndpCBJEgNg1ivRsod2vOvsxYaS0tWX6c5bprCe9CioFsfO7L7
         8eFysP2nrzYVN0ns/niIopmyc1vzszsc2G9SIRo51wXIAiTRiENO6kKgo+gRQLIE+qpt
         v1bKXRoKXDbqQqDmYeBfbU4gQH6XnDwzpEKm89zDCd/Rft87shCXxf8gsUvhgqPkuXhk
         tZFQ==
X-Gm-Message-State: AOJu0YxqWyURGAJm1DOhhO/9az1Z1kMuFzSOLE/VNq2vR0BFZ2J2q7eH
        15rplMwagushjchZnXlCaR0=
X-Google-Smtp-Source: AGHT+IFpgox4BFKnt0rNPbRceB2bQ3Z76YQCI6/Tvh13dhWuZo0yy8xGtqPL7TTMQCkN8A9GyXFFKg==
X-Received: by 2002:a17:906:2189:b0:99b:de31:6666 with SMTP id 9-20020a170906218900b0099bde316666mr8837593eju.22.1694458945409;
        Mon, 11 Sep 2023 12:02:25 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id re1-20020a170906d8c100b00993a37aebc5sm5697324ejb.50.2023.09.11.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:02:25 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] iommu/sun50i: Allow page sizes between 4K and 1M
Date:   Mon, 11 Sep 2023 21:02:18 +0200
Message-ID: <20230911190218.1758812-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While peripheral supports only 4K page sizes, we can easily emulate
support for bigger page sizes, up to 1M. This is done by making multiple
entries in map function or clearing multiple entries in unmap.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 49 +++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 74c5cb93e900..93077575d60f 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -95,6 +95,10 @@
 
 #define SPAGE_SIZE			4096
 
+#define SUN50I_IOMMU_PGSIZES		(SZ_4K | SZ_8K | SZ_16K | SZ_32K | \
+					 SZ_64K | SZ_128K | SZ_256K | \
+					 SZ_512K | SZ_1M)
+
 struct sun50i_iommu {
 	struct iommu_device iommu;
 
@@ -593,10 +597,12 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu = sun50i_domain->iommu;
-	u32 pte_index;
+	u32 pte_index, pages, i;
 	u32 *page_table, *pte_addr;
 	int ret = 0;
 
+	pages = size / SPAGE_SIZE;
+
 	page_table = sun50i_dte_get_page_table(sun50i_domain, iova, gfp);
 	if (IS_ERR(page_table)) {
 		ret = PTR_ERR(page_table);
@@ -604,18 +610,22 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	pte_index = sun50i_iova_get_pte_index(iova);
-	pte_addr = &page_table[pte_index];
-	if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
-		phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
-		dev_err(iommu->dev,
-			"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
-			&iova, &page_phys, &paddr, prot);
-		ret = -EBUSY;
-		goto out;
+	for (i = 0; i < pages; i++) {
+		pte_addr = &page_table[pte_index + i];
+		if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
+			phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
+
+			dev_err(iommu->dev,
+				"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
+				&iova, &page_phys, &paddr, prot);
+			ret = -EBUSY;
+			goto out;
+		}
+		*pte_addr = sun50i_mk_pte(paddr, prot);
+		paddr += SPAGE_SIZE;
 	}
 
-	*pte_addr = sun50i_mk_pte(paddr, prot);
-	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	sun50i_table_flush(sun50i_domain, &page_table[pte_index], pages);
 
 out:
 	return ret;
@@ -626,8 +636,10 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	phys_addr_t pt_phys;
+	u32 dte, pages, i;
 	u32 *pte_addr;
-	u32 dte;
+
+	pages = size / SPAGE_SIZE;
 
 	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
 	if (!sun50i_dte_is_pt_valid(dte))
@@ -636,13 +648,14 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 	pt_phys = sun50i_dte_get_pt_address(dte);
 	pte_addr = (u32 *)phys_to_virt(pt_phys) + sun50i_iova_get_pte_index(iova);
 
-	if (!sun50i_pte_is_page_valid(*pte_addr))
-		return 0;
+	for (i = 0; i < pages; i++)
+		if (!sun50i_pte_is_page_valid(pte_addr[i]))
+			return 0;
 
-	memset(pte_addr, 0, sizeof(*pte_addr));
-	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	memset(pte_addr, 0, sizeof(*pte_addr) * pages);
+	sun50i_table_flush(sun50i_domain, pte_addr, pages);
 
-	return SZ_4K;
+	return size;
 }
 
 static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -827,7 +840,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 }
 
 static const struct iommu_ops sun50i_iommu_ops = {
-	.pgsize_bitmap	= SZ_4K,
+	.pgsize_bitmap	= SUN50I_IOMMU_PGSIZES,
 	.device_group	= sun50i_iommu_device_group,
 	.domain_alloc	= sun50i_iommu_domain_alloc,
 	.of_xlate	= sun50i_iommu_of_xlate,
-- 
2.42.0

