Return-Path: <linux-kernel+bounces-147455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1188A7472
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75F4C1F22CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424EA137C29;
	Tue, 16 Apr 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Q/GBub0S"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1D13792A;
	Tue, 16 Apr 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294918; cv=none; b=YWlKF0gvPm7sO2wIWLTJ3ru4gKojHBG0/ic8945KDQhCTUhp3RosQjJ00neqywYwOCsN/WpSIqda/p5h7n/AXU0wx+V9AEFK7df93119Iy+Vn+qJ9ePFTDnAJXpT7gFhy2++Rg6cA1e4erLNARymbPQaD3Y0soeM7QL59pYBKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294918; c=relaxed/simple;
	bh=Ac43jLMqQf/eO9EHaae+vUIk7xfngUWmCTeT+44YV3Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOqtKIh/NWE9YHedsnZk5rtC34cDHMKr4V/OIzBWnYrta8+Q+nGWgFhv968Nyy9Jjb/kBX8P3RdvySuKoNSJF4XbSefdaoMx7r+0jY5khxu3MBtSM6fBLXfTiJHPdl190wEd4Y7uBYrqgUJIWGvAjdLbe6cGmNGPIHoadG+maRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Q/GBub0S; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1713294909; x=1713554109;
	bh=Ac43jLMqQf/eO9EHaae+vUIk7xfngUWmCTeT+44YV3Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q/GBub0SIgyBam+4opzEKK0txUbxvfCrhfAWYuAaSiYJtSNYdp44AFC9Y8RMMlxCw
	 HXEZOppzCgWxF/UTq5ZhXx0+vd7kSizjzsE+3uoTjfdGyI1a+/F1od+NZN2/1ks8ow
	 m6hngQhsRQdLUty/0DF+MgGgtZFff+fs/pd73fUAxuSHd7AqPrDTBMesEMQzmP9Inn
	 Z76tf04rtmm1dt99egNjOuvc4a23AOjz7yZU007yWLt0IWhATgFMmFs5DXbiyxLrrG
	 zrprpzfcX7aVT5enfVvRGGyU6LtRo11WdwtyqdatIFToOgHaZlECm8HiUINe/cQ+Ka
	 /YViFEgnWX88g==
Date: Tue, 16 Apr 2024 19:15:03 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Wander Lairson Costa <wander@redhat.com>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 3/3] serial: 8250: Set fifo timeout using uart_fifo_timeout()
Message-ID: <CmMdmgjPFh8R-rH0-mjU0QdQcqhRwVr9bmApDJ7BV_9DjRBL35K_Qfjs7oIPVwGFv5mdT476a8tPtkgnWqY2lRBEfGvfhjk0yW9ueI4bcf8=@pm.me>
In-Reply-To: <Zh7KIz1AGyyS3zLT@smile.fi.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me> <20240416182741.22514-4-mcpratt@pm.me> <Zh7KIz1AGyyS3zLT@smile.fi.intel.com>
Feedback-ID: 27397442:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tuesday, April 16th, 2024 at 14:57, Andy Shevchenko <andriy.shevchenko@l=
inux.intel.com> wrote:

>=20
> > unsigned int status, tmout =3D 10000;
> >=20
> > - /* Wait up to 10ms for the character(s) to be sent. /
> > + / Wait for a time relative to buffer size and baud */
> > + if (up->fifo_enable && up->port.timeout)
> > + tmout =3D jiffies_to_usecs(up->port.timeout);
>=20
>=20
> Why do we still use that default? Can't we calculate timeout even for\
> FIFO-less / FIFO-disabled devices?

Maybe it's possible that there is some kind of rare case where the LSR regi=
ster
is not working or not configured properly for a device in which support
is being worked on...without a timeout, that would result in an infinite lo=
op.

AFAIK, when everything is working properly, there is no such thing as needi=
ng
a timeout for a uart device without fifo, as every single byte written woul=
d trigger
an interrupt anyway.

> --
> With Best Regards,
> Andy Shevchenko

--
MCP

