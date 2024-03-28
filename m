Return-Path: <linux-kernel+bounces-123691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5D890CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FD21C2272C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E213AA43;
	Thu, 28 Mar 2024 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvrkwfpN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9791651B2;
	Thu, 28 Mar 2024 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662830; cv=none; b=rFrbKbr2cBxLLG+raIrteT0PehY5ilQGW3zjiK5U+osR/06p35x2W+I9rWBimqBH3ZuoCR1H2gncuIWmPvUkA7aXkb9MaNj59QHdQV3om75EapzFlWP9XGOTzwQeEfWbUo4YCI7/uvLg9wlRbK+sxEF4HoSeTAC6kcvzbToUT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662830; c=relaxed/simple;
	bh=hllItWoe55/OAq69a/mspkkgXn6x1Ii1x8UHcxndGkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSrcapeOHGIBEZP/KpTmQUc/GHMJ5s9xxgV/CKnKURXQGtE8xL8xGu4N/6esKONAXkiHQOOs8K2SMRbj9wKFwP3Q6nlFouyZErU+fI1jtiLlVm7nL4PokCOixIV6WpTUlQ+NOoxrFskKfo/l4JOI5umLq14Uvvx9O+zfPqNIoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvrkwfpN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711662829; x=1743198829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hllItWoe55/OAq69a/mspkkgXn6x1Ii1x8UHcxndGkg=;
  b=VvrkwfpNftLPxsL0Ael3Cd0V92J4QL2I4hGr7FAXU+2FNlt/qLpIdkKc
   FdNnvJM3N4uEIe0XDT1oj1u+61x4o36bfGag3729Cb/rwdb9VHrCNaUFH
   sAl/aKVGzQ3N7BtQMjf3AfNzZ52LYufCxr3ou3yCA36PKHVtfyQGVwJNE
   cicpjiSpBvLq6c39Mj/j555HRa4dImacmWbSjqoKhH6kIXmdeuOmvirqV
   nTf3gYvVyxbbIRWzyXLWvTrZKYml9C6BFi/Q5+E2cJAEyTy3w963kJAdt
   w1ix93LvqCwYLMp5S0vU8iCMvPZJ+JyKz7G96BLz7jXma/PmI0TZrFsAk
   g==;
X-CSE-ConnectionGUID: LSA0tPlfSdaTUUWyVeUs+Q==
X-CSE-MsgGUID: jqafTy4CQq6TpKRq3w2uUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6708572"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6708572"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16825714"
Received: from sroy1-mobl1.amr.corp.intel.com (HELO [10.209.99.151]) ([10.209.99.151])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:53:47 -0700
Message-ID: <fc085af8-12c0-4885-81e1-453ae203e23e@linux.intel.com>
Date: Thu, 28 Mar 2024 14:53:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: panasonic-laptop: fix NULL dereference
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>
Cc: Len Brown <len.brown@intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Harald Welte <laforge@gnumonks.org>, Matthew Garrett <mjg@redhat.com>,
 Ivan Kapranov <i.kapranov@securitycode.ru>, lvc-project@linuxtesting.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328103518.169604-1-korotkov.maxim.s@gmail.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240328103518.169604-1-korotkov.maxim.s@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/28/24 3:35 AM, Maxim Korotkov wrote:
> When initializing the pcc by calling acpi_driver_data(), the "device"
> pointer was dereferenced without checking for NULL. This seems like
> a logical mistake.
>
> Added a pointer check to ensure that it is valid
> before using it for pcc initialization.
>
> Found by Security Code and Linux Verification Center(linuxtesting.org)
>
> Fixes: 709ee531c153 ("panasonic-laptop: add Panasonic Let's Note laptop extras driver v0.94")

Since this is a remove function within kernel, is there any change for
device being NULL?

> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> ---
>  drivers/platform/x86/panasonic-laptop.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index cf845ee1c7b1..de29758b0384 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -1067,9 +1067,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
>  
>  static void acpi_pcc_hotkey_remove(struct acpi_device *device)
>  {
> -	struct pcc_acpi *pcc = acpi_driver_data(device);
> +	struct pcc_acpi *pcc;
>  
> -	if (!device || !pcc)
> +	if (!device)
> +		return;
> +	pcc = acpi_driver_data(device);
> +	if (!pcc)
>  		return;
>  
>  	i8042_remove_filter(panasonic_i8042_filter);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


