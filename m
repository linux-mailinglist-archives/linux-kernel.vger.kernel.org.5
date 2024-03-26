Return-Path: <linux-kernel+bounces-119633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD6488CB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4797F1F65A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5F3200CB;
	Tue, 26 Mar 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkH3rksW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3D1B59A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475624; cv=none; b=UoTuwPJ3cMc1ka6SZKOWuNcwr9gnsAfpqUzHAjcYzeuGXC37YkdOUics4FyZ6aMeA2oheW1dl12yJlvzThP0p2rR6mNViqCYnXHBIOqCmu1GaKq7FgBo0qBRQpT5UjnET0D5kpste9W2fG9KftzE89DJ9wCeVF4FRcQw4yTJneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475624; c=relaxed/simple;
	bh=wU0JE4kouoaua5oyHsX4nd5C2asEXFa3mxPJlgLUrxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeNlnzXvIYViYwO5DdyAzfYvT2zkdFxbopuuhITRcO4GU8JyfqjUjA2uU414luEYbngTX6BJ4uil7x/TI3qOXkAF4sj93HsOKATp4uEsI80CFrE/OC+A5048jP3vKWWzcCu3zkNemcNPcd5eYHfwAkHbqaLiZ4LVJJgJ6NrduOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkH3rksW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711475623; x=1743011623;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wU0JE4kouoaua5oyHsX4nd5C2asEXFa3mxPJlgLUrxk=;
  b=CkH3rksWFToklrlhsBu3OQ5aD2+UVWouyqlRSLfZE/SMLPfKi1Ql3Uur
   iIO0FWwjFU5QG/5S47khpe5bWOnZ5xWBUwzO7YgBK9yHC8Ns2cx61B2Sl
   q8nICMaqoPdBbpEYRaJhzhJoORha5oVXOhtDVegf2ghatOoq8h37Fv9rd
   5BC4eZQOLNPU22vQTID/SVK/Lh24Nj/niPkL+Gdz6LtltxyHgKwWBbBYj
   jjzRdgK3rsIA+8BZCl1fl/HCU4nprzZQ8CQX0ipqQR8O4oF4PLlYVRwzD
   BmDWbfZEBu6tZ3s6mXkzlRgUIiQJdYf7Ho7rOOH1bAjH7D4v/BGQk/qGI
   A==;
X-CSE-ConnectionGUID: AFGhLv9BRW+x2o1B3oM7Gw==
X-CSE-MsgGUID: VxbaazpLTuOOXujvoEc8AQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6651551"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6651551"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="53500100"
Received: from pwimalas-mobl.amr.corp.intel.com (HELO [10.251.11.118]) ([10.251.11.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:53:41 -0700
Message-ID: <0582b182-3293-43d5-a4be-5e0c6e97f7ff@linux.intel.com>
Date: Tue, 26 Mar 2024 10:53:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 17/17] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is
 parsed
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-18-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240325103911.2651793-18-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/25/24 3:39 AM, Kirill A. Shutemov wrote:
> When MADT is parsed, print MULTIPROC_WAKEUP information:
>
> ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])
>
> This debug information will be very helpful during bring up.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/acpi/tables.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index b976e5fc3fbc..9e1b01c35070 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> +		{
> +			struct acpi_madt_multiproc_wakeup *p =
> +				(struct acpi_madt_multiproc_wakeup *)header;
> +			u64 reset_vector = 0;
> +
> +			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
> +				reset_vector = p->reset_vector;
> +
> +			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
> +				 p->version, p->mailbox_address, reset_vector);
> +		}
> +		break;
> +
>  	case ACPI_MADT_TYPE_CORE_PIC:
>  		{
>  			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


