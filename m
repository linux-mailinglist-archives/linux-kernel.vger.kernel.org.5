Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33DA7F3821
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjKUVUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjKUVUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:20:39 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6081D45;
        Tue, 21 Nov 2023 13:20:35 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ce5e76912aso38592095ad.2;
        Tue, 21 Nov 2023 13:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601635; x=1701206435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huLzv0PM0TYdV6aZ2lF/u0VoqugwXORYCB79pbYxdec=;
        b=mNFF3+SokYSSzvKY/avlzJ6uiXmE1rOhKUfVMA0fSHjyGvztuzBmuldSN3xrQg2kvf
         VM4Oc5RFmRWkos+kIIKNjMrQpe9cypAZeZ3R4rnIJw29uf3kFhP/EKAtCd223RPSKj02
         1oYDWGu4h2GJEq8dilXv9NF2ayUpWA2iTL0TN6foU4jlZDub8BszN5CjjmvxRGO6Y9Gx
         Y2t/X9mQwbHTXCckNAOafy6LkBNY9JfTe1yg2jfAB0nczEZZguWUJfzkcRLLxdnQ/xKr
         jD6SzKOoCZFGmc0O1GeCLeNHinOroNMIcZ5eDx1QYf6xjq3YBd4SkuBvFDytA0CBBC/9
         QlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601635; x=1701206435;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=huLzv0PM0TYdV6aZ2lF/u0VoqugwXORYCB79pbYxdec=;
        b=WPcQsQnMqJzRXlLARyFj9qhGHUR0QhuN34AANOioCSGbE9veRBha4l4yPZeE4lFGLx
         jEsgDP623BL6MZQUXZWn7RGUUrCMsutkmNtS3ywmWetRqnp8W3mLr3SbV5qkx+K5t6Mf
         IhjK9EVQ/6U1iX2loYoOhyZQNzlaq2yQLIBmQY5N1TjlBSNQ6ESQoqwV6Z3huc9nbfR0
         41YCXc6HzW6OC/5dKZU4UJkLMRdfAfYfGxKDgZH48GDbprbmKJzUBqVFG80+SNN5ipQ9
         geoNN9UTe1Brw/p7c2JB0FIADbyjJIF35Cf42V2nRwAJeyqYDemBU/7YeBgZfgN4Nujt
         CSRA==
X-Gm-Message-State: AOJu0YyPuDDZ4eA3A5piYosr5PgGeNgTHSzAiE3qA+GXOaKTy7LRh/Dp
        nDoRcO9F8O3R+ltVdlffJBc=
X-Google-Smtp-Source: AGHT+IGu3jcvDWzMmd2brW4AbNgRjSnITFzU3bEr293ek/NBxeKno17B5zHl10Y2Oi8nNIq+gnZz2g==
X-Received: by 2002:a17:902:b687:b0:1cf:6d46:9f2f with SMTP id c7-20020a170902b68700b001cf6d469f2fmr351299pls.48.1700601635304;
        Tue, 21 Nov 2023 13:20:35 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:35 -0800 (PST)
From:   mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        thomas.lendacky@amd.com, ardb@kernel.org, jroedel@suse.de,
        seanjc@google.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/8] x86/mm: Don't do a TLB flush if changing a PTE that isn't marked present
Date:   Tue, 21 Nov 2023 13:20:10 -0800
Message-Id: <20231121212016.1154303-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121212016.1154303-1-mhklinux@outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mhklinux@outlook.com>

The core function __change_page_attr() currently sets up a TLB flush if
a PTE is changed. But if the old value of the PTE doesn't include the
PRESENT flag, the PTE won't be in the TLB, so a flush isn't needed.

Avoid an unnecessary TLB flush by conditioning the flush on the old
PTE value including PRESENT.  This change improves the performance of
functions like set_memory_p() by avoiding the flush if the memory range
was previously all not present.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/pat/set_memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 8e19796e7ce5..d7ef8d312a47 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1636,7 +1636,10 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		 */
 		if (pte_val(old_pte) != pte_val(new_pte)) {
 			set_pte_atomic(kpte, new_pte);
-			cpa->flags |= CPA_FLUSHTLB;
+
+			/* If old_pte isn't present, it's not in the TLB */
+			if (pte_present(old_pte))
+				cpa->flags |= CPA_FLUSHTLB;
 		}
 		cpa->numpages = 1;
 		return 0;
-- 
2.25.1

