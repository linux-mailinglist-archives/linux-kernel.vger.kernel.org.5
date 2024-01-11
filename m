Return-Path: <linux-kernel+bounces-23399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493782AC4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FC4285726
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314DA14F60;
	Thu, 11 Jan 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kn1wlYvU"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16A14A92
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704969779; x=1736505779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oeO4P4G8+DW7P/TORAOolFsZ/4zgVraJv9jIndq8zmM=;
  b=Kn1wlYvUf3+Lgqp6THBJh5OznX9My7kKLET+AxHx5MpkP9GU6inI4ahF
   P/c+NgVGtytrHNdlaP9xGVAaaPhL+UhUmBGeVlJ9NeG3usjEcARc2i/sV
   3nIpHQwy0XfuGrWkp/k86REDskG0SJz7D299FubUGfpTkGWBLmLk8eVhb
   FIj4BXtsPMAPqMnzhM1ciO8dda4tIvvYVyyfWrmTd9v39Z5MaavwsLJPh
   Qp2szIJqCY0uwNnF0FMlkjO18iVpwp1SAFHhvP6llNP+mtGpxUj0+TMTU
   iK6eXioq0fly9wy8mYxyVODQx2WEIGVCeD14DJNgKGOqKMzB+Z4BuC4z1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="395954017"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="395954017"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:42:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="782582390"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="782582390"
Received: from tvonhert-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.213.56])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:42:56 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 57E4C10A557; Thu, 11 Jan 2024 13:42:53 +0300 (+03)
Date: Thu, 11 Jan 2024 13:42:53 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: Re: [PATCH] x86/mm: Fix memory encryption features advertisement
Message-ID: <20240111104253.fzfjl6z4j3nup6cj@box.shutemov.name>
References: <20240110193514.15620-1-kirill.shutemov@linux.intel.com>
 <8d443374-1b3b-4099-a306-5f9e0fac7851@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d443374-1b3b-4099-a306-5f9e0fac7851@amd.com>

On Wed, Jan 10, 2024 at 03:33:13PM -0600, Tom Lendacky wrote:
> On 1/10/24 13:35, Kirill A. Shutemov wrote:
> > When memory encryption is enabled, the kernel prints the encryption
> > flavor that the system supports.
> > 
> > The check assumes that everything is AMD SME/SEV if it has the TDX CPU
> 
> s/if it has/if it doesn't have/

Oopsie.

> > feature set.
> > 
> > To avoid confusion, check the cc_vendor directly.
> 
> Is this because of the setting of cc_vendor in hv_vtom_init() without
> setting the TDX feature and so "Intel TDX" isn't printed and instead "AMD"
> is printed?
> 
> If so, the commit message should really have some info about how this
> relates to Hyper-V isolation VMs.

That's one of the issue. But the code is generally has flawed logic that
worth addressing.

Will send v2 with better commit message.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

