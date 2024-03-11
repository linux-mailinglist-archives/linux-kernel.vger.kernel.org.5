Return-Path: <linux-kernel+bounces-98882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A768780A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EFD1F21B31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26933FE2B;
	Mon, 11 Mar 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyRdoZjS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DB3FB93;
	Mon, 11 Mar 2024 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163696; cv=none; b=Py5Y7s49k3ltOhq1FwZ5+oiI2Oa41xBvT33XX9GeRwQK6NTtX6F2OnvT0dqFqPLuyTUxF2DwKU1HC5JGcphUUWvejZUlCTrxuVFLkPeB+Pordehm3Dp+T/rrni3jgN2vl/04D9zLc8nsC9bvpkl2KdnP+Ua+xvy25MPSYgFWz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163696; c=relaxed/simple;
	bh=sp8wPVWLcMFirjt1xb+bkWZ4tLirl6iWsWdIf0hhyrg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KxOz32VSntoRUoo+SY6vFICPrORZtI9NQBjoVYWpqPFBbsE9dMoISC8s2yw5XUxKvbfpxwFKBoP9xqr9Y0lnh8VG8fiVx0vzrXHWOGOQ4DqF+qWBgSHAjUhn6ZKqbUJbbnocngoZe5HOZhJF5Fd8/oZ9cBiZ8kPgIkl+i2yyGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyRdoZjS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710163694; x=1741699694;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sp8wPVWLcMFirjt1xb+bkWZ4tLirl6iWsWdIf0hhyrg=;
  b=EyRdoZjSzBWbANkbyCEuYUKhvhBgQrJi8xh2JrruXi56DOo0UFMiUyD6
   M9lPHKCSfppgLpefIET43TW3CIkAtqyMvFUQjchGTcIvRmMpqnMuech9Z
   6Cao+es1nQNmReHEYChPLveLMWG0Zf9Q+vb4q1phmzmXY8TbPCFnFjYlU
   VE3T6ic/AiRlxh1S8ZyRf3hS69ERMSv58qas85l6h8xZ6FwRMsi4+DjFE
   Hk48CGaOhGeITEXvBsVttVBybzFamH5SD5n1y3zU6QkgmRIAEkAr/Naso
   J5dW7L0xiwFVshVM9L2z5Q5xaiPwvhwMVIpkWp6xHkNJkKs7TAW7p7vTM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15963217"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15963217"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11259697"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:28:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 15:28:00 +0200 (EET)
To: Gergo Koteles <soyer@irl.hu>
cc: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH v2 0/2] map Fn + R key on newer Lenovo Yogas and
 Legions
In-Reply-To: <cover.1710065750.git.soyer@irl.hu>
Message-ID: <f77afd46-a238-630e-e77f-2c2506097554@linux.intel.com>
References: <cover.1710065750.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 10 Mar 2024, Gergo Koteles wrote:

> Hi All,
> 
> This patch series adds a new KEY_REFRESH_RATE_TOGGLE input event code 
> and maps the Fn + R key to it in the ideapad-laptop driver.
> 
> It affects two WMI keycodes. I couldn't try the 0x0a.
> 
> Regards,
> Gergo
> 
> Changes in v2:
>  - use KEY_REFRESH_RATE_TOGGLE instead of KEY_FN_R
> 
> [1]: https://lore.kernel.org/all/cover.1708399689.git.soyer@irl.hu/
> 
> Gergo Koteles (2):
>   Input: allocate keycode for Display refresh rate toggle
>   platform/x86: ideapad-laptop: map Fn + R key to
>     KEY_REFRESH_RATE_TOGGLE

Hi,

As mentioned in the other thread, please redo this on top of 
pdx86/for-next.

-- 
 i.


