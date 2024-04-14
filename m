Return-Path: <linux-kernel+bounces-144267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFB38A43CD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2406E1C21BB2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A691353F2;
	Sun, 14 Apr 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGDJfIl9"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2F1CF92;
	Sun, 14 Apr 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112432; cv=none; b=VWof/1YswA0vfc8yNPjX5h7nWJNIDMH8UF9f4q7h/0kCmt/Co+NvpFN6ZESdxS7eRZ7Ko2Hg8Pucmy0Lx8Si2g1f6r+LmvOYVDY0WNAxFpR5CWE3pu/3DsmLqjklu271Q6hFQ0hq7Tn8p1CVsjlyMsIFT9ZOGj4x/dxOIKLoPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112432; c=relaxed/simple;
	bh=dyXqlvW9YjzLdAkkWuX++ClIqo70zTkGtGKhUa4LQpM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=enCwX7TfjoMyR0wObIwY4xUjOaprwfCuZycOUv24RV22q6Q9yvc78q7Q4IVjg47YMXKjSVbUiRHuucJhc5bOfAOd2hDZQAKkLb+rqqfxufm3FUS7j88ftLYTrzY8t8bAxf4VN2c/EagVVuB7Wgh92X142ntLemTJixWiKoUPGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGDJfIl9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78ec78c4fceso168077585a.0;
        Sun, 14 Apr 2024 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713112430; x=1713717230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqL0WG5MvKc2cIq0z8Q5OhCeWqEk3epdhelny8K600w=;
        b=eGDJfIl98CDRAq8WfVTN3Qx9tI2bVhkdRGExQy9y41Ji039X86T/4JByWDcOKWdCEH
         KZhWUmb7ONMwJ3WOs+zy95Nx4l1u1OPanzdlTqrT5prKkM3Rtp9mmhd5i0U7bIdhdaAX
         LxkHosc5Bja4tOBmHwsNPlD6qxkBOGqvEV/MEPixXVCwJNF1GzB1l8VqZ7qeVIvMw4+n
         YiMo4HQBd3Ro8ye7M582H3Av7xidKvHrL2/N7eA7zbGI/wWj+SDq/8odlJWDQsbWr76K
         wNzQtSm1kkxPwpxvfIxKyb2kcFH1mWsM53MeRLIqF29Od1R7jG5aLY4ajL9DEkyluC+2
         mpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713112430; x=1713717230;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eqL0WG5MvKc2cIq0z8Q5OhCeWqEk3epdhelny8K600w=;
        b=omvQEdKjl0RVnAwEhMpk++rX+sVJnSfE4OUQhH5ytDBdjX8J2E1/vkpWlucSsQbbmS
         jPTFz0K2QiPdZ+A/+5HkR+Ibi6c6vX6LrQjt2EGtyIdc83kYRfUheQ8sMFCY8wdUsA/z
         KU+mhWv6y/s06KXxdTjmffhYkpxT+F3xoB9gVojAWfAxKpuKZvRbYpT7gP8iK7YpPEnZ
         f7M6utN7FZCLnIUQvN4We3JEOUhehiv41JLcbpG6d0TZZVdmxuOjtfym2c1H+Nymdjby
         fm1gMY0gc9I4hrw/GZO/13iGRJGIn1ILJfxvdL6I3z3YwDS9Lstb4rwo05BS9GLA7NG4
         XdZw==
X-Forwarded-Encrypted: i=1; AJvYcCWb0KOhPL6SmzOI7m7/uGt9QXNRK7pY0Inbvl4QZygbz3sRm+P/2dCkJwS5vGxQNARr0d2WPogE92Yncu2s1eLzlRDfITvUNpoEitmxmLRjOPn/6Y3aEGd1fVZT9tf2C6JQFtU7RCEEnAMOz/S7WmFPEVQC0SkOLkxIMwA1JT5Z
X-Gm-Message-State: AOJu0YxT6jHPR0AZp0C2Jmt00yk+ISU8AiHEU9rzVbOByOma9dfXdZSw
	OFbiiKlkJSYK51pJy3+JSTyMR2F4rknw+llSN+pyPmwpehRlQAA6
X-Google-Smtp-Source: AGHT+IHTOBVsxm4/lXrUUUQxQfSI05H0EVLBNy41Bu3n+HJQTCm8ENB7o0ZDxOkgCjw16yeeKdkeYQ==
X-Received: by 2002:a05:620a:191d:b0:78e:13f1:3040 with SMTP id bj29-20020a05620a191d00b0078e13f13040mr14999873qkb.22.1713112429649;
        Sun, 14 Apr 2024 09:33:49 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id m12-20020ae9e70c000000b007883184574esm5208818qka.98.2024.04.14.09.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 09:33:49 -0700 (PDT)
Date: Sun, 14 Apr 2024 12:33:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kory Maincent <kory.maincent@bootlin.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, 
 Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
Message-ID: <661c056cf26d6_3e7732294f3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240414073315.5aa7adf0@kmaincent-XPS-13-7390>
References: <20240409-feature_ptp_netnext-v10-0-0fa2ea5c89a9@bootlin.com>
 <20240409-feature_ptp_netnext-v10-8-0fa2ea5c89a9@bootlin.com>
 <66175265992c8_2d6bc6294d8@willemb.c.googlers.com.notmuch>
 <20240414073315.5aa7adf0@kmaincent-XPS-13-7390>
Subject: Re: [PATCH net-next v10 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kory Maincent wrote:
> On Wed, 10 Apr 2024 23:00:53 -0400
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > > +/**
> > > + * netdev_ptp_clock_register() - register a PTP hardware clock driver for
> > > + *				 a net device
> > > + *
> > > + * @info: Structure describing the new clock.
> > > + * @dev:  Pointer of the net device
> > > + */
> > > +
> > > +extern struct ptp_clock *
> > > +netdev_ptp_clock_register(struct ptp_clock_info *info,
> > > +			  struct net_device *dev);  
> > 
> > No need for explicit extern?
> 
> Indeed I don't think it is needed.
> I am wondering why few other functions uses it (ptp_clock_register,
> ptp_clock_event, ptp_clock_index). Do you know?

Perhaps it predates the coding style rule

    Do not use the ``extern`` keyword with function declarations as this makes
    lines longer and isn't strictly necessary.



