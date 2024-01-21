Return-Path: <linux-kernel+bounces-32230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B4A8358E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224342822E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DAB367;
	Mon, 22 Jan 2024 00:10:51 +0000 (UTC)
Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92895195;
	Mon, 22 Jan 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882251; cv=none; b=tm/1/Apb4oscfw/oCGhN3Es14hlYGOaoG8Zn2BzV6fPlZOkSe/H3u2sg7Ddcja3kQldoMSM3NgNbKjY6BOxkDy0fvJUIQpiUXoG6dUoCmJYp/sYMCQFphKNbckflhxvi/DTu18KM163CLQGwWBfxX52gNwBIL9iDmQaSKOxxH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882251; c=relaxed/simple;
	bh=i1LLD5pj5IdOf6XxKkB7dJJ9iRSC3xD/bjbvPMftkak=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ezfi24SF349IrvBT//f+VkoiduTpFJIeH9I7u4bxDIBl2XtcRWVJlXDTM9VLrZcd5K8rozlJcnSJH+MiomIOFzS2zdJfMtw0Kff23PlqCLOPG/QrAjComIyjP4KtxvzWqWK2DcqPSfCR6DTkWsYyKwq6nR44RM2FaE2SGnHH9oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40LNwBdR015513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Jan 2024 23:58:25 GMT
Date: Sun, 21 Jan 2024 23:58:11 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, rostedt@goodmis.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
In-Reply-To: <d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com>
Message-ID: <Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
 <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
 <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org>
 <d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

H. Peter Anvin dixit:

> But yes, with all even remotely recent CPUs all actually handling nopl
> properly, this isn't relevant anymore.

This was, incidentally, triggered by looking into a problem report that
something did *not* work on a Geode LX system.

People don=E2=80=99t just run Linux on =E2=80=9Crecent CPUs=E2=80=9D (thoug=
h I at least got me
an Atom and a Core2Duo for it and run BSD on my Pentium-M and VIA C7
systems).

bye,
//mirabilos
--=20
=E2=80=9ECool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.=E2=80=9C
=09-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: =E2=80=9C[=E2=80=A6]uhr.gz is a reason to install mksh on every system=
=2E=E2=80=9D)

