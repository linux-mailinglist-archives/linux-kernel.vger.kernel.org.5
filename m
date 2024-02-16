Return-Path: <linux-kernel+bounces-68755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F8857F96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AC028D0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008112EBDD;
	Fri, 16 Feb 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyaot3mB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCD12C7F9;
	Fri, 16 Feb 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094507; cv=none; b=ffGl/W+ILhCxhPjYxWnIZTHRlkd2S91UtpwpzC4hFdlCAszwRWllqRl7o2inGRwuzEroZKMsIyrO0d1ZT1+49wDtwLFRv0YFhYfTx5qaMXgUZRUgLE75Rc+PakovJyDVpevGuuFysyudFhBwwMuIc8dhHS71XImSptV/eLNurl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094507; c=relaxed/simple;
	bh=SJfWuVrYm6W7g9wgVBs61EgaeDg8McjlOJnxC3WqQqE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jJvvdEuPJwLxAl3EHMVqniDTDC6IF03Oq7nXbJbNCxmmWPjg7oiMdJ1Dt1xZkQrqIiR52pRLAPlJq6ukyvnG9H5aU7iuz41MWDkCBA9b+kaWIO0dkPDgLSmKnN/yi88Zq5I99kFQL5mcA+3V8m1YyxtOh8yRCAGf66hWSBMULb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyaot3mB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708094506; x=1739630506;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SJfWuVrYm6W7g9wgVBs61EgaeDg8McjlOJnxC3WqQqE=;
  b=nyaot3mBiIPhpME4YdhNi9U+9HoPQ6z7bU0ZcUCRqMKCSZnAKKIrQmoz
   fSN3Sjyl3/GphrmKX11N6Kqu5H0CvI1HAHDQQ5Zb5CAUBkwYw/ItM8DeY
   U0a3YOnW2mrPqjiDUMwuVsVz3tMoKs+hBCUB1bZFEmEpZM4Q9clGDHifR
   Ck4l0ozv8PbzEsUjeu8Ug1EKGlGrvDSYhCJqc/1E3NxQqxDMACzYzfPD+
   SLqzU9s+2k7UlO/GVqr2mSD+C56gOReWWJr9anpc0QxZ88MNFlweOUy68
   0b7ltSlZ+MqpEHyGif+ogrBvQb7NZIWn7SdIBXQ3Mogt9RWZPctMxtLFZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2373598"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2373598"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:41:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="34642652"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:41:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 16:41:37 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_of: Drop quirk fot NPCM from
 8250_port
In-Reply-To: <Zc9zsrp5KeSRoqxP@smile.fi.intel.com>
Message-ID: <3885f098-140c-bd5a-922d-a010236cc87d@linux.intel.com>
References: <20240215145029.581389-1-andriy.shevchenko@linux.intel.com> <835925e0-0df0-fed6-6b29-0cf4a9f811b0@linux.intel.com> <Zc4_IHMQWSGtCCC2@smile.fi.intel.com> <cfbd1259-918b-d6c6-6018-70742c8b598c@linux.intel.com>
 <Zc9zsrp5KeSRoqxP@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-993169058-1708094497=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-993169058-1708094497=:1097
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Feb 2024, Andy Shevchenko wrote:

> On Fri, Feb 16, 2024 at 11:31:01AM +0200, Ilpo J=E4rvinen wrote:
> > On Thu, 15 Feb 2024, Andy Shevchenko wrote:
> > > On Thu, Feb 15, 2024 at 06:40:15PM +0200, Ilpo J=E4rvinen wrote:
> > > > On Thu, 15 Feb 2024, Andy Shevchenko wrote:
>=20
> ...
>=20
> > > > > +=09/*
> > > > > +=09 * Nuvoton calls the scratch register 'UART_TOR' (timeout
> > > > > +=09 * register). Enable it, and set TIOC (timeout interrupt
> > > > > +=09 * comparator) to be 0x20 for correct operation.
> > > > > +=09 */
> > > > > +=09serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
> > > > > +
> > > > > +=09return serial8250_do_startup(port);
> > > >=20
> > > > I know this matches how it is currently done\
> > >=20
> > > Exactly, I haven't changed the workflow.
> > > Does it mean you are okay with the change?
> >=20
> > Mostly. Another thing I was let bit unsure if it's okay to move that=20
> > serial_port_out() outside of RPM get/put that is inside=20
> > serial8250_do_startup().
>=20
> We have other (actively used AFAIK) drivers which do the same.
> In any case this driver does not use RPM anyway, and in the future,
> when Tony finalizes his RPM work those 8250 RPM wrappers should gone.
> If somebody implements RPM in this driver, it may be done via standard
> RPM calls.
>=20
> TL;DR: for now it's okay, I am sure.

Okay,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-993169058-1708094497=:1097--

