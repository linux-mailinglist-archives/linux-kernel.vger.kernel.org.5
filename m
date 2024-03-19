Return-Path: <linux-kernel+bounces-107447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B85A87FCA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC3A2825D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89067E585;
	Tue, 19 Mar 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="arCtFEik"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6A54BF6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846839; cv=none; b=pPoqUl6/BlSdUz+olfRCsw32JkYQwh9OJ9gLFXeDbDlco1LRgLvFyk6i7efrl1983y1vN1WL0LoaRW4IZLA25ZR20Shy0Vyv8UYQAu/HUb9RoktRqdIrBOncYZHKfyRHi2cGUoCWF8RgAHnNdrVOeWcIV+m8sdiTp5EWbkmRKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846839; c=relaxed/simple;
	bh=8o6AsrDuBW9CkCbDERKA5AevJiBEb0jHHDBjyDq/Kxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsVhoX1JF9v+Ww70+nxcbb4VJg3OHEfBUH4kL0sqa+iU1Hd786WQtyIePIO303ER1q41XUqw0dgnQFP4PSGutMEz1+GI2CbsW8CzELOA3DlTUNyVaIAqQdZiQuoozsrlzJfhE6vyUzWSxu+PeVB2TQ/nKpcRMg7vC+TqOdZa0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=arCtFEik; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710846837; x=1742382837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8o6AsrDuBW9CkCbDERKA5AevJiBEb0jHHDBjyDq/Kxs=;
  b=arCtFEikxCGD+HpPcv0jipk37biZgOBwk4Om6bWwfLZlB7gVY1m5LV5v
   jtOEMFbmyKCLMgC4LWxV98X9I7xLBPbZDLRnWaVgWMkUcT26muOdqvoU2
   qVofw7TfTJz6Pum0E4WZiNmIt501rm9XU79Y0DcVElfy4grw2Y6sp7dBi
   1yYqxaQW8TF8YF4nAoEfQX1KJi13dpOKBFp+eEUuFwj8MEWaXt3978HY+
   O1sIzU+4N1X6qWgq/BZFmNRMv+fxjg+KK5V48IpXmAbW+4PyU3d3E2Ild
   IB6XGp5SxV/DrbYk/wOjIRXv899PXTdwQnY0h7ExeVWSexHaXBfFyUt4w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="17110320"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="17110320"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 04:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="937061647"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="937061647"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2024 04:13:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2ECC91A6; Tue, 19 Mar 2024 13:13:51 +0200 (EET)
Date: Tue, 19 Mar 2024 13:13:51 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, 
	bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, 
	luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com, 
	thomas.lendacky@amd.com, ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com, 
	nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Message-ID: <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>

On Tue, Mar 19, 2024 at 01:48:45AM +0000, Kai Huang wrote:
> Both SME and TDX can leave caches in incoherent state due to memory
> encryption.  During kexec, the caches must be flushed before jumping to
> the second kernel to avoid silent memory corruption to the second kernel.
> 
> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
> remote cpus when they are being stopped.  For SME, the WBINVD in
> relocate_kernel() flushes the cache for the last running cpu (which is
> executing the kexec).
> 
> Similarly, for TDX after stopping all remote cpus with cache flushed, to
> support kexec, the kernel needs to flush cache for the last running cpu.
> 
> Make the WBINVD in the relocate_kernel() unconditional to cover both SME
> and TDX.

Nope. It breaks TDX guest. WBINVD triggers #VE for TDX guests.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

