Return-Path: <linux-kernel+bounces-162326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC1E8B5967
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7371C2440F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0014D54917;
	Mon, 29 Apr 2024 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXAni5OU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CA5338A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396056; cv=none; b=XtOKKMHsCjroz4p0gvCER854PzukYtOa5KN2BoTRzgUN/g7pZvzulaOi2maSSEETaPgQDc8CTTS/bgzT/KeJWAu/rSZ1Fi3FtG74VZq7HNnF30gnnS+ZqSf6dRYY3kOmduxQOBmhR5BBcO18xTnQG8Ek/s1kP9qeMb65xftsMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396056; c=relaxed/simple;
	bh=mU6IqfK/ep54cTBYwZjovP3nUs54R/m1b1WtwAHyPX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0eecAACGiANCkVgjTL5a/3o5dg8nzhq6lmwgpV3zbMfeQR7dSC1Z3tUNfnB61FqJ9rRISkRDtZSJWs4mvDYc7HpVEsBHmPwAXbOK2e2kV3jRS0O7GROYkoehWKnIyPTanVp45h5cPkFdAcUVWdUGuT0bOkXwNvsPtatLuAxWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXAni5OU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714396055; x=1745932055;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=mU6IqfK/ep54cTBYwZjovP3nUs54R/m1b1WtwAHyPX8=;
  b=QXAni5OUdfUM4mCBe7QQjtVCe8dPMQXAwUStBtbaCZ4qy+IJeKafr8fx
   OpY8lT/jMVRDGiurnFR5bke3gw10KOcONJC3SgzZ98q8DkBkb/aP9Scg2
   6YAhJiKakm48nbLIzK6jWmkT5OFKUj43as3+uIepDRhLXAg0kDsxSbjMs
   jYX6XLUZuo/+/NNTkBeYXIySK7KKK3mluvwRk/5bdarKwrmk1eXlscO4x
   ymKxdSTXuNo5UVjHI0iqTakoa8uUOe0MaSaaankhxFbicDwkbZnmqNvLs
   mQzQldyzKIh1D2HcENzcTymtP5iyyq4dqDXBI5jJH7Dsmw5dhhmK7WpVJ
   Q==;
X-CSE-ConnectionGUID: eBvN2ZXCRw2zQLrY8onC4w==
X-CSE-MsgGUID: 0y1yjvwnRy2ZPYWSyDWtWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20604007"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="20604007"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:07:35 -0700
X-CSE-ConnectionGUID: q9ZWRW0aQbSPkWBKU0Er8A==
X-CSE-MsgGUID: yG4anL5fQ2aOCL2I6/SjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26067867"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 06:07:32 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
In-Reply-To: <87y18wuzao.fsf@ubik.fi.intel.com>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
 <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
 <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
 <87edd5y7lz.fsf@ubik.fi.intel.com>
 <rnybbv5sddkgtnxzad7sg2jyosr77vvud6t7ii3sssfsi7td2u@3b5nbhsprcaf>
 <875xwjxgsk.fsf@ubik.fi.intel.com>
 <rucgdqb5ejtttsd2ksvph3toeow652rdiqnohdsg6ndp6qgcwu@c3rz275bofqg>
 <871q6owe8f.fsf@ubik.fi.intel.com> <87y18wuzao.fsf@ubik.fi.intel.com>
Date: Mon, 29 Apr 2024 16:07:31 +0300
Message-ID: <87r0eouxkc.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:
>
>> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>>> I intend to change the prototype of platform_driver::remove() after the
>>> merge window leading to v6.10-rc1 closes to cook in next for some time.
>>> If this patch doesn't make it into the mainline before, I'll send it
>>> together with the change adapting the remove callback. That will go in
>>> via Greg's tree, too.
>>
>> I saw that you included this patch with your series earlier today, so I
>
> Wait, did I hallucinate this? I can't find your new series now. Ugh.
> If so, I'll put your patch back in and re-send my series right away.

Series re-sent [0]. Sorry for the mess.

[0] https://lore.kernel.org/all/20240429130119.1518073-1-alexander.shishkin=
@linux.intel.com/

Regards,
--
Alex

