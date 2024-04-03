Return-Path: <linux-kernel+bounces-129652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92607896DE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E11228D8CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A21419B3;
	Wed,  3 Apr 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JO1Rz2tL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VIONJcZP"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCAA1353E2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143050; cv=none; b=s/gziTvcwkqoQl1XeDOi4FJpbSxSsrBy/I0beP3V2PsDEJlPfCzOvhd2F3UjlTKkHL2KHTg2gJMbO5PKYzzOMe373/L1Hd8ev7WMuvZut7v5zjaWz49b6uv+lgieNqRRvK19r23IkJy0vWOWq0V3HASrbsTX9KuvAbcA342fzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143050; c=relaxed/simple;
	bh=hVe9rbSPpT2y71SxD/q11C+ArqBPm7Fa1Gwafs7sHM4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JR8YvslJA+c5rmtFk6Yv3Ls8OU5xK99uB6drL6Cd3FDMOjXCABciwzGg+MdqmsH8Ih/radurePKndrJWZMfYN1H4uuAJyQtNW56uWi6ig5JIql7s5rJZM090+z/BrT6XI9AqWd6o08IMGT0BWzw7ZwQV1DXsCh5xHhz8V88nHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JO1Rz2tL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VIONJcZP; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5BD9B138018F;
	Wed,  3 Apr 2024 07:17:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 07:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712143047;
	 x=1712229447; bh=gbdRMeNJ6ALKR+3+hWL9ZqdoOal70v+nuEve4HR/CQw=; b=
	JO1Rz2tLI7Ma0JjtwrzkGEkz9hSCLJhsxeULuLb6C5TXucDPVEJoUyUaHdBNN2m6
	26lo5XemS017jTZFAyHFBaU1A1/eXwEM5P6vESQIx1j78Uu0YwSC/SBzzKmj3MtD
	UMRgr83iopvPUdPatr5CnNofvWIWlsytb/B/HUHR5O4yKXnzIHzA//bDVwnTPwm6
	PbiM/mcNvmsFnzGx7RI9hbYqAMClaenNo/rV+U3a4QykXsoo8Nbs7Yw4C/Dgs/Qf
	Zwj9HbtQ5VlXZmJmBOlBEuwBvaUWf6v3ce4aotFM7rjtquvYtcxXDUAWL5ZMp693
	+8g7+EV7hPQg12vnYuYrMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712143047; x=
	1712229447; bh=gbdRMeNJ6ALKR+3+hWL9ZqdoOal70v+nuEve4HR/CQw=; b=V
	IONJcZPa5Itt751Ra1NUbEPIYjGfWgM5CY2EWU/rZsYOHOPFYHoPWd8KSkdin/qi
	vSZq4IT29fyF6oiJJbGlNkpJMID4v8LXy7/+v6f/sXxM15xwU5UZhDdxwxODi6CH
	Awp+kx3ECjkSpVqbEleYp64044OZUMfkrn7LZ2VL2Ayid+aPFvniCIBGKZZ7j+Bq
	o9L1Phr4AihxnKFfAWXP6Dq7qQ3o8qQquhgQ+pLnroOR/6YPIv6Omcb74n+kpy9+
	+gi3jPUPuXHon/qN6ydA6GMWD6l19G23SJ9y7J2pohsoBnpbpMVnvqH6nBbEhHfg
	75IhsFUwPpBfbw+IMmFDQ==
X-ME-Sender: <xms:xjoNZm5R9FVsmKvAJ41w1le4LaewYsU3dwWHh2tIivBv5G0LJwD-7g>
    <xme:xjoNZv6bjdcf1aIyI5rczcDpOAi0I0dHtKsA2f09gWWVQnwDDxlgemMHAyYaxNRrt
    Q72xCeuSghjLwn0QcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefhedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:xjoNZlf3-QqN9gFEUDV78JW0ZmjZaJ4cHbCuWUN-5kXXSFsO7hp7Dw>
    <xmx:xjoNZjLmvftUBSL57wUDkfbWXKK5zzlzlTrPbqxpJJ4UXRz5IWFMiA>
    <xmx:xjoNZqKzB5tXrFdOV7oGDKIZ6OP3DAyuFcTtzKvnTywySIlvopoatA>
    <xmx:xjoNZkyk6YPlqcL_frNQCQ6xBkHBgCyQl87n_0oOFrZ8DIB8UJ2qvQ>
    <xmx:xzoNZsjMu5rr0GTWb5E3JxNMDJeh3CqNsz513omGA1797VirUjrNlkK->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A1592B6008D; Wed,  3 Apr 2024 07:17:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <80d7ab36-2746-43c7-a9b5-184f59981b81@app.fastmail.com>
In-Reply-To: 
 <CAPyNcWdPJYOtDbun-qUJApm9ndsVkEj-sHDfbMWK2yCT6FOwdA@mail.gmail.com>
References: 
 <CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com>
 <CAPyNcWeu+bzyQg9S3wDb43jbfk95Su5XcSRFPzUbS2ofZ=+5Fg@mail.gmail.com>
 <347bb21e-98db-4bd5-9ca1-550eac5be9f8@app.fastmail.com>
 <277decf7-d9cb-451c-a105-6ecc998f9f46@intel.com>
 <CAPyNcWeXpidnVsXgt4XpwXiA0CRFdZYFN9O2ys5oq9FQKXNxsw@mail.gmail.com>
 <CAPyNcWdPJYOtDbun-qUJApm9ndsVkEj-sHDfbMWK2yCT6FOwdA@mail.gmail.com>
Date: Wed, 03 Apr 2024 13:17:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anton Protopopov" <aspsk@isovalent.com>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "David Ahern" <dsahern@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>
Subject: Re: include/linux/build_bug.h:78:41: error: static assertion failed: "struct
 bpf_fib_lookup size check"
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024, at 12:09, Anton Protopopov wrote:
> On Wed, Apr 3, 2024 at 11:57=E2=80=AFAM Anton Protopopov <aspsk@isoval=
ent.com> wrote:
 end.
>>
>> Yeah, I am sending a patch for this right now. Better not to depend on
>> compiler options
>
> One __packed__ was not enough though. The problem was also with the
> union of two __u16's which is padded to be 32 bits when AEABI=3Dn and
> the whole structure is packed (so total size is 66 in this case).

The __packed attribute is easy to misunderstand, in this case you
would need to mark every internal union and struct as well, since
you otherwise run into one or both of these problems:

- an inner aggregate with explicit packing still requires
  32-bit alignment (and padding) for each member, even if the
  outer struct puts it at an unaligned position

- You get a compiler warning if an internal structure
  is follows the normal alignment constraints but is located
  at an unaligned offset, since that violates the alignment
  constraints of the C standard.

      Arnd

