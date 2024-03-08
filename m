Return-Path: <linux-kernel+bounces-96618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854FD875EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71231C22143
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E0A50A6E;
	Fri,  8 Mar 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFxDBR3u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC24F61D;
	Fri,  8 Mar 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884876; cv=none; b=Ew+no0YoWok8kPHD7+LS+ppWbv3TNMQzetaiuNq63uHYiWdHI2/FTMMCW2xVCb//rGEoNQs8Ov1RwA9PEm8/lXrhu40Esbl9X6TDd/XOkHaYN6wkScBZRQO8J8DftPfrQETx373jlsRuYSzqdfneDdYwSAjdUC0DRW1skQcgyKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884876; c=relaxed/simple;
	bh=ioKP+FCr73IWPP6an5pqKpjOX6aJDfsCIfbs7bCOtM4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k76NZPfkfAi6sUK6e6ptyiaHqm1fkxOHYyku1HzO+/RYtzKWjPpmhaynI6paY3KD2aDAUwhswsykPHP69J7BMWKDWG/AflR79bYGiBvJ30R+odOmfQJwKBRIRhGkklvzJ5cdNu9xIYvvrugUUitVDkzD4/RxlGpp4HtQI3k3HYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFxDBR3u; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709884875; x=1741420875;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ioKP+FCr73IWPP6an5pqKpjOX6aJDfsCIfbs7bCOtM4=;
  b=oFxDBR3uFBt1q5ukkI/g+DqSRm3tD9qyF56RJlHCMb9ot9/zN4uuHMqc
   +cwlEb/Q6WDE5x+Q4dBHb+CRk3D8TEb+tQWEmmbtsxlF1piphOzAjOd2Q
   tcG1k87Wy1WJaJrnkhE481hBlSvcUUfWzvJq9nJagReHfA9fFAsHYpxUu
   9nkeWASFsnIyFwEJEzjhgAQEuQTGuFX2ymRg5vSKIRacSC0lLZocWpNY6
   +V1fS7HNZvDdNpK7pE7yYFeLPUVrw1DYaC1wsatUXZF1jEutY5XWXs+At
   Jrg7+xJ0Qv0SXSrcoNcpSRtNbb2GKEd+F+8VHYBLoJVAOajH9haDZaCK/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22119413"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="22119413"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10267075"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:01:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 Mar 2024 10:01:05 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] platform/x86: wmi: Support reading/writing 16
 bit EC values
In-Reply-To: <20240307195753.2961-1-W_Armin@gmx.de>
Message-ID: <21fd57a2-d8c3-779c-7090-b7cdfc8198be@linux.intel.com>
References: <20240307195753.2961-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 7 Mar 2024, Armin Wolf wrote:

> The ACPI EC address space handler currently only supports
> reading/writing 8 bit values. Some firmware implementations however
> want to access for example 16 bit values, which is prefectly legal
> according to the ACPI spec.
> 
> Add support for reading/writing such values.
> 
> Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

> @@ -1162,27 +1188,28 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  			  u32 bits, u64 *value,
>  			  void *handler_context, void *region_context)
>  {
> -	int result = 0;
> -	u8 temp = 0;
> +	int bytes = bits / BITS_PER_BYTE;
> +	int ret;
> +
> +	if (!value)
> +		return AE_NULL_ENTRY;
> 
> -	if ((address > 0xFF) || !value)
> +	if (bytes > sizeof(*value))
>  		return AE_BAD_PARAMETER;
> 
> -	if (function != ACPI_READ && function != ACPI_WRITE)
> +	if (address > U8_MAX || address + bytes > U8_MAX)

This doesn't look correct. With address = 0xff and bits = 8 this will 
return AE_BAD_PARAMETER, is that intensional?

-- 
 i.


