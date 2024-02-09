Return-Path: <linux-kernel+bounces-59542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FB084F8A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1161C21054
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539674E06;
	Fri,  9 Feb 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKyc+CZT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2E745C6;
	Fri,  9 Feb 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492882; cv=none; b=rEP3subK17I1nPa/uZO5sTiE+HCplDnkSU51jI9RsWB3gvuZ1AbCfzupKmcnEx9tSDeElBIAq6a1j+t2wZo0d/2utVAkdRKKcMNQeiOhvzXFAK2NSVtsk4b/vF9SKBk1HFZf3Ecff/a/lcusCPemY5aCoQ/7lb+z8SSvBNb6FQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492882; c=relaxed/simple;
	bh=m+5LdOQ+jTK/GyzxwvCFRkBVDD7WFaJyPCMJYBAwNOo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HrucQutmC4ls06SVs2de6HQmiVM0HTjtDuKZS1/mMx7Xw//yoDHjH34kIfJHem3fqjdhZdfx8iyfjMqHEO6xv2FUdXVMZ+3GhmTi+bKOXxArIND8DnpMZemLx1x946GkkIt8gJxRmR6Guj2X9ttFGsRI6Zh18B7Q1XOfgxdznGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKyc+CZT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707492881; x=1739028881;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m+5LdOQ+jTK/GyzxwvCFRkBVDD7WFaJyPCMJYBAwNOo=;
  b=gKyc+CZTLHD0s6O47OfqNxRFcAz+x7563VY455Oj8u1e+IXZUF8fcHDZ
   TO2uK3coNenXL/jWWMD3T1H8kQEHCzvPM+RhZZrH5Tp1L/tVO+hxzwIcM
   hSx4Pc1qUfsJzldM4KonWs8DndeuEajTRY4n72tdJReWLeieCuJ4j8X/k
   JGUXC6uKL0hUDozprrQVOFKbHxsubgC/B1BzsQgMoZcB6nl5v4dlXre9E
   Om1N2AFVguZc/674LAIv9BRvqUVfridi7iPi21Vg1dDYsdPlwRQ1D10ju
   qOU1z71I9o2baJ6L7oSkEh6RgbNhbQeWEUbE7usxNlk0WrRlOfa/21Oro
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5264260"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5264260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:34:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1968105"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.226])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:34:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 9 Feb 2024 17:34:34 +0200 (EET)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: think-lmi: Fix password opcode ordering
 for workstations
In-Reply-To: <20240209152359.528919-1-mpearson-lenovo@squebb.ca>
Message-ID: <dfb993c6-0e10-bc70-e8e9-a88651863a27@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20240209152359.528919-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Feb 2024, Mark Pearson wrote:

> The Lenovo workstations require the password opcode to be run before
> the attribute value is changed (if Admin password is enabled).
> 
> Tested on some Thinkpads to confirm they are OK with this order too.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Would a Fixes tag be appropriate here?

-- 
 i.

> ---
>  drivers/platform/x86/think-lmi.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 3a396b763c49..ce3e08815a8e 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1009,7 +1009,16 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		 * Note - this sets the variable and then the password as separate
>  		 * WMI calls. Function tlmi_save_bios_settings will error if the
>  		 * password is incorrect.
> +		 * Workstation's require the opcode to be set before changing the
> +		 * attribute.
>  		 */
> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +						  tlmi_priv.pwd_admin->password);
> +			if (ret)
> +				goto out;
> +		}
> +
>  		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
>  				    new_setting);
>  		if (!set_str) {
> @@ -1021,17 +1030,10 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		if (ret)
>  			goto out;
>  
> -		if (tlmi_priv.save_mode == TLMI_SAVE_BULK) {
> +		if (tlmi_priv.save_mode == TLMI_SAVE_BULK)
>  			tlmi_priv.save_required = true;
> -		} else {
> -			if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> -				ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> -							  tlmi_priv.pwd_admin->password);
> -				if (ret)
> -					goto out;
> -			}
> +		else
>  			ret = tlmi_save_bios_settings("");
> -		}
>  	} else { /* old non-opcode based authentication method (deprecated) */
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
> 

