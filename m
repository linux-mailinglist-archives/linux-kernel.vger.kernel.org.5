Return-Path: <linux-kernel+bounces-103116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A124787BB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3587728487E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6BC6E61E;
	Thu, 14 Mar 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnIvgLPJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3F1A38C6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412087; cv=none; b=al57LtjVHC10XNCpYivyU0XkBPAMF1eIdbqeT1mBiV1lqv3Na39Qi+Ml6b55vQvFuvXUibItGLjMQH6C6febRahg4sNcp7Gb0edw81MP/jMYsWF2lr4qVVZkiN+eK9Er0hmpl9U/cYh287c4aG9tVNKWiOVl/xhXcTWgvBRS70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412087; c=relaxed/simple;
	bh=3AdoF7PXMMauR/QLjhj/rHqOnywAffnOLLq68/SM3B0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bIRm0tdVOvfIun746W1Pf1XAvaJe/LHcid6G6o5DhSPg4hPyIZ77AR30LrjeCPmYMAVyq/RTL7nxDPLSQwuaazUIIYHumWo2jsVixHO0uSvGaXtaDTJfVLEhQHOftu8GpfZVUWueoXV1v/ziSHTOEAknbegku8eeRt7M0KAzOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnIvgLPJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710412086; x=1741948086;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=3AdoF7PXMMauR/QLjhj/rHqOnywAffnOLLq68/SM3B0=;
  b=mnIvgLPJV+zhEmWst8jDhrxDDJX2meNtxfEVqsOhl3pGEtQqE3nOSgM9
   iTeovITun/DZHEt0osEEIpVGJfO+U/Psw+KZ6X+3FdtSIuq7pSDaFglwn
   VHH5yz6fyU8Y0uyPFx4sCP+XHOnscIrhTKMxFQcpWg+Jk5MooLoSMMYHA
   MVXKn7WiVMKnO7D2D4ebSmfFoaDFW5pXjYxIfjkXsJ1xWANcEHxpoYCDh
   /Z6RgfaFsI/QSNI2AWMFxAehsR5Eah6XpSp+iKg1Zp5HH/P32zFBBi5yU
   Y+iapoJf7xsTBBvKD3XjdX6ALkMCyLhSIXg/FQCvwUDE0LVxanAr7Kui1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5079860"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5079860"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 03:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12177178"
Received: from rboza-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.139])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 03:28:03 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] m68k: pgtable: Add missing #include <asm/page.h>
In-Reply-To: <8734t2xsde.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ba359be013f379ff10f3afcea13e2f78dd9717be.1709804021.git.geert@linux-m68k.org>
 <8734t2xsde.fsf@intel.com>
Date: Thu, 14 Mar 2024 12:28:00 +0200
Message-ID: <87ttl9qf9r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Mar 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> On Thu, 07 Mar 2024, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> When just including <linux/pgtable.h>:
>>
>>     include/asm-generic/pgtable-nop4d.h:9:18: error: unknown type name =
=E2=80=98pgd_t=E2=80=99
>> 	9 | typedef struct { pgd_t pgd; } p4d_t;
>> 	  |                  ^~~~~
>>
>> Make <asm/pgtable.h> self-contained by including <asm/page.h>.
>>
>> Reported-by: Jani Nikula <jani.nikula@intel.com>
>> Closes: https://lore.kernel.org/r/878r2uxwha.fsf@intel.com
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> Jani: Feel free to pick this up as a dependency.
>> Else I will queue this in the m68k tree for v6.10.
>
> Thanks, I'd like to pick this up as a dependency, so I can proceed with
> my series. It'll also be queued for v6.10 via the drm subsystem.

Replying here too, I've merged this via drm-misc-next as d1815393cac0
("m68k: pgtable: Add missing #include <asm/page.h>").

Thanks for the patch!

BR,
Jani.


--=20
Jani Nikula, Intel

