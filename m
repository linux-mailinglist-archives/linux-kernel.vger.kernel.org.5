Return-Path: <linux-kernel+bounces-108916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4898811E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE77B23178
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1DD405CE;
	Wed, 20 Mar 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4ooAwvC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6751DFD9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939096; cv=none; b=rFATDPu4yVun9YKziwBL+cpBIswzk0Q4gxph+S+O+zvtzIO42iTQonBKOk4LURvsINchspIxcR7mhFtySOLlkTbgnVJ4lr6XqhEF4op/3PfpXwJfdgzJmUumXkxlWywm2pxWUy+QD01zxlQf7VUW9JA/UB1wPVMohzavQYHE7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939096; c=relaxed/simple;
	bh=lfAURvC2+3B1iC4qgdZoOJvGeLgWzRIEZBM013TmXTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j49uMvrDc68WzyMCuv7/D06gtsapsn7CnvXB4FABTBUvd6leYfSRUEvaXw06G7a5Ycutmcq2M/YHe6t8iHfuJJhWdq054BUUUR97BhV18E+sAKvftSxB1ukKBgxRRwReiL2q0x994P+GFfSfWp/Ubqx9A5k0C536JiooQmHH4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4ooAwvC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710939095; x=1742475095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lfAURvC2+3B1iC4qgdZoOJvGeLgWzRIEZBM013TmXTE=;
  b=U4ooAwvCyqFtDyipW6PBPoaMVfneUidQLjhWyLu+XYb4PRjwsVagw03v
   pyI+tgDDrSx0OoysYPt026f4071qdn71WF9EGw5NzS+GZ6Ql8rRIUs/Vf
   EQVpa7HPG6FeG/xH4GHm9kzh6qO7h6WBtclBBoCqqEkBh2vwJK9m3Ngdh
   cml20nfZ9Nv0eYxKaUyLz8g3knNa+G1OQF1bOhj6WPi2eRygfHpK1nbDi
   8wddG/ev1emZk56T2mtEbDY8untAKTbvhhc/nCrlOCmyfYfwCOaDtyZhD
   eFt30O0gyL+4bvrFFYV/90wKwnd3yK9rk4pylB/dT/7lG0x54nTR1MEjr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="9655587"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="9655587"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 05:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="937063579"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="937063579"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2024 05:51:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BCBC730D; Wed, 20 Mar 2024 14:51:28 +0200 (EET)
Date: Wed, 20 Mar 2024 14:51:28 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, dave.hansen@intel.com, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, hpa@zytor.com, luto@kernel.org, peterz@infradead.org, 
	rick.p.edgecombe@intel.com, ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com, 
	nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Message-ID: <fn3ikztlp6qphsb5lohnjvhianbf2nh5f7ch53a3px5g5wloo5@rhbxjcllwauq>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <i3nxazyv2dlauias4jmoqwpjixviuduaw6bgtfv4claxtimlm3@54xmat6zqud4>
 <256052ee-4e7b-45c5-8399-515fbb529a01@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256052ee-4e7b-45c5-8399-515fbb529a01@intel.com>

On Wed, Mar 20, 2024 at 01:45:32PM +1300, Huang, Kai wrote:
> Anyway, regardless whether patch 1 will break TDX/SEV-ES/SEV-SNP guests, I
> think to resolve this, we can simply adjust our mindset from ...
> 
> 	"do unconditional WBINVD"
> 
> to ...
> 
> 	"do unconditional WBINVD when it can be done safely"
> 
> For now, AFAICT, only TDX guests and SEV-ES/SEV-SNP guests are such guests.
> 
> And they all report the CC_ATTR_GUEST_MEM_ENCRYPT flag as true, so we can
> change to only do WBINVD when the kernel sees that flag.
> 
> 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> 		native_wbinvd();
> 
> Alternatively, we can have a dedicated X86_FEATURE_NO_WBINVD and get it set
> for TDX/SEV-ES/SEV-SNP guests (and any guests if this is true), and do:
> 
> 	if (!boot_cpu_has(X86_FEATURE_NO_WBINVD))
> 		native_wbinvd();
> 
> It seems the first one is too generic (for any CoCo VMs), and the second one
> is better.
> 
> Any comments?

I like cc_platform_has() variant better. There's no good reason to invent
X86_FEATURE if we don't cases outside of CC.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

