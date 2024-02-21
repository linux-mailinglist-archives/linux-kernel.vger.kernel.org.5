Return-Path: <linux-kernel+bounces-75329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228C685E6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DC71C24192
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0585935;
	Wed, 21 Feb 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9hLApkr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8642A8E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541438; cv=none; b=A0DRXGxzlJ2c3AEfRe2bf0H205wKwTvQYPVTtVpMBSn3JEiL8UG+ukHXrFD0h9M7A6ML48LbDi1vIS9CM//Ka5Ai+y2cW9bDBx0rj363zAM50OiwFNlu/ao1Wqhg0FQlsdRX1/YPPKdhohRIM99COSvTosZ49LDRfBYD3TTaAPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541438; c=relaxed/simple;
	bh=mhvRmgtT+jSnGSxPdhDDc4NPptiHgOKbg3hxZ0mh8ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQ8M99Ic4PHrur6l274H3Lp5ohdKsFYp8AL6Du/5JkwV/jXqrT4qB9BiGO48RXuVpPywU2wnFLdGGWfB486vQKDwyLW/p4eWiXKenRolORIgl4g/asYz04IHBLqJYpw+ReMN4662KxsCO8EsNCv7sFK2GqiOlIzLtURHmtZHD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9hLApkr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708541436; x=1740077436;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=mhvRmgtT+jSnGSxPdhDDc4NPptiHgOKbg3hxZ0mh8ck=;
  b=b9hLApkrprcxKDb3E419/wQTai7ua2xXStDPFJw935pQNasqDg3S/LKN
   ymuU6mszZhJaHC9wii4hH30/X7eyG86vzXMqP2xqOFVRHf/XtS/XaWJ1e
   9Orqw3ECdowtZbU+jx8yfrnwlGqcqcBRv96SDdI7NT2t1ecv3/K/nTOw0
   zSaTEzoij5ZsuweyO9Be1xIyK8ugixeP0USrgM6Z/E3FjNW6T2+VZhFNv
   85Jt+vzeOLq3Q2eCxsD3ihHONSLufK6dj/tIh2n8/6vmKvaSHgVl5h4rA
   92VlSIq56quNysZYGo6MXNWp10g3utBSHvgd26A+ZFnhshU12LT8UbLrT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2871753"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2871753"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 10:50:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9788017"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2024 10:50:33 -0800
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Greg
 Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
In-Reply-To: <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
 <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
 <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
Date: Wed, 21 Feb 2024 20:50:32 +0200
Message-ID: <87edd5y7lz.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Hello Greg,
>
> On Thu, Feb 15, 2024 at 10:16:41PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> On Wed, Jan 10, 2024 at 09:41:54AM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> > On Tue, Nov 07, 2023 at 09:28:26PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> > > The .remove() callback for a platform driver returns an int which ma=
kes
>> > > many driver authors wrongly assume it's possible to do error handlin=
g by
>> > > returning an error code. However the value returned is ignored (apart
>> > > from emitting a warning) and this typically results in resource leak=
s.
>> > >=20
>> > > To improve here there is a quest to make the remove callback return
>> > > void. In the first step of this quest all drivers are converted to
>> > > .remove_new(), which already returns void. Eventually after all driv=
ers
>> > > are converted, .remove_new() will be renamed to .remove().
>> > >=20
>> > > Trivially convert this driver from always returning zero in the remo=
ve
>> > > callback to the void returning variant.
>> > >=20
>> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> >=20
>> > I didn't get any feedback to this patch and it didn't make it into next
>> > up to now.
>> >=20
>> > Is this still on someone's radar?
>>=20
>> Is there a chance to get this patch into v6.9-rc1? Are you the right one
>> to talk to about this patch? (According to MAINTAINERS you are.)
>>=20
>> The patch was sent during the 6.7 merge window and now already missed
>> the 6.8 one :-\
>
> I failed in several attempts to get feedback on this patch. You applied
> the last two patches for this driver (that is all patches since the
> driver was born). Would you care for that one, too? Tell me if you want
> a resend. Note that the other 7 patches from this series are already
> cared for, so if you're using b4 am or shazam, make use of -P7.

Apologies. This looks good to me, I will pick it up for my next
submission to Greg unless somebody objects.

Regards,
--
Alex

