Return-Path: <linux-kernel+bounces-86025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933A86BEB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE26EB239D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB76364C0;
	Thu, 29 Feb 2024 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfkF0B2P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2A23DB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172235; cv=none; b=UKbqOkeSJoh56Hbxd4nWrbpIzPbZH+paMBE4IfWej3QiZWsekAkuPGwwNt6Ym4+aI5dgylR07sRpBdz36gBh2otSF/OVU19ncZVniSC5BD5i3B63lHwZezRNYcjnbvWRrrAwIUnntEMlmdAybmeW6Ur/QC7DvROVpLSv1VsjbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172235; c=relaxed/simple;
	bh=Q75pArREJLjVh3lGI4fFUuUjzEdAl5eP+jZ7P9RGLrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdZNfRX8K/q9Zu1jSmkEd8TMU32w1Ca5DR8MtjKMTgPBJo9kjYCGeR3WKyz5ObHHERN7+MLnND0qOhCV/go2IPjBYkLpot/dC0LP8Y6TF+tMdkraJU2ViqEeK29zRK9VOxum/k8zf//Ob/BocuYOPO73E6UOPDiWp+N+JmSeX4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfkF0B2P; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709172233; x=1740708233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q75pArREJLjVh3lGI4fFUuUjzEdAl5eP+jZ7P9RGLrs=;
  b=AfkF0B2PVsnCAJL+70YT0Nu/DMI4DSv3FFfOEGD+tLa62Hz8azMU4gXW
   KxPeyVLS22zNKc34MXrIgIW2hxawHozWr9KJJahIAdnwhHZk3w3vL6B9+
   oqAQTjKus0W7QcIPIhebA3dvS802R/5mfgQ7q++zUpKosZU2MdYtIJKpW
   W3SyfwtQD6DgmeY8Smuz0Kg13lz/HrnpoNhIGVX/WAZFatotrt8nJ8SGd
   ojywt5+8MQCBdDY3yhIPvDXVDWcTsBhG2/35Bg8hW5XpylBnHkv5jUgNI
   eWkCjyWdV734ZJRGFzSKYsPhVJYu1z1fEsvCYJh53H5rGi937np00tNyz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3539938"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3539938"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 18:03:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="12349324"
Received: from vabarca-mobl1.amr.corp.intel.com (HELO desk) ([10.209.19.138])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 18:03:48 -0800
Date: Wed, 28 Feb 2024 18:03:47 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Use fixed addressing for VERW operand
Message-ID: <20240229020347.nhu6564kmwcp2cey@desk>
References: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>

On Mon, Feb 26, 2024 at 03:52:33PM -0800, Pawan Gupta wrote:
> Macro used for MDS mitigation executes VERW with relative addressing for
> the operand. This is unnecessary and creates a problem for backports on
> older kernels that don't support relocations in alternatives. Relocation
> support was added by commit 270a69c4485d ("x86/alternative: Support
> relocations in alternatives"). Also asm for fixed addressing is much
> more cleaner than relative RIP addressing.
> 
> Simplify the asm by using fixed addressing for VERW operand.
> 
> Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
> Closes: https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 2aa52cab1e46..ab19c7f1167b 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -323,7 +323,7 @@
>   * Note: Only the memory operand variant of VERW clears the CPU buffers.
>   */
>  .macro CLEAR_CPU_BUFFERS
> -	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
> +	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF

Extremely sorry this change will not work with KASLR. The patch was
rushed to facilitate backports, and was only tested on qemu that had
KASLR disabled. :( Lesson learnt.

Please drop this patch.

