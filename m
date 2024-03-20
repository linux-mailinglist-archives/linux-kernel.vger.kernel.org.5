Return-Path: <linux-kernel+bounces-108889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F2588116F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A791C22BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1333F9F8;
	Wed, 20 Mar 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSly6aUg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333CB3D393;
	Wed, 20 Mar 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936155; cv=none; b=ZemD7nQEs44VgkGRBYChgRMBodXUCxMydS6SrsGSJau1zZEJ8t4EwLZPGB0gWIqaWsCuWpQaR/hMDmucZ9OIG7u7orL5+wP20kzaxos/1Uk+CUKTH/i1sQoyb4w2O0U3dDYwyej68obLF3yGkNDQx/2kuWptG/ktxYGOMm/hqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936155; c=relaxed/simple;
	bh=3IfBM7CZPsrnnCzumTW5cLGnUB9v0Dgtbn2eIr/xXU0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cy0nBClWoHVm/oqDaa04GFyp3meRuTxrGw0E9nGOEr65d0utykx9dJZjFGIvsO119N+uCuZ8jur8Fd7lz6wYUGG+BDRa699IQSEPC9zQRX+P9uZ+eqhUZPw5tih4SPMJUKW/3BHtG2bG0bY8GiGkXRnSW/NgGeRVi0YrGcieqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSly6aUg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710936154; x=1742472154;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3IfBM7CZPsrnnCzumTW5cLGnUB9v0Dgtbn2eIr/xXU0=;
  b=SSly6aUga6ezDGbu3Osgwf+0MYdDIxJh3udZv9eKQx9Uj3ezn4rJW68z
   wwU4lIq2hvFhbL+U8yCuIBroSgqJZiyr4GLVf7RLe4kAvxCTolb9QahJl
   mRvJILNOMo6w+F0NlTjQHscJOgZ5b2lrEA7IBFMfuczxfBf40EbGO53Xg
   c8wE2rfvz9/GxWRyPL2WIn7yWdfKMcRkh+AhqmQPERFVpDosWPH13RouL
   guXGuHIInXlYbwHJiHCDx6PyVEsUPHWzv9+187mAE58TcS05PsWqCdmhp
   itEYZ6X3g0HCuxG4BPttoo8CyxqEU0embI1iSmYD8iL8qy4EHiS1ZAPfR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="6033671"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="6033671"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 05:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14215938"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.16])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 05:02:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Mar 2024 14:02:27 +0200 (EET)
To: Luke Jones <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for Vivobook
 GPU MUX
In-Reply-To: <fbd2dc65-33d9-447e-9edb-78df370778be@app.fastmail.com>
Message-ID: <c7e375df-e709-a348-a240-0d6d8bde1840@linux.intel.com>
References: <20240310055312.11293-1-luke@ljones.dev> <20240310055312.11293-2-luke@ljones.dev> <0f35beb8-5453-63cb-0570-752b2693f6ec@linux.intel.com> <fbd2dc65-33d9-447e-9edb-78df370778be@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-738845263-1710936147=:1037"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-738845263-1710936147=:1037
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 20 Mar 2024, Luke Jones wrote:

> On Wed, 20 Mar 2024, at 1:26 AM, Ilpo J=C3=A4rvinen wrote:
> > On Sun, 10 Mar 2024, Luke D. Jones wrote:
> >=20
> > > Adjust existing MUX support to select whichever MUX support is availa=
ble
> > > so that ASUS Vivobook MUX can also be used if detected.
> >=20
> > This description is a bit on the short side. It wouldn't have hurt to=
=20
> > first state that Vivobooks come with a GPU MUX WMI that has a different=
=20
> > WMI device ID. I can infer that after reading the diff but the descript=
ion=20
> > should not require reading the patch.
>=20
> Would you prefer I changed the commit message?

I kind of tried to give some leeway for you and not sound like I'm=20
enforcing you to do it but yes, I do prefer good commit messages myself
(I know that after reading this patch the reasons will be pretty obvious=20
to anyone so it's not a grave problem). So half it was said future=20
patches in mind, half you can do it if you want also for this patch.

But since you'll need to resend this anyway because of the=20
independent/series issue I mentioned in my reply to one of the other=20
patches, just cover this minor thing as well, it's one sentence after
all.

--=20
 i.

--8323328-738845263-1710936147=:1037--

