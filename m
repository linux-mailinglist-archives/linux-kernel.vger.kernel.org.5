Return-Path: <linux-kernel+bounces-48324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFEF845A61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182771C26E56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC105F467;
	Thu,  1 Feb 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQV67DeE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCEC4500F;
	Thu,  1 Feb 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798081; cv=none; b=RJ++bqnSox4/yQhY68kS0fJ/mf71Kox6iZyc9OUC+4KdrXn95jRoeIaedql88cqEKo8zkQxNoIok6xTzrJVRPI6v2JlbhyHFlhW0YrQhoOBWsnE5mP0EkZYMhu0R/riKtq0CDV3rfZilsfE84Xy4lHuabucZF2fXmGOby9UAVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798081; c=relaxed/simple;
	bh=MwpDtmXN1dHVZjKlwVZnjRa8BnrGUX+o12/7/pZ4rzE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=juGlE91V6T0PcS7FUzKcEZLYtkvm8aZ4qWTmjKjwZ55zMx6iil7nU0/UB1EbkbD9vRX+O4Yr783NCgiWnpqOsC5AmLiJmswh/H7MiyS7HfXlZ/dSzgEz808uNMR4fGg+h+xU+HIbgbTgwVarKb8TIcWzO84gvuGuFjRpU0Xw5fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQV67DeE; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706798080; x=1738334080;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MwpDtmXN1dHVZjKlwVZnjRa8BnrGUX+o12/7/pZ4rzE=;
  b=PQV67DeE/3UPzdnxCmfjMEaxv3KOh7aYGDGBbiOz7FWHKupLJoX+C06U
   riZ/dg0dvK5+fZrihDKJTyoOODNyWIMsPtExcYwBCmXLNgHiG+bTu//xT
   19U/BqESiwA4AB9iOFYi40j63O2CwnKGcbJrsvxGGhWqZukPxWs3RVc25
   MUXe75m6jfQCcK5943GHAIrPIXWwEFtnx+7PLPMRS0uK+sZCqlgbFDMyu
   UxwubZ5sMmad4TU37rOYv8VKFrbcrOXYZAdmmbaJ+KK/G/Y2DpY1h767T
   AioVnSdHRkwlXb0hHN5aJw+3Sr7W0DMbe89VJeJLYQje55whn7Vixg1Uz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403517806"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="403517806"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="859163966"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="859163966"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:34:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 1 Feb 2024 16:34:30 +0200 (EET)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: "Hegde, Suma" <Suma.Hegde@amd.com>, naveenkrishna.chatradhi@amd.com, 
    LKML <linux-kernel@vger.kernel.org>, Carlos Bilbao <carlos.bilbao@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use
 device_add_groups()
In-Reply-To: <2024020144-duplicity-nuptials-1cd7@gregkh>
Message-ID: <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>
References: <2024012822-exalted-fidgeting-f180@gregkh> <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com> <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com> <2024020144-duplicity-nuptials-1cd7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-462016549-1706798070=:1028"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-462016549-1706798070=:1028
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Feb 2024, Greg Kroah-Hartman wrote:

> On Thu, Feb 01, 2024 at 06:50:33PM +0530, Hegde, Suma wrote:
> > On 1/29/2024 6:16 PM, Ilpo J=E4rvinen wrote:
> > > Caution: This message originated from an External Source. Use proper =
caution when opening attachments, clicking links, or responding.
> > >=20
> > >=20
> > > + Cc Suma Hegde.
> > >=20
> > > On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
> > >=20
> > > > The use of devm_*() functions works properly for when the device
> > > > structure itself is dynamic, but the hsmp driver is attempting to h=
ave a
> > > > local, static, struct device and then calls devm_() functions attac=
hing
> > > > memory to the device that will never be freed.
> > > >=20
> > > > The logic of having a static struct device is almost never a wise
> > > > choice, but for now, just remove the use of devm_device_add_groups(=
) in
> > > > this driver as it obviously is not needed.
> >=20
> > Hi Greg,
> >=20
> > Could you please hold on merging this patch for a week? I will push a p=
atch
> > for converting platform specific structure's memory allocation from sta=
tic
> > to a dynamic
> >=20
> > allocation.
>=20
> Push it where?  Ususally we do "first patch wins" type stuff, why not
> just do your work on top of mine?
>=20
> Also, when you do make the needed changes, please remove the explicit
> call to create sysfs groups and use the default groups pointer instead,
> that will make things much simpler and avoid races in the code.

Hi Greg,

Well, if you really want to "win" :-), please provide an updated version=20
which considers the changes already made in the for-next branch (the=20
current one won't apply).

--=20
 i.

--8323328-462016549-1706798070=:1028--

