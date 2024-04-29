Return-Path: <linux-kernel+bounces-162243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05D8B586E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43B7287DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930AA1B94D;
	Mon, 29 Apr 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bt67j0IT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B854FA5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393332; cv=none; b=p5ZvWil7ETAPCXqaV2sQpseANMjkH1X8KZvX4A2LKwiyHBt0r8HvG6BxPmi1JFfdFbXi64IZkJn1svjq75glMryY4IXfg5rSZFNfyyVPLFYE1CYlycEjN/Y17AwpLJm/j7acJz3NiUPgeEO1ppc47RBexXbEaM65gzKRi8gOXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393332; c=relaxed/simple;
	bh=f9E0JsW1Zr8WalwbdzrxALXJY56Hnqa4bXQDRCCNlz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g9ZhSzWxN53x6LuTj973op4xX8LmtEOe6wIdFqG84tfgsIT2fiitHoWZsJ5FnjU3fueZnIgM5YAUMPGy84o94pHkhf0Ju8WmiBMsxtNtDcAGCeb/Tex5zorMPvzGlzRNwuiHNSjIk5qr8HHkTgWk6VLYmf2P8gc+H37JjSQ1rwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bt67j0IT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714393331; x=1745929331;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=f9E0JsW1Zr8WalwbdzrxALXJY56Hnqa4bXQDRCCNlz4=;
  b=bt67j0ITviNy1zyWPpcTXNzkHdIiOcOPIsyoja/7jmPhlQ6B9YG7FjG2
   CWOePiJKIBIVsLPnpZMV/UhO752oHLxI0xl99qUCo89zgftPNR+n4HNwW
   HTfBIllpoo1ek7cAg0beZScUD1pfeYiW1O8M9QOzslejUFc5woHuaUclN
   HSsrl9wWDSCdO5SGioVNzuGAfuLcaKtNJTCUQcWHt9m4S+hVRbD3kgb3U
   NQnxviOylaaz1bl1qjf57jNwIN/RtNRtpDvVXlzuvct+8po7BzLlvtRJ+
   AdF684oEBTXl5pD+cnmJz63SWmFCjXAzmVMPrB9ew/NM6UONTAeoyxAEv
   Q==;
X-CSE-ConnectionGUID: SYZXKa9yTDauuQTKaYXBbA==
X-CSE-MsgGUID: 52SzO8ZSTFOA1j127B3ulQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10159315"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10159315"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:22:11 -0700
X-CSE-ConnectionGUID: mKvVOwv4SD6d84QBLCBtdQ==
X-CSE-MsgGUID: 0GtuFPyTScanG++jXwkyOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26060023"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 05:22:09 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 7/8] intel_th: Convert to platform remove callback
 returning void
In-Reply-To: <rucgdqb5ejtttsd2ksvph3toeow652rdiqnohdsg6ndp6qgcwu@c3rz275bofqg>
References: <20231107202818.4005791-1-u.kleine-koenig@pengutronix.de>
 <20231107202818.4005791-8-u.kleine-koenig@pengutronix.de>
 <i3oybmf3axeyk5rcef5kgfdb4cucd63h24gup6idn62nq3vvav@4mfzwzyamq27>
 <jawceotzgdydpz74qr2e5dwgfumwjmt4wxvi43qlwldlbgemzf@v3qa2hoopawv>
 <qiiln66o6uy2nsqdjcykygp3yumonn7jqp7q4wxf56i6pazics@iqfaiglmsgwt>
 <87edd5y7lz.fsf@ubik.fi.intel.com>
 <rnybbv5sddkgtnxzad7sg2jyosr77vvud6t7ii3sssfsi7td2u@3b5nbhsprcaf>
 <875xwjxgsk.fsf@ubik.fi.intel.com>
 <rucgdqb5ejtttsd2ksvph3toeow652rdiqnohdsg6ndp6qgcwu@c3rz275bofqg>
Date: Mon, 29 Apr 2024 15:22:08 +0300
Message-ID: <871q6owe8f.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Hello Alex,

Hi Uwe,

> On Mon, Apr 15, 2024 at 09:48:27AM +0300, Alexander Shishkin wrote:
>> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>> > Given there are not that many patches left (~50) as of today's next, I=
'd
>> > like to see this patch going in during the next merge window, that I c=
an
>> > finalize the (next step of the) quest around platform_driver::remove.
>> >
>> > Is sending this patch to Greg still on your todo list?
>>=20
>> Yes, as soon as I finalize other patches on my series. Should be soon.
>
> I know neither your nor Greg's plans, but I wonder if this patch will
> make it into v6.10-rc1 given that it still didn't land in next yet.

I've just sent my series [0].

> I intend to change the prototype of platform_driver::remove() after the
> merge window leading to v6.10-rc1 closes to cook in next for some time.
> If this patch doesn't make it into the mainline before, I'll send it
> together with the change adapting the remove callback. That will go in
> via Greg's tree, too.

I saw that you included this patch with your series earlier today, so I
dropped it from my series [0]. FWIW, you can add

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

to that patch if it helps. If you want me to pick it up again, let me
know. Apologies for the repeated tardiness in handling this.

[0] https://lore.kernel.org/all/20240429120908.3723458-1-alexander.shishkin=
@linux.intel.com/

Regards,
--
Alex

