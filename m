Return-Path: <linux-kernel+bounces-2831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA981628E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DBAB21477
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3448CE6;
	Sun, 17 Dec 2023 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q8lWjJck"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507B487A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BHLjrZP415745
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 17 Dec 2023 13:45:54 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BHLjrZP415745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1702849554;
	bh=UBkT/UbBN1VUMnPrXVesUOXFqJl0PBzlbqiMgCj6YiM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Q8lWjJck6lo62970EYOSiAdoOQSYPD2tS12Sy4JJqusCXUNTUZp2BaEEMgM9paE1m
	 0BbhJtj4d1bauy+7ILwlABKR0aPdrhfRM27JOawwgau08BD+Cn7NYe/lM7NcpUH6sp
	 YJMj6pbfA7N7MF3N2xslYQKZN+ih450F+RqlspH7Anz1ULCPI/ITHqmp2KqMLrFo49
	 9l+btLU5uKpL3iDLfa2Hquv3ioAo06L3F0GJPmfw3Z7ZGqVdcAoBjp05IO8gYI+Fvn
	 +z5c3qnxVsA2Vj34SDnhvyR4iWlmo2nNybFar31RV8iVaM8zlUBBqEAu5HCpu9uEVs
	 y41WkMTSuaPgg==
Date: Sun, 17 Dec 2023 13:45:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
CC: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH 3/3] x86/sigreturn: Reject system segements
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgOxf3u-4qp9z+50y93dw2aj_nnx3Y8zLo_GGBA4U92BQ@mail.gmail.com>
References: <20231213163443.70490-1-brgerst@gmail.com> <20231213163443.70490-4-brgerst@gmail.com> <CAHk-=whXt7QZV+HDA8=PN1pTBSNTL0ZJrcqtc4af=FtJpjPQeQ@mail.gmail.com> <C7EB5080-639B-41EE-B494-869D5D6F60A7@zytor.com> <CAHk-=wgOxf3u-4qp9z+50y93dw2aj_nnx3Y8zLo_GGBA4U92BQ@mail.gmail.com>
Message-ID: <2D83F195-CFE8-41D2-87AB-60B148CC5672@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 17, 2023 1:40:53 PM PST, Linus Torvalds <torvalds@linuxfoundati=
on=2Eorg> wrote:
>On Sun, 17 Dec 2023 at 13:08, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> On December 13, 2023 10:54:00 AM PST, Linus Torvalds <torvalds@linuxfou=
ndation=2Eorg> wrote:
>]> >Side note: the SS/CS checks could be stricter than the usual selector=
 tests=2E
>> >
>> >In particular, normal segments can be Null segments=2E But CS/SS must =
not be=2E
>> >
>> >Also, since you're now checking the validity, maybe we shouldn't do
>> >the "force cpl3" any more, and just make it an error to try to load a
>> >non-cpl3 segment at sigreturn=2E=2E
>> >
>> >That forcing was literally just because we weren't checking it for san=
ity=2E=2E=2E
>> >
>> >           Linus
>>
>> Not to mention that changing a null descriptor to 3 is wrong=2E
>
>I don't think it is=2E All of 0-3 are "Null selectors"=2E The RPL of the
>selector simply doesn't matter when the index is zero, afaik=2E
>
>But we obviously only do this for CS/SS, which can't be (any kind of)
>Null selector and iret will GP on them regardless of the RPL in the
>selector=2E
>
>              Linus

Of course not for CS/SS, but I would agree that if the selector is 0 befor=
e the signal it shouldn't mysteriously and asynchronously become 3=2E

