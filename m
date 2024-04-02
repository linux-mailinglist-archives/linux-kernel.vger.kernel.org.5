Return-Path: <linux-kernel+bounces-127892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1B4895269
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0F6286593
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD174262;
	Tue,  2 Apr 2024 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dzbb8kai"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97F69D31;
	Tue,  2 Apr 2024 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059519; cv=none; b=DExCS4CNtJvCcRhrgd+CxHD4jUcbNC0BfL3iaRnur2tU3fdBNwfA8MH+XnaZS0uxxdXdM/8FYzrsUdF1vyAY16PVMd0ZsEGbqCDkVEVxul4L0M9VncRmelewQe7yeqQZzXKizEsDIbu4Hcy1vp3GiHTWE6tnzckAAlJjeTpDTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059519; c=relaxed/simple;
	bh=8itSNBWONp/JWbHCXlll2v/LVKAb3eTRaE5mwetyAWQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J87oj2PlNEXu8lYIrpl0b8oYAHJGnyYTMpzdzBLbI8KsDwQDk0F3155u+900NqaAhuDHePJK0d8jr0ZjlYPjUgPClfvlNoyKqyu+jwiyyENSDUIWc0Ai8D6UVzLAHlDoiVerHI5QAkbz01X3CknhvtxOtHfSLhEEyUuc4DPmr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dzbb8kai; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712059517; x=1743595517;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8itSNBWONp/JWbHCXlll2v/LVKAb3eTRaE5mwetyAWQ=;
  b=Dzbb8kaitITZpi75b0FuidVau+cfoKlOROQjLgJj4UGZTBr0s4dNzwi2
   O99KPhjKLbPNatHk/1sn7Dbcr1ofOiRy1ybqTiapKltk9l7wkVna3DM1c
   aBumL6nLM2hi6Y+t76mlsGosTvc9fi2m0KaqkVrRp1rFNaQTtQT6v/s3q
   aL1nMl2ZrBjNMskGG7ra7K3Zhp7Te1gPqLG6FqW+eMJ2mNTjgokXq6f5J
   hZWXVlV0P+dVa0nzH/y2b1xvIjCWe3zbbT+2QWUUuHaiuxYb4mSOsuZC8
   yIppIXtycEDQCnN82NbpJD0blffuBmz78h/M46zTT/oz8PYq3FoRckscg
   w==;
X-CSE-ConnectionGUID: AA3Y304hRO201zQFbS0DPA==
X-CSE-MsgGUID: k7t5gzkCS96gql6EY+mHzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29705939"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="29705939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:05:16 -0700
X-CSE-ConnectionGUID: YBndc8D5R5qeQDWrg3M7jw==
X-CSE-MsgGUID: sjBJdEQqQsKLbM72DEpw4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="49062418"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.23])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 05:05:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 2 Apr 2024 15:05:09 +0300 (EEST)
To: Nikita Kiryushin <kiryushin@ancud.ru>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>, 
    Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
    John Ogness <john.ogness@linutronix.de>, 
    Thomas Gleixner <tglx@linutronix.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, lvc-project@linuxtesting.org
Subject: Re: [PATCH] serial: core: use sysfs_emit() in sysfs show handlers
In-Reply-To: <20240329180634.1037706-1-kiryushin@ancud.ru>
Message-ID: <2385bd33-e481-b9a4-fa9c-ccbaaa8ea52c@linux.intel.com>
References: <20240329180634.1037706-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-536657061-1712059509=:1019"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-536657061-1712059509=:1019
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 29 Mar 2024, Nikita Kiryushin wrote:

> Change sprintf() in sysfs show() handlers to sysfs_emit(),
> as recommended by sysfs documentation.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-536657061-1712059509=:1019--

