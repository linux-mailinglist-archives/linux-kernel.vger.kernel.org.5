Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F73C7DFC77
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377497AbjKBWhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKBWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:37:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC9B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:37:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc68c1fac2so12968215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698964625; x=1699569425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqRhvait8VVatqN/i/IJY8Kth48ACusoSG4fYjp7jjA=;
        b=B6FUlkuGlYdRjkbRtH0xPg1xH3GBO1fZFMvfnn7xYFcdU424WN3JSiFxKD8t6P0QE2
         k2xirnl6pcArWOFtR8vA9hsImbcOyW+ATz/B7jsUVJAlnDtDqOAELUBrm5V0zqlnwC55
         az/J1GrYL3cxPFEOvqngIjutn+huzsGfhAJ0ydLt+nSE1AyKte4GwKhytbZNUdu2CJq0
         A2PHgVP6ks9MXIkL3MAezZaln9fJhC7uYqMwFhKG25PimQubCz7G7PdmEgsMPcUDQ7MU
         jWJMXrBFRBfbqerXssPuWSqUQAzmt27XTZdIx45OoLqzNXX4TrnCmceXQNvDcnjakSqC
         B8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698964625; x=1699569425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqRhvait8VVatqN/i/IJY8Kth48ACusoSG4fYjp7jjA=;
        b=qp/qZ5xZRN0tJiwFxZYBqgvTpCAweyrD/ohW0GWnn/omatf3RziS9JTb3o4FWOBqWa
         jfWjo/6OZD8fCU9J24U1EDbJwa376Ak4NscvTgl9491xXG+toL5wHzexJgn+y6IPSOfH
         Y+mDjjdHesRmHnNFHq1F/ospOlbMdC9WQneDb8s5/waB64I+1eryCH/L2sQWFmsZLEOg
         toZDN8u0HLySJ2z9I2OAw2mdYMHOGi+ZhlbCiMXxXcyojbNLpBBglxem6sN5RqCUUwzV
         rJd9OcbCS3Q/NZ518kyclZYbcyDtRVQbQmqTHDh5QofUpXLk4UWRfwSudaoUjthjDDUM
         F5yg==
X-Gm-Message-State: AOJu0Yw4DMqYHWj8uKi6NbFkEjA18fpxKUB5T+ahsSTZbJ2feOIDzyj2
        sCg2JygreMuYV1M+y2XvTA5R3T0Gix7o+A==
X-Google-Smtp-Source: AGHT+IEgVP5cjcRzbC4ztZzoaVxnj9qdf9nwpAaWIm/B9bsNXUnV6CI8AVZDK6qMsBaf5tntW//ZHA==
X-Received: by 2002:a17:902:cf41:b0:1ca:8252:a91 with SMTP id e1-20020a170902cf4100b001ca82520a91mr21901200plg.41.1698964625104;
        Thu, 02 Nov 2023 15:37:05 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e722:b6da:dbb3:53e3])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001c611e9a5fdsm188097plf.306.2023.11.02.15.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 15:37:04 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     ryan.roberts@arm.com
Cc:     21cnbao@gmail.com, Steven.Price@arm.com, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@suse.com, shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
Date:   Fri,  3 Nov 2023 11:36:43 +1300
Message-Id: <20231102223643.7733-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <73aad98e-de4c-4021-af3c-db67e06cdb70@arm.com>
References: <73aad98e-de4c-4021-af3c-db67e06cdb70@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But, yes, it would be nice to fix that! And if I've understood the proble=
m=0D
> correctly, it doesn't sound like it should be too hard? Is this something=
 you=0D
> are volunteering for?? :)=0D
=0D
Unfornately right now I haven't a real hardware with MTE which can run the =
latest=0D
kernel. but i have written a RFC, it will be nice to get someone to test it=
. Let=0D
me figure out if we can get someone :-)=0D
=0D
[RFC PATCH] arm64: mm: swap: save and restore mte tags for large folios=0D
=0D
This patch makes MTE tags saving and restoring support large folios,=0D
then we don't need to split them into base pages for swapping on=0D
ARM64 SoCs with MTE.=0D
=0D
---=0D
 arch/arm64/include/asm/pgtable.h | 21 ++++-----------------=0D
 arch/arm64/mm/mteswap.c          | 20 ++++++++++++++++++++=0D
 2 files changed, 24 insertions(+), 17 deletions(-)=0D
=0D
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgta=
ble.h=0D
index 7f7d9b1df4e5..b12783dca00a 100644=0D
--- a/arch/arm64/include/asm/pgtable.h=0D
+++ b/arch/arm64/include/asm/pgtable.h=0D
@@ -45,12 +45,6 @@=0D
 	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)=0D
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */=0D
 =0D
-static inline bool arch_thp_swp_supported(void)=0D
-{=0D
-	return !system_supports_mte();=0D
-}=0D
-#define arch_thp_swp_supported arch_thp_swp_supported=0D
-=0D
 /*=0D
  * Outside of a few very special situations (e.g. hibernation), we always=
=0D
  * use broadcast TLB invalidation instructions, therefore a spurious page=
=0D
@@ -1028,12 +1022,8 @@ static inline pmd_t pmdp_establish(struct vm_area_st=
ruct *vma,=0D
 #ifdef CONFIG_ARM64_MTE=0D
 =0D
 #define __HAVE_ARCH_PREPARE_TO_SWAP=0D
-static inline int arch_prepare_to_swap(struct page *page)=0D
-{=0D
-	if (system_supports_mte())=0D
-		return mte_save_tags(page);=0D
-	return 0;=0D
-}=0D
+#define arch_prepare_to_swap arch_prepare_to_swap=0D
+extern int arch_prepare_to_swap(struct page *page);=0D
 =0D
 #define __HAVE_ARCH_SWAP_INVALIDATE=0D
 static inline void arch_swap_invalidate_page(int type, pgoff_t offset)=0D
@@ -1049,11 +1039,8 @@ static inline void arch_swap_invalidate_area(int typ=
e)=0D
 }=0D
 =0D
 #define __HAVE_ARCH_SWAP_RESTORE=0D
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *foli=
o)=0D
-{=0D
-	if (system_supports_mte())=0D
-		mte_restore_tags(entry, &folio->page);=0D
-}=0D
+#define arch_swap_restore arch_swap_restore=0D
+extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);=0D
 =0D
 #endif /* CONFIG_ARM64_MTE */=0D
 =0D
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c=0D
index a31833e3ddc5..e5637e931e4f 100644=0D
--- a/arch/arm64/mm/mteswap.c=0D
+++ b/arch/arm64/mm/mteswap.c=0D
@@ -83,3 +83,23 @@ void mte_invalidate_tags_area(int type)=0D
 	}=0D
 	xa_unlock(&mte_pages);=0D
 }=0D
+=0D
+int arch_prepare_to_swap(struct page *page)=0D
+{=0D
+	if (system_supports_mte()) {=0D
+		struct folio *folio =3D page_folio(page);=0D
+		long i, nr =3D folio_nr_pages(folio);=0D
+		for (i =3D 0; i < nr; i++)=0D
+			return mte_save_tags(folio_page(folio, i));=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+void arch_swap_restore(swp_entry_t entry, struct folio *folio)=0D
+{=0D
+	if (system_supports_mte()) {=0D
+		long i, nr =3D folio_nr_pages(folio);=0D
+		for (i =3D 0; i < nr; i++)=0D
+			mte_restore_tags(entry, folio_page(folio, i));=0D
+	}=0D
+}=0D
-- =0D
2.25.1=0D
=0D
> Thanks,=0D
> Ryan=0D
=0D
Barry=0D
