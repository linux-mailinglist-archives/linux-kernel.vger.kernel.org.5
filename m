Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63315803B7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjLDR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjLDR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:27:03 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDBCFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:27:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3f951af5aso51937347b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701710829; x=1702315629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhY7K21fTuleJoRqinTH8FQOk8orwGh5uZOpWymHf1Q=;
        b=WzGYea8n8gKWhOwUN/QBnPZuZ64gGSovVSoWBoiu4lbkEjmhix1LpnW/02s19SFZrU
         QMVFdWKaxmPZunHSypbzY+U7yR2JTPyA41Cbhk3LyKYudi8ww5ybiC3hT+8dLtwBDuQq
         Qg74t1rFE9TL1mv3NkTfGz2vK3NybbXMukI32VwczFC2vBgCRWOjUSHMYJs+emm/e3nO
         xJFhfR5/0+lQmbwE/Uo0mGt4fp6L7vE/lQzYwMNzQTTLWdUS1e4TAi4krkOISbwofcZg
         mKe0cT4CAIz81vMLSxpK8K8AUvk5aMUMSlTkMo+6raEgYH+8Z5D8apajVYlCQjqmzIDZ
         9+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710829; x=1702315629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhY7K21fTuleJoRqinTH8FQOk8orwGh5uZOpWymHf1Q=;
        b=gRPyqFiFL/MxV/JjRMpo7MxeOT5auYFD5roBdq2tOlXx2A2NiTEAzuDD7Yizdg7/1c
         B4gyLvFJil2qn6PSudch586cMuDk1Ub6F7Z8ppxQMtOds1hEEX4M1dOQwqjoCrRTii9o
         v26hxz0Zi/CfcH/S2xPJUm1ZhrJdRMAU9rVJ/5kVY6mk+B1KYIblKJt3jJ9qpQ3aI+PH
         jLmruS9adutV96JJGhRknkXXKpFlO1GYQBw9qOoXo/UX0aXlRVfZxO0V33IEFGozhudm
         4RKzOpgFgteEWhwkbzBkliNc1utIX7udem0tqEq9yJny/ndRno7SgaKc0khjd6vQzobo
         TZ0g==
X-Gm-Message-State: AOJu0Yy77gQP8aJvSeM/Rd3sGPPzcQIbYQ/AWZWX40RiJXg9+L9T3n7Z
        X1b8oQmhju/2uXrgCElTxnF3p0JctX67X3o0
X-Google-Smtp-Source: AGHT+IEhvePiHl3xyV55jaT6gG1N1cwFNsflp2+fj8EBDZAd96hh+3/YkVm099+dmC2eTTOXHiutCQyCzt5QJhnb
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:b61d:0:b0:5d3:84d4:eb35 with SMTP
 id u29-20020a81b61d000000b005d384d4eb35mr358241ywh.3.1701710828830; Mon, 04
 Dec 2023 09:27:08 -0800 (PST)
Date:   Mon,  4 Dec 2023 17:26:45 +0000
In-Reply-To: <20231204172646.2541916-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20231204172646.2541916-1-jthoughton@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204172646.2541916-2-jthoughton@google.com>
Subject: [PATCH 1/2] arm64: hugetlb: Distinguish between hw and sw dirtiness
 in __cont_access_flags_changed
From:   James Houghton <jthoughton@google.com>
To:     Steve Capper <steve.capper@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__cont_access_flags_changed was originally introduced to avoid making
unnecessary changes to the PTEs. Consider the following case: all the
PTEs in the contiguous group have PTE_DIRTY | PTE_RDONLY | PTE_WRITE,
and we are running on a system without HAFDBS.  When writing via these
PTEs, we will get a page fault, and hugetlb_fault will (rightly)
attempt to update the PTEs with PTE_DIRTY | PTE_WRITE, but, as both the
original PTEs and the new PTEs are pte_dirty(),
__cont_access_flags_changed prevents the pgprot update from occurring.

To avoid the page fault loop that we get ourselves into, distinguish
between hardware-dirty and software-dirty for this check. Non-contiguous
PTEs aren't broken in the same way, as we will always write a new PTE
unless the new PTE is exactly equal to the old one.

Fixes: 031e6e6b4e12 ("arm64: hugetlb: Avoid unnecessary clearing in huge_ptep_set_access_flags")
Signed-off-by: James Houghton <jthoughton@google.com>
Cc: <stable@vger.kernel.org>

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f5aae342632c..87a9564976fa 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -437,7 +437,10 @@ static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
 	for (i = 0; i < ncontig; i++) {
 		pte_t orig_pte = ptep_get(ptep + i);
 
-		if (pte_dirty(pte) != pte_dirty(orig_pte))
+		if (pte_sw_dirty(pte) != pte_sw_dirty(orig_pte))
+			return 1;
+
+		if (pte_hw_dirty(pte) != pte_hw_dirty(orig_pte))
 			return 1;
 
 		if (pte_young(pte) != pte_young(orig_pte))
-- 
2.43.0.rc2.451.g8631bc7472-goog

