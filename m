Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E27D9B85
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346071AbjJ0Oed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbjJ0Oeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:34:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62DC4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:34:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f61312eso16781045e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698417267; x=1699022067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEPgDTMpIXvshpOSSpINtGH8/u8zbO38mo5vAWcHcCQ=;
        b=H18pUSVj/grz+Rh752v5d+wojcXm2kkbTVewsVY06pyHeReHXkvMreUxlTFeBTQfjv
         8XSTZAPK43/ZrpERlV7oKnTcBn7CWVF6Jh7O4ghraMtK+vz1UmtYWsx40+JFOursBju3
         pjkdqSq139hIKPYp8dcTzIP5i1gEFAC1D+jBynePL4wO45MepRaOqegle0zgbMKDdwt3
         TIJLMmfjM6BJeMPctOVkTr5wGdg86td0tGBAJupZvxOsrW8YkyZm+EYpyYl2X7yciWn3
         k/w/eKxT/1mhal6ChBfHDwsZ5L4XAThym0+ta+c8Oh6IiXMPLXejMh1k4vOKPVvVbxyz
         En/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698417267; x=1699022067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEPgDTMpIXvshpOSSpINtGH8/u8zbO38mo5vAWcHcCQ=;
        b=VBPd24rL6tq3L7rPQB5IJfaN9rqxhDBZZv2bQsRNER0nDlLR7oVFPueZm2n6cHZbAo
         Hkf/USWm4L8Hi2ysxleYMWmiAFDrcvtDD7UyXlSsEfbPKFf9CAovefmWU/gBR7yh8g+C
         X3Kd2gvrpBafogbiy36N177+TGcQtaG2HRP0t2hSjRjL4R4hGJczX6sEysw6YXYlfyCI
         A6iZnWnut272g38RvGz900yqRuEQSFhnKl2Qt3TYX1A3c5KWeEk81SNXraAhx+Qj65tn
         +8IdPLl0SAhEKpf4kGcy62Er2MZIcVrmMLS5c7wJrMyiUEY6Meb51nzyeTPLMssmYljI
         1JFQ==
X-Gm-Message-State: AOJu0YzResH8YsCu6YDVcPyS5qIxgvecsQTcp+GPIl/ic2p0b23SeUxM
        lPMybK/pAG+xxiiMe5LHtL8AnQ==
X-Google-Smtp-Source: AGHT+IGgXhMWzVbY/CI1TaL9qhKqjFE/Gtm74EQrOTMgbMpUh3znTT8LX3bbvZgg/wy8HLgfxYChcQ==
X-Received: by 2002:a05:600c:45ca:b0:408:4f5d:eeb2 with SMTP id s10-20020a05600c45ca00b004084f5deeb2mr2609822wmo.20.1698417267289;
        Fri, 27 Oct 2023 07:34:27 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b004090798d29csm1784097wmo.15.2023.10.27.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:34:27 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 1/2] riscv: Don't use PGD entries for the linear mapping
Date:   Fri, 27 Oct 2023 16:32:21 +0200
Message-Id: <20231027143222.115588-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231027143222.115588-1-alexghiti@rivosinc.com>
References: <20231027143222.115588-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagating changes at this level is cumbersome as we need to go through
all the page tables when that happens (either when changing the
permissions or when splitting the mapping).

Note that this prevents the use of 4MB mapping for sv32 and 1GB mapping for
sv39 in the linear mapping.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0798bd861dcb..6dc61d3c392f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -664,16 +664,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
 				      phys_addr_t size)
 {
-	if (!(pa & (PGDIR_SIZE - 1)) && !(va & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
-		return PGDIR_SIZE;
-
-	if (!(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
+	if (pgtable_l5_enabled &&
+	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
 		return P4D_SIZE;
 
-	if (!(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
+	if (pgtable_l4_enabled &&
+	    !(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= PUD_SIZE)
 		return PUD_SIZE;
 
-	if (!(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
+	if (IS_ENABLED(CONFIG_64BIT) &&
+	    !(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
-- 
2.39.2

