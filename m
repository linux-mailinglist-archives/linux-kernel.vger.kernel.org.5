Return-Path: <linux-kernel+bounces-160105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A68B392B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC5E1C20B76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19D2148843;
	Fri, 26 Apr 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7Ma5Tnn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA11482EB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139682; cv=none; b=VYfLjvvrNCy6XbNJjERdVfZk+K13yAQl3s7UQxLQsOw63+gcy8PSMVIPD18qcQ3UqRYdSoS7J5tqqmXXsWU6U2D4n8f3RJBs8kmu46no9hK3O5MOZyCVsxyjxgFZrbjh/EafZFisn0uAPnHOuXcvR50J2UOPwfljdi68lpOu5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139682; c=relaxed/simple;
	bh=KCGvinQ94pasaC0yesrfVS37dImELT/sByZcuALkkgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPtBZgXqMY0aGU4h7RFBEmyzZJCpqmNQ1zviU2Jh/hLBj6lujHH76OYzbROAxUr4aA7o7hn7i9y+FY55h26O7+kI68bdON28T9VKB3mhEsQ42mE3SqmPOVxiV7/4S2PRRbZW61fi/TAM+YYu0JwTN/zSWMJ+PSfrMVppwkoDs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7Ma5Tnn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714139679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WXzg55UNGF+ubjZE2+OFVJ9vlVX3fwUMCwPAWdRnKtI=;
	b=V7Ma5TnnVzYSzvOv9GyojJmNJjvEAVlll+xbpMqS9lt/kOnasaZJt6/fUY3XEmqR/H5UXo
	aIIx2JltwAPOOSlPskTXJP+j+3h99z1nhyyf4vAQvjdApJTy4ZDBdfdMEN3FZBlhk5kRvV
	XKYI+EueG6JrzBOMblt49m4yrv3W8B0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-Ey0ZawgWO0OwEILJifd8KA-1; Fri, 26 Apr 2024 09:54:37 -0400
X-MC-Unique: Ey0ZawgWO0OwEILJifd8KA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78f008cb479so3267185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139677; x=1714744477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXzg55UNGF+ubjZE2+OFVJ9vlVX3fwUMCwPAWdRnKtI=;
        b=HIVHCoSiQo8l/7DiwbxBoxcstbvWoJr5l9xV2ek3Zrf/y0cjEQHxM/xtP/rxXg4+e6
         5Vxy4+Z1zx7NtaiNlm0KVCQhxlSZKdg7XHbuKCfvJzk3iFAsgPsQ/TR8N0COk7xnQnNt
         Co9YZu+7lkKkSs/ggT2CRkMnzJ8tzhbXYnyATBHmS/DIk8zFkBQ7op0Iy3TeXHF3DvCL
         6SdRMnXJLDZbBjA/jOVyNM3Jm12IanSITfExajoV8c84yhe5gA0PENlAY385ligeLMyN
         rhUfVveq9PYHmWNK/9meU4A2Lc/kdcGuI8ILGflKPDxD/3+wZaPNGUU9xE3vbFBq/Wln
         nJow==
X-Forwarded-Encrypted: i=1; AJvYcCWUzYVpPhfD3VulEUS9gm33lwg5ystq3sQHL4zgrXGBfSmB+r/Z7euuhbVQ+h0Ad+bXEoPibbnAaQELiRELs3Hbw1JQUHx1Thm/WB1w
X-Gm-Message-State: AOJu0YwvjgWnB0FvEBVwR3jm/NN2Q8+V2wbfYNa4Wy45dYC5mkU4uZMG
	6ND6AcI7jwfztYWAtNX2QJJX0m/lwClFKYy6Dij2aYilOipaitUYrzvr2vxNv5crXpS68lAkSBS
	rGnErQnbg2BrlZE9QJ4EdQ0f3tyTSyue/0eTKa0z59RZMQ1FHCXvjWbAla7UR0hbYOXQf7g==
X-Received: by 2002:a05:620a:1aaa:b0:790:98be:4cc9 with SMTP id bl42-20020a05620a1aaa00b0079098be4cc9mr2966485qkb.6.1714139676506;
        Fri, 26 Apr 2024 06:54:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVmEjzcMxKjM7Nh6FWEAWEijr1jAB0CV7Rmv1BMhzxskt4GL/bzsE7DJkfbgEV3HMrnwlhvA==
X-Received: by 2002:a05:620a:1aaa:b0:790:98be:4cc9 with SMTP id bl42-20020a05620a1aaa00b0079098be4cc9mr2966447qkb.6.1714139675859;
        Fri, 26 Apr 2024 06:54:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id m21-20020ae9e015000000b007908bd7a309sm2541679qkk.111.2024.04.26.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:54:35 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:54:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64/mm: Add uffd write-protect support
Message-ID: <ZiuyGXt0XWwRgFh9@x1n>
References: <20240424111017.3160195-1-ryan.roberts@arm.com>
 <20240424111017.3160195-3-ryan.roberts@arm.com>
 <Zijzrje2FDXsSojP@x1n>
 <e0fdf7b9-39d6-4eb3-b740-9c110b75182f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0fdf7b9-39d6-4eb3-b740-9c110b75182f@arm.com>

On Fri, Apr 26, 2024 at 02:17:41PM +0100, Ryan Roberts wrote:
> + Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Hi Peter, Muhammad,
> 
> 
> On 24/04/2024 12:57, Peter Xu wrote:
> > Hi, Ryan,
> > 
> > On Wed, Apr 24, 2024 at 12:10:17PM +0100, Ryan Roberts wrote:
> >> Let's use the newly-free PTE SW bit (58) to add support for uffd-wp.
> >>
> >> The standard handlers are implemented for set/test/clear for both pte
> >> and pmd. Additionally we must also track the uffd-wp state as a pte swp
> >> bit, so use a free swap entry pte bit (3).
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > 
> > Looks all sane here from userfault perspective, just one comment below.
> > 
> >> ---
> >>  arch/arm64/Kconfig                    |  1 +
> >>  arch/arm64/include/asm/pgtable-prot.h |  8 ++++
> >>  arch/arm64/include/asm/pgtable.h      | 55 +++++++++++++++++++++++++++
> >>  3 files changed, 64 insertions(+)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 7b11c98b3e84..763e221f2169 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -255,6 +255,7 @@ config ARM64
> >>  	select SYSCTL_EXCEPTION_TRACE
> >>  	select THREAD_INFO_IN_TASK
> >>  	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
> >> +	select HAVE_ARCH_USERFAULTFD_WP if USERFAULTFD
> >>  	select TRACE_IRQFLAGS_SUPPORT
> >>  	select TRACE_IRQFLAGS_NMI_SUPPORT
> >>  	select HAVE_SOFTIRQ_ON_OWN_STACK
> >> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> >> index ef952d69fd04..f1e1f6306e03 100644
> >> --- a/arch/arm64/include/asm/pgtable-prot.h
> >> +++ b/arch/arm64/include/asm/pgtable-prot.h
> >> @@ -20,6 +20,14 @@
> >>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
> >>  #define PTE_PROT_NONE		(PTE_UXN)		 /* Reuse PTE_UXN; only when !PTE_VALID */
> >>  
> >> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> >> +#define PTE_UFFD_WP		(_AT(pteval_t, 1) << 58) /* uffd-wp tracking */
> >> +#define PTE_SWP_UFFD_WP		(_AT(pteval_t, 1) << 3)	 /* only for swp ptes */
> 
> I've just noticed code in task_mmu.c:
> 
> static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> 				  unsigned long end, struct mm_walk *walk)
> {
> 	...
> 
> 	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
> 	    p->arg.category_mask == PAGE_IS_WRITTEN &&
> 	    p->arg.return_mask == PAGE_IS_WRITTEN) {
> 		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
> 			unsigned long next = addr + PAGE_SIZE;
> 
> 			if (pte_uffd_wp(ptep_get(pte))) <<<<<<
> 				continue;
> 
> 			...
> 		}
> 	}
> }
> 
> As far as I can see, you don't know that the pte is present when you do this. So
> does this imply that the UFFD-WP bit is expected to be in the same position for
> both present ptes and swap ptes? I had assumed pte_uffd_wp() was for present
> ptes and pte_swp_uffd_wp() was for swap ptes.
> 
> As you can see, the way I've implemented this for arm64 the bit is in a
> different position for these 2 cases. I've just done a slightly different
> implementation that changes the first patch in this series quite a bit and a
> bunch of pagemap_ioctl mm kselftests are now failing. I think this is the root
> cause, but haven't proven it definitively yet.
> 
> I'm inclined towords thinking the above is a bug and should be fixed so that I
> can store the bit in different places. What do you think?

Yep I agree.

Even on x86_64 they should be defined differently.  It looks like some
sheer luck the test constantly pass on x86 even if it checked the wrong one.

Worth checking all the relevant paths in the pagemap code to make sure it's
checked, e.g. I also see one fast path above this chunk of code which looks
like to have the same issue.

Thanks,

-- 
Peter Xu


