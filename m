Return-Path: <linux-kernel+bounces-86900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6C86CC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179D2284C43
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0033B137778;
	Thu, 29 Feb 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2gWyqEL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB672137758;
	Thu, 29 Feb 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219516; cv=none; b=jQMMX7jCSa3yuWAQizDD/uazMUX3wdMCX9GUm8sEqA2jOSJEx2up4r6Rl5IQ0BGulpcX0RYPm47Y/b+w/Oxam0vvwqhvzUDHEPQvkrBKlW0R7VASb+qy/+x1V8j0xmTJfsDA6/4rdVWCVbJZXWBbYb8TO6wj8rI2LYbB+mETq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219516; c=relaxed/simple;
	bh=UMRP82nw8wcg/hwq4VlGEgT1JAcwIaZKCQDJs70vYYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lc8H08GrNAaZetzz1A6Bu1Q7sydoTfFecKz4aC0j6SzZ4VkJKnn25top0MeYm1JrXzDtp5IOikcK/481ve+d/BCh1YJn8K1T7idKknl2sKUFMWaHlN/sNusiTvOZ4niktFy/p3D+Jy/aQHxuF2now32Ox13FLNTm+2vS5RDtz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2gWyqEL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709219515; x=1740755515;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UMRP82nw8wcg/hwq4VlGEgT1JAcwIaZKCQDJs70vYYs=;
  b=C2gWyqELj0Y291u+Oz1uZ9hFDjB/ULZ9u5jrB+HRh2Xl0zh6ojT7mvlb
   aCod8SVx+/o4LCdWPBa7Nc/1/cDO2pM7AM7HLQB4KuwNeE2mQRfRNrUVY
   KoEM92Wq32EO4hvUpNZhfCzXqSfvn5SNRXM7+qdpx6A+yasS5uFKnizTO
   kj9YYDo6ZGFF4Wb5WXXwhxgQRCjPj8NcRPZf8aESNKRuw45OwxL5PGo0f
   vDSyIYNaGIiXFmglix8WF/Rwgllacbyf0Ov81mQcot9bcBIkpnuHJIKDF
   NTqlOJT36zx7McSCEZ40Srb2ACXwd/i4q/PCRiY8/HXudDFNaN8CE+2w9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="26156400"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="26156400"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12542013"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.87.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 07:11:54 -0800
Message-ID: <9c80b55de09af2549b7465b7c2322254c71d7d4e.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: Allow reading core-power state on
 HWP disabled systems
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date: Thu, 29 Feb 2024 07:11:47 -0800
In-Reply-To: <23b62f29-902c-800a-1cd4-6e24d70abd86@linux.intel.com>
References: <20240229002659.1416623-1-srinivas.pandruvada@linux.intel.com>
	 <23b62f29-902c-800a-1cd4-6e24d70abd86@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 14:32 +0200, Ilpo J=C3=A4rvinen wrote:
> On Wed, 28 Feb 2024, Srinivas Pandruvada wrote:
>=20
> > When HWP (Hardware P-states) is disabled, dynamic SST features are
> > disabled. But user should still be able to read the current core-
> > power
> > state, with legacy P-states. This will allow users to read current
> > configuration with static SST enabled from BIOS.
> >=20
> > To address this, do not call disable_dynamic_sst_features() when
> > the
> > request is for reading the state.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
>=20
> Is this a fix? (It's lacking the tag if it is).
This is not a fix. This is a feature request from a customer.
Some customer wants to use in certain way.

Thanks,
Srinivas

>=20


