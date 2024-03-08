Return-Path: <linux-kernel+bounces-96710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54776876060
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80CAB230FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1EF524CC;
	Fri,  8 Mar 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWcasuGr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE9225CF;
	Fri,  8 Mar 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888201; cv=none; b=KmXq5I7nRlRNlwdNkMDqBHmctOc8hQX05EFXo0AcWVJfn5mlOnLO9e0XAnQoLag5JkAh4+UloDL/y/sF33F/amwUAmB8VkqXJ5IrKU1FbyBfq4Nw1BTZhAj0uGGkIj4ScABge5g3Nh8GA5llSaZcdn8Rf5NR2EMnOxOKWHzQJXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888201; c=relaxed/simple;
	bh=uQha1tFBJnHaGoRIEeuvrAp8KSth9qG6TxJD/e13900=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IdLNTL6MLDHtEv2SWtA9AL/7XGT/wChbTKEN5VBdczO416PQmH3wDu/Cp+mcWQrjLvmD+dSM27tn6OTVDtoOTAu8Oz2c/i1tG5m+hedrdMaZFCIsrkLi4J8HFGL/Ho/P/wPNfIw+KVM37SJ5noYMtvNAL/nxB1UvwCN3ozk0pBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWcasuGr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709888200; x=1741424200;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uQha1tFBJnHaGoRIEeuvrAp8KSth9qG6TxJD/e13900=;
  b=SWcasuGroCc/osl1OxPbfyAjm8L3kApy9E22od1kE8pjlKADqsuqXn0m
   mvyD85waw/c7hNCxHP8zS1N8cXJMa2suP/Bk2UmaNZBv8PLtH9PPAhKjE
   Xb+IW3UFY20pa5Ai5VsIORlAf9MDYAPnHmIRZPmUnH0yfhwSQ0yu1jx/R
   FuIjItkPDRGI32IWqisL0fnlO0SK8ZsJbXZXb/fsfs1VlJaIVxyWnUIVp
   zxutVqpZiyb1WKUY4sBJj8dj1DaDG5mAEX70dY3km9hwndryHzmPslZGA
   s8aAUtRXM10gOJOL/n1B/jdkELQOnE/ND+6KdEX+GSYhShq3dXDr8F5g/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4526313"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4526313"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="47875239"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 00:56:36 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 Mar 2024 10:56:30 +0200 (EET)
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
cc: corentin.chary@gmail.com, luke@ljones.dev, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: Consider device is absent when
 the read is ~0
In-Reply-To: <20240308053255.224496-1-kai.heng.feng@canonical.com>
Message-ID: <2186f344-a3dc-33f2-388a-55f91f31f775@linux.intel.com>
References: <20240308053255.224496-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-796059183-1709888190=:1046"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-796059183-1709888190=:1046
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Mar 2024, Kai-Heng Feng wrote:

> AAEON PICO-TGU4 board doesn't have any LED but there are bogus LED
> controls under /sys/class/leds:
> $ ls /sys/class/leds
> asus::kbd_backlight asus::lightbar  platform::micmute
>=20
> The reason is that the ~0 read from asus_wmi_get_devstate() is treated
> as a valid state, in truth it means the device is absent.
>=20
> So filter out ~0 read to prevent bogus LED controls being created.
>=20
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-796059183-1709888190=:1046--

