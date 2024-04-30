Return-Path: <linux-kernel+bounces-164559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC08B7F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9C0B21605
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6DF18133F;
	Tue, 30 Apr 2024 17:57:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33D180A6E;
	Tue, 30 Apr 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499877; cv=none; b=Yb0OpG+fr+PkNh1+T42210qtSmd+mMzLDoQxTN8iekKwa7JFghd8VdTe4IAxKbUaKo4rnsuz5Ri3tLgAdyRagXt4hMdHA9ERxLBjtTr9anA1GIfyyJh/OXisE81urVySW+zsGCF9x5BN+M6B8vNERfBDC+r+0TAQ6BZDBRWoYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499877; c=relaxed/simple;
	bh=1mnPuEmB9SM0+xUMK/nXa6i0m18KSVJYhpah7UrSo28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BapmO/JR+c1AB02CDN6rs414iHCKM+dPUkkBcwkLfsIuOgmtjZjW/LhcY8a6Ok4q30+6+7q14gTy/O9YQQA5HCEa0jfZxj9UEi34/9ASJHtzUAGrWgqS3DR6BDCmS3EEczW84r3d6/br30lC75VPZODq/EsFpFSIJc9Kmacg8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E97C2BBFC;
	Tue, 30 Apr 2024 17:57:54 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Date: Tue, 30 Apr 2024 18:57:52 +0100
Message-Id: <171449974870.639201.3165060270571039049.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430133138.732088-1-ryan.roberts@arm.com>
References: <20240430133138.732088-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Apr 2024 14:31:38 +0100, Ryan Roberts wrote:
> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry. It calls pmdp_invalidate()
> unconditionally on the pmdp and only determines if it is present or not
> based on the returned old pmd.
> 
> But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
> unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
> pmd_present() calls to return true - even for a swap pmd. Therefore any
> lockless pgtable walker could see the migration entry pmd in this state
> and start interpretting the fields (e.g. pmd_pfn()) as if it were
> present, leading to BadThings (TM). GUP-fast appears to be one such
> lockless pgtable walker.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks! It should land in 6.9-rc7. I
removed the debug/test code, please send it as a separate patch for
6.10.

[1/1] arm64/mm: pmd_mkinvalid() must handle swap pmds
      https://git.kernel.org/arm64/c/e783331c7720

-- 
Catalin


