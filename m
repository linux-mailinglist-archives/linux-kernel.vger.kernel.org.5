Return-Path: <linux-kernel+bounces-100843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4DC879DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D74A1F21F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56544143742;
	Tue, 12 Mar 2024 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei5F6qlS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67213B2BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280683; cv=none; b=U8Saa/Uz/bD0OEsWl2SSvU5YShxnggTLuY8TTAeUn21WEQhXbACOD3SWntW9h+OtY5iu4XmAFGCtmLqHjWtVV8gsEJRfFV/H8YlXMuLO03Oh/YGjcRESOsF1Yca2Dj76UPr4mFYDLAVhO63Gva82Yn0tU+NUq7DoUVt00SrOp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280683; c=relaxed/simple;
	bh=PdlJgX8tKEbtAKrGAhg/LgPRC/1pQYEMsdNhtUbvpF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pexFRnNZrLKSkOhALyWUnZxcp00Bx1tImP5ZhIfLQ63RMCrL9KuSILh+ZxlBhkJWmQipf8fL737e4GVOMKW/tPE9TcWEz3G0B9Fxx1k+alktBjpabDtK8o2nrwPZFA1TxnsG5CnumYpqeM3fK7EpZ9VDuc8kpo7l4ym34KEAgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei5F6qlS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710280682; x=1741816682;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PdlJgX8tKEbtAKrGAhg/LgPRC/1pQYEMsdNhtUbvpF8=;
  b=Ei5F6qlSP4cBRw1qppEUp0vdB2RBjP8wVmcqSyLYFXfPykeJIhGgZtU0
   1ki1BD/Ly7IHcFkZdFpNJ4tGADIqT1+TDNh7VdbACqdWDYqWa6Xx77LYg
   SEapdo3peYg3Qw5caKBCu4CXdZI3mCVdq59jtrWR+vuSD8Hx2eolRF3+J
   D0amN5tjP4OWmwPOSnRqiYCwBHOpFPKBl1EFEc5kuNUuHrYADEDyAT8Tm
   aWNZfecPZlXGs3MlgUzU5i+5mhXYfAEZJ0ZlYYFdpfqOSOli6STkcX67l
   orLQaWgYVT8IFTMHmqw7jddFoO966mAgrZOeHJIzi6qvhbFUHUi9KT7nJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8832285"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8832285"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 14:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16331982"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by orviesa003.jf.intel.com with ESMTP; 12 Mar 2024 14:58:01 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id C2461301066; Tue, 12 Mar 2024 14:58:00 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  akpm@linux-foundation.org,  x86@kernel.org,  bp@alien8.de,
  brauner@kernel.org,  bristot@redhat.com,  bsegall@google.com,
  dave.hansen@linux.intel.com,  dianders@chromium.org,
  dietmar.eggemann@arm.com,  eric.devolder@oracle.com,  hca@linux.ibm.com,
  hch@infradead.org,  hpa@zytor.com,  jacob.jun.pan@linux.intel.com,
  jgg@ziepe.ca,  jpoimboe@kernel.org,  jroedel@suse.de,
  juri.lelli@redhat.com,  kent.overstreet@linux.dev,  kinseyho@google.com,
  kirill.shutemov@linux.intel.com,  lstoakes@gmail.com,  luto@kernel.org,
  mgorman@suse.de,  mic@digikod.net,  michael.christie@oracle.com,
  mingo@redhat.com,  mjguzik@gmail.com,  mst@redhat.com,
  npiggin@gmail.com,  peterz@infradead.org,  pmladek@suse.com,
  rick.p.edgecombe@intel.com,  rostedt@goodmis.org,  surenb@google.com,
  tglx@linutronix.de,  urezki@gmail.com,  vincent.guittot@linaro.org
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
In-Reply-To: <20240311164638.2015063-12-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 11 Mar 2024 16:46:35 +0000")
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
	<20240311164638.2015063-12-pasha.tatashin@soleen.com>
Date: Tue, 12 Mar 2024 14:58:00 -0700
Message-ID: <87ttlbm7tj.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index d6375b3c633b..651c558b10eb 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1198,6 +1198,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
>  	if (is_f00f_bug(regs, hw_error_code, address))
>  		return;
>  
> +	if (dynamic_stack_fault(current, address))
> +		return;

Probably I'm missing something here, but since you are on the same stack as
you are trying to fix up, how can this possibly work?

Fault on missing stack
#PF
<will push more stuff onto the missing stack causing a double fault>

You would need a separate stack just to handle this. But the normal
page fault handler couldn't use it because it needs to be able to block.

Ah I get it -- you handle it in the double fault handler?  So every
stack grow will be a #DF too? That's scary. 


-Andi

