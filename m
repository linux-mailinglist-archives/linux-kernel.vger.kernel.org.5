Return-Path: <linux-kernel+bounces-14788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7C982225C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A315284779
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0156B16407;
	Tue,  2 Jan 2024 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sf+h60Ai"
X-Original-To: linux-kernel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541F168D6;
	Tue,  2 Jan 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-73-239-240-195.hsd1.wa.comcast.net [73.239.240.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C6DD20B3CC1;
	Tue,  2 Jan 2024 11:58:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C6DD20B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704225493;
	bh=2UaDwV/oGm+Epqzq+iuoXLl1XYKs/iiOjHPSgAf4WNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sf+h60AikfAoNDWIfOQf+gp/7n62YjqR91jk021dI0v+1a8M9a0OEjS7fQlNbGHtT
	 ipeSl4ZqBYQjVEH3GZlLaVHYTWm8e6nUV0SEqCtKnbq135a3/00oHsQNKX3wd4Z7BD
	 ICaDdMQVBMMzyyO3sadV/R66AVE4C1KSJe3ErDtk=
Date: Sun, 31 Dec 2023 19:33:01 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, arnd@arndb.de,
	pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 04/17] kexec: Add KHO parsing support
Message-ID: <20240101033301.GA765@skinsburskii.>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222193607.15474-5-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222193607.15474-5-graf@amazon.com>

On Fri, Dec 22, 2023 at 07:35:54PM +0000, Alexander Graf wrote:
> +/**
> + * kho_reserve_previous_mem - Adds all memory reservations into memblocks
> + * and moves us out of the scratch only phase. Must be called after page tables
> + * are initialized and memblock_allow_resize().
> + */
> +void __init kho_reserve_previous_mem(void)
> +{
> +	void *mem_virt = __va(mem_phys);
> +	int off, err;
> +
> +	if (!handover_phys || !mem_phys)
> +		return;
> +
> +	/*
> +	 * We reached here because we are running inside a working linear map
> +	 * that allows us to resize memblocks dynamically. Use the chance and
> +	 * populate the global fdt pointer
> +	 */
> +	fdt = __va(handover_phys);
> +
> +	off = fdt_path_offset(fdt, "/");
> +	if (off < 0) {
> +		fdt = NULL;
> +		return;
> +	}
> +
> +	err = fdt_node_check_compatible(fdt, off, "kho-v1");
> +	if (err) {
> +		pr_warn("KHO has invalid compatible, disabling.");

It looks like KHO preserved regions won't be reserved in this case.
Should KHO DT state be destroyed here to prevent KHO memory regions
reuse upon rollback?

> +
> +void __init kho_populate(phys_addr_t handover_dt_phys, phys_addr_t scratch_phys,
> +			 u64 scratch_len, phys_addr_t mem_cache_phys,
> +			 u64 mem_cache_len)
> +{
> +	void *handover_dt;
> +
> +	/* Determine the real size of the DT */
> +	handover_dt = early_memremap(handover_dt_phys, sizeof(struct fdt_header));
> +	if (!handover_dt) {
> +		pr_warn("setup: failed to memremap kexec FDT (0x%llx)\n", handover_dt_phys);
> +		return;
> +	}
> +
> +	if (fdt_check_header(handover_dt)) {
> +		pr_warn("setup: kexec handover FDT is invalid (0x%llx)\n", handover_dt_phys);
> +		early_memunmap(handover_dt, PAGE_SIZE);
> +		return;
> +	}
> +
> +	handover_len = fdt_totalsize(handover_dt);
> +	handover_phys = handover_dt_phys;
> +
> +	/* Reserve the DT so we can still access it in late boot */
> +	memblock_reserve(handover_phys, handover_len);
> +
> +	/* Reserve the mem cache so we can still access it later */
> +	memblock_reserve(mem_cache_phys, mem_cache_len);
> +
> +	/*
> +	 * We pass a safe contiguous block of memory to use for early boot purporses from
> +	 * the previous kernel so that we can resize the memblock array as needed.
> +	 */
> +	memblock_add(scratch_phys, scratch_len);
> +
> +	if (WARN_ON(memblock_mark_scratch(scratch_phys, scratch_len))) {
> +		pr_err("Kexec failed to mark the scratch region. Disabling KHO.");
> +		handover_len = 0;
> +		handover_phys = 0;

Same question here: doesn't all the KHO state gets invalid in case of any
restoration error?


