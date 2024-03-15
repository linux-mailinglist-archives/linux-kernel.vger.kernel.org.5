Return-Path: <linux-kernel+bounces-104300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EBB87CBDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27250283873
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82D1A5BA;
	Fri, 15 Mar 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRPzuBFi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7869199DC;
	Fri, 15 Mar 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710500740; cv=none; b=mGqZnDGb01B0Km1EHN7BWXMp20J6hBpk9VRPTaMEC1ftFyGh1JsePo5XYyKOcXMWxsfkXXI5cvNi9hE/fMtFfivNQQb1prdNY3rIv72m+746WSTCcZonaZTqaZig+Z0dKXV3BTeTGZWiInLtFYiO8Xc012j5XzLFNV9e1VdPxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710500740; c=relaxed/simple;
	bh=MgqARmkmFiRKcZvZFNIWXFpXn8vOmw2GlN6mG+1hCBs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j+KpDxxVM61Spmc8c/q9qFkMibPfIgucJUdIcZQye/cbj8p8aAQlMIva9tB+znFy6itLV9UYMJsEn7F485heOjP1VY2caZT9dHvN2TeqO8ZbxwRhEAC6ZNC3kGGRoABO6FCpd07DDuUL+Dlr8taBHDmMaJRbnSUQDVMfkPIPrvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRPzuBFi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710500739; x=1742036739;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=MgqARmkmFiRKcZvZFNIWXFpXn8vOmw2GlN6mG+1hCBs=;
  b=BRPzuBFitS6iakO3rFqHq5qOAoqQ1f53Km8LE4sz02WQlw4QF9qfyA0Q
   05yjuooN8J2JKLo7O5LiHjqH53tfHWqp3S+I/1douli0wb4sWkAK5/W1a
   QNN5uejUqes4V8/K8aceNOPl4b1UcE7BlzV0RbcldbZtoELVvE3CUpKXC
   POV5ZwIOQVxDt5aMGGb4GgDFDmrQIFbeBWn+hnX7pMK4xEHj+1vyNFgAR
   m6mnQ1/AvPZ18CFhPwwZVBd/APnNAq+AKOy/7P1RZttvnL/rvj72nzs7h
   Mh1PwIuwlui3qANPbucBprKSWtxXh67sq7VomIqg6jj4XVaIJ4d+PjKHi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15914712"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="15914712"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17230365"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.9])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 04:05:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 15 Mar 2024 13:05:29 +0200 (EET)
To: Ivor Wanders <ivor@iwanders.net>
cc: Maximilian Luz <luzmaximilian@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] platform/surface: platform_profile: add fan
 profile switching
In-Reply-To: <20240314223733.6236-2-ivor@iwanders.net>
Message-ID: <71c9e24b-c64b-581c-87f0-fb0c58066ceb@linux.intel.com>
References: <20240314223733.6236-1-ivor@iwanders.net> <20240314223733.6236-2-ivor@iwanders.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1830540064-1710500675=:1018"
Content-ID: <44724541-d78b-5b49-543d-941a89ec3610@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1830540064-1710500675=:1018
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <dd311c35-3889-204d-1240-e502d6dda41a@linux.intel.com>

On Thu, 14 Mar 2024, Ivor Wanders wrote:

> Change naming from tmp to platform profile to clarify the module may
> interact with both the TMP and FAN subystems. Add functionality that
> switches the fan profile when the platform profile is changed when
> a fan is present.
>=20
> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
> Link: https://github.com/linux-surface/kernel/pull/145
> Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> Changes in v2:
>   - Added link entry to commit message.
>   - Use u8 instead of char for the argument of __sam_fan_profile_set.
>   - Made profile and profile_le variable const.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-1830540064-1710500675=:1018--

