Return-Path: <linux-kernel+bounces-100152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778698792A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F60283A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30779951;
	Tue, 12 Mar 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PohRhB9I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4C58207;
	Tue, 12 Mar 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241376; cv=none; b=UweNabm3BrrpwhlhzxHPfEKZlz7Wb5sfsReTktzPZ3jk+5l7CQ/L3tvYo/qfIcSx+bcvcbSecHPfnRcu6Y6rNeQP4p3yC/v+SFq9hcvI4eU5IDvQMWjNcbhh1KdL7ulEjZ+kskS2oYSZbHPlArabh5hbqQBk+ZBchyfqU0tkxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241376; c=relaxed/simple;
	bh=jdZ39KgFKi+P+VuX9T2V/8LYAIxgcSoisypNOOasOd4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZmyxTwR6s70Ak9KCPzhdeIiM2a0mxtDQrfcDwyFDJlRNeQBUVf/yj7sZwG3eAmmFMYG/eLit4uxTMh0hKt4QNrtY3isEd+AXPwSnE+el+1HEwFat/lN3h3vBxQrUX8PG61lQYCJSsnfFwW6ht2fxy1dQ651EbnX7q7a0yDJL7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PohRhB9I; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710241374; x=1741777374;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jdZ39KgFKi+P+VuX9T2V/8LYAIxgcSoisypNOOasOd4=;
  b=PohRhB9IsFnlM8b+dRxIHjnTkxM7vVlB77ifaYyYiL+nsHLBVRfVGZTp
   LJWabDj5IMYfthBqFQjjmxO1+e4blbHPkcrfXrRqQ/0DZeVuJqv2NpjV9
   5FLt1sfapVDQPrQ8yxIonALUeNuB6MwC6RDAe1ZSQMqrQbRbiT4d9Ceaz
   i4Hp6XrZ+VWC2QCOOzYT64FiTctGwfFZw0dLn+pH6UGsFFBBDNVfK8GtS
   e8hSafCVoQT/qi2i4fTFiRWf1WqjzIqaV0ljYx+tk/lTnVM7C/gc7ufP5
   IG2P23y3ew5WA70inq+so7K+AjLv4UrnSYQDNK3aQhgRAdtvZrh2LUzhD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4803122"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4803122"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:02:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11418748"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.6])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:02:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Mar 2024 13:01:59 +0200 (EET)
To: Gergo Koteles <soyer@irl.hu>
cc: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH v2 0/2] map Fn + R key on newer Lenovo Yogas and
 Legions
In-Reply-To: <f77afd46-a238-630e-e77f-2c2506097554@linux.intel.com>
Message-ID: <af3e8249-e363-46b2-9d3e-859d5e20bacf@linux.intel.com>
References: <cover.1710065750.git.soyer@irl.hu> <f77afd46-a238-630e-e77f-2c2506097554@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1272444202-1710241319=:1770"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1272444202-1710241319=:1770
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Mar 2024, Ilpo J=E4rvinen wrote:
> On Sun, 10 Mar 2024, Gergo Koteles wrote:
>=20
> > This patch series adds a new KEY_REFRESH_RATE_TOGGLE input event code=
=20
> > and maps the Fn + R key to it in the ideapad-laptop driver.
> >=20
> > It affects two WMI keycodes. I couldn't try the 0x0a.
> >=20
> > Regards,
> > Gergo
> >=20
> > Changes in v2:
> >  - use KEY_REFRESH_RATE_TOGGLE instead of KEY_FN_R
> >=20
> > [1]: https://lore.kernel.org/all/cover.1708399689.git.soyer@irl.hu/
> >=20
> > Gergo Koteles (2):
> >   Input: allocate keycode for Display refresh rate toggle
> >   platform/x86: ideapad-laptop: map Fn + R key to
> >     KEY_REFRESH_RATE_TOGGLE
>=20
> As mentioned in the other thread, please redo this on top of=20
> pdx86/for-next.

Nevermind, I replaced the original patches with these two.

--=20
 i.

--8323328-1272444202-1710241319=:1770--

