Return-Path: <linux-kernel+bounces-35718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34735839597
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A63DB2BA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EF580027;
	Tue, 23 Jan 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAzgYyft"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736B5FF0C;
	Tue, 23 Jan 2024 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028636; cv=none; b=MaVwAQJ82PXOipfno96vmDiOptrrEXOh6gnP7RASdb7GkdLUoNTDdnOf0mYv1PN/USjUNOm2FxllEmUkIPl60ga+X/eg9eZiPmD2wM9hroRqNhvjI1rncjxaVfKdHHCZmzzXmcqmxKc3fjbi2mk39nJpHL3ujH1cBpEKnUjiXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028636; c=relaxed/simple;
	bh=a88Zmqp4njTtxWiCg25rinX9YmeD6CxdtUTfyxUVraw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJjgct4W7ITlvlzLuq9p7lsn8E78Bog8hWzflKFONA9pD9iaF+zKJPrQSuriR2Xkmqg18XlExEfG+XQFL3REhuT2D1eU0Uw1UqLhWmCbgrfYXuKdtXFaPbC5JaGnRvrJuytvMLCXJ7a8J89nrwOyxvKHNZEyfBZA+g/XeIF3S3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAzgYyft; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so3871870a12.1;
        Tue, 23 Jan 2024 08:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706028634; x=1706633434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/d5m76wt4OsGM3BZpBnIBiif9rXJ89dqo98BB5XGUk=;
        b=UAzgYyftjDM1qC7oDcXUT9vb/SgUrspTABZouLUUIDpGPHXRewSmV+DtNRpFQidMLe
         D7Xqakc4+9geOAJRlrZbj66McHy+Gso39eDesJkQt2OlNGqSYlDlelJPl2N3/iI9lywS
         A0HvgN2IRMqVpJwbMRP8tdidZDTgk7BNMshLUKf0y3X2uM+hzGyqg/fiR+4DYVy5BAhM
         EsJ050BJjJ/Jchv1EeAOu7NJKy+B7UQbASonEdlfiAS6APDrJmouBBhK1JKY16awSc26
         gumx4pUYOt8hKMDRYMtULYb5KX3Ow8b9qhMLqP7MOAv+1uVVqKZ6h+3piLPz5IBjazBn
         OYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028634; x=1706633434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/d5m76wt4OsGM3BZpBnIBiif9rXJ89dqo98BB5XGUk=;
        b=aV361/hZzruCuB6ufKGH2wvnDQIqn4Ug2cG+pp1F3xoObfjcoS9P3R18yeVBPji8nb
         xmT9BGsD9j/rMAAY94DkKe4y25y2vXiuabL6XUMadfcSzefwfVleprSgYM5yXt8M3Qn6
         SIu9NQdz4E8VtA3qikWB06TOO+nyKKmqv0Q8pu72vv5jhK9vcOuennC6ROK0A4iWtQm3
         ja7LJQ694dVZrXn6EOKJJjpwBlNzbHfzWMt5RV5+bxjBJZZNRCPv8922xR3i/vyDP1tg
         8tdLdqyiURW7weMJ7Q4NugkgSLvRwaNinKu3julN4j5ofTu/sFKuuICISp0lLxbfRrzJ
         /0PA==
X-Gm-Message-State: AOJu0YzD/4PFqYONdYNxHG8rtJZqibIuyRfTqwOpfO2i5uvnLWfrpWLe
	n04J19YA3083gycalxWPrHw+0wc9qOqxT/cx+ZV8iq9ByVEdWNV9Uo4qC2lFFIDejIVzdmalqBD
	XOL1ImFnKwx1Wov1unWJnYgE5AYLd39/xSWL60g==
X-Google-Smtp-Source: AGHT+IHxf9a68FIsVrmVsskDTKcJeb1LqACbFmkg/jO9ZAJTowrip8lle2QJ9q3KZe1rH30cf2uTccw+eNPDcvK80iE=
X-Received: by 2002:a17:90a:f0d7:b0:28e:8787:9ab7 with SMTP id
 fa23-20020a17090af0d700b0028e87879ab7mr7137333pjb.38.1706028633969; Tue, 23
 Jan 2024 08:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com> <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
 <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu> <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
In-Reply-To: <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 23 Jan 2024 17:50:22 +0100
Message-ID: <CAOiHx==FzSyyqP3NzLTeOSVxUQYy3ZhypZrDLsc-OjGCdSzvUA@mail.gmail.com>
Subject: Re: [PATCH] spi: Raise limit on number of chip selects
To: Mark Brown <broonie@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, 
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Guenter Roeck <linux@roeck-us.net>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 23 Jan 2024 at 14:56, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 23, 2024 at 01:26:04PM +0000, Christophe Leroy wrote:
> > Le 23/01/2024 =C3=A0 14:18, Mark Brown a =C3=A9crit :
> > > On Tue, Jan 23, 2024 at 12:04:30PM +0100, Herve Codina wrote:
>
> > >> Moving the SPI_CS_CNT_MAX value from 4 to 8 is not enough to handle =
my case.
> > >> Tested moving SPI_CS_CNT_MAX to 16 and it was ok.
>
> > > OK, I've also heard 12 as a number which this would cover.
>
> > By the way the comment in include/linux/spi/spi.h is confusing. This
> > SPI_CS_CNT_MAX is really not the max number of CS supported per SPI
> > device but the max number of CS supported per SPI controller.
>
> Well, it's a combination of the comment being confusing and the
> implementation being a bit broken - we simply shouldn't be limiting the
> number of chip selects per controller, the per device limit is much more
> reasonable.  So ideally the code would be changed to reflect the
> comment.

At a first glance at all places using SPI_CS_CNT_MAX I don't see
anything being broken / reading out of bounds if a controller has more
chipselects than SPI_CS_CNT_MAX.

So I think the check of ctrl->num_chipselect in of_spi_parse_dt() is
bogus/unnecessary and is in the wrong place, as this is for parsing a
spi device node and not a controller node. The following check for the
amount of chip selects defined for the spi device should just check
against SPI_CS_CNT_MAX instead of ctrl->num_chipselects.
__spi_add_device() later will ensure that any chip selects are valid
chip selects, so no need for of_spi_parse_dt() to check that either.

But I didn't do a very thorough read, or even tested it, so I might
have easily missed something.

Best Regards,
Jonas

