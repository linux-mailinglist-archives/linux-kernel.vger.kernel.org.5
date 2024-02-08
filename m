Return-Path: <linux-kernel+bounces-58587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9FE84E88F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB5A2953FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F68E2563F;
	Thu,  8 Feb 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgfI801I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF720B34;
	Thu,  8 Feb 2024 18:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418204; cv=none; b=lhja7JRwZsrKeqZylKe9WLKqJ7IzCu0zOs6sgb8M2AMjfwpzaj1fN/TiQ+GAPz1DF5aqhQvZaZltEUOj0uyE79pC3QU2nFtzbMyE8d08fFP7rbnRsv3M8YHqHCVcP2DohKnVCZE1YFDNOGqfehdYVdXzQS7nBzPR/VYaMDtAYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418204; c=relaxed/simple;
	bh=hwTf093RVjq/m/qVR5K2tlUN00/hzHQE6eH+6DkfOdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXC5v3muJq5wS2BVrAv1i3BPXkyjmQq3BVWo4CjeibmMOqxK7psT17ygkQhzQUKLhew1p3rENABrIogTFote3FugMDe7Tc5eGNt8NGkm0bgTOWjZUAwy4TnMOSrH0fzZBD5fHVCHx6AdQx3rTMS+wgS7mtIwj8iNou7MRbVCg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgfI801I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418203; x=1738954203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hwTf093RVjq/m/qVR5K2tlUN00/hzHQE6eH+6DkfOdQ=;
  b=jgfI801IVZ0F5wz/uofuUA33HjTDf2cRaVfZvppt9C6rF4nzG7GYsf04
   5Uq9ebjc+A9LNpQl7eim/TONzULFIuRW6OfPslDfnVTn+4itGajnQiJgq
   LXpIXT8FmYYS2Kj004Y805nugoLVw0JeN7+kjDq8HrPdaSJ08gNJHjpX3
   2RRp7WF1/M6xrYsBbO04Hif1ino1dVp/bUmbmh4BE5A1KTbE1YDXsCkIR
   3z7GsMgy6fDdQMkV+eBJ1+wbEPqKZdBd744hum8B2lWv4ZdkDJDuOUmCV
   0dDh1aNOcOprvgfybpE9zsAL1dHKeyS8FFfR36Lx4Jp9zAVHPuHbhzVNB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1179204"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1179204"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910469418"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910469418"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY9TA-00000002xPb-3wmy;
	Thu, 08 Feb 2024 20:49:56 +0200
Date: Thu, 8 Feb 2024 20:49:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 00/15] auxdisplay: linedisp: Clean up and add new
 driver
Message-ID: <ZcUiVAk7uwJdqvsc@smile.fi.intel.com>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
 <20240208-drearily-carwash-60e4ba70a559@spud>
 <CAMuHMdWBbjHe8D+sn94wMqXy3Rv-VU2CDWca=fJKyH+=G_ngmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWBbjHe8D+sn94wMqXy3Rv-VU2CDWca=fJKyH+=G_ngmw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 07:10:40PM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 8, 2024 at 6:52 PM Conor Dooley <conor@kernel.org> wrote:
> > On Thu, Feb 08, 2024 at 06:58:43PM +0200, Andy Shevchenko wrote:
> > > Add a new initial driver for Maxim MAX6958/6959 chips.
> > > While developing that driver I realised that there is a lot
> > > of duplication between ht16k33 and a new one. Hence set of
> > > cleanups and refactorings.
> > >
> > > Note, the new driver has minimum support of the hardware and
> > > I have plans to cover more features in the future.
> > >
> > > Andy Shevchenko (15):
> > >   auxdisplay: img-ascii-lcd: Make container_of() no-op for struct
> > >     linedisp
> > >   auxdisplay: linedisp: Free allocated resources in ->release()
> > >   auxdisplay: linedisp: Use unique number for id
> > >   auxdisplay: linedisp: Unshadow error codes in ->store()
> > >   auxdisplay: linedisp: Add missing header(s)
> > >   auxdisplay: linedisp: Move exported symbols to a namespace
> > >   auxdisplay: linedisp: Group line display drivers together
> > >   auxdisplay: linedisp: Provide struct linedisp_ops for future extension
> > >   auxdisplay: linedisp: Add support for overriding character mapping
> > >   auxdisplay: linedisp: Provide a small buffer in the struct linedisp
> > >   auxdisplay: ht16k33: Move ht16k33_linedisp_ops down
> > >   auxdisplay: ht16k33: Switch to use line display character mapping
> > >   auxdisplay: ht16k33: Use buffer from struct linedisp
> > >   dt-bindings: auxdisplay: Add Maxim MAX6958/6959
> > >   auxdisplay: Add driver for MAX695x 7-segment LED controllers
> >
> > Not all of these patches have made their way to the lists FYI:
> > 2024-02-08 16:58 Andy Shevchenko [this message]
> > 2024-02-08 16:58 ` [PATCH v1 01/15] auxdisplay: img-ascii-lcd: Make container_of() no-op for struct linedisp Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 02/15] auxdisplay: linedisp: Free allocated resources in ->release() Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 03/15] auxdisplay: linedisp: Use unique number for id Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 06/15] auxdisplay: linedisp: Move exported symbols to a namespace Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 07/15] auxdisplay: linedisp: Group line display drivers together Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 08/15] auxdisplay: linedisp: Provide struct linedisp_ops for future extension Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 09/15] auxdisplay: linedisp: Add support for overriding character mapping Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 10/15] auxdisplay: linedisp: Provide a small buffer in the struct linedisp Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959 Andy Shevchenko
> > 2024-02-08 16:58 ` [PATCH v1 15/15] auxdisplay: Add driver for MAX695x 7-segment LED controllers Andy Shevchenko
> > https://lore.kernel.org/all/20240208165937.2221193-1-andriy.shevchenko@linux.intel.com/
> 
> Same for my mailbox.

I just resent it, hopefully without missing parts now.

-- 
With Best Regards,
Andy Shevchenko



