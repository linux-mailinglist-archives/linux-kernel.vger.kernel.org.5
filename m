Return-Path: <linux-kernel+bounces-166685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB7F8B9E25
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1E31C2341E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C615D5A0;
	Thu,  2 May 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCqaaOI4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF915359A;
	Thu,  2 May 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665950; cv=none; b=ethDiv3BSBuswi9vHNOFQXwdV00J6M7mIsFfE+3rqD4d8ZSsqxcQf9EaS/funz+14Cysd7tbZbqFWFcWyfsBIBLo8vrBugJws3wbaQVqCc/Hq0PntQ93jBWz7ASlNMYSPtBl9xeG/Rw/d5N57VRWHdkYMnj0KB56VGG0I+26hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665950; c=relaxed/simple;
	bh=liNJpqZaUusEYaet5+AZ8QmE2V1rDP/SCGnddJWnXNg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nwTnGcDCByU2EgATjK+4odkPAf7wICjLQLnj7cLCTrgVnQ1aKZsj53jci4nHtZFJWOLRfTvz7z++QHqGVN4awfma3QIssd9Cuq+WOgG/0bbX066b71jA7pN1mPVUNYLmM8QLc7Qgi2EZC7ukxSbrF7fmoBbvG8ZmcqGIO101ejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCqaaOI4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714665949; x=1746201949;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=liNJpqZaUusEYaet5+AZ8QmE2V1rDP/SCGnddJWnXNg=;
  b=DCqaaOI4SxpvTEmveF/UnfOdQ7Uek6XSnLcKsxj6Jj8IitMPS+vz397J
   sfyj3QuJT2lQpFIEsg7i1+6Snx0aVszcoHpIGNClyD1tzOB+TLPbVLnuy
   5FqUHtur/Ajf07Pk4/hGiHWNUAJVsGfMns5e4KdsfT4rJpGZr1gwFZW3R
   l2FH+JK40mxXVm9FXYI/+BFobwTkj/NKXoAC2qJUlIot06FmAyyYvFSf1
   VYT7vMPIpTpUzWrv0rMxpgjwBxh1zDT7B/9vQltCMucwQZapODC56vNBW
   SamN4Jx0FCWIkA/6NdpUv0vjQOHWCGmOMVw1YJepoZZgaumza2TebnuAR
   Q==;
X-CSE-ConnectionGUID: G9xQVcqaSA+/5yPn+P9v1A==
X-CSE-MsgGUID: vNDf5q9SRlqAcGN1UdcKQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10374567"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10374567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 09:05:17 -0700
X-CSE-ConnectionGUID: gWDa5TmKQPuG2RdMmF7q/A==
X-CSE-MsgGUID: IoiQcfODT/G8bTRHDEkG9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="64606203"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.54])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 09:05:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 2 May 2024 19:05:03 +0300 (EEST)
To: Shresth Prasad <shresthprasad7@gmail.com>
cc: davem@davemloft.net, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
    sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
    skhan@linuxfoundation.org, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by
 using __free
In-Reply-To: <20240501084110.4165-2-shresthprasad7@gmail.com>
Message-ID: <f1707254-ec32-4884-275a-c3c85b48d7d5@linux.intel.com>
References: <20240501084110.4165-2-shresthprasad7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 May 2024, Shresth Prasad wrote:

> Add `__free` function attribute to `ap` and `match` pointer
> initialisations which ensure that the pointers are freed as soon as they
> go out of scope, thus removing the need to manually free them using
> `of_node_put`.
> 
> This also removes the need for the `goto` statement and the `rc`
> variable.
> 
> Tested using a qemu x86_64 virtual machine.

Eh, how can you test this with an x86_64 VM ???

config SERIAL_SUNSU
        tristate "Sun SU serial support"
        depends on SPARC && PCI

-- 
 i.


> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Changes in v2:
>     - Specify how the patch was tested
> 
>  drivers/tty/serial/sunsu.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
> index 67a5fc70bb4b..0f463da5e7ce 100644
> --- a/drivers/tty/serial/sunsu.c
> +++ b/drivers/tty/serial/sunsu.c
> @@ -1382,44 +1382,29 @@ static inline struct console *SUNSU_CONSOLE(void)
>  
>  static enum su_type su_get_type(struct device_node *dp)
>  {
> -	struct device_node *ap = of_find_node_by_path("/aliases");
> -	enum su_type rc = SU_PORT_PORT;
> +	struct device_node *ap __free(device_node) =
> +			    of_find_node_by_path("/aliases");
>  
>  	if (ap) {
>  		const char *keyb = of_get_property(ap, "keyboard", NULL);
>  		const char *ms = of_get_property(ap, "mouse", NULL);
> -		struct device_node *match;
>  
>  		if (keyb) {
> -			match = of_find_node_by_path(keyb);
> +			struct device_node *match __free(device_node) =
> +					    of_find_node_by_path(keyb);
>  
> -			/*
> -			 * The pointer is used as an identifier not
> -			 * as a pointer, we can drop the refcount on
> -			 * the of__node immediately after getting it.
> -			 */
> -			of_node_put(match);
> -
> -			if (dp == match) {
> -				rc = SU_PORT_KBD;
> -				goto out;
> -			}
> +			if (dp == match)
> +				return SU_PORT_KBD;
>  		}
>  		if (ms) {
> -			match = of_find_node_by_path(ms);
> +			struct device_node *match __free(device_node) =
> +					    of_find_node_by_path(ms);
>  
> -			of_node_put(match);
> -
> -			if (dp == match) {
> -				rc = SU_PORT_MS;
> -				goto out;
> -			}
> +			if (dp == match)
> +				return SU_PORT_MS;
>  		}
>  	}
> -
> -out:
> -	of_node_put(ap);
> -	return rc;
> +	return SU_PORT_PORT;
>  }
>  
>  static int su_probe(struct platform_device *op)
> 

