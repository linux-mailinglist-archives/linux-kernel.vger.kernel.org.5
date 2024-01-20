Return-Path: <linux-kernel+bounces-31853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F20833578
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51D41C20FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7705E10A03;
	Sat, 20 Jan 2024 17:21:40 +0000 (UTC)
Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2510949;
	Sat, 20 Jan 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705771300; cv=none; b=uG6za0veBsWfwZNId+BWrPDKOxtqwF5xLsYW4sXyvLovudAuCFJpUWfVKtyDV0PC/nUZhmVxYmV1mca7J7Tg+r3hfrDLO5SkZtG4dFM/2eAXfFlFhDOOQynsmnLZHbc1CG1G0DWbi3PM8c03yLRbcKQWf7awAevUnKPffCyDcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705771300; c=relaxed/simple;
	bh=gBE4xVygc3JOwDax09M1VzTIOcA/rcCnlGWj2tBy2zo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vDZtwqnqGcwXO4qlLwa0QxEl1UaeyIXbh6aXHdMyHmdisqKjYHl7k0DCq6XNKZC/Iu5eDCuVaAN8IBKPGKr4/N5P+q6NH+nLZ2O/Wi/TVrzWKTft9Do6m2pebOdi8VbM8P1aOUYf3x3XJiPc3ahzy9NQfQLAicqxhAONNALEzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40KHJG5V000030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 20 Jan 2024 17:19:24 GMT
Date: Sat, 20 Jan 2024 17:19:16 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: Linus Torvalds <torvalds@linuxfoundation.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
        x86@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
In-Reply-To: <CAHk-=whtFk2DoO8WhtmsbU9nGXUd8sKShV1Dk71krFLBjPUSeg@mail.gmail.com>
Message-ID: <Pine.BSM.4.64L.2401201711130.29203@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
 <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
 <CAHk-=whtFk2DoO8WhtmsbU9nGXUd8sKShV1Dk71krFLBjPUSeg@mail.gmail.com>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Linus Torvalds dixit:

>On that note, does anybody have a better disassembler than objdump? Or
>even a script around it to make it more useful? I do use "objdump
>--disassemble" a fair amount, and I hate how bad it is.

Other than -Mintel (and -Mintel,i8086 for boot code) to make the
syntax 90=E2=80=9395% less awful, I=E2=80=99m sorry I=E2=80=99ve also been =
looking.

>My pet peeve is the crazy relocation handling (or lack there-of). IOW,

Yes! This!

I=E2=80=99ve been putting markers into the file and then disassembling
the final linked thing instead of just the object file I need
because of this.

>Is there some sane tool that just does the sane thing and shows this as

The only other disassemblers I know don=E2=80=99t know about ELF objects
at all, I=E2=80=99m sorry to say.

I didn=E2=80=99t know about objdump -r, but that=E2=80=99s truly awful to r=
ead.
Given a wide enough screen, an intermediate | sed 's/^\t/&&&&/'
at least moves the relocation info more to the right to interrupt
the reading flow less.

Thanks,
//mirabilos
--=20
FWIW, I'm quite impressed with mksh interactively. I thought it was much
*much* more bare bones. But it turns out it beats the living hell out of
ksh93 in that respect. I'd even consider it for my daily use if I hadn't
wasted half my life on my zsh setup. :-) -- Frank Terbeck in #!/bin/mksh

