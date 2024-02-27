Return-Path: <linux-kernel+bounces-83272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AED0869122
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0288B2567F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990EE13AA32;
	Tue, 27 Feb 2024 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjK9FRpX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA931EA7A;
	Tue, 27 Feb 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038772; cv=none; b=m7Y+X6G1gmpWdP278j2AJps7Rf2HsPwFIfhdLHEDVDBVeRUdd3wxHlD9YN1ca9JIpdx8lgu18A6CcPm1i9TlxtN41TUUWS8HzXWIEF8Icgi6UD3lXKSnW3bI5KwzWOQc8RrxWFddH2/HetOKlZKVuRh0kYIHc7WKIAco6nC3vpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038772; c=relaxed/simple;
	bh=wiU20DrGryX1NTjOXTqiYvpUtgqll5ToH7wjB9oLF/U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Km8TpQ3ehAGqEqHYy5Ss+yDLTu8/5fbJZo4IegOU0vJ+qIM9sOdHafHxv4gADgZYJcbwFz61129XVSmnuqAMV7XiYnGwDKWILEmn1pnUFySrewUe+JEdzpcCvDGOgOJ72fJ4bLnHE9xjLf+EVat9E5/8hcHFVc+36q7ebdr6Z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjK9FRpX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709038772; x=1740574772;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wiU20DrGryX1NTjOXTqiYvpUtgqll5ToH7wjB9oLF/U=;
  b=NjK9FRpXMWjumcgOIW4lCUcGOF6zWTd9MAHqGhslhZwKImFgPBlFN6xb
   kVRqBhHLXZosVhqfRjzpG+MyEPgbF1/IWjDJP2p+mdYSJTYaGLTew+ZZY
   stMCn5Dms4Vg8eB08dErr3hUQlvdplTI36Hfm6IBCyErI1JpM8xMweyY0
   ALAeJWyYAOm6A9BV/KAB+BSoMVBtaNBngLCrcNiqs4VekTbTYW+JSg5uk
   mtM3jdWNGURMZyMHkjCNZ4gO1qNXMeH/X2jz1xp8Ng4rxIzszXN3ft9Rn
   NzKUuKi4eD+sCli/8URE6S7bKEj/eUqji0nUOPtDcotGoJmGVGOEThtO2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25840411"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="25840411"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7456140"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.34.61])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:59:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Feb 2024 14:59:23 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Shyam-sundar.S-k@amd.com, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] platform/x86/amd/pmf: Do not use readl() for
 policy buffer access
In-Reply-To: <20240223163901.13504-2-W_Armin@gmx.de>
Message-ID: <e2b81849-3435-3efb-f2da-b74ac7f99a50@linux.intel.com>
References: <20240223163901.13504-1-W_Armin@gmx.de> <20240223163901.13504-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Armin Wolf wrote:

> The policy buffer is allocated using normal memory allocation
> functions, so readl() should not be used on it.
> 
> Use get_unaligned_le32() instead.
> 
> Compile-tested only.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index 16973bebf55f..3220b6580270 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -11,6 +11,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/tee_drv.h>
>  #include <linux/uuid.h>
> +#include <asm/unaligned.h>
>  #include "pmf.h"
> 
>  #define MAX_TEE_PARAM	4
> @@ -249,8 +250,8 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
>  	u32 cookie, length;
>  	int res;
> 
> -	cookie = readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
> -	length = readl(dev->policy_buf + POLICY_COOKIE_LEN);
> +	cookie = get_unaligned_le32(dev->policy_buf + POLICY_COOKIE_OFFSET);
> +	length = get_unaligned_le32(dev->policy_buf + POLICY_COOKIE_LEN);

I don't understand you need _unaligned_ here, the offsets should be dword 
aligned, no?

#define POLICY_COOKIE_OFFSET      0x10
#define POLICY_COOKIE_LEN         0x14

-- 
 i.


