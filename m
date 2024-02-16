Return-Path: <linux-kernel+bounces-68582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9D857CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B784BB22F19
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72212A16C;
	Fri, 16 Feb 2024 12:35:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293F129A74
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086911; cv=none; b=LQxl8PUY9WPMvwSkxqIHB4geD1uxMVSnF4GfVSMFEKg+C4kYWFsggaxJv41MIfTm41vfGu72heoCtZASmT/PbKsbiSrwRXKL40MfXA7GIRo92g0XtHvdIBYlH/DlRNuIwKVk2r44t2spPAhsCiE9c5QBmfVHD5LTqCmtD8Rwh1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086911; c=relaxed/simple;
	bh=Pl4R/QWLLFRDsjgD9md2zsv8zdcqMfqx2HQS9GMeEz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRzqYMbAK/AR/xBI1c71A4uOuoCsV8C1t6Nh3oB2VpzaTrw40QBC6QXyayoT3qZAQIzdnjEu3DYnTgynJN7zmvQ9m6gYeV2qD7WY22GSGzU9Uu5y0OB28k0V+O0xaaiJp0yIDE9l5UMlG8/A1RiugBx0qmd5fs/WjB6owe+Fuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F79C43394;
	Fri, 16 Feb 2024 12:35:05 +0000 (UTC)
Date: Fri, 16 Feb 2024 12:35:03 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/18] arm64/mm: Automatically fold contpte mappings
Message-ID: <Zc9Wd0N03pPY5Nq5@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-19-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-19-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:32:05AM +0000, Ryan Roberts wrote:
> There are situations where a change to a single PTE could cause the
> contpte block in which it resides to become foldable (i.e. could be
> repainted with the contiguous bit). Such situations arise, for example,
> when user space temporarily changes protections, via mprotect, for
> individual pages, such can be the case for certain garbage collectors.
> 
> We would like to detect when such a PTE change occurs. However this can
> be expensive due to the amount of checking required. Therefore only
> perform the checks when an indiviual PTE is modified via mprotect
> (ptep_modify_prot_commit() -> set_pte_at() -> set_ptes(nr=1)) and only
> when we are setting the final PTE in a contpte-aligned block.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

