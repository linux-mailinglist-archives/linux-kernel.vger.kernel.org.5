Return-Path: <linux-kernel+bounces-63540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E058530F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4298B243A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A44207B;
	Tue, 13 Feb 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdU+NQfc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5E40BFE;
	Tue, 13 Feb 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828745; cv=none; b=UyzqnkfKVSltd1tSk41PU+w6K42OK3LStCt/PlQiEpIkA6lKW0JDeMCcw2BpTwrRKhIBUiyRfCn5Aiy/l0MRhUOkvDRvEZY+a3fg46sbWCo/0BMH+Cw+34MFbnZceaKW3stl6Rk2XTLHgA7n6fud4nNU2eRz8384kOhKIYM5Mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828745; c=relaxed/simple;
	bh=ZD1GdMXW2br6888ExGHvUmhLBqC6M5LBnwaWbeXCj6g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i2C7KAJqwqDCafslZl1+B5vw6x/EHzYmRhx0xcrILjS/pVm/rqPmeKeqjAtxGrMOSKBh3TrSdFIfDhj+9ArkUb0JR8TDj80bWMD3yAV+6A5yPcia0ontJbgRJ2kNSdZls+2EE7j8+ghJrUxy3DIemEsrkfORQKPeg6NhQPJpuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdU+NQfc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707828744; x=1739364744;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZD1GdMXW2br6888ExGHvUmhLBqC6M5LBnwaWbeXCj6g=;
  b=hdU+NQfc78lTF5SXejweSZosG9dpUwx2U84tc7oRJP6ywd0QJPCuGoK2
   T1J/owGVjgKsBtIAwU4yXD3NHN/GPWJ/RP3UP44uecgtvu5writojxAUx
   61XOpA6ij93KhuEOYe0BjpkySLGcpif6gOZh2R4Ea47Nk2VeL1FZfNVzT
   Q2zWw4S6NZ9QnHIgn8Ou9ic7Akqq/e9x4yZHkUKOaKESIXZNlrRI8T6mt
   THt7hfqUXtZbsToFNNtzcobfLH0ULaWxQucuCsTxPfy/SkYo2+CbJVrfh
   kxxOK5nS2G2wpQwMX/4UUFPxLzpN4NPdUerCraV0EMDTK3zOmWU9F3ULs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="4796983"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="4796983"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:52:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911782042"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911782042"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.103])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:52:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 13 Feb 2024 14:52:16 +0200 (EET)
To: Mark Pearson <mpearson-lenovo@squebb.ca>
cc: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: think-lmi: Fix password opcode ordering
 for workstations
In-Reply-To: <c4e6d61d-d836-4a79-a89d-141f92f6b41e@app.fastmail.com>
Message-ID: <7aa1ac00-0db4-934a-94d5-b5daacaeb863@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20240209152359.528919-1-mpearson-lenovo@squebb.ca> <dfb993c6-0e10-bc70-e8e9-a88651863a27@linux.intel.com> <c4e6d61d-d836-4a79-a89d-141f92f6b41e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-986691078-1707828736=:9580"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-986691078-1707828736=:9580
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 9 Feb 2024, Mark Pearson wrote:

> Thanks Ilpo
>=20
> On Fri, Feb 9, 2024, at 10:34 AM, Ilpo J=C3=A4rvinen wrote:
> > On Fri, 9 Feb 2024, Mark Pearson wrote:
> >
> >> The Lenovo workstations require the password opcode to be run before
> >> the attribute value is changed (if Admin password is enabled).
> >>=20
> >> Tested on some Thinkpads to confirm they are OK with this order too.
> >>=20
> >> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >
> > Would a Fixes tag be appropriate here?
>=20
> Hmmm - good point, though it has been "wrong" since it was originally imp=
lemented (where we tested on Thinkpads).
>=20
> I guess I could use the commit ID from when I originally implemented opco=
des?
> Fixes: 640a5fa ("platform/x86: think-lmi: Opcode support")

Yes, in that case the original commit is the correct one.

> Do you want me to push a new version with this?

I think this is simple enough to go through fixes branch so it depends on=
=20
Hans.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-986691078-1707828736=:9580--

