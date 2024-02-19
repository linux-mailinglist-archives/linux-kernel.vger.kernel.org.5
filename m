Return-Path: <linux-kernel+bounces-71738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81D85A9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7025A1F2696E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855845953;
	Mon, 19 Feb 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jtOKukrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kdJ4re0F"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD42446A9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362407; cv=none; b=mtNn9NrQ3PJ6cPt2zgzuXUJFetfJgusFQ7bddCHfS/lWBYgesKUhTBGQBUb5gQP8BLw+uGrxVsDenlpCufaIJv8Kk1b4ZL7p+DQo1m2UursJIz52KWSfbtMk1PP2+iQnILymh+QN3im3Q2GlZRC5MJmyJxW/LT/bHXOjmdUde64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362407; c=relaxed/simple;
	bh=NjBPWEitbQB8h/c6rIA0dK3jf1as/36ddLT339U5cDA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=u122lfJX46cOPtbYl5sMEMXa/u6xkTPRqiJHEvk2dtE9KaRYi7OW3REh5yaPkgTq/8N36A0UmQM++zB+q4fR8OYra4dDEvaZcADteVspRz7Ynkt7FvzEk99EDq0fEhtFiku/8cadw4CRYw7EpjQv91Kd3kBXzmXv05a5EQuhAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jtOKukrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kdJ4re0F; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 7EE70320077A;
	Mon, 19 Feb 2024 12:06:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 19 Feb 2024 12:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708362404;
	 x=1708448804; bh=2NsTyUfjfmFCmuigRd0UfWMsj8n+TennjpPS2AonWHM=; b=
	jtOKukrLdok0XLb/u1PZvLXxkAjIXbZKOlTXkGD3fBUrVJ/qYs6a3IJXU/ndOsJq
	Vs5b+RuCGL4r1rctiphmtj+3upHQ4wcjxLX8AFWYsoJ5VtsR2deFl8db35Q590P6
	1rWvi2XkYySqsnwqllOPDnGU5DX5DNm0aZ9UWqc7MYj+o5crFSLy0rVZy3ZD64Qt
	FXfDEzDWKH+hg3b0E6rp1GohObWQw92OjiucbAg4gbDRlkIzG+Anp1eduByFOL5d
	S6MkIgFBazU4/suF2gSfuOMTQxjo/fwNyriFSHSaIrndaWVMZeFVEHGAIWQAWlx4
	gElHpgalUFX7yOsm3NyojA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708362404; x=
	1708448804; bh=2NsTyUfjfmFCmuigRd0UfWMsj8n+TennjpPS2AonWHM=; b=k
	dJ4re0FgYVOAgbyO77Y7/cKAhNXBtaQgEb0M5bl4femM7YMeOB13DDjYx5JW2QxT
	GGmwfRizOveLyyzvsWIPE3El9XX8FddlUY7OtZPnfkZDPeAYRC5BMIoM/r0Y/XgF
	ctYo/jF79EZT7gkJ4KlK+yYJu/Kun9b6HsyIWXq1fLUZ4h/i0Zmx4Nvgfd6fGdp0
	oRSU//OivYLfBBLd237UojXturjoRiFZ0z5BIJ3kgkYTJ3kcqmpiCFiYSIyY+rTj
	LNwsQLbh6D0+IoIlxhEW6RY5opjtFSOz4YfvZMSq9v9NrGvVTXmX/XHpi2p+C6m3
	LP1iQEhZxzpSPptR8+zfg==
X-ME-Sender: <xms:o4rTZfvwaWkLX1jIG4V8BXA8sqRDEZFCJYUSOnPY-JfpdF9fRSV_zQ>
    <xme:o4rTZQc59yndQ-oen0H2Ore3BV7QpyRiubwI_wO-GGLjykoi-n2L95Od7a1SlTarn
    7rzVh7ecuzbS1WqgZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepfffgudeljeduieevueegteelkefghfeffefftdefvdehteelfefgueffveeu
    geegnecuffhomhgrihhnpehgohgusgholhhtrdhorhhgpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:o4rTZSzqU5c_eiDfgJ7cUT9KZR1GndGx7KO-J3GRfpiMID_GPDqVEQ>
    <xmx:o4rTZeOokSAhI4D9EOjoLctyM5xOQHqLGycHmiZahls4aDMKLzkGUA>
    <xmx:o4rTZf-eSIOJRInhs3ppxP-Eiz7ybLb_aUkakt7U6zha8w02gsFq0g>
    <xmx:pIrTZWbIPizoH29l-buGto2MYny9-bIbmKhh4ob8xzdNCI2ZIO9FLQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 535F1B6008F; Mon, 19 Feb 2024 12:06:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dca5b082-90d1-40ab-954f-8b3b6f51138c@app.fastmail.com>
In-Reply-To: 
 <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
References: <20240206074552.541154-1-maskray@google.com>
 <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
 <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
 <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
 <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
 <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
Date: Mon, 19 Feb 2024 18:06:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ard Biesheuvel" <ardb@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Fangrui Song" <maskray@google.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, "Jisheng Zhang" <jszhang@kernel.org>,
 "Dave Martin" <Dave.Martin@arm.com>, "Peter Smith" <peter.smith@arm.com>,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024, at 16:41, Ard Biesheuvel wrote:
> On Mon, 19 Feb 2024 at 15:43, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>> On Mon, Feb 19, 2024 at 11:57=E2=80=AFAM Ard Biesheuvel <ardb@kernel.=
org> wrote:
>> > On Mon, 19 Feb 2024 at 11:56, Ard Biesheuvel <ardb@kernel.org> wrot=
e:

>> > https://godbolt.org/z/GTnf3vPaT
>>
>> I could reproduce the issue on v6.8-rc5 using arm64 defconfig
>> and x86_64-gcc-5.5.0-nolibc-aarch64-linux.tar.xz from
>> https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/:
>>
>
> OK, I managed to do so as well.
>
> And GCC 6.4 from the same source works correctly.
>
> Not sure whether there are any plans to bump the minimal GCC version
> any time soon (cc'ing Arnd), but we should probably drop this change
> until that happens.

From what I can tell, we may as well formally raise the minimum
gcc version to 8.1+ already, as that is a version that is
actually used in distros, and we have been on 5.1+ for a few
years already.

Not sure if there are any other benefits to gcc-8 besides
allowing minor cleanups.

gcc-9 would bring --std=3Dgnu2x support, but it may be too
early for that.

      Arnd

