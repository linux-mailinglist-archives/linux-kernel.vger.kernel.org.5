Return-Path: <linux-kernel+bounces-155223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810228AE70A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0070B21522
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9339127E0A;
	Tue, 23 Apr 2024 12:54:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B385C4E;
	Tue, 23 Apr 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876886; cv=none; b=iPN0wlHcvnoIaxhriV7Nza28JYQx+/gwBxtsmt4UssnU5L1THsh5yzv1SldHPMK13A7vh8qUdFIrLQdHS5v6JqSKZCNqsogAfiLOkn3I6OKzuW1Mnur9lgwEsEwg2YGBWlGpAnjCCjlET1kdpJD8fvH5AzOnbFCqdceTrrWERBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876886; c=relaxed/simple;
	bh=bZscrFVbL5MIv+tBaZTCbom6rFShV6yOHbat7bVKsf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CERaHZoj3RMKr8zF6XolCrxQ+PN1EshI3NLpyrMLwOIDpkWqXW1Lo7vtVIe6JRCTP7XA/dqsGLe2CX8jkZIhYOsN3Eam9vH0A2m7vNyH7xb5bgClO+x0FkVfFTwYDix2Rx9p0ox09sC1iya2NiVYpM8tK39FfgOWhoAR7xJFOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: pGUV6ildRXSS0gCvzTNqZQ==
X-CSE-MsgGUID: vbb4DcbzQqOB3apoJkAOOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9996722"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9996722"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 05:54:39 -0700
X-CSE-ConnectionGUID: qARixsnoRCCYCfWyxvIvXA==
X-CSE-MsgGUID: bvVD3QNSSZuve+4VIQIGTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55557007"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 05:54:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rzFfL-00000000KxX-0nMB;
	Tue, 23 Apr 2024 15:54:31 +0300
Date: Tue, 23 Apr 2024 15:54:30 +0300
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
Message-ID: <ZievhgXTstnfr_zQ@smile.fi.intel.com>
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
 <e2989aa1-7f2b-4ac3-8fd8-822c87d61a1e@kernel.org>
 <CAF1WSuzqLxpxwYuNYfHyvXLDMBE-ZU69YLXwBdQokZzhs49xzw@mail.gmail.com>
 <c5fdfc26-b8c7-4e0e-bd15-1299ec052833@kernel.org>
 <CAF1WSuzzzG_vm5b55zb_ha-Vj7H+i3ZbmPyN1F-EQxS3GLaurg@mail.gmail.com>
 <ZiZ3p8XVjolnzR4U@smile.fi.intel.com>
 <CAF1WSuyfsjgwnum0SLsCeYVv44w_02JmRYxpe9THgtgff3VXMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF1WSuyfsjgwnum0SLsCeYVv44w_02JmRYxpe9THgtgff3VXMg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 05:57:31PM +0300, Konstantin P. wrote:
> On Mon, Apr 22, 2024 at 5:45 PM Andy Shevchenko <andy@kernel.org> wrote:
> > On Mon, Apr 22, 2024 at 05:30:13PM +0300, Konstantin P. wrote:
> > > I do not skip it, it added to patch 2, as you requested.
> >
> > You still continue top-posting!
> > It's not good.
> >
> > You missed _my_ tag.
> >
> > But please, please, wait a bit, you really need to slow down.
> >
> > > On Mon, Apr 22, 2024, 16:51 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > On 22/04/2024 15:50, Konstantin P. wrote:
> > > > > On Mon, Apr 22, 2024 at 4:45 PM Krzysztof Kozlowski <krzk@kernel.org>
> > > > wrote:
> > > > >> On 22/04/2024 15:32, Konstantin Pugin wrote:
> >
> > > > >>> EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> > > > >>> it has additional register which can change UART multiplier
> > > > >>> to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> > > > >>> flag to guard access to its specific DLD register. It seems than
> > > > >>> other EXAR SPI UART modules also have this register, but I tested
> > > > >>> only XR20M1172.
> > > > >>> Yes, in datasheet this register is called "DLD - Divisor Fractional"
> > > > >>> or "DLD - Divisor Fractional Register", calling depends on datasheet
> > > > >>> version.
> > > > >>>
> > > > >>> I am sorry about too many submissions and top post reply. About second
> > > > -
> > > > >>> I do not know how to reply properly to this ML from GMail phone app.
> > > > About first - I just
> > > > >>> get very good feedback from Andy Shevchenko, and want to fix his
> > > > review picks ASAP.
> > > > >>>
> > > > >>
> > > > >> One patchset per 24h.
> > > > >>
> > > > >> Plus, you already got such review comment:
> > > > >>
> > > > >> This is a friendly reminder during the review process.
> > > > >>
> > > > >> It looks like you received a tag and forgot to add it.
> > > > >>
> > > > >> If you do not know the process, here is a short explanation:
> > > > >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> > > > >> versions, under or above your Signed-off-by tag. Tag is "received", when
> > > > >> provided in a message replied to you on the mailing list. Tools like b4
> > > > >> can help here. However, there's no need to repost patches *only* to add
> > > > >> the tags. The upstream maintainer will do that for tags received on the
> > > > >> version they apply.
> > > > >>
> > > > >>
> > > > https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> > > > >>
> > > > >> If a tag was not added on purpose, please state why and what changed.
> > > > >>
> > > > >> Just start using b4.
> > > > >
> > > > > There is not only for tag. I submit fixes for version 4 by mistake,
> > > > > so, repost to 7 was necessary, because v6 was not work (as v4). But v7
> > > > > should be based on v5, and v5 is tested better around tty-next.
> > > >
> > > > ???
> > > >
> > > > You got tag, didn't you? Then explain why you decided to skip it. In the
> > > > changelog of patchset which ignores/skips the tag.
> >
> I am sorry about your tag, I did not notice it, if I do new version, I
> will for sure add it. About top-posting - I do not know, how not to
> top-post from GMail phone app(

I remember I was able to answer from mobile phone, but I stopped using GMail
App as it's awfully made. So, you may do it via browser and web-gmail.

> Also, I added a linux-serial mailing list into all my mail, I do not
> know why my emails are missing.

I have a script [1] that I'm using almost on a daily-basis, you may try it or
take an ideas, or even patch and send a PR if you think it can be made better.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



