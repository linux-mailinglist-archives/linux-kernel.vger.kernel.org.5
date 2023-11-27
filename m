Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06167F97E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjK0DSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0DS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:18:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC88F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:18:36 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-285bcb577d6so606838a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701055116; x=1701659916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YUVZSBDmlLkpRYuqko+WA+ovvBfJQ/Jtk/CFG14qI8=;
        b=iBE69FmsSIwigvAxTaDF9aShOFjnWDOOmc47UjLHO9s+iHHfGrdMwmaLfDs5SVcfu4
         lqhA2Tz9qLSezg41Xifh01KHOtaJLv4+z6hqYGgdrSfO30PYgvy3mQAQnBq/P29GPT7c
         RuXdW5Dw1zyNyx+1N9alzMRM7qeZy+KatGaFVU+tD93RvTQbls5Y0L8lm3MlxGAw7tI6
         8HhnEJ3FWlbtZRBFwqQrYrcfAhyWho3Dzy+w+rHud9GFtn1A+XiFaBMfJzBR9Iha5RmQ
         Q0+r26dScSz2z4XZEg2Jw7G3IMvC8z68Zl/UQ6VAGXV+UGhHd/kFV2HRVA+xy1Bb0Eu3
         LCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701055116; x=1701659916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YUVZSBDmlLkpRYuqko+WA+ovvBfJQ/Jtk/CFG14qI8=;
        b=JGyA6FW1jcznyVGAcWmmArtH2l35U5s+iflT6qGVvSpyitKFkxD7d5iLmLBCOuabsz
         NxPoZjicUYV3MRV1peZyNSm0rJG07h5HdAN9ZqjzsegXn4PoGX2eGWrO+fPaYfVpDmFs
         QmRinPe4p+RD/b5BGgBXoPZ8fbih+kk2CZxxuF+wG3i1kQ8ESoXvJVVthPmA+l1kp+lg
         fTB8MWkXBhj+5WpSXGouxII1HdclF70byD0fjQ3/Ll9j5qNtqGYkgXkJMOKzeAymsMcK
         t3eBLn0vB9YfIucQPccZoCl6gfHiy+UytmMA0VrXCI+v6RvipPDW7pUog1dUF62nEId4
         y7Cw==
X-Gm-Message-State: AOJu0YxERjyhZA5ibfUXHBJ91k1A+CJGg3GvQVakJ7xF8m9xyG2xPbdE
        ZvreF7du62h3JlptG5cn9Xg=
X-Google-Smtp-Source: AGHT+IGgMuZfPDZohj9ZVrdvknifQxFY6+QikEc0Y519BYWtXbBg+E6rR7Xu1UR37893FbvdQSU4Aw==
X-Received: by 2002:a17:90b:33d1:b0:285:dbc9:dc1e with SMTP id lk17-20020a17090b33d100b00285dbc9dc1emr410912pjb.2.1701055115718;
        Sun, 26 Nov 2023 19:18:35 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:a061:a5bd:f09d:c339])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b0027df6ff00eesm7178394pjj.19.2023.11.26.19.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 19:18:35 -0800 (PST)
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
Subject: Re: [PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings
Date:   Mon, 27 Nov 2023 16:18:13 +1300
Message-Id: <20231127031813.5576-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163018.1303287-1-ryan.roberts@arm.com>
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
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

> Ryan Roberts (14):
>   mm: Batch-copy PTE ranges during fork()
>   arm64/mm: set_pte(): New layer to manage contig bit
>   arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
>   arm64/mm: pte_clear(): New layer to manage contig bit
>   arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
>   arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
>   arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
>   arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
>   arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
>   arm64/mm: ptep_get(): New layer to manage contig bit
>   arm64/mm: Split __flush_tlb_range() to elide trailing DSB
>   arm64/mm: Wire up PTE_CONT for user mappings
>   arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
>   arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown

Hi Ryan,
Not quite sure if I missed something, are we splitting/unfolding CONTPTES
in the below cases

1. madvise(MADV_DONTNEED) on a part of basepages on a CONTPTE large folio

2. vma split in a large folio due to various reasons such as mprotect,
munmap, mlock etc.

3. try_to_unmap_one() to reclaim a folio, ptes are scanned one by one
rather than being as a whole.

In hardware, we need to make sure CONTPTE follow the rule - always 16
contiguous physical address with CONTPTE set. if one of them run away
from the 16 ptes group and PTEs become unconsistent, some terrible
errors/faults can happen in HW. for example

case0:
addr0 PTE - has no CONTPE
addr0+4kb PTE - has CONTPTE
....
addr0+60kb PTE - has CONTPTE

case 1:
addr0 PTE - has no CONTPE
addr0+4kb PTE - has CONTPTE
....
addr0+60kb PTE - has swap

Unconsistent 16 PTEs will lead to crash even in the firmware based on
our observation.

Thanks
Barry


