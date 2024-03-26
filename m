Return-Path: <linux-kernel+bounces-119014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5206388C2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F941C3FD43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32256D1D7;
	Tue, 26 Mar 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9PmjWXA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1828E8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457657; cv=none; b=liEYawF8A3ZUgBtRq4hb2DHLrI3kyf8EzInOkuSTI1M7yLVa6vIxrvejcfLagW/zyRdrvGBXMRThpqLbVQF0eKTCa3Gh91/GLkAzTcuvBFVgATi7Bh0R+TCPNuBtkkR2V6o8QuIRBjhLezRX8tTp573bOSpO1pnP3MTlC5O/+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457657; c=relaxed/simple;
	bh=HANE9Ck98nA4yLDO1qZtV2vsNr/fyY+1mdplJg0Nl0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd+7KAAg5YPPE5WPQVBj38eDfoi6HxlajVgAKE2+9DeY4OojurAXPI6FH16RvepyLFczc2HjDP6SjxhVO6fm8562NsiqrbSWpzr4H9eKUPDY98CBrBgJqYBNxK2q9gMrF2pxDGGTJRyQDekMKG20xE6OnLg/TYpyOm7Uj9QcKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9PmjWXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEEBC433C7;
	Tue, 26 Mar 2024 12:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711457656;
	bh=HANE9Ck98nA4yLDO1qZtV2vsNr/fyY+1mdplJg0Nl0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9PmjWXAuvpNf0kNeIJ0S0w4XhOn94evh/3pN3bRrDW2/KVo+R51sJ3qo5GE1elZP
	 f5Wkxt40uLV+bjhEf0PkwctDFfveSWI+k/otPA46eBO8agrwarzJp8aAWAIhNzOiH1
	 2qUZyC9O+TrOvy/J4jEajfH8bBlf3sHoq3vit2j/x8qWEI5CFIuBzIarSvh5ptim1d
	 RZo4rEcaoxRcqSRs4k/PXDSRybpM7rH3VvtkgeHzhdbniaU7FwF5mocez2Foim4YXY
	 2xuI9jLgUvoLTYVVcO6/IRIwLpAuwQQJYx0FnEhVK9OOMYeMzaqMu5kV/da7HkDX+1
	 /RPLaXzvje0kA==
Date: Tue, 26 Mar 2024 12:54:10 +0000
From: Will Deacon <will@kernel.org>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: David Rientjes <rientjes@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Matthew Wilcox <willy@infradead.org>, muchun.song@linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	anshuman.khandual@arm.com, wangkefeng.wang@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Sourav Panda <souravpanda@google.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <20240326125409.GA9552@willie-the-truck>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <ZcN1hTrAhy-B1P2_@arm.com>
 <44075bc2-ac5f-ffcd-0d2f-4093351a6151@huawei.com>
 <20240208131734.GA23428@willie-the-truck>
 <f8a643a9-4932-9ba4-94f1-4bc88ee27740@google.com>
 <22c14513-af78-0f1d-5647-384ff9cb5993@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22c14513-af78-0f1d-5647-384ff9cb5993@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 25, 2024 at 11:24:34PM +0800, Nanyong Sun wrote:
> On 2024/3/14 7:32, David Rientjes wrote:
> > On Thu, 8 Feb 2024, Will Deacon wrote:
> > > > How about take a new lock with irq disabled during BBM, like:
> > > > 
> > > > +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
> > > > +{
> > > > +     (NEW_LOCK);
> > > > +    pte_clear(&init_mm, addr, ptep);
> > > > +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > > > +    set_pte_at(&init_mm, addr, ptep, pte);
> > > > +    spin_unlock_irq(NEW_LOCK);
> > > > +}
> > > I really think the only maintainable way to achieve this is to avoid the
> > > possibility of a fault altogether.
> > > 
> > Nanyong, are you still actively working on making HVO possible on arm64?
> > 
> > This would yield a substantial memory savings on hosts that are largely
> > configured with hugetlbfs.  In our case, the size of this hugetlbfs pool
> > is actually never changed after boot, but it sounds from the thread that
> > there was an idea to make HVO conditional on FEAT_BBM.  Is this being
> > pursued?
> > 
> > If so, any testing help needed?
> I'm afraid that FEAT_BBM may not solve the problem here, because from Arm
> ARM,
> I see that FEAT_BBM is only used for changing block size. Therefore, in this
> HVO feature,
> it can work in the split PMD stage, that is, BBM can be avoided in
> vmemmap_split_pmd,
> but in the subsequent vmemmap_remap_pte, the Output address of PTE still
> needs to be
> changed. I'm afraid FEAT_BBM is not competent for this stage. Perhaps my
> understanding
> of ARM FEAT_BBM is wrong, and I hope someone can correct me.
> Actually, the solution I first considered was to use the stop_machine
> method, but we have
> products that rely on /proc/sys/vm/nr_overcommit_hugepages to dynamically
> use hugepages,
> so I have to consider performance issues. If your product does not change
> the amount of huge
> pages after booting, using stop_machine() may be a feasible way.
> So far, I still haven't come up with a good solution.

Oh, I hadn't appreciated that you needed to remap the memmap live. How
do you synchronise the two copies in that case? I think we (i.e. the arch
folks) probably need some more explanation on exactly who can race with
what here, otherwise I don't grok how this can work.

Thanks,

Will

