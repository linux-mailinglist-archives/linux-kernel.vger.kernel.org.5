Return-Path: <linux-kernel+bounces-60530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDF3850624
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F362D1F21F98
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D0C5F579;
	Sat, 10 Feb 2024 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKuIi5Ll"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CE5F562
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707593921; cv=none; b=Pe3GdEk638k3dxUMGg+3Z/BvyWyQc55ojzjVqMTgQN0WHHGCFptsouAi2lzY2mUYrG5yL9y8STa2/SFa+vai58oZpJecSmGIoDBF0i5yFj1ekLCqfc+NSGH2aypZ5c/I27hUazF/rgHP/AOzuubHQdBhbKJLVFb7KHg6sGqJzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707593921; c=relaxed/simple;
	bh=iQGav6Iaw9dZL+breAfuJsbdBBeXtSO2cp14+fT+agM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoTOOQlvsVeFwA5MAB3gHNfrJaNxrHPqnUQYbFdHuH7bhPucNWJ34XXOAGLjBhAdMr5xUBVmDdVCheDA7IrAKwLL0qgU47e2bAUuJT2HsExhQcSqAOFiQqhsZQo0tOIZGyHuN/VQwYPhSAmnGDB3+P71/1/8gljJ3hxBtf//8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKuIi5Ll; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so1903873276.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707593919; x=1708198719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQGav6Iaw9dZL+breAfuJsbdBBeXtSO2cp14+fT+agM=;
        b=TKuIi5LlC1MTkdIWUg05KZubPATDs/vIrwxeNMeP6ZmsU6E+grHiePfUPr/Q1vnoR7
         924cBbF1u0BmcVoK4cYYTpc1FdGuV6imhQ6/tEPjICAu5dHEuQK8ql+wShf6fyxwWhO2
         AmJ/4astLEtK0Q6304WB2pXipx9p70HmxZxiKYubgsgYmx16nKq9fysDlSKDjgZQh4Jt
         CwUYTyA3LtS3TiC6q615GyV1Lw8VUGsLwo4n0kOnT+t3BEmIKpOhOBk7d3dfJoE5c7Xu
         8jB1GoLsnjJbO2I2CIM6kH+/haC4GaYwF+TEWVMC48Vuk1SmsZpnx2p0TCfKS5jkeaIw
         uFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707593919; x=1708198719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQGav6Iaw9dZL+breAfuJsbdBBeXtSO2cp14+fT+agM=;
        b=Or1z38oewb56vj5mkSJElxGb0jMQ03aE/YXBH49QZKKqSHo+pAakV4y+WCbID2vjYZ
         ubNVyc9anbjgYjApvVb6TKFB2CxO+5PBUphFRZbpjUUyZ9wbsF3WTjFuoFY7aiHLL7v0
         wUDlJdk0stvo6ipYd2cNWE2q03LcVMHr50Xaor3oQzRtLygnQnKDC+808lALWcHYC/2X
         vtPHt0LVGGStHNy82/tLAqOPhV5irqs2XFVzUXSyfpEOA/X0bnBUvnyUYTvfjYLMOSbY
         fgogBZGL75luuYRAml/2L1pt8KryI5SzdFG64xvVpNJc+L9TNvzeF9aneW5QZ5KwDziZ
         JgIw==
X-Gm-Message-State: AOJu0Yw8rf7vbP+wU+wYwm7v0gpW2AIBzc0EGsLKGJOLv5glOn8XKRvg
	4WoijHPfx6Zl1wEvTv/fl2lJ+2Dj/+Sy9xpgqgx/Awa0gR92BysUFlcxUhV+yWiKpqW+GkZ9eIm
	A6xSA81paVHD4SEQ1Wenu3++Hq9n2khNd7I5G3g==
X-Google-Smtp-Source: AGHT+IHQoqM+Ez0vwI0AVPIhNfj0ZyMahw8je8adZerNoLLmS48CzI3weQoop/efGwuIi89+sDPbS9ZYs4Lz4MndOBE=
X-Received: by 2002:a25:d653:0:b0:dc7:30e8:f232 with SMTP id
 n80-20020a25d653000000b00dc730e8f232mr2580780ybg.18.1707593919188; Sat, 10
 Feb 2024 11:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
 <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com> <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
 <CACRpkdb=aDd+CuJhckE9xZjA4MXRS_BD=qd3sc3Qjnm7CNbATA@mail.gmail.com> <87e339bf-6ca9-406a-9f15-d744f90c9c40@app.fastmail.com>
In-Reply-To: <87e339bf-6ca9-406a-9f15-d744f90c9c40@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 10 Feb 2024 20:38:27 +0100
Message-ID: <CACRpkdYtUFAWweawpJquz2BUT81Ako0cZnKgZeyj8Jj93ru8fA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 12:58=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Sat, Feb 10, 2024, at 00:41, Linus Walleij wrote:

> > The only difference is where the CPU have to read/write the
> > buffers really, before the change those were all guaranteed to
> > be in lowmem (bounced there by the block core), now they can
> > also be in highmem, but sg_miter will deal with it for sure.
>
> Yes, that was my point: The sg_miter() code is meant to
> handle exactly this case with highmem data, but as far
> as I can tell, that code path has never been tested on
> 32-bit systems with highmem but without BLK_BOUNCE_HIGH.

It's actually possible to enforce testing of highmem scatterlists
to an MMC card (one need to be careful as this is destructive
testing!)
drivers/mmc/core/mmc_test.c

..but the one relevant target I have is a Kirkwood and it only
has 128 MB of memory so highmem won't be exercised.

I'll put this into the cover letter on the other series (fixing a bunch
of drivers to use sg_miter) though.

Yours,
Linus Walleij

