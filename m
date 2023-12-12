Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB1B80F472
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376561AbjLLRWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376438AbjLLRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:22:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CAE8F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:22:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF92C433C7;
        Tue, 12 Dec 2023 17:22:37 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steve Capper <steve.capper@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: (subset) [PATCH 0/2] arm64: hugetlb: Fix page fault loop for sw-dirty/hw-clean contiguous PTEs
Date:   Tue, 12 Dec 2023 17:22:34 +0000
Message-Id: <170240171502.947884.1971452020621917745.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204172646.2541916-1-jthoughton@google.com>
References: <20231204172646.2541916-1-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 17:26:44 +0000, James Houghton wrote:
> It is currently possible for a userspace application to enter a page
> fault loop when using HugeTLB pages implemented with contiguous PTEs
> when HAFDBS is not available. This happens because:
> 1. The kernel may sometimes write PTEs that are sw-dirty but hw-clean
>    (PTE_DIRTY | PTE_RDONLY | PTE_WRITE).
> 2. If, during a write, the CPU uses a sw-dirty, hw-clean PTE in handling
>    the memory access on a system without HAFDBS, we will get a page
>    fault.
> 3. HugeTLB will check if it needs to update the dirty bits on the PTE.
>    For contiguous PTEs, it will check to see if the pgprot bits need
>    updating. In this case, HugeTLB wants to write a sequence of
>    sw-dirty, hw-dirty PTEs, but it finds that all the PTEs it is about
>    to overwrite are all pte_dirty() (pte_sw_dirty() => pte_dirty()),
>    so it thinks no update is necessary.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[2/2] arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify
      https://git.kernel.org/arm64/c/3c0696076aad

I only picked up the second patch and added the description from the
cover letter into the commit log.

-- 
Catalin

