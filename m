Return-Path: <linux-kernel+bounces-148111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E58A7DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09475B2394E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1DB80BF8;
	Wed, 17 Apr 2024 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6JgFA7d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB46A02E;
	Wed, 17 Apr 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341610; cv=none; b=nLyGyEcBeejDwAA9JnrfUdtxwYMBwH6Tlico642CGjxqNPMxFWI40VHZ6Q/6pvBJActlohk5XP8wipwPDB/APjKQewMlkLo9AbMyvmhCrcBCq/xc+zMxdwy60rHE9gUAVAXijPs7dCBo6U1sNAwXv3cf8tVPQcgS0WjaNUhk7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341610; c=relaxed/simple;
	bh=Fx5PXmOnt+cu8UKI/4+7CAwyifLLmMRP4sxlDsBLIqg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=at2xlLvD0BCCd+dt2x0OPeleO4bzXd5c6kmxHaYLmwsnews6M4X5ZQZso1+wb2eBLVQbu9mcge/QiEVTwgXVqPBwUvK5E/UbrF++UAVU5nsX7sk0LUtTCcMEHok8Ri9WMLFqe4P7fLkSYw6OpVzxAR9+c10FG/JD49ZY8DfHXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6JgFA7d; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713341608; x=1744877608;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Fx5PXmOnt+cu8UKI/4+7CAwyifLLmMRP4sxlDsBLIqg=;
  b=W6JgFA7drF0o6KTbkn2f3q8ilIHT3v/MK8ckABXMniBsVUYVO4n3F/0O
   5sqjJee8PWiqzw+9QVwpT0nW/yCNau0YROe0N+jsWdpSgaJDarEmm9UhW
   ujTjn6DpunL+g21kB4QUyKTOwVtdxrT4bCrddAL2pS3WmD82yB4DlInBD
   hmdNXcduqGElOhF1FXQGVbAU8SW/GPJaAA3pApX6hYN77uBgaEO1o42pO
   0q5/Nk+6Fsu3cjuqGaqBvBE60QGl+7AQhDMPiR2c/anHt4Q4G84cO5WYd
   pEvVV98/bKROfLZaFhnCJoIhujC5cGGoIDRwQAmHmmBpnzYvU1EhFRAwR
   w==;
X-CSE-ConnectionGUID: LkPksYK3SDuravLB6emjNw==
X-CSE-MsgGUID: S+BcJxjCTyqHbQ1rbKdVOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8679119"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="8679119"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:13:27 -0700
X-CSE-ConnectionGUID: 4i3Fn0c/QZGSzXPKPX/6Uw==
X-CSE-MsgGUID: K1VgBYjtTfGYPpnA1JUHjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22616220"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.35])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 01:13:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Apr 2024 11:13:21 +0300 (EEST)
To: Michael Pratt <mcpratt@pm.me>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    Wander Lairson Costa <wander@redhat.com>, 
    Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 3/3] serial: 8250: Set fifo timeout using
 uart_fifo_timeout()
In-Reply-To: <CmMdmgjPFh8R-rH0-mjU0QdQcqhRwVr9bmApDJ7BV_9DjRBL35K_Qfjs7oIPVwGFv5mdT476a8tPtkgnWqY2lRBEfGvfhjk0yW9ueI4bcf8=@pm.me>
Message-ID: <7e66eafe-902c-38ab-b624-d9386c1bcd22@linux.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me> <20240416182741.22514-4-mcpratt@pm.me> <Zh7KIz1AGyyS3zLT@smile.fi.intel.com> <CmMdmgjPFh8R-rH0-mjU0QdQcqhRwVr9bmApDJ7BV_9DjRBL35K_Qfjs7oIPVwGFv5mdT476a8tPtkgnWqY2lRBEfGvfhjk0yW9ueI4bcf8=@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Apr 2024, Michael Pratt wrote:
> On Tuesday, April 16th, 2024 at 14:57, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > > unsigned int status, tmout = 10000;
> > > 
> > > - /* Wait up to 10ms for the character(s) to be sent. /
> > > + / Wait for a time relative to buffer size and baud */
> > > + if (up->fifo_enable && up->port.timeout)
> > > + tmout = jiffies_to_usecs(up->port.timeout);
> > 
> > 
> > Why do we still use that default? Can't we calculate timeout even for\
> > FIFO-less / FIFO-disabled devices?

Yes we definitely should be able to. Unfortunately these patches just keep 
coming back not in the form that follows the review feedback, but they 
come up their own way of doing things which is way worse and ignores the 
given feedback.

> Maybe it's possible that there is some kind of rare case where the LSR register
> is not working or not configured properly for a device in which support
> is being worked on...without a timeout, that would result in an infinite loop.

"without a timeout" is not what Andy said. He said you should always have 
a timeout, regardless of there being FIFO or not. And that timeout should 
be derived in the same manner from baudrate and FIFO size (to address the
cases w/o FIFO, the fifosize should be lower bounded to 1 while 
calculating the FIFO timeout).

> AFAIK, when everything is working properly, there is no such thing as needing
> a timeout for a uart device without fifo, as every single byte written would trigger
> an interrupt anyway.

While I agree the general principle, that this is backup that should not 
even be needed, the statement is partly incorrect. We don't get interrupts 
during console write because they're disabled. But LSR should still change 
and allow progress without the backup timeout.

-- 
 i.


