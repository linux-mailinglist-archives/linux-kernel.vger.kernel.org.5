Return-Path: <linux-kernel+bounces-98725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045EA877E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EB61C21434
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB1381DA;
	Mon, 11 Mar 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LL+b8d93"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38539AFA;
	Mon, 11 Mar 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154425; cv=none; b=R4PVanqKJ4oZ13ILrkJG31k2vIZn2PJOnrsCD+iflIW+nHfMlIEZKvU8pHeNI9LOKrFsVi5bEfDb5nw5PVb+1TZBQBJ511UayTLnOdpU7AHxhxkbuKteR/mFlykesCo+HyFBwspHPdeU0Iim07X+nzHu3UZkFS5RCWTw7WkrpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154425; c=relaxed/simple;
	bh=VSP00wO7OIIGupc9rW7UIGcH4LmAgSCiiUSpQQNLfRo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DXjTT+0D14acB3NJawafKybLoBh5lRoYj8MjFZGCMlEaQmpG0J75GUF6yaajIBMAHlqqEZFcJwa5yQnr1FymnUMCanbDc/VrVAcA6a+reMp7Ydrie4dySQNNGgG7SIUm8QqPr201Rc6DsRjLc5BW6bzd90nwe+60snS2wbMhtlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LL+b8d93; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710154424; x=1741690424;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=VSP00wO7OIIGupc9rW7UIGcH4LmAgSCiiUSpQQNLfRo=;
  b=LL+b8d93nUevVTvk/eat+ouvDq+S2sB90CjvVO0+pLogbcibjz4CE+ks
   SOba8p9J5q0smshmnmBR4/DWv3Xz5JriG3sI9JoZMfx9BZMYrIsj+pDHq
   +KF1TCPVpRFuohsXE9skC50ursBnPc69mZGJj8pgX5RvnSR6e3M3H9eGV
   4L5qXtSUjvHyD374LsS0DYnOwsc3tDpi/fL+C+y/9a6g+jT3NxIted96y
   chgt/ufOWIyrot3XVpjsr9S3+d7Najf3LqzTHOepMe5Dgbd7zq+kQP7VB
   Bn0m+zcZGPGjHnQ2D+GA9z56iqWqs2uprjm9C0Y1SWXRJfi3sIjKnTLQO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4657791"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4657791"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11015172"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:53:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 12:53:36 +0200 (EET)
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>, 
    Philipp Jungkamp <p.jungkamp@gmx.net>, Gergo Koteles <soyer@irl.hu>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH 0/2] map Fn + R key on newer Yogas and Legions
In-Reply-To: <Ze0PSaOQSJMxL_Ln@google.com>
Message-ID: <269b8adf-426a-b614-5450-383cde095c75@linux.intel.com>
References: <cover.1708399689.git.soyer@irl.hu> <170895405312.2243.4199399921923370447.b4-ty@linux.intel.com> <Ze0PSaOQSJMxL_Ln@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-335598526-1710154033=:1142"
Content-ID: <654ca533-7037-e696-d270-7614da2c282f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-335598526-1710154033=:1142
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7c606b5b-6ac7-d09b-dc8e-f45e74b06bda@linux.intel.com>

On Sat, 9 Mar 2024, Dmitry Torokhov wrote:

> On Mon, Feb 26, 2024 at 03:27:33PM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 20 Feb 2024 04:39:34 +0100, Gergo Koteles wrote:
> >=20
> > > This patch series adds a new KEY_FN_R input event code and map the
> > > Fn + R key to it in the ideapad-laptop driver.
> > >=20
> > > It affects two WMI keycodes and I couldn't try the 0x0a, but I couldn=
't
> > > find any indication that the refresh rate toggle should not be Fn + R=
=2E
> > >=20
> > > Regards,
> > > Gergo
> > >=20
> > > [...]
> >=20
> >=20
> > Thank you for your contribution, it has been applied to my local
> > review-ilpo branch. Note it will show up in the public
> > platform-drivers-x86/review-ilpo branch only once I've pushed my
> > local branch there, which might take a while.
> >=20
> > The list of commits applied:
> > [1/2] Input: allocate keycode for Fn + R
> >       commit: 4e45fa464aeef4e803412b5dcce73aad48c94b0e
>=20
> I am sorry for the delay, but instead of defining a generic name we shoul=
d define
> a proper keycode for concrete action even if nothing is printed on a
> particular key on a particular device.
>=20
> Please drop this patch.

Dropping them at this point would bit of a hassle due to backmerges of
fixes branch.

Gergo please make new changes on top of for-next for the change into the=20
proper keycode (I see up sent a new series with assumption that I drop=20
the other patches).

--=20
 i.
--8323328-335598526-1710154033=:1142--

