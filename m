Return-Path: <linux-kernel+bounces-83669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3919869D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D50828BC13
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207B2CCD5;
	Tue, 27 Feb 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="08SNpyQv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="schyaOoT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630520B38
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053392; cv=none; b=Ta2/WSXGRHIEWXfQckRbvxl1EagWIKteFtNXC5ldkMuvH16zactCOPShtosUBMiYxa8v1Q7j99MtlxJh7rwiyINXizNzwDE7QPfakUCpEW5XrBrwW32vTBagv2G/7es/Tkq2GqQOYp3iyXwTYnH7fAZiJgnSvW48vMNfA4EHN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053392; c=relaxed/simple;
	bh=l5e8ml4REQQUTX3sdXHOM7YXsSKlUkKAscSC883nVrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTzaJ1qwf8BOg7cRQJiQHYMR4Q9qd2gmSIasIbkDPMk3VDb6VjXV4nfp9nCOZuZqZ39Evcy4mWy8BSHotPOXKrfzO0+20gWVZQSijreCGZPdFNMaYFqSt78B4CdvCTSA4xZhyQTUV6P3SNJSK0k4YbDNpJfvL7/rmIhFLfGqH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=08SNpyQv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=schyaOoT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709053387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5l/z5niNWmPcrTzUn5sccV50+EwR7ocb+Kg+fSadhTg=;
	b=08SNpyQvlIQU2jDRMfIsTN3MWypAwK0VUGYT42tEBQgFLalrgvtfjw6UYXQVej2Ynh4ktb
	5Fk4PQ1exCmD8hEkfA4vrrKFpZNWQ1AO3HA3SOinAlt+rWo2xwFY3/wZ4SgDpWCFL1WpVQ
	3Ui4gjSwZIE6e4msvl5V/U6twYA1bl7qqqwSy4rvbFeY2tm46uoYWMhDEYq394TrR6uYZl
	vyY759M+v3TaLN6BSUKcNv5ijbkpmhowBrO7U9XpbEd6b6qCRHNIBjq4sBKqSlm/CRti8t
	+xDkOUF+Kz4koFfCmAS4TKjW+HgSAGy+/eSlmUdGDeyzosfVbk/gwAEqza17pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709053387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5l/z5niNWmPcrTzUn5sccV50+EwR7ocb+Kg+fSadhTg=;
	b=schyaOoT6pP96CHkQtz1KlTYOnuJapoTYgyTGeAbfVUt5j0qYE5viIyMTjwapWp7ij9Uiz
	Tq5mM+uFan0hgUAA==
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Charles
 Keepax <ckeepax@opensource.cirrus.com>, kernel@pengutronix.de, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, NXP Linux Team <linux-imx@nxp.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, patches@opensource.cirrus.com, Fabio
 Estevam <festevam@gmail.com>, Gregory Clement
 <gregory.clement@bootlin.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 00/13] irqchip: Convert to platform remove callback
 returning void
In-Reply-To: <knhwqxhouaiehmnnz5oxaxibhq7usokefztae4pplqypwuzgye@mke2irokres4>
References: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
 <knhwqxhouaiehmnnz5oxaxibhq7usokefztae4pplqypwuzgye@mke2irokres4>
Date: Tue, 27 Feb 2024 18:03:07 +0100
Message-ID: <874jdtalh0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15 2024 at 22:03, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Dec 22, 2023 at 11:50:31PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> this series converts all drivers below drivers/irqchip to use
>> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
>> callback that returns no value") for an extended explanation and the
>> eventual goal. The TL;DR; is to make it harder for driver authors to
>> leak resources.
>>=20
>> The drivers touched here are all fine though and don't return early in
>> .remove(). So all conversions in this series are trivial.
>
> I'm still waiting for this series to go in (or get review feedback). Is
> this still on your radar? You're the right maintainer to take this
> series, aren't you?

I am and it fell through my christmas crack. I don't even try to catch
up with email after being almost 3 weeks AFK. For two decades I rely on
submitters to ping me after a couple of weeks or month in this case :)

Thanks,

        tglx


