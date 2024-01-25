Return-Path: <linux-kernel+bounces-38343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2989283BE16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFE81C22E99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C14A1CA83;
	Thu, 25 Jan 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLLEMHa5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270B81C696
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176571; cv=none; b=SMh323I+G9DxLcFQcepYBPUicLpXzQejfTr9fUXvaHIEEv6OHkpTGbi8FJqnD4dSDgcCXBOWgwjgpiuB0j0OX9yh0y4YmWk7HkP23+MqvDWDND5pU/f+WlHEr2A1GiOwWzoltDlXnWy5+5GfNNtfSEVCs4QAMgSaIx3aYvrh/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176571; c=relaxed/simple;
	bh=GxwRbE55YIwDHZtfx76YzVpE3RzFJjrHMcE6Kj92Rps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S/e/koer+ZWmIs4Vs1KC/Yg1BP5ZJ1I1l8gL1SpUxDh0By9RX55viXNLjvxV1grVIn5bsIWg+vm/rdtnlf/evDiks0m2evgoQ7+6EVUQofhCXarMWe+vu/QSGRXw0sss5DC9ijXSUjWX9HldsuGrWf1jCZkU9sqytHjijlVEhdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLLEMHa5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706176569; x=1737712569;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=GxwRbE55YIwDHZtfx76YzVpE3RzFJjrHMcE6Kj92Rps=;
  b=eLLEMHa5l9foFnKJqxnQBAX8Xjvez0u2bQcWX0B4uDL/bYlufuWNjKax
   gpNojaC7pCd/FPrf/6WXQqqPaXthGP5G175UVQHKbmIV0RfgTUF3LG02H
   TSKGNpxrlhAaDbJD8i6BovARojJ0pQRXNq9xumT8shnjWG54nAaRWwnNi
   yC8lPVTFM0ROIhO7pw6STJQnzQYGy2146HBHMNCow9Q/yBI5/keDHmYaw
   D7G4uWFuDDIXvclNIHeC2SNTaDe4VRtVz22ChpX66JFQyXonZeq2f00k1
   Cy/Yv1r+VysgzYkMqmz+/w//aQzOMWwyLHMpXSxCtRhZOEK5D/brIpaQG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="23578976"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23578976"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:56:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2188240"
Received: from cyrillet-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.252])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:56:05 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Gustavo Sousa <gustavo.sousa@intel.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Yury Norov <yury.norov@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, intel-xe@lists.freedesktop.org
Subject: Re: Re: [PATCH 1/3] bits: introduce fixed-type genmasks
In-Reply-To: <170611134445.31262.2799581830173501277@gjsousa-mobl2>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240124050205.3646390-1-lucas.demarchi@intel.com>
 <20240124050205.3646390-2-lucas.demarchi@intel.com>
 <87v87jkvrx.fsf@intel.com>
 <gvkvihpcc45275idrfukjqbvgem767evrux5sx5lnh5hofqemk@ppbkcauitvwb>
 <ZbEsfl0tGLY+xJl0@yury-ThinkPad>
 <170611134445.31262.2799581830173501277@gjsousa-mobl2>
Date: Thu, 25 Jan 2024 11:56:01 +0200
Message-ID: <878r4dlosu.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jan 2024, Gustavo Sousa <gustavo.sousa@intel.com> wrote:
> Quoting Yury Norov (2024-01-24 12:27:58-03:00)
>>On Wed, Jan 24, 2024 at 08:03:53AM -0600, Lucas De Marchi wrote:
>>> On Wed, Jan 24, 2024 at 09:58:26AM +0200, Jani Nikula wrote:
>>> > On Tue, 23 Jan 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>> > > From: Yury Norov <yury.norov@gmail.com>
>>> > >=20
>>> > > Generalize __GENMASK() to support different types, and implement
>>> > > fixed-types versions of GENMASK() based on it. The fixed-type versi=
on
>>> > > allows more strict checks to the min/max values accepted, which is
>>> > > useful for defining registers like implemented by i915 and xe drive=
rs
>>> > > with their REG_GENMASK*() macros.
>>> >=20
>>> > Mmh, the commit message says the fixed-type version allows more strict
>>> > checks, but none are actually added. GENMASK_INPUT_CHECK() remains the
>>> > same.
>>> >=20
>>> > Compared to the i915 and xe versions, this is more lax now. You could
>>> > specify GENMASK_U32(63,32) without complaints.
>>>=20
>>> Doing this on top of the this series:
>>>=20
>>> -#define   XELPDP_PORT_M2P_COMMAND_TYPE_MASK            REG_GENMASK(30,=
 27)
>>> +#define   XELPDP_PORT_M2P_COMMAND_TYPE_MASK            REG_GENMASK(62,=
 32)
>>>=20
>>> and I do get a build failure:
>>>=20
>>> ../drivers/gpu/drm/i915/display/intel_cx0_phy.c: In function =E2=80=98_=
_intel_cx0_read_once=E2=80=99:
>>> ../include/linux/bits.h:41:31: error: left shift count >=3D width of ty=
pe [-Werror=3Dshift-count-overflow]
>>>    41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
>>>       |                               ^~

I stand corrected.

>>
>>I would better include this in commit message to avoid people's
>>confusion. If it comes to v2, can you please do it and mention that
>>this trick relies on shift-count-overflow compiler check?
>
> Wouldn't it be better to have explicit check that l and h are not out of =
bounds
> based on BITS_PER_TYPE() than relying on a compiler flag that could be tu=
rned
> off (maybe for some questionable reason, but even so)?

My preference would be the explicit check, a comment in code, or an
explanation in the commit message, in this order. Because honestly, none
of this is obvious, and a future refactoring of GENMASK might just
inadvertently thwart the whole check.

Regardless, my main concern was moot, on the series,

Acked-by: Jani Nikula <jani.nikula@intel.com>


--=20
Jani Nikula, Intel

