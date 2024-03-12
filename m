Return-Path: <linux-kernel+bounces-100151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77878792A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F701C225CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6220E79949;
	Tue, 12 Mar 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbU6fWTi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0F58207;
	Tue, 12 Mar 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241268; cv=none; b=YySWrF9Fjkf8ViAGgx7s0Sl8nb+pg7svIe6gHioKT8rqDFDT6KdQ7xAXDcGyjpRrTKp77mZ5tZLgqILJ8PnkemHj47f+n8xWs3MkJWNpDjgUxioAx7PmOsM34LsffFo9Uvn6b2cuTE4wIbuIhApZP18q+nmAZnv3fySvlxBs6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241268; c=relaxed/simple;
	bh=yWxjcqk3nCMt2Sxjy1ZbQ/ciNB8fetvsro9SiWbKotA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k+c9teb09e+qL9og+ra+MSK0tSqkPfUFXCFL8RAwMfhZOVJr/YxFNVcxa2v6rTxHU0TpmvC5Kxv1vCpofUyisCb28WscUtrADvf7TPFsT6N71mJhF5htzCBb+0maiCrZy0RUjfE8EYeO8zvi3sMceR5vUEE9O5Z3hgOtzA6p6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbU6fWTi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710241267; x=1741777267;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yWxjcqk3nCMt2Sxjy1ZbQ/ciNB8fetvsro9SiWbKotA=;
  b=GbU6fWTiHG9X2mPdxLkBq8UH4FivdWrSQ7388R0kYScGE7qG7s+dpKTt
   HxWvIpLyIRgArlB5AWorQTVJdqynAg07kVko+WDOQoYO8ch0cYV4OF73k
   XUAbLzfRzfh3npHX140/aAlrbVyaQO0eYT78GNP+qNrUZWuE+Iidry+Qh
   ASjh88r6xiyQz9WJZzsWnCFXGkR5KQ5CksEpjD5HZDJO50deH9g58I7Lh
   j5pou6Fy68nLAjm0ditRUby771YYOa9zk8JP4wd6MfWwzN7hw4vV3YFSp
   DKm+c0Yyuwb0b3IIF69f/EJmTMyGn6Ac0pjCUzp3EQogUMFNmSd+Z+bEx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5062316"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5062316"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11422913"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.6])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:01:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Mar 2024 13:01:00 +0200 (EET)
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>, 
    Philipp Jungkamp <p.jungkamp@gmx.net>, Gergo Koteles <soyer@irl.hu>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH 0/2] map Fn + R key on newer Yogas and Legions
In-Reply-To: <Ze9RU8Mbnl-w8ZUL@google.com>
Message-ID: <3aa59524-1d66-0536-a0e0-264e6b089aa5@linux.intel.com>
References: <cover.1708399689.git.soyer@irl.hu> <170895405312.2243.4199399921923370447.b4-ty@linux.intel.com> <Ze0PSaOQSJMxL_Ln@google.com> <269b8adf-426a-b614-5450-383cde095c75@linux.intel.com> <Ze9RU8Mbnl-w8ZUL@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-859821774-1710241260=:1770"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-859821774-1710241260=:1770
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Mar 2024, Dmitry Torokhov wrote:

> On Mon, Mar 11, 2024 at 12:53:36PM +0200, Ilpo J=E4rvinen wrote:
> > On Sat, 9 Mar 2024, Dmitry Torokhov wrote:
> >=20
> > > On Mon, Feb 26, 2024 at 03:27:33PM +0200, Ilpo J=E4rvinen wrote:
> > > > On Tue, 20 Feb 2024 04:39:34 +0100, Gergo Koteles wrote:
> > > >=20
> > > > > This patch series adds a new KEY_FN_R input event code and map th=
e
> > > > > Fn + R key to it in the ideapad-laptop driver.
> > > > >=20
> > > > > It affects two WMI keycodes and I couldn't try the 0x0a, but I co=
uldn't
> > > > > find any indication that the refresh rate toggle should not be Fn=
 + R.
> > > > >=20
> > > > > Regards,
> > > > > Gergo
> > > > >=20
> > > > > [...]
> > > >=20
> > > >=20
> > > > Thank you for your contribution, it has been applied to my local
> > > > review-ilpo branch. Note it will show up in the public
> > > > platform-drivers-x86/review-ilpo branch only once I've pushed my
> > > > local branch there, which might take a while.
> > > >=20
> > > > The list of commits applied:
> > > > [1/2] Input: allocate keycode for Fn + R
> > > >       commit: 4e45fa464aeef4e803412b5dcce73aad48c94b0e
> > >=20
> > > I am sorry for the delay, but instead of defining a generic name we s=
hould define
> > > a proper keycode for concrete action even if nothing is printed on a
> > > particular key on a particular device.
> > >=20
> > > Please drop this patch.
> >=20
> > Dropping them at this point would bit of a hassle due to backmerges of
> > fixes branch.
>=20
> You should really wait applying patches affecting other parts of the
> kernel as well as UAPI until all maintainers responsible for them agree
> with the changes.
>=20
> Thanks.

I'm sorry about that. I'll try to be more careful in the future.

I've now replaced those patches in pdx86/for-next.

--=20
 i.

--8323328-859821774-1710241260=:1770--

