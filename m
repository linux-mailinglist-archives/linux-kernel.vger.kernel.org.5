Return-Path: <linux-kernel+bounces-71349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC685A3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604AC280DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3592E859;
	Mon, 19 Feb 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7c1+v65"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0B29408;
	Mon, 19 Feb 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347120; cv=none; b=OWNTF0Knvx7d32b/FrTN6Jtq2BknMYME8xTVs9TG7XVSm1nrOKphoZaWJw0xhGTgSMGSzBCkBBtigqbaTT4CBpM4Eeya8UThkfAmgpz/f3wFW+qPZseNHnQnSeeMZs9166ZVBLCDpHkKYlyNiWdtut/c2SFS8obRzWL+eWx2qrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347120; c=relaxed/simple;
	bh=x2tSeZqCvSLh48WjR/1aaEIXZ1DQ5VUPkspUWEFkPOw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a1X4NC7LZYsjFVDOQGbNi3b+ZrWQKuAzdt4/dXVbyEYH9jkWuwgrL5yFsE05dN4WoLVBtWg7rf3Mz0g7tff/nCXXrIRYbufYDNYx5BOT/o5fRXVc7gjH92m6ppQcP+wm3WVbmScJ4TeCjizb2Nxk8DHu5Fnz2x88VYNtsme7kgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7c1+v65; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347118; x=1739883118;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x2tSeZqCvSLh48WjR/1aaEIXZ1DQ5VUPkspUWEFkPOw=;
  b=i7c1+v65C8C7H+GB6fU52O7MYTOKs9pSrXj1lOJdmI/NTF6qkyi66O9s
   sJaYfo0laSD+C2V2bqojbP2xoYZmyP7pCBX8rmPrT/CcleFISWUw2FKT9
   iM9tEUuZpyp1QxqRY8LJuds2jeqz17sSsDEoZgMQQhLofgML5SBMwUtug
   B/qklmAIGGS5BFHDxn/vXu6JyJCbIQ2wz7lHudT2DiAlC9c1putsIvssK
   YQhUoCZkpikjK6nDbBVy27SrIUV1wRsJ2WqhMRqUKNxtHkaRhEcuIlm8E
   9/4OEXkEIG1iNLVfqHEVHeIDr5mNx7EP6YvFU9hTuhuO9f1Qj/FVqw1J7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13822552"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13822552"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:51:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4387476"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.18])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:51:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 Feb 2024 14:51:48 +0200 (EET)
To: Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>
cc: Ike Panhc <ike.pan@canonical.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: support Fn+R dual-function
 key
In-Reply-To: <531e85d73c1926161eb15f8900ea77aade394b6f.camel@irl.hu>
Message-ID: <29ed8a8e-09f5-ec43-11bd-7ddd12ce08f8@linux.intel.com>
References: <0cdbc0e6eb65e160384ae0ed152e7de3ded1d9d5.1707604991.git.soyer@irl.hu>  <3b6a7bba-47a5-469c-aac1-5574ad78dadf@canonical.com> <531e85d73c1926161eb15f8900ea77aade394b6f.camel@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 Feb 2024, Gergo Koteles wrote:
> On Mon, 2024-02-19 at 10:39 +0800, Ike Panhc wrote:
> > On 2/11/24 06:51, Gergo Koteles wrote:
> > > According to the manual, Fn+R adjusts the display refresh rate.
> > > Map Fn+R to KEY_DISPLAYTOGGLE.
> > > 
> > > Signed-off-by: Gergo Koteles <soyer@irl.hu>

> > > +++ b/drivers/platform/x86/ideapad-laptop.c
> > > @@ -1091,6 +1091,8 @@ static const struct key_entry ideapad_keymap[] = {
> > >  	{ KE_KEY,	0x07 | IDEAPAD_WMI_KEY, { KEY_HELP } },
> > >  	{ KE_KEY,	0x0e | IDEAPAD_WMI_KEY, { KEY_PICKUP_PHONE } },
> > >  	{ KE_KEY,	0x0f | IDEAPAD_WMI_KEY, { KEY_HANGUP_PHONE } },
> > > +	/* Refresh Rate Toggle (Fn+R) */
> > > +	{ KE_KEY,	0x10 | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
> > >  	/* Dark mode toggle */
> > >  	{ KE_KEY,	0x13 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
> > >  	/* Sound profile switch */
> > 
> > Acked-by: Ike Panhc <ike.pan@canonical.com>
> > 
> > BTW on which ideapad we need this patch?
> > 
> 
> Oh, I somehow missed that. I found it on a Yoga 7 14ARB7.
> 
> Newer Yogas and Legions with 60Hz/90Hz displays have this refresh rate
> toggle feature.
> 
> I'm wondering if this would be worth a new KEY_REFRESH_RATE_TOGGLE
> event code? 
> 
> KEY_DISPLAYTOGGLE is used to toggle the LCD on/off in other drivers.
> 
> What do you think?

At least to me it felt like an abuse of KEY_DISPLAYTOGGLE because it's 
obviously different. But since there was existing, similar use for it 
already, I didn't push back on it but took your patch.

-- 
 i.


