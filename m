Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C397FB3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344062AbjK1ISA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1IR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:17:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAADEB0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:18:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cf8c462766so36842155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701159484; x=1701764284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avri5+l4jh4I23MBWhAH2OdfRZsJMW+CaKeEjn0D5Uc=;
        b=HKnaZyXomxMX0CYpvmFHQP+5llu0mo+S91tmCdhifRA3RxhEtZviqjOqz1nl+3GF71
         /ibxDtCY0wsC52Z8kdgyOmcpdGOOzXv/FPSOgINLxS9dAIh2htvtNMi2mKxMnK4Vux9Y
         +4XfK98sMMNNo0YFJe6Fdg2WGfxJNaTOUeeOdJyKqxQNLZMREYpcDiY76iFdGUHDR3AA
         sgj1NQOINDR0KTTUAuc4rEhD3OXVavJLRUO+aDfsN3FpbGwfc+gUrlVpfE55oadlnO+Z
         0+cusVdkqg7UHxIF01ZXL5xgCVsmI9hFu8KT94ojkKbpGqEcCZpIi+aej4x8JGhicSTX
         +MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701159484; x=1701764284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avri5+l4jh4I23MBWhAH2OdfRZsJMW+CaKeEjn0D5Uc=;
        b=LuZ0Kwu4QS5NMpfYTj1sx08usdjwNHPrY1nk7X6g6lF0PQkGgXCzaNS/dL37SoGfDD
         tnvxPSmzYNGgbEiTjInOGI+zsSNOmhecyMOZsPfF32BkqJ+BOdKOuMMv0IgfySS7SSF8
         Y4vgVDHAhrH6IzB23ZJhCK+Vrnne9HCKg4PCc2vRCB19Amf1RKsh38vc7QjYY8gtelGn
         DB4t2dIQ+ReRvh1ZY9V30NcWFI7aGS4ANiyUh8CfUWhkU7Xsf7RUS+tglcNWDOSpEeXL
         QixhYeMmUp6NFoFel+8R56uCO476RHki9h9Dsh3s6GTUjKffKENTrLoI03Tjy1qOSIL+
         N+zQ==
X-Gm-Message-State: AOJu0YzkpV6yT2CHanEqNQCnuSQHCFb0oIr8OAH9zZNvmgcrMbeQopFk
        BboOg5QkbEWF0A4njBOBdrA=
X-Google-Smtp-Source: AGHT+IHg5I/Ci0iCDZnbxkvP6wNr9HbmrpJG8sakGeJnQdcAnq4ez+i1YbJ3DGIkY3W0SdSQ+FYcFQ==
X-Received: by 2002:a17:903:246:b0:1cf:b29d:3e8e with SMTP id j6-20020a170903024600b001cfb29d3e8emr10213348plh.58.1701159484095;
        Tue, 28 Nov 2023 00:18:04 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:6e62:da63:8968:8aec])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b001cfcc10491fsm3628891plz.161.2023.11.28.00.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:18:03 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     ryan.roberts@arm.com
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
Date:   Tue, 28 Nov 2023 21:17:42 +1300
Message-Id: <20231128081742.39204-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163018.1303287-15-ryan.roberts@arm.com>
References: <20231115163018.1303287-15-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
> +					unsigned long addr, pte_t *ptep)
> +{
> +	/*
> +	 * When doing a full address space teardown, we can avoid unfolding the
> +	 * contiguous range, and therefore avoid the associated tlbi. Instead,
> +	 * just get and clear the pte. The caller is promising to call us for
> +	 * every pte, so every pte in the range will be cleared by the time the
> +	 * tlbi is issued.
> +	 *
> +	 * This approach is not perfect though, as for the duration between
> +	 * returning from the first call to ptep_get_and_clear_full() and making
> +	 * the final call, the contpte block in an intermediate state, where
> +	 * some ptes are cleared and others are still set with the PTE_CONT bit.
> +	 * If any other APIs are called for the ptes in the contpte block during
> +	 * that time, we have to be very careful. The core code currently
> +	 * interleaves calls to ptep_get_and_clear_full() with ptep_get() and so
> +	 * ptep_get() must be careful to ignore the cleared entries when
> +	 * accumulating the access and dirty bits - the same goes for
> +	 * ptep_get_lockless(). The only other calls we might resonably expect
> +	 * are to set markers in the previously cleared ptes. (We shouldn't see
> +	 * valid entries being set until after the tlbi, at which point we are
> +	 * no longer in the intermediate state). Since markers are not valid,
> +	 * this is safe; set_ptes() will see the old, invalid entry and will not
> +	 * attempt to unfold. And the new pte is also invalid so it won't
> +	 * attempt to fold. We shouldn't see this for the 'full' case anyway.
> +	 *
> +	 * The last remaining issue is returning the access/dirty bits. That
> +	 * info could be present in any of the ptes in the contpte block.
> +	 * ptep_get() will gather those bits from across the contpte block. We
> +	 * don't bother doing that here, because we know that the information is
> +	 * used by the core-mm to mark the underlying folio as accessed/dirty.
> +	 * And since the same folio must be underpinning the whole block (that
> +	 * was a requirement for folding in the first place), that information
> +	 * will make it to the folio eventually once all the ptes have been
> +	 * cleared. This approach means we don't have to play games with
> +	 * accumulating and storing the bits. It does mean that any interleaved
> +	 * calls to ptep_get() may lack correct access/dirty information if we
> +	 * have already cleared the pte that happened to store it. The core code
> +	 * does not rely on this though.

even without any other threads running and touching those PTEs, this won't survive
on some hardware. we expose inconsistent CONTPTEs to hardware, this might result
in crashed firmware even in trustzone, strange&unknown faults to trustzone we have
seen on Qualcomm, but for MTK, it seems fine. when you do tlbi on a part of PTEs
with dropped CONT but still some other PTEs have CONT, we make hardware totally
confused.

zap_pte_range() has a force_flush when tlbbatch is full:

                        if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
                                force_flush = 1; 
                                addr += PAGE_SIZE;
                                break;
                        }

this means you can expose partial tlbi/flush directly to hardware while some
other PTEs are still CONT.

on the other hand, contpte_ptep_get_and_clear_full() doesn't need to depend
on fullmm, as long as zap range covers a large folio, we can flush tlbi for
those CONTPTEs all together in your contpte_ptep_get_and_clear_full() rather
than clearing one PTE.

Our approach in [1] is we do a flush for all CONTPTEs and go directly to the end
of the large folio:

#ifdef CONFIG_CONT_PTE_HUGEPAGE
			if (pte_cont(ptent)) {
				unsigned long next = pte_cont_addr_end(addr, end);

				if (next - addr != HPAGE_CONT_PTE_SIZE) {
					__split_huge_cont_pte(vma, pte, addr, false, NULL, ptl);
					/*
					 * After splitting cont-pte
					 * we need to process pte again.
					 */
					goto again_pte;
				} else {
					cont_pte_huge_ptep_get_and_clear(mm, addr, pte);

					tlb_remove_cont_pte_tlb_entry(tlb, pte, addr);
					if (unlikely(!page))
						continue;

					if (is_huge_zero_page(page)) {
						tlb_remove_page_size(tlb, page, HPAGE_CONT_PTE_SIZE);
						goto cont_next;
					}

					rss[mm_counter(page)] -= HPAGE_CONT_PTE_NR;
					page_remove_rmap(page, true);
					if (unlikely(page_mapcount(page) < 0))
						print_bad_pte(vma, addr, ptent, page);

					tlb_remove_page_size(tlb, page, HPAGE_CONT_PTE_SIZE);
				}
cont_next:
				/* "do while()" will do "pte++" and "addr + PAGE_SIZE" */
				pte += (next - PAGE_SIZE - (addr & PAGE_MASK))/PAGE_SIZE;
				addr = next - PAGE_SIZE;
				continue;
			}
#endif

this is our "full" counterpart, which clear_flush CONT_PTES pages directly, and
it never requires tlb->fullmm at all.

static inline pte_t __cont_pte_huge_ptep_get_and_clear_flush(struct mm_struct *mm,
				       unsigned long addr,
				       pte_t *ptep,
				       bool flush)
{
	pte_t orig_pte = ptep_get(ptep);

	CHP_BUG_ON(!pte_cont(orig_pte));
	CHP_BUG_ON(!IS_ALIGNED(addr, HPAGE_CONT_PTE_SIZE));
	CHP_BUG_ON(!IS_ALIGNED(pte_pfn(orig_pte), HPAGE_CONT_PTE_NR));

	return get_clear_flush(mm, addr, ptep, PAGE_SIZE, CONT_PTES, flush);
}

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L1539

> +	 */
> +
> +	return __ptep_get_and_clear(mm, addr, ptep);
> +}
> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
> +

Thanks
Barry


