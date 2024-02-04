Return-Path: <linux-kernel+bounces-51865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F284B849036
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307EF1C215D8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E7525564;
	Sun,  4 Feb 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkXM9n1H"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9B24B59;
	Sun,  4 Feb 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076634; cv=none; b=iBRxbIg/NULUkckdjE7NiEGiRCD6FskAth2iS3kp+OQY2RacDda+45ISu9dzBTJ/xLyKuoR6kfM5kQuvCh9+/035a7M+m6nz/0tDRfkGwAemWCSg5sDEbuP5+T9JKh8eNHTEYY2hLIBb6jG/xBDp9JpekaEobAJgVcGfUHplTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076634; c=relaxed/simple;
	bh=zvwlEGr3Cm41VvB1vK4xccHaj+bW2/dqXLVV3griGLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHkl1HaKtn1a4UM5lL7/rkcRyFyURThc49HCWZgtPsC9gpTwPgeiiOzXnAr471JXEwVP9QzKPWDnuyd3SW2T2mLrVoLe6LRGXFBKKS3NKeyjWYqdifAlUqZkfaVcpz/O2iEXziQB2/+igjN8qsQJoBpUtVQejSZj67NB99jvGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkXM9n1H; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5111c7d40deso6155579e87.1;
        Sun, 04 Feb 2024 11:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707076630; x=1707681430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvwlEGr3Cm41VvB1vK4xccHaj+bW2/dqXLVV3griGLc=;
        b=ZkXM9n1HOHn3N2pyP8aVRFUASiDz9OJdm2rvIMFgbtjDBSFthrJXTCIzThi0GSPm2A
         9VstwhEWeJtcZF08QkbQvt/gI0FPZ91c0hRTBiabIU55Dchmr84uC2uAILdPR1bewru7
         qrdGNmxR86gjwh6iD+HUfmfO7O0IuXVRuxPQ9GtYMjg2XXSxWf+Y4E2nuuL4wFQnhksT
         IXdqAiGySslnpOxB0lQHDso5W3N2/C3rZcZD3ZnnCHsuLpcTcQvzOE30OAmXwU+yPN7I
         GTqsnh4YuGN1U68d8A1OEOieWA3znQRtODGt62I2JpOYdguVa7XvKavOQW60Y6Jt8dzm
         yZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076630; x=1707681430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvwlEGr3Cm41VvB1vK4xccHaj+bW2/dqXLVV3griGLc=;
        b=LULWJ5uVAbEazcEhbT/mN3XJydbcFwXe/n6mvc2GZHYd0ksExtkyHmH5Wpx7GUuHbQ
         OadxZgCHn0644TMLvbVSZkvNTB7lPi4kYT6Kuv0Re/xwsQIaA1leKp6uzjuJ9ngARSBw
         eGKuv3IJOkDt+G/FArd6aaqiBCizTLbQQ/jNCToheoFyUWxKSs0B9AksKlzIRuopDuAT
         E+hfG7waVpWOGDApWhsXnRbmJ4wF+WTOC0pIhQi/sF6zgCS+yvYvTjdxGpwYnxcvclDe
         VEXJxwi+8mZ/yrV6PKnnaJcCaTANNL1pN/Ox95hJ2b5YjoJCDuaBzONvdcHMC7cVH7oB
         Vdnw==
X-Gm-Message-State: AOJu0YxxicxN1S6x+zCKMJfiGkar5ziHesx6V4LURCLbeBTBztcUVkz3
	HDetGY7oSMmpRhiAClDQzi/j/Y9Qvs9wkhcJSB+/P+XJUhkXmqthb1EHognIlw/vHGjibCX6hgZ
	pJzVluUBZNTDxtbL33mFgue/oIak=
X-Google-Smtp-Source: AGHT+IG5k1VsFWdKw3oG352GHjuAT9Qf03kt7/4yNlpr5CFWwN5tpoab6IVaAAsrk54CjBmouwMuyy2tzPj0RxWCvok=
X-Received: by 2002:ac2:4da6:0:b0:511:499d:5dda with SMTP id
 h6-20020ac24da6000000b00511499d5ddamr1981379lfe.10.1707076630601; Sun, 04 Feb
 2024 11:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204162106.1179621-1-andy.shevchenko@gmail.com>
 <20240204182417.jnw4iuqgghxynq3v@skbuf> <20240204183130.r4rdggcqx6czuzoc@skbuf>
In-Reply-To: <20240204183130.r4rdggcqx6czuzoc@skbuf>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 4 Feb 2024 21:56:34 +0200
Message-ID: <CAHp75VcLtzJ7heNxfEGxNJbkjbnHSLJTSHCcMnEQfLUTnbwkRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] spi: fsl-dspi: Unify error messaging in dspi_request_dma()
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 8:31=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
> On Sun, Feb 04, 2024 at 08:24:17PM +0200, Vladimir Oltean wrote:

..

> > Passing -EINVAL to dev_err_probe() here doesn't work. It overwrites the=
 "ret"
> > from dmaengine_slave_config().

> Ah, the original code also ignores the dmaengine_slave_config() return
> code and replaces it with -EINVAL? I wonder why that is... It doesn't
> appear to be a widespread pattern. Pretty arbitrary. Could you please
> make 2 patches, one which preserves the original return code and another
> which uses dev_err_probe()?

Sure.

--=20
With Best Regards,
Andy Shevchenko

