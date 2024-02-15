Return-Path: <linux-kernel+bounces-66880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB685630D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D29B2C32E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A812C52D;
	Thu, 15 Feb 2024 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSVhTIBG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9012BF06;
	Thu, 15 Feb 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999648; cv=none; b=Mmxq9AqK/S11Z8hQ6RZIPMOviRijOL57oDB++6rywg+nRUxM4ujbU+OD2RkK1jWvDo6Rwd0rTsQXm4e0Okm+8E6A9ePn0NVuWPrZ4kuxksQm8QhRlm/Jfkoy+TbZvvJzyBRs8jMcvMBQ5y/rpJAIP6cbeJRAzIegTTMR9Ruz10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999648; c=relaxed/simple;
	bh=AvAdvQwLcOfX6j/BUVnTPJuxC5LlC000NkZpa5BlS10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qybaDcR9scRzszxGV+6qqIoTv2vNiZf2WGFvelD441g4C2NCWTshwigKE3Ehmk8G2Vm+Ucq9OOgALCRm4PzfKsOy1496KwYHrqWq93JUY/44MI8PrAOleiXT9WHbpLnLJ+NUAG8/Wma1amgfF4nqIMcgUUj1GY2uy76sGQvFgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSVhTIBG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707999647; x=1739535647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AvAdvQwLcOfX6j/BUVnTPJuxC5LlC000NkZpa5BlS10=;
  b=LSVhTIBG7pNad/FgO6bk2RIl+SI96auaUeQ31couuH7BPwaHtC6Ved17
   CuOgk626I4uftjuLMiRSbGcBcNoRvrE2pAafXINiLFc6IraLyBxMfatAc
   aviYtlkAJfMc/I8+f67aMzq6T9+0Ht1bLjtiQCipRsv4UktQev9Zisqp7
   D61IQwSc7qL6ORWNMVj3XXv/5xQ92027+QHtybzQP6h22sZf0WcCNrYel
   opx//E3jartNywoq5Qq5W4mkVkexsbRe1dT5xlQ1tyNMR/bhGKlodhYOB
   vemKPfd8VArDprmYaRMXiuxzWF8INAJgVy/vegFmvmvP8dxHvCkKArcsh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5050042"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5050042"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:20:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912157233"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912157233"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 04:20:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raajJ-00000004mmf-1lNV;
	Thu, 15 Feb 2024 14:20:41 +0200
Date: Thu, 15 Feb 2024 14:20:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 12/15] auxdisplay: ht16k33: Switch to use line display
 character mapping
Message-ID: <Zc4BmcVF-dEX4Mvo@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-13-andriy.shevchenko@linux.intel.com>
 <CAMuHMdUBMieOt8V03OzRXO84w6RTjnMDHwBr3RtAWc+v-cRUsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUBMieOt8V03OzRXO84w6RTjnMDHwBr3RtAWc+v-cRUsA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 09:16:05AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 12, 2024 at 6:04 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

..

> > +static int ht16k33_linedisp_get_map_type(struct linedisp *linedisp)
> > +{
> > +       struct ht16k33_priv *priv = container_of(linedisp, struct ht16k33_priv,
> > +                                                seg.linedisp);
> > +
> > +       switch (priv->type) {
> > +       case DISP_MATRIX:
> > +               /* not handled here */
> > +               return -EINVAL;
> > +
> > +       case DISP_QUAD_7SEG:
> > +               INIT_DELAYED_WORK(&priv->work, ht16k33_seg7_update);
> > +               return LINEDISP_MAP_SEG7;
> > +
> > +       case DISP_QUAD_14SEG:
> > +               INIT_DELAYED_WORK(&priv->work, ht16k33_seg14_update);
> > +               return LINEDISP_MAP_SEG14;
> > +       }
> 
> error: control reaches end of non-void function [-Werror=return-type]
> 
> Missing "return -EINVAL";
> 
> This case cannot happen, so it wasn't handled in the old code.
> But with the new code, it fails at compile-time.

What is the command line and compiler you are using?
I have compiled this code without issues.

-- 
With Best Regards,
Andy Shevchenko



