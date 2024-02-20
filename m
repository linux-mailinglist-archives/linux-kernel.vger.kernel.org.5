Return-Path: <linux-kernel+bounces-73218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FECB85BF83
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 933BBB21A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410274E13;
	Tue, 20 Feb 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tY11oLHE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="coHV/e+m"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260D745F7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441821; cv=none; b=hSZfm2toPf6coH8+qbDWNTZpJm5GqqKjhqkeraG7UUmk43m3xe3tf5Mgo55l7Pag7lEpOID9SHfc5pUE43Luu9PNsUbEHXeM6j667wPpbh7ywlHLdLoTu/pxDgaO5u2WIDr/IFb+yCIJdNk5/OdcLsc8ytUzS/0MvRMDUeeJSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441821; c=relaxed/simple;
	bh=8uKXtErleUTOrIMNYktGodmojGKjihEgbYdtl9mFGgo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZHGPiB/8RFnyapIA7IZY2TtRg5yobhG6fkZMgW+W0bTaToGYm/D/eRuIvQTXrUiWwxurzuiEcw7VZ2o626a/H/Xizl3fgbyJ3NKENeXNDsTru2kzQb2yJ34sjuCXVG43EYyeNKDFP1p7+mgCIzPHO/+wwqbn7I/2GhaLzDoT7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tY11oLHE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=coHV/e+m; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 4B1E71C00096;
	Tue, 20 Feb 2024 10:10:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 10:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708441817; x=1708528217; bh=Atu0OpnXzZ
	orWtqFeTIeosaeih3wF0IbqGTMPEqB/RI=; b=tY11oLHEtqcO9Z0if6sonscf2L
	Z3Lf0sdP1MLmKYk7ZgAczwPZZMjpTqfG7nUKztQRS9iTCTAXqvsfiKhCa2fSrTMa
	vbJSFqcFqPCU1uzHzSWceNQpx1THQT6hqYBIc/nhm0nqpdk4E2vgZFHJ4jHi1m8v
	pK4MyfTI7RE6ls//2k/h7/tGOLYS+L3FtM0hHkngzjztfeIKjSm9wxu3AOEWD+v+
	OMbr+nhzbOqeC1yaPGcnlDCckuCFu8EaOXAQ3xmw50xlerD0o4et+Z0iQrAjooy3
	dX65zRJwHn4GznaoHgphXfhoWvMtkV03t4VZUReccLemtWu7Xy3iSBmqcqCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708441817; x=1708528217; bh=Atu0OpnXzZorWtqFeTIeosaeih3w
	F0IbqGTMPEqB/RI=; b=coHV/e+mdCsgad2PUKvoy/NyfCmXq7VHJWjPHaDkwlvg
	VPguCg4KeV4YoLDCLrUbxxn4qFU1UG/uJiRLT/HNGgkV20/J1+PrxO2yrodIBDBi
	U/zYAYjff22ZiZB+n1NyMRG5rxtEa2fCePrEbSLqKYi1zCRYAvH2uzXPA7EIkpAS
	YapalWKD7otM5v02U7TM1GZQg5+xLlpPYoUc9BESn7UiWIzdnnUj7nA2uy5QbVQe
	CI38HJx7blQDpZR9zym7LdSOfTlAkDl7rtHeFb7+gaMUC1shP/asQ0AexKLJ5t/u
	GkH+Es+mH+s8AbgyA24gFJWiBVnqlobJ9yAc6j7rsw==
X-ME-Sender: <xms:2cDUZUBNiOlJKcBW-QSbiwM96EB-wC302bX_pOTE-_x1bWfrer0N3w>
    <xme:2cDUZWiAZuNAoz2BHoIne0qTy-oFEgLXwQ2ffOPIuqu3sc-IbX5CnRzw2DQOmz6q-
    BvzsC63g5V12nHinMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2cDUZXl0QnFEwqEzGQL8_AHgws1Zt22IB8FTcfNdNfPeE4-z9fiuLg>
    <xmx:2cDUZay5X4AokSEU5qsMAIUOTHgszMVpq8PJiV8I49KGNI4sSxxvSQ>
    <xmx:2cDUZZRaZjhFd8jKM32FY6sggxM6ZVGcGQC5Q47axUEy5erRARzowQ>
    <xmx:2cDUZSK7ZZCHC0pnlrvmmJeGntFcUcnSQeIrBAr4WaJoAKTFm5zRLjxmzUc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 16AFCB6008D; Tue, 20 Feb 2024 10:10:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4824192b-5573-4246-a47c-ad6249e2900e@app.fastmail.com>
In-Reply-To: <6f3b246e-7417-4455-abe4-ca3b42fdda4c@linux-m68k.org>
References: <20240219160126.510498-1-thuth@redhat.com>
 <6f3b246e-7417-4455-abe4-ca3b42fdda4c@linux-m68k.org>
Date: Tue, 20 Feb 2024 16:09:55 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Ungerer" <gerg@linux-m68k.org>, "Thomas Huth" <thuth@redhat.com>,
 linux-m68k@lists.linux-m68k.org, "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>
Subject: Re: [PATCH v2] m68k: Avoid CONFIG_COLDFIRE switch in uapi header
Content-Type: text/plain

On Tue, Feb 20, 2024, at 15:13, Greg Ungerer wrote:
> On 20/2/24 02:01, Thomas Huth wrote:
>> We should not use any CONFIG switches in uapi headers since these
>> only work during kernel compilation; they are not defined for
>> userspace. Fix it by moving the struct pt_regs to the kernel-internal
>> header instead - struct pt_regs does not seem to be required for
>> the userspace headers on m68k at all.
>> 
>> Suggested-by: Greg Ungerer <gerg@linux-m68k.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Move the struct instead of changing the #ifdef
>> 
>>   See previous discussion here:
>>   https://lore.kernel.org/lkml/6e3f2a2e-2430-4b4f-9ead-d9a4d5e42713@linux-m68k.org/
>
> I am fine with this. FWIW the following architectures do
> not define pt_regs in their uapi/ptrace.h header either:
> arc, arm64, loongarch, nios2, openrisc, riscv, s390, xtensa
> Though quite a few of them have a user_pt_regs instead.
>
> So for me:
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>
> Geert, Arnd, do you have any thoughts on this?

It clearly doesn't change the ABI, so that part is fine.

If asm/ptrace.h is included by some userspace tool to
get the definition, it might cause a compile-time error
that needs a trivial source change.

This could be needed for ptrace (gdb, strace) or signal
handling and setjmp (libc), though it's more likely that these
already have their own copies.

     Arnd

