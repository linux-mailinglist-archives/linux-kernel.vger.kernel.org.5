Return-Path: <linux-kernel+bounces-68331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE38578DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C6F2857FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5B51BC2A;
	Fri, 16 Feb 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTYLxhhY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C701B968;
	Fri, 16 Feb 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075871; cv=none; b=ZLw4668XHG6vxnZ6x50vpPCNbXirr2iTy0/6sYgc7x+Rxiwvj1gjjfkKJ/wNuGvH4Gr6uXenKoGDGxzhMpBrWjPku9bjmiY/MaaSL20oZE6hDSg2ONO81FHWPE4OPyXlkWgDK+Rcj20JLGRHeiTOIRfV9G/3aGibm4sMi7jriNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075871; c=relaxed/simple;
	bh=5DAMBk7G/fMQ25LqLvhK5SazronXB/ayX8g/0O9oWuU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J2W1HzDy7NhhBRCKKrHGzskPoknmCFpqVAfK4c/fL/Kimf2FZyoRJhbFjVRgbfVePEgRU3YWu2Fl/fMM1XITv+JfT7rKwujzZhMG+2VQm7in+6tikjYM3OkMwELS5h+AbVweVdw1gafst9uoD5MFQsiBcqYdc3hCwXBdE85bi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTYLxhhY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708075870; x=1739611870;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5DAMBk7G/fMQ25LqLvhK5SazronXB/ayX8g/0O9oWuU=;
  b=NTYLxhhYljZOZ8QaUsBMvPOm/NG5tIjhdgvOPBd9F+1DReShPwjaGuTX
   S1Xrt7keYzoXW+aLtzm8/w/6mbcCWarl1BCzIKm1qboHit+8g2j4I3WdQ
   No0BjW9V6E4fB4eWruj6+4Rdxab9mzkQY4iBd8g3qVzfvViSRbJehw9WT
   JN3oVOgXgoF5KKDQD4PXPuhAHRZQQCMRQsI4bxVI+vZqIEfalYAx8rWic
   46obKCuv1ZH/wLdOkZjufxOUpVF8GvJu0zwlHzWUbFR6a+KjFPCda7b8H
   4OrANa+GhcIsFjql2zysk4HhuTrN6n63bY9g3nziPcCAhRUs0TNV4pjM5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2071264"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2071264"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:31:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3814413"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:31:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 11:31:01 +0200 (EET)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_of: Drop quirk fot NPCM from
 8250_port
In-Reply-To: <Zc4_IHMQWSGtCCC2@smile.fi.intel.com>
Message-ID: <cfbd1259-918b-d6c6-6018-70742c8b598c@linux.intel.com>
References: <20240215145029.581389-1-andriy.shevchenko@linux.intel.com> <835925e0-0df0-fed6-6b29-0cf4a9f811b0@linux.intel.com> <Zc4_IHMQWSGtCCC2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-912725755-1708075861=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-912725755-1708075861=:1097
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Feb 2024, Andy Shevchenko wrote:

> On Thu, Feb 15, 2024 at 06:40:15PM +0200, Ilpo J=E4rvinen wrote:
> > On Thu, 15 Feb 2024, Andy Shevchenko wrote:
>=20
> ...
>=20
> > > +=09/*
> > > +=09 * Nuvoton calls the scratch register 'UART_TOR' (timeout
> > > +=09 * register). Enable it, and set TIOC (timeout interrupt
> > > +=09 * comparator) to be 0x20 for correct operation.
> > > +=09 */
> > > +=09serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
> > > +
> > > +=09return serial8250_do_startup(port);
> >=20
> > I know this matches how it is currently done\
>=20
> Exactly, I haven't changed the workflow.
> Does it mean you are okay with the change?

Mostly. Another thing I was let bit unsure if it's okay to move that=20
serial_port_out() outside of RPM get/put that is inside=20
serial8250_do_startup().

> > but I wonder if TOIE should not be enabled until ->setup_irq()
> > has been called.
>=20
> No idea, this will need an extensive test on the hardware and should
> be done separately anyway. I have no HW to test this.

Okay.

--=20
 i.

--8323328-912725755-1708075861=:1097--

