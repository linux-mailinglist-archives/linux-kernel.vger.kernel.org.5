Return-Path: <linux-kernel+bounces-32256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086383591D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835DF1C2174E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BDA48;
	Mon, 22 Jan 2024 01:18:53 +0000 (UTC)
Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD3641;
	Mon, 22 Jan 2024 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705886332; cv=none; b=HpN8oKqV0cVAvH0OGlFAY6NznFkHQPP0UL/GICzDI5Bee0v2Ysxo7UbUsXhN+nI6q0dFTNsWTZ6M9tnAO2b4DavJRC/thOHoPWXjbucAokX748Px+MOC3VmS/2MFgBPdd9LZPHTs1+yzSJvtBbrzXKLvLi4x6QuUG+iSn1Bf0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705886332; c=relaxed/simple;
	bh=2poKMX0qg+XjXgrCcJfWxPUrTDfcbU4NiKXzW4D/UZY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eXPeFIPVaY16WfWsuWsKaPMjVXd3gYlwPXhN9+eKDhRwVTo+W3hXCJ8sYpNymhIkkWQftPh/S29rDG8wdcAKcGoKvED1HwIvTjP0xK7b+KAqSbmCzo71BjuVD6xQ/mRLqCIcvmDpwsZ1VHkiI/ly1twPnICOPVKnEzZ1C3AQexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40M1Ha9Y027192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Jan 2024 01:17:44 GMT
Date: Mon, 22 Jan 2024 01:17:36 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: Steven Rostedt <rostedt@goodmis.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
        x86@kernel.org, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
In-Reply-To: <20240121195649.7355e1d5@rorschach.local.home>
Message-ID: <Pine.BSM.4.64L.2401220106590.999@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
 <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
 <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org>
 <d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com> <Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org>
 <20B57BDC-9A3F-4B02-9BA9-41477088A6CE@zytor.com> <20240121195649.7355e1d5@rorschach.local.home>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Steven Rostedt dixit:

>> >This was, incidentally, triggered by looking into a problem report that
>> >something did *not* work on a Geode LX system.
>
>What problem happened?

It turned out to be a compiler issue (GCC thinks i686 means PPro,
not 686-class CPUs, and -fcf-protection causes long NOPs, which
not all 686-class CPUs support, to be inserted). This turned out
to break a large part of Debian stable on OLPCs and other systems,
and the kernel=E2=80=99s changes in nopl handling were tabled as arguments.

https://www.jookia.org/wiki/Nopl has a longer writeup on the nopl
history.

bye,
//mirabilos
--=20
<igli> exceptions: a truly awful implementation of quite a nice idea.
<igli> just about the worst way you could do something like that, afaic.
<igli> it's like anti-design.  <mirabilos> that too=E2=80=A6 may I quote yo=
u on that?
<igli> sure, tho i doubt anyone will listen ;)

