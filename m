Return-Path: <linux-kernel+bounces-150588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FDB8AA150
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DD2283E95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D722176FB3;
	Thu, 18 Apr 2024 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="ZlEkK+hS"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142C174EF9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462293; cv=none; b=IMD0IKLl62kCwx4DqHbVL1rncIyBycqR5Nt6u/cbwqlqkoK2ddBQWWITo8frtWZLQu74Pmeklfd6Nl7rGsdJmBHPyrFmr0RkTa/yhx3UPpo5bRw9PNv2ue/wXb4hOyck+owakZ5yBHEbWtrn/+nXk65S+hAA1EyORERPICHli44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462293; c=relaxed/simple;
	bh=EndrSlUL8lOUGOcQbCMTZWu/7CtEhpYfDQ/0p0uQKLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T1IAEq3GJt1U36OeaUqjsRrXI8R9cGbfphL8+6ukEjfanTLIrshIrAhj6hGC9G4EtxWZUXXpF8dBP1l7cxm2nWkPVQ3+O+IT7a5RftPbBSj1lh0mhp9rzBH7YE4VhYY7hM2hZJ60A8rLHPFN6UEtNj0ZRLZ04C/qJeNWw2LMcmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=ZlEkK+hS; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1713462283;
	bh=EndrSlUL8lOUGOcQbCMTZWu/7CtEhpYfDQ/0p0uQKLs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZlEkK+hSEytOWrYlgHowGpBxHnRBlr2XVpDMd/0GBYgOboQopAsDNuFVcOC6n2wmY
	 7xAhePZtZJisDQjP1mRpYoWGNRbuVgOxS8d8CGyJQ2THyRm4luUOCc00MamIW7jPAm
	 cgWQ4EdxM3Tkkt65Eqz7cHwcpt9nJzvnF/8bwbNc=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A770C1A3F62;
	Thu, 18 Apr 2024 13:44:41 -0400 (EDT)
Message-ID: <5e005ed913086d7e641306b89baa29b070e0359b.camel@xry111.site>
Subject: Re: [PATCH v3 0/4] Give chance to build under !CONFIG_SMP for
 LoongArch
From: Xi Ruoyao <xry111@xry111.site>
To: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date: Fri, 19 Apr 2024 01:44:39 +0800
In-Reply-To: <b752273b-0e94-4325-9cf8-6f16a204818b@app.fastmail.com>
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
	 <CAAhV-H6bHudfUVE4SWY88mxmLhFok9DS8UyODSZEdUJ816V8Rg@mail.gmail.com>
	 <b752273b-0e94-4325-9cf8-6f16a204818b@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 08:06 +0200, Arnd Bergmann wrote:
> On Thu, Apr 11, 2024, at 06:26, Huacai Chen wrote:
> >=20
> > I remember that you both suggested not introducing NOSMP support for a
> > modern architecture which brings additional complexity. I wonder if
> > you still have the same attitude now. I will merge this series only if
> > you think it is worthy to introduce NOSMP now.
>=20
> It's an interesting question, as we have recently discussed two
> opposite ideas and may end up doing both (or possible neither)
> in the future:
>=20
> - On x86, there is no real reason to need non-SMP kernels as the
> =C2=A0 memory savings are fairly small, and it tends to break because
> =C2=A0 of lack of users testing it.

FWIW I'm still running the latest Linux kernel on a Athlon 64 3000+
launched in 2004 with !CONFIG_SMP :).

No objection to this paragraph (and other paragraphs) though.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

