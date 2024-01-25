Return-Path: <linux-kernel+bounces-39116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90383CB02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A368129ACDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46173134740;
	Thu, 25 Jan 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="d3aGhRMi"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162F51339B9;
	Thu, 25 Jan 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206928; cv=none; b=c5lHFe1tnUt9Y1/HHGkSpuXgvhshT4mgVEXKW5PAz0hLlD1+JWqMNKArvaFcvd53kp5IkeKuBTIDa4u2Dmp8kFsziR6UmXSIn5jf5kFT1t155QWGU105nKSxHxfiPImzvehGZTZqBuQsNzKR9mAFv7cKNfeA08Ev1yRlGLXOos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206928; c=relaxed/simple;
	bh=HbZRvOPmUoDoxMvnN1tcKFGHea0N3gtSkkLsdTvtCXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTYMBENjiAQKCWjfvmRioeoFsKpPMRa1Fj3PbvG7De9DuoUKD9crWZnd9VKVb/8z/FWZf59rX+QxwWP1A04x/Do0QiM/TM+GNrKRlplpKh9PXDagTEgIIkFarIdIr6QHHuAnAfBlkxVQyDOqUsNvMSmjmcxR64V32TI+SptRWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=d3aGhRMi; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=FgEoT584W6SjWCsE4sg8BnmzLjboNnQ+rbt0JzkUi6Q=; b=d3aGhRMiERnO/WXNeXVeDlrKOM
	zgo4595Zg/mk9eEoBXDdRaWRDReNwAo5RyQSK7gSg5n7JWoGJ46RJpSejU5KgA1FQhr+SBP3uyd+e
	b8sn+uQiq47KvWqLIV697u1+xs+Uc0N3o5nrnN6luUVTeAeKdD50bCiX7VkreVNDjmXNrG3KnPgD7
	FAZrXN3cEsfFuPZEWzSH9mYIERjT/+Ze+GzF+KQ5TRmdYgas6trUCQrhr/aDE78MsIAC5CwjohuCc
	N2eLVx7w2vot2rloT381XyiUzntm0RtfV28R6mEwyFOdxLLny71bGk/plJd/JEpIIOnObk476f1mk
	33R2QZHw==;
Received: from [10.69.139.15] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rT4MS-00FQJx-2Y;
	Thu, 25 Jan 2024 12:22:00 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Andy Lutomirski <luto@kernel.org>, wine-devel@winehq.org,
 Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexandre Julliard <julliard@winehq.org>
Subject:
 Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
Date: Thu, 25 Jan 2024 12:21:59 -0600
Message-ID: <3785748.kQq0lBPeGt@terabithia>
In-Reply-To: <63b3828d-8482-4435-9c98-50578bbbbe07@app.fastmail.com>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <10405963.nUPlyArG6x@terabithia>
 <63b3828d-8482-4435-9c98-50578bbbbe07@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, 25 January 2024 10:47:49 CST Arnd Bergmann wrote:
> On Thu, Jan 25, 2024, at 04:42, Elizabeth Figura wrote:
> > On Wednesday, 24 January 2024 16:56:23 CST Elizabeth Figura wrote:
> >> On Wednesday, 24 January 2024 15:26:15 CST Andy Lutomirski wrote:
> >> > On Tue, Jan 23, 2024 at 4:59=E2=80=AFPM Elizabeth Figura=20
<zfigura@codeweavers.com> wrote:
> >> [There is also a potential problem where some broken applications
> >> create a million (literally) sync objects. Making these into files runs
> >> into NOFILE. We did specifically push distributions and systemd to
> >> increase those limits because an older solution *did* use eventfds and
> >> *did* run into those limits. Since that push was successful I don't
> >> know if this is *actually* a concern anymore, but avoiding files is
> >> probably not a bad thing either.]
> >=20
> > Of course, looking at it from a kernel maintainer's perspective, it
> > wouldn't be insane to do this anyway. If we at some point do start to
> > care about cross- process isolation in this way, or if another NT
> > emulator wants to use this interface and does care about cross-process
> > isolation, it'll be necessary. At least it'd make sense to make them
> > separate files even if we don't implement granular permission handling
> > just yet.
>=20
> I can think of a few other possible benefits of going with
> per-mutex file descriptors:
>=20
> - being able to use poll() for waiting on them individually in
>   combination with other file descriptor based events (socket,
>   signalfd, pidfd, ...)

I can say for sure this isn't going to be useful for Wine, at least not wit=
h=20
the current design.

It also doesn't really mesh well with the NT design in the first place.=20
NTSYNC_IOC_WAIT_ANY differs from poll() in two major ways: it consumes stat=
e=20
of most object types, and (as coded here) it needs the owner thread ID to b=
e=20
specifically passed for mutexes.


Anyway, as Alexandre has informed me I clearly have misunderstood our=20
requirements, so I'm going to try to put together something using files=20
instead.



