Return-Path: <linux-kernel+bounces-153574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8148ACFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569CAB25283
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8C4152E0F;
	Mon, 22 Apr 2024 14:44:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B014152DE7;
	Mon, 22 Apr 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797043; cv=none; b=sNRjEf5GBNZnszqQTjqnat2nr0Xi8HSwuyUSTONGPZl2zplbmSut7cUOfWhyETHX/0WMIm+mDZywxr+bFORUljA92Wm6xR8pEyVGUGK3r5VVXcbM+/BvgFFrCCx9qvxYuvst2RzpbcK19kuMWp3v8Mw8AWURxbxNrxwDKI8AT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797043; c=relaxed/simple;
	bh=gBUYWauvGv9ThwhZ6oDCve7DncumHaHE1b9MyIXYKWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/6C5lXupHErq6hxo1baWEd1OBYfaBEVwJVbOsi+ZN37alXl+j8y/btwlmlx9ni70ObfR/TKIXdFtLO8eq6EONaUi848eWnNkOyEdQHTanzTawlcIeRbhUt8rfeC2o3HahvjK+hjpTEZs3kMegh815T5Xlnxe2UkfHwc8GOGc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 99VZ6J5RT1q57oJ/TtxaXQ==
X-CSE-MsgGUID: l8LVkdIRSYi7K69C9TEbJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9506523"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9506523"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 07:44:01 -0700
X-CSE-ConnectionGUID: sCyeB4r8Rx6Pf/2ZUlJ3ZQ==
X-CSE-MsgGUID: MGbSjyz2SImN99WrHP67pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28851989"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 07:43:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1ryutc-000000005cN-1VZv;
	Mon, 22 Apr 2024 17:43:52 +0300
Date: Mon, 22 Apr 2024 17:43:51 +0300
From: Andy Shevchenko <andy@kernel.org>
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
	lkp@intel.com, Vladimir Zapolskiy <vz@mleia.com>,
	Rob Herring <robh@kernel.org>, jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com,
	corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v7 0/3] add support for EXAR XR20M1172 UART
Message-ID: <ZiZ3p8XVjolnzR4U@smile.fi.intel.com>
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
 <e2989aa1-7f2b-4ac3-8fd8-822c87d61a1e@kernel.org>
 <CAF1WSuzqLxpxwYuNYfHyvXLDMBE-ZU69YLXwBdQokZzhs49xzw@mail.gmail.com>
 <c5fdfc26-b8c7-4e0e-bd15-1299ec052833@kernel.org>
 <CAF1WSuzzzG_vm5b55zb_ha-Vj7H+i3ZbmPyN1F-EQxS3GLaurg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1WSuzzzG_vm5b55zb_ha-Vj7H+i3ZbmPyN1F-EQxS3GLaurg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 05:30:13PM +0300, Konstantin P. wrote:
> I do not skip it, it added to patch 2, as you requested.

You still continue top-posting!
It's not good.

You missed _my_ tag.

But please, please, wait a bit, you really need to slow down.

> On Mon, Apr 22, 2024, 16:51 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On 22/04/2024 15:50, Konstantin P. wrote:
> > > On Mon, Apr 22, 2024 at 4:45 PM Krzysztof Kozlowski <krzk@kernel.org>
> > wrote:
> > >> On 22/04/2024 15:32, Konstantin Pugin wrote:

> > >>> EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> > >>> it has additional register which can change UART multiplier
> > >>> to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> > >>> flag to guard access to its specific DLD register. It seems than
> > >>> other EXAR SPI UART modules also have this register, but I tested
> > >>> only XR20M1172.
> > >>> Yes, in datasheet this register is called "DLD - Divisor Fractional"
> > >>> or "DLD - Divisor Fractional Register", calling depends on datasheet
> > >>> version.
> > >>>
> > >>> I am sorry about too many submissions and top post reply. About second
> > -
> > >>> I do not know how to reply properly to this ML from GMail phone app.
> > About first - I just
> > >>> get very good feedback from Andy Shevchenko, and want to fix his
> > review picks ASAP.
> > >>>
> > >>
> > >> One patchset per 24h.
> > >>
> > >> Plus, you already got such review comment:
> > >>
> > >> This is a friendly reminder during the review process.
> > >>
> > >> It looks like you received a tag and forgot to add it.
> > >>
> > >> If you do not know the process, here is a short explanation:
> > >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> > >> versions, under or above your Signed-off-by tag. Tag is "received", when
> > >> provided in a message replied to you on the mailing list. Tools like b4
> > >> can help here. However, there's no need to repost patches *only* to add
> > >> the tags. The upstream maintainer will do that for tags received on the
> > >> version they apply.
> > >>
> > >>
> > https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> > >>
> > >> If a tag was not added on purpose, please state why and what changed.
> > >>
> > >> Just start using b4.
> > >
> > > There is not only for tag. I submit fixes for version 4 by mistake,
> > > so, repost to 7 was necessary, because v6 was not work (as v4). But v7
> > > should be based on v5, and v5 is tested better around tty-next.
> >
> > ???
> >
> > You got tag, didn't you? Then explain why you decided to skip it. In the
> > changelog of patchset which ignores/skips the tag.

-- 
With Best Regards,
Andy Shevchenko



