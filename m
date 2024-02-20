Return-Path: <linux-kernel+bounces-72692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9594B85B768
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961BA1C2466A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7C60ECA;
	Tue, 20 Feb 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a7OWtSYW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JzeQRiQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904165FDCC;
	Tue, 20 Feb 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421286; cv=none; b=MG4qL4n4ogOQuuAOzkbv7wo0OQ9bPmmAsKlZJkRKU+Et1izvjHuzT0/aoP+iac7VlxWkWLXdi7dsXAH+k+9CkVGOcsjJ+VMvl1jUHZp+m6cljfu85G97fSJ37bNH7gQ5k7AsiMr82QCmzOQpF+cH1HJRRE30IjxpFgiqQwbscx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421286; c=relaxed/simple;
	bh=xbCMaT+ablExRVFmyzTzsHg1dEx1miGZfzRPaob+1OQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gSWgHS9W5uIywXVlhdBx4tVXM9xbfeDcQRTOC99oP+nkoCFPHC/7khuoXblM+NmWEIiPcQu6J+4QGEZWGi27p+jyFVUux7h+Rb/UJtyXl2sT7TkPTDAfhNyLJECivSX2gcKoSe5g+GPZogiUYCbtK4Fk/c1J5pUw8M71uX2Yq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a7OWtSYW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4JzeQRiQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708421282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6CpMnesPhZeNYa5GMfDIrbJkajmTM0m01p5Zn8iWA8=;
	b=a7OWtSYW3DSkbDbTDAMCiQZJmhoCy8AyLzmTWeCbtAPBeNeUYEG02OUdWLpv/oNlyMxGzg
	eWws7F8PJzw7gwM9JX1WUueyECgZMU90qf61H3CHqZoQSmDk+hB1/8DZsResiaXJX1WT5G
	C0gWcgp9om533GJkmGXodcl4p7S+5KcleMn/WmtwYC5lfQdUNi+oDAzva4j9rP1UkFg2X9
	QznSTbQXQ0fxfXRua7J0QUKMCUFABFcTebIDRJ2FRJsWfvNrZTG8jb0p8E8AuWHpIc8KDW
	e1XpQD5ZfIKXfQkzTy922sekYgiajkeVzWoYLt9omBTp4TaYcyIIZ2uhGoz0hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708421282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R6CpMnesPhZeNYa5GMfDIrbJkajmTM0m01p5Zn8iWA8=;
	b=4JzeQRiQ07VSCsteczn4s7AiUEjGAV7v/flNhT1Ey7GksgvRtbZQk0LH+t1akJBQMtqEG6
	yxD6w2S8Op3wboDQ==
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Leyfoon Tan <leyfoon.tan@starfivetech.com>, Jack Zhu
 <jack.zhu@starfivetech.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= [PATCH v2 2/2] irqchip: Add StarFive
 external interrupt
 controller
In-Reply-To: <SHXPR01MB0671BD046F6E3F3A215414A6F252A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
 <20240130055843.216342-3-changhuang.liang@starfivetech.com>
 <87cyt0ivn3.ffs@tglx>
 <SHXPR01MB0671BD046F6E3F3A215414A6F252A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
Date: Tue, 20 Feb 2024 10:28:02 +0100
Message-ID: <87o7cbiixp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Feb 18 2024 at 02:36, Changhuang Liang wrote:
>> On Mon, Jan 29 2024 at 21:58, Changhuang Liang wrote:
> [...]
>> > +static void starfive_intc_mod(struct starfive_irq_chip *irqc, u32
>> > +reg, u32 mask, u32 data) {
>> > +	u32 value;
>> > +
>> > +	value = ioread32(irqc->base + reg) & ~mask;
>> > +	data &= mask;
>> 
>> Why?
>> 
>
> If I want to update the reg  GENMASK(7, 4)  to value 5, the data I
> will pass in 5 << 4

All call sites pass a single bit to set/clear, right? So this GENMASK
argument does not make sense at all.

Thanks,

        tglx

