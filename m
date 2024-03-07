Return-Path: <linux-kernel+bounces-95309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8896874C09
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B27B25626
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49346839E8;
	Thu,  7 Mar 2024 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nxvw/poF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B173874262
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806372; cv=none; b=kQS2dYzMOnGDL3kFuUH8RyxSgUaepoeSky9hQ/H7QDoDjMPUCUPhu8f+sIt/NrnGQ0RuOXHO6WZNAvfp7p84+Ko5CIFpVn7DK87MfZZ38CfCUj8senR3hrl6X69OMGW5bEDmz6qzf02rmbY18uBB+P3kBdvvdzpu4RN21kyWIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806372; c=relaxed/simple;
	bh=f6wBBysqfQOEtG+YY8fSdpRVawUGnNfgV70+vyePSr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O6H52FjN55kbgVoMoBdyfrh3hZIU2HuxnbTTMNL/N2Lw/mC2DA6vL1VEtOXJWwRwdp1B5NYCD4Dmmsbx82uEXhq8JQ1xtislHipRhSLn/alnJjc4qvfXfhKuuECFhEdtGVFu8CVq2RcwhsULk2QzjeFyaC3VTzRWxiN8B6aY8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nxvw/poF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709806371; x=1741342371;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=f6wBBysqfQOEtG+YY8fSdpRVawUGnNfgV70+vyePSr0=;
  b=Nxvw/poFApar0d3wgfBwFKJbxyeelUDp5EUGE1yQaDeJaR1YLbLoB1OG
   U0DVpT2pCx7cBdQPxKSL9ZWvIhAg6HSCyHLuMDTMeIFsG9/qr4yQuwlvV
   iTs8xLI9NjUf0OKV6t8xTU9sVyrZ1OZRqkzyXA7hiBJvh+rDXVZxSGKhh
   P6+KuhQ22p6G6UBmvuVOXKFkkhdINsm4b0NInQ/gTHnhEl3QKTJBvdnS7
   vrBEvntTuh5y5NafvzVwhyazj5UGcGkajnxuzvLBVDO96pIw71diXDCwZ
   NCHdwovce7cFYK0A+BGjTPj57tNn4lO/wY08Bz7+ZrDM3khHIeL7Vt6hE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="8285944"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="8285944"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 02:12:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="10134733"
Received: from tcavalax-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.241])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 02:12:48 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] m68k: pgtable: Add missing #include <asm/page.h>
In-Reply-To: <ba359be013f379ff10f3afcea13e2f78dd9717be.1709804021.git.geert@linux-m68k.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ba359be013f379ff10f3afcea13e2f78dd9717be.1709804021.git.geert@linux-m68k.org>
Date: Thu, 07 Mar 2024 12:12:45 +0200
Message-ID: <8734t2xsde.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Mar 2024, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> When just including <linux/pgtable.h>:
>
>     include/asm-generic/pgtable-nop4d.h:9:18: error: unknown type name =
=E2=80=98pgd_t=E2=80=99
> 	9 | typedef struct { pgd_t pgd; } p4d_t;
> 	  |                  ^~~~~
>
> Make <asm/pgtable.h> self-contained by including <asm/page.h>.
>
> Reported-by: Jani Nikula <jani.nikula@intel.com>
> Closes: https://lore.kernel.org/r/878r2uxwha.fsf@intel.com
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Jani: Feel free to pick this up as a dependency.
> Else I will queue this in the m68k tree for v6.10.

Thanks, I'd like to pick this up as a dependency, so I can proceed with
my series. It'll also be queued for v6.10 via the drm subsystem.

BR,
Jani.


>
>  arch/m68k/include/asm/pgtable.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/m68k/include/asm/pgtable.h b/arch/m68k/include/asm/pgta=
ble.h
> index 27525c6a12fd0c7f..49fcfd7348600594 100644
> --- a/arch/m68k/include/asm/pgtable.h
> +++ b/arch/m68k/include/asm/pgtable.h
> @@ -2,6 +2,8 @@
>  #ifndef __M68K_PGTABLE_H
>  #define __M68K_PGTABLE_H
>=20=20
> +#include <asm/page.h>
> +
>  #ifdef __uClinux__
>  #include <asm/pgtable_no.h>
>  #else

--=20
Jani Nikula, Intel

