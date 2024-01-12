Return-Path: <linux-kernel+bounces-24638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A682BF96
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291B21C21FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A556A322;
	Fri, 12 Jan 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyM//Fnf"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526026A032
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705061188; x=1736597188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qZO5o8gloP88hNEdbyf9gooCX6/C7fxpb8IKA6kIC/U=;
  b=hyM//FnfKYE1n2o5ZnHZAR1919Dre9R4uNLe9OsDqzuTw24JQkF6BvV/
   HWWEa41oWu77lU6VN8uRXOTAyRt4YHpv+5M4z2APrTTCLarTXbFCWJ9cq
   pfXhQdhR39DV/O87Y+QoDutx3lpd2/JohfRccufoN/pElEsZalVzbogT5
   QQWdEq4j8LB6KUulyArRWdl7WedkRZiTAFYnW2Tg5VVO4DSTeRb9eN9et
   +tHsSXMF/IftuW809i26bRGWQzo0Eh+jXZkZp5hPbXJC7rkMruMiXLfe8
   zVqxWybOzmq+sBCXhFEkhebFMdbybdwwuZQN8TAJVw/0s/asSUabYDwWE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463441909"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="463441909"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="24689196"
Received: from kschuele-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.195])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:06:19 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id B843210A557; Fri, 12 Jan 2024 15:06:16 +0300 (+03)
Date: Fri, 12 Jan 2024 15:06:16 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= <junichi.nomura@nec.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"nikunj@amd.com" <nikunj@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"debarbos@redhat.com" <debarbos@redhat.com>,
	"jlelli@redhat.com" <jlelli@redhat.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>,
	"dzickus@redhat.com" <dzickus@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH repost] x86/boot: Add a message about ignored early NMIs
Message-ID: <20240112120616.5zjojjmjeqg5egb7@box>
References: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>

On Fri, Jan 12, 2024 at 11:13:53AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> Commit 78a509fba9c9 ("x86/boot: Ignore NMIs during very early boot") added
> empty handler in early boot stage to avoid boot failure by spurious NMIs.
> 
> Add a diagnostic message in case we need to know whether early NMIs have
> occurred and/or what happened to them.
> 
> Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Link: https://lore.kernel.org/lkml/20231130103339.GCZWhlA196uRklTMNF@fat_crate.local/
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -387,7 +387,10 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
>  	kernel_add_identity_map(address, end);
>  }
>  
> +extern int spurious_nmi_count;
> +

It has to be in a header file.

>  void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
>  {
>  	/* Empty handler to ignore NMI during early boot */
> +	spurious_nmi_count++;
>  }
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -357,6 +357,8 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
>  	return entry;
>  }
>  
> +int spurious_nmi_count;
> +

It is not a right place to define a variable. Do it next to rest of
variables at the beginning of the file.
>  /*
>   * The compressed kernel image (ZO), has been moved so that its position
>   * is against the end of the buffer used to hold the uncompressed kernel
> @@ -493,6 +495,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
>  	/* Disable exception handling before booting the kernel */
>  	cleanup_exception_handling();
>  
> +	if (spurious_nmi_count) {
> +		error_putstr("Spurious early NMI ignored. Number of NMIs: 0x");
> +		error_puthex(spurious_nmi_count);
> +		error_putstr("\n");
> +	}
> +
>  	return output + entry_offset;
>  }
>  

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

