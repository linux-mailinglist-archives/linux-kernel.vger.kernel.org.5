Return-Path: <linux-kernel+bounces-118960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F7B88C1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637B83014E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB52B745DC;
	Tue, 26 Mar 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtpuVFXI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754287441F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455691; cv=none; b=P8sAXUvBxLhxpnG+feGzP6ZDmNG1zIN9k+7LMeigdFkuwJSS+8cuJhu4AfA9S1ajk8ldycadpDlEMQh6fEDVkP25dkBMddlPODEj+WdGQW5lQD0inRlwwhj3ys89XMMNgeUavAuoOVh/IemMQxmwPD2yPepfc4vHTPXxAgIL0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455691; c=relaxed/simple;
	bh=fB1NRi5e23WxYWmcslguhVN6x/28OSeS/uzIQxRcQ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdbaHPR0iRdlrEwZNnrBZmkFG2bdmj2wF2p3PdPjhjKdg6vLJe70FVY86CBFmCRr82MRNQF3A30yZ04gw33op9iBFAhBDUjJ0ACKZPpYVlgyowA6qI6dYstS2HowKtPLMP0hKIU+YsOeR33CpTenC0KG6/QRB5Rj5+hRFWH46lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtpuVFXI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711455689; x=1742991689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fB1NRi5e23WxYWmcslguhVN6x/28OSeS/uzIQxRcQ3I=;
  b=mtpuVFXI5HCHGJeLc4aFeRurXIpoxjGmwxdav+L7FcvJ1HBgslWUU6T7
   b28GCLZbXySN0arGmCh+/zm2DayfTjWIyCpSvGpayJYu/98k6ruIU3yrx
   k2jgJtjEEKTamCAC68oAW/0if+qdqdhcHT/BAt/sQXgTTT3wdehOXJpVo
   FW7w38dI5b6Moyi27PfzaDRgtOfM3OBAMb/ZJGoQZg2Tp8FrmCZl8IsFR
   YEXVSTTmxBbGJmqyCq7YfK9oz5WfIPc7GpaXAD7ZoElvPi/4XiS4KuyoA
   AQ9FKmXHkbTFEoAdcjA7F3D7ZSPRKSEo+eWIK2nKjAQZOyvaRvnWBBShp
   g==;
X-CSE-ConnectionGUID: 8KJvAbCLQzmMEmsypb5Hlw==
X-CSE-MsgGUID: bVBazYFYTLyYBCkJx1cRNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6333945"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6333945"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 05:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="937072476"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072476"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 05:21:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 942D3E7; Tue, 26 Mar 2024 14:21:24 +0200 (EET)
Date: Tue, 26 Mar 2024 14:21:24 +0200
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 4/4] x86/tdx: Enable ENUM_TOPOLOGY
Message-ID: <mh5bwjdwzg5kg6b4mqnxpu2ri5765ilgoskefdnbkgyhzqymqg@elweoth2mh6j>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
 <20240325104607.2653307-5-kirill.shutemov@linux.intel.com>
 <ea00b63e4e7f27dfb35b8b5947bd0951039db9bd.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea00b63e4e7f27dfb35b8b5947bd0951039db9bd.camel@intel.com>

On Tue, Mar 26, 2024 at 10:59:38AM +0000, Huang, Kai wrote:
> On Mon, 2024-03-25 at 12:46 +0200, Kirill A. Shutemov wrote:
> > TDX 1.0 defines baseline behaviour of TDX guest platform. In TDX 1.0
> 

Okay.

> > generates a #VE when accessing topology-related CPUID leafs (0xB and
> > 0x1F) and the X2APIC_APICID MSR. The kernel returns all zeros on CPUID
> > topology. Any complications will cause problems.
> > 
> > The ENUM_TOPOLOGY feature allows the VMM to provide topology
> > information to the guest. Enabling the feature eliminates
> > topology-related #VEs: the TDX module virtualizes accesses to
> > the CPUID leafs and the MSR.
> > 
> > Enable ENUM_TOPOLOGY if it is available.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/coco/tdx/tdx.c           | 19 +++++++++++++++++++
> >  arch/x86/include/asm/shared/tdx.h |  3 +++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> > index 860bfdd5a11d..b2d969432a22 100644
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -289,6 +289,25 @@ static void tdx_setup(u64 *cc_mask)
> >  		else
> >  			tdx_panic(msg);
> >  	}
> > +
> > +	/*
> > +	 * TDX 1.0 generates a #VE when accessing topology-related CPUID leafs
> > +	 * (0xB and 0x1F) and the X2APIC_APICID MSR. The kernel returns all
> > +	 * zeros on CPUID #VEs. In practice, this means that the kernel can only
> > +	 * boot with a plain topology. Any complications will cause problems.
> > +	 *
> > +	 * The ENUM_TOPOLOGY feature allows the VMM to provide topology
> > +	 * information to the guest in a safe manner. Enabling the feature
> > +	 * eliminates topology-related #VEs: the TDX module virtualizes
> > +	 * accesses to the CPUID leafs and the MSR.
> > +	 *
> > +	 * Enable ENUM_TOPOLOGY if it is available.
> > +	 */
> > +	if ((features & TDX_FEATURES0_ENUM_TOPOLOGY) &&
> > +	    tdg_vm_rd(TDCS_TOPOLOGY_ENUM_CONFIGURED)) {
> > +		if (!tdcs_ctls_set(TD_CTLS_ENUM_TOPOLOGY))
> > +			pr_warn("Failed to enable ENUM_TOPOLOGY\n");
> > +	}
> >  }
> >  
> >  /*
> > diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> > index 29a61c72e4dd..2964c506b241 100644
> > --- a/arch/x86/include/asm/shared/tdx.h
> > +++ b/arch/x86/include/asm/shared/tdx.h
> > @@ -27,15 +27,18 @@
> >  #define TDCS_CONFIG_FLAGS		0x1110000300000016
> >  #define TDCS_TD_CTLS			0x1110000300000017
> >  #define TDCS_NOTIFY_ENABLES		0x9100000000000010
> > +#define TDCS_TOPOLOGY_ENUM_CONFIGURED	0x9100000000000019
> 
> Do you know where can I find the metadata field ID definition?
> 
> It seems I couldn't find all metadata field ID definitions in the latest TDX 1.5
> ABI spec anymore.

See "Intel TDX Module v1.5 ABI Definitions":

https://cdrdv2.intel.com/v1/dl/getContent/795381

It has all fields described in JSON.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

