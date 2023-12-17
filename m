Return-Path: <linux-kernel+bounces-2813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADB81624B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE30281248
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25FB48CC0;
	Sun, 17 Dec 2023 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R3nIxJMP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8104495C3
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BHL79dC403593
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 17 Dec 2023 13:07:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BHL79dC403593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1702847232;
	bh=0dnqhhXzm9mOHNsAfokZCYmGFUM9LzT22sJSAlB7J58=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=R3nIxJMPwrlQJEsr+ZTCtdqfMA/HfF5mSH03ods6syXlhNN+pZSMZB6gwxBkdsq44
	 BckNe3cj3E2EbArUiF43piBsX2gHxjc7/ZNZfKgYg/jhdRprxcKQtwEOKEMsCNbrPo
	 j5cZCpA0UHpPw1OJwK59K6IOk+kEeU7wds3gLbk9Cs5+EdxFMf8BRAw8mNGEC9U0I9
	 hJJVan1OHHu2YFGClAQnopw/YKQrYda99g1F3l/lbgHFepEn3amMVV0q1CWYjB4G8O
	 GE1Iod0IpE8xPM22izzZFwTLsvvjdtRxF2JvPDX5Y0R2f8Rur/Sprilx2Y2SowdYYl
	 jq/15wBM7VG+A==
Date: Sun, 17 Dec 2023 13:07:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>,
        Brian Gerst <brgerst@gmail.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH 3/3] x86/sigreturn: Reject system segements
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whXt7QZV+HDA8=PN1pTBSNTL0ZJrcqtc4af=FtJpjPQeQ@mail.gmail.com>
References: <20231213163443.70490-1-brgerst@gmail.com> <20231213163443.70490-4-brgerst@gmail.com> <CAHk-=whXt7QZV+HDA8=PN1pTBSNTL0ZJrcqtc4af=FtJpjPQeQ@mail.gmail.com>
Message-ID: <C7EB5080-639B-41EE-B494-869D5D6F60A7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 13, 2023 10:54:00 AM PST, Linus Torvalds <torvalds@linuxfoundat=
ion=2Eorg> wrote:
>On Wed, 13 Dec 2023 at 08:34, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>>
>> @@ -98,7 +98,11 @@ static bool ia32_restore_sigcontext(struct pt_regs *=
regs,
>>
>>         /* Get CS/SS and force CPL3 */
>>         regs->cs =3D sc=2Ecs | 0x03;
>> +       if (!valid_user_selector(regs->cs))
>> +               return false;
>>         regs->ss =3D sc=2Ess | 0x03;
>> +       if (!valid_user_selector(regs->ss))
>> +               return false;
>
>Side note: the SS/CS checks could be stricter than the usual selector tes=
ts=2E
>
>In particular, normal segments can be Null segments=2E But CS/SS must not=
 be=2E
>
>Also, since you're now checking the validity, maybe we shouldn't do
>the "force cpl3" any more, and just make it an error to try to load a
>non-cpl3 segment at sigreturn=2E=2E
>
>That forcing was literally just because we weren't checking it for sanity=
=2E=2E=2E
>
>           Linus

Not to mention that changing a null descriptor to 3 is wrong=2E

