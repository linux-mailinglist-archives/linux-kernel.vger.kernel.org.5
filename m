Return-Path: <linux-kernel+bounces-68926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE5858202
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B338B26049
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5737113172C;
	Fri, 16 Feb 2024 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="INUCV6mq"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8868C12C809;
	Fri, 16 Feb 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099056; cv=none; b=Fr85swdryohF9xe/7biVaAARlqkeoUkSTv5Yz5GjkEVhKOxO7V0nCZMRGBGzFFiGazUpe3Lkael8ESTuAjVWaNdLRnYYUEvn9GdTjzTTjBeFE6vRCRV/TqX7fFMVnBfC506q2sQqAb9vRyhAyrKR0Ld+mvLcvzNOHMmf4wraV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099056; c=relaxed/simple;
	bh=92zPtdd0rAFo21Fvita8bJaJeG+DPj1KURFAzjkg2QY=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vt545GRyr3U7Ma/FVO5Kj9FTL4LUnjzQe5l3PsDe1tqFLzYmfuMuWw3XkOLrup3sXUPpNSykZoDPBZsuKgL3G5LJDJ9E7UxuLe4SZDBrGIGSEo1QaUDXKjzMLgmIjZ3t+TDtS0FZUjVeY6EtVCVPSskcsTWAsnZH/TY/L0Qomrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=INUCV6mq; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708099055; x=1739635055;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ySlk5EP+5EPRFvPn7fKspQz+Y/lmLyPoeT8Lylq3p9Y=;
  b=INUCV6mqjR9bApW5bPO0D8ZD37F1XaWRtO+wK3N12g+gRywP9XEtWK7q
   ndTGY0ChLjMKu8+L1K953A1sZd20aXSOhg1LMfmMqY+yW1LdE/Wox4nkc
   X5kIvTHlyqVnclXMUhgTxt3+hLdbhTBmhYh6uejjdrWjQlLrKrWTap/YR
   E=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="327444091"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:57:26 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.0.204:20286]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.58.150:2525] with esmtp (Farcaster)
 id 5a50e3a4-7605-4a6b-bd7b-2201142338a7; Fri, 16 Feb 2024 15:57:25 +0000 (UTC)
X-Farcaster-Flow-ID: 5a50e3a4-7605-4a6b-bd7b-2201142338a7
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:57:10 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:57:09 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 15:57:09 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 4FB1420D21; Fri, 16 Feb 2024 16:57:09 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 04/17] kexec: Add KHO parsing support
In-Reply-To: <20240117144704.602-5-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:51 +0000")
References: <20240117144704.602-1-graf@amazon.com>
	<20240117144704.602-5-graf@amazon.com>
Date: Fri, 16 Feb 2024 16:57:09 +0100
Message-ID: <mafs0eddc8kru.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Wed, Jan 17 2024, Alexander Graf wrote:

> When we have a KHO kexec, we get a device tree, mem cache and scratch
> region to populate the state of the system. Provide helper functions
> that allow architecture code to easily handle memory reservations based
> on them and give device drivers visibility into the KHO DT and memory
> reservations so they can recover their own state.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
> ---
>
[...]
> +/**
> + * kho_return_mem - Notify the kernel that initially reserved memory is no
> + * longer needed. When the last consumer of a page returns their mem, kho
> + * returns the page to the buddy allocator as free page.
> + */
> +void kho_return_mem(const struct kho_mem *mem)
> +{
> +	uint64_t start_pfn, end_pfn, pfn;
> +
> +	start_pfn = PFN_DOWN(mem->addr);
> +	end_pfn = PFN_UP(mem->addr + mem->len);
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++)
> +		kho_return_pfn(pfn);
> +}
> +EXPORT_SYMBOL_GPL(kho_return_mem);
> +
> +static void kho_claim_pfn(ulong pfn)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +
> +	WARN_ON(!page);
> +	if (WARN_ON(page_count(page) != 1))
> +		pr_err("Claimed non kho pfn %lx", pfn);

You do sanity checks but then never actually change anything on the
page. kho_claim_mem()'s documentation says: "This function removes the
reserved state for all pages that the mem spans". So this function
should at the very least call ClearPageReserved().

Also, checking the page count is a very rough heuristic. There can be
other non-KHO pages with page count == 1. Do you think it would make
more sense to use one of the private pageflags bits to mark a page
KHO-owned? If not, shouldn't you at least also check if the page is
reserved?

> +}
> +
> +/**
> + * kho_claim_mem - Notify the kernel that a handed over memory range is now in
> + * use by a kernel subsystem and considered an allocated page. This function
> + * removes the reserved state for all pages that the mem spans.
> + */
> +void *kho_claim_mem(const struct kho_mem *mem)
> +{
> +	u64 start_pfn, end_pfn, pfn;
> +	void *va = __va(mem->addr);
> +
> +	start_pfn = PFN_DOWN(mem->addr);
> +	end_pfn = PFN_UP(mem->addr + mem->len);
> +
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++)
> +		kho_claim_pfn(pfn);
> +
> +	return va;
> +}
> +EXPORT_SYMBOL_GPL(kho_claim_mem);
> +
[...]

--
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




