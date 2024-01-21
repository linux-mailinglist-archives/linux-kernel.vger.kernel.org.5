Return-Path: <linux-kernel+bounces-32220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47B88358A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D2F1F21846
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591038FB2;
	Sun, 21 Jan 2024 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HLMxdGSh"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA94381A5;
	Sun, 21 Jan 2024 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705878712; cv=none; b=Agyu/qca7mMV3Lirou0H837n66PetvXJVlD0COrXeWJhflVuhbURlTHMzRZeiUxtv+rEqN0pcF5wKvi1ZIk/bTXHaE+mXMGDOFzDETanR6WtGDsQJl21sYCVM1AxmlX/dormeGhpmOaoo8wa/SbkkCAPk8S9jfgtfEdZEabqbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705878712; c=relaxed/simple;
	bh=MG81dEEUzlOJawIbbK26hTj7WRthmWC2wXOpQJBTIg8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f8UoGlYBG63+f7ml9i87GMGXg+GosLn1bZMzk966/d2Awr+D91JyB24+WOXqM/ZwEoTCc+evugElPtk5Pa5obJkENMrVKp+AW+Kgln26wZQLBImyXm2Xi+Qg+D+0z4xMNVzfeKGNQIo1QTbhSFuBr47/6gmPoyrGg0anc7X3bdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=HLMxdGSh reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40LNB0Bm2227686
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 21 Jan 2024 15:11:02 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40LNB0Bm2227686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705878662;
	bh=xtKNHfaOPZM8B+XMFsJSVlRmlVPBJeOVPXr8Y53vGyY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=HLMxdGShJOcsDPORWAgN1dFTPTiE1yWVQs/5XgAe7+YHboB2WXgX022SCGNwibjXX
	 6kWXyKzkf7lzjZiW41q/dbFUJHCLHgd5X7eE6hVSZX0KpVpy0inabv28OEwYhO+ecU
	 sFuaNJ1bmOZIKajXwBAdZ7DxYs7cqzB/fIRtpoh+sCA2i1HUbehmsXF95NsXw6TqJa
	 0CeAkDXSqQLc8l2nY9/rbGAv1xlAk6QhFC3pnUYuzhubIUeJKG/uWz9CpLcQtUUr6c
	 hRDQhlCSwIdRXgv6p/6Gcj9y/eU0+hRkOtzTu5DEHNjb0Gi7ARC7XUJeC/a2rvkL38
	 6BdkfMVYx7Hpg==
Date: Sun, 21 Jan 2024 15:10:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <David.Laight@ACULAB.COM>,
        "'Linus Torvalds'" <torvalds@linuxfoundation.org>
CC: Thorsten Glaser <tg@debian.org>, Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: RE: [PATCH 1/2] x86: Remove dynamic NOP selection
User-Agent: K-9 Mail for Android
In-Reply-To: <c911eadd249d4e4cbc8c247ed677b56a@AcuMS.aculab.com>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org> <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org> <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com> <CAHk-=whtFk2DoO8WhtmsbU9nGXUd8sKShV1Dk71krFLBjPUSeg@mail.gmail.com> <c911eadd249d4e4cbc8c247ed677b56a@AcuMS.aculab.com>
Message-ID: <38AEAC02-2507-4997-9A4C-52CA9C48AE5D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 21, 2024 2:36:32 PM PST, David Laight <David=2ELaight@ACULAB=2EC=
OM> wrote:
>From: Linus Torvalds
>> Sent: 20 January 2024 17:00
>=2E=2E=2E
>> And if I add "-r" to get relocation info, I get
>>=20
>>         call   <delayed_put_task_struct+0x1a>
>>                         R_X86_64_PLT32  rethook_flush_task-0x4
>>=20
>> which shows the raw relocation data, but with truly mind-bogglingly
>> horrendous syntax=2E
>>=20
>> Is there some sane tool that just does the sane thing and shows this as
>>=20
>>         call   rethook_flush_task
>>=20
>> which is what the thing actually means?
>
>While you are re-writing a disassembler, remember to print the
>contents of string when you get a reference into =2Erodata=2Estr :-)
>
>How many times have you had to dig out a printf format string in
>order to locate the source associated with some object code?
>It is so much easier if the disassembler does it for you=2E
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
>Registration No: 1397386 (Wales)
>

Probably don't even need to rewrite the disassembler=2E Postprocessing is =
probably sufficient=2E

