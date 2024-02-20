Return-Path: <linux-kernel+bounces-73409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563CE85C21D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E28282062
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75A76C64;
	Tue, 20 Feb 2024 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2fWMjB1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXskBNwp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF85768F3;
	Tue, 20 Feb 2024 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449166; cv=none; b=WfMj83LFitd39iYEYXgjoiiZXw0pXAzKSBA0VGJPjNPH4woioTeFN5Drie5mUwZUhZBtjqeRYuy0yHaNkvLNGvrIGYIUckUUEVHPWPjUvYgUmdJuW4E57wXUOdtQO8JIJ40NY/mSS3F0j8OvsxuSreCqux5O3YrOzb+1jgcPjUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449166; c=relaxed/simple;
	bh=mzwyhdq+fMgEafvqseGJTXtDYih/dQ4/kROp9V9RbeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CXgaWHH9+n9d/YvFP8xut2ROpGlTpa1+I2y7UlbduEDB505d9q4MSHfWIaq45LcZes/JM/eKFpHcv3rHR+Bglo1iQFJY+VffaLPpGgPNRS80lcvFOMJyP2TTJBVZxq3/47E5myiXzrJQuFTba8R9lAOvTgTKgB9o7I5prJ5NQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2fWMjB1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXskBNwp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708449162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSHAfYIgTOaEzn4d0Y9lfsKjNJQSBoDQ7KhW/iaFfb4=;
	b=A2fWMjB1JjQPtT1dSVxjD+FBAizT/AOYIkLhHJP4m2JnRw0E4Qb9bBrBlQnxy2fWBQMpWR
	7Apwn1AMbyR517PEwMC9+K4ePwHYVoU+aCtOWWiX/3VgYXDUc0MXcC0vZDmLYG/LChTibe
	hEFR7LGGNiziY9NHM39vIFlSQJmPNQNHpsosbrLLSrn88bK+JVo+kZojWGbdW8+ZZ/apdg
	HAwZMZQaRZsFEszqyBElRvVYfcLmZPE0u86PK/tMd9C5XcPxaCPwar555zcilXIUdXuQRZ
	JMDGvZhyS2ceh5rPZa6r+o38lr+B6I41E3QYBjd5AHnnq+2krsxtY+jRxtTMuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708449162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mSHAfYIgTOaEzn4d0Y9lfsKjNJQSBoDQ7KhW/iaFfb4=;
	b=zXskBNwpTlyCapqr81po5bvbMgoWyomCGNp6X1ypT2UybdZ24qQN5BRov2Mvl3dWK+/Gwj
	PqXrEsIBOCvzzlDQ==
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Marc Zyngier
 <maz@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Atish Patra
 <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Sunil V L
 <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, Anup
 Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v13 07/13] irqchip/riscv-imsic: Add device MSI domain
 support for platform devices
In-Reply-To: <CAK9=C2V3hQnpibHgHUpwRXWn4LSuGue0a7Sh9NFYPB6XOizjoA@mail.gmail.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-8-apatel@ventanamicro.com> <875xyji7mc.ffs@tglx>
 <CAK9=C2V3hQnpibHgHUpwRXWn4LSuGue0a7Sh9NFYPB6XOizjoA@mail.gmail.com>
Date: Tue, 20 Feb 2024 18:12:41 +0100
Message-ID: <87msrvgiuu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20 2024 at 22:22, Anup Patel wrote:
> On Tue, Feb 20, 2024 at 7:02=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
>> > +#ifdef CONFIG_SMP
>> > +static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vec=
tor *vec)
>> > +{
>> > +     struct msi_msg msg[2] =3D { [1] =3D { }, };
>>
>> That's a weird initializer and why do you need an array here?
>>
>>        struct msi_msg msg =3D { };
>>
>> Should be sufficient, no?
>
> I had taken reference from irq_msi_update_msg() in
> arch/x86/kernel/apic/msi.c

Which is equally bogus :)

The charm of copy and pasta...

Thanks,

        tglx

