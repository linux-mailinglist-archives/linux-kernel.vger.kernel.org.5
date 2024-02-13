Return-Path: <linux-kernel+bounces-63327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D54E852DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7EF1C21B64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D26D22F02;
	Tue, 13 Feb 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIpHBncd"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F0249E6;
	Tue, 13 Feb 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819420; cv=none; b=puR3jGPwzoF2fFtk/3ThEFF0Dve6KjI4z/uHSGWlLOG0Gd5Ub3ZXNJfWMQbAS4wPW5zwbA2s4/UvBIgEi3vHxJWz9GblhlUk0+buXC3/3vv2XP5A0Z65s04qprRmnK48S6KpCCgKqEjyowVo2xs2eqc+hjq3C2Ll3W+ps31BLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819420; c=relaxed/simple;
	bh=l1WA4BmJhUNPO0PgFoT3yDhO05qGKqCPxUNKzMlQ+64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jntqW7tSWQWoH5y1JCvyee8o+Nx/okozxvRIOVrjlnuCcMKJLA3rqm0IgPUEcD6UYkYJSlOAgrQyQIAmBHaoY4enaw9QDuIfy5GW9d9IwKFhojDgG9KwhRMkoTl0JqiQz8nkz+5QrjSdByvbmMUzPH0bv8foXKSEShD6IdxQXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIpHBncd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-296c562ac70so3107864a91.2;
        Tue, 13 Feb 2024 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707819418; x=1708424218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1DrFPpG1AE0oqq6JXyatuI9CZhYrl0C6K6iXvSzHYYM=;
        b=dIpHBncdW93YjujcZdcVLtBBxmj0IHqAo3kGJqb33C6b+Uv3pP1ajY83Mm5QZwsW/u
         9l4catVIUxgspVoKOqFrd9KzNshnyDBsNNMmQDWnBC0Nijpb0aqK0JJ0Rl48SWuEfHPz
         toKc1Khxt86QuyRy4lkTEgj4eSZoYDHl7TYfVWNOd8mzkZ46nFsQ0tOoda1toM8HFDjK
         +NBgaCWIkLjd8yWk9J9lfZVImaGJSTmpxCRLRo70Yd8gF9vrLuWc+uMI9iGBHArtW5f5
         BifVoTgbR4Xqzc418MOwa4rk4e3GaJGVZNRet1dV+ODKVnwEnXDJoi9z7zniad8/Ro+V
         jq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707819418; x=1708424218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DrFPpG1AE0oqq6JXyatuI9CZhYrl0C6K6iXvSzHYYM=;
        b=FrdSlmI97t1btg/Ea0JdhmyGYQor4jC/ELt4ShircuPz2t7LTQjqY/DuumAG3gal/+
         kPVfYEnZBgAxc359p+TR6ToMcWhrtrra+udoKOekpKTzPGezaWtesoFt/G8AqX8vWsVM
         /GdsknGhrUYrhzCsLBVbT+wIdC+7mlvVaUVc3UrLA+dQV2N4RjLIUFqfN51vDFG5QT3X
         wr7GPRpa5iexaP41/RJsB6UErnuOvyYwWIEFZH/5ns/3x5MT3KtJE37clgVpASrASnhg
         RL3qzvPir0ftMpAwonTryf78E2Lni0+BgZqHfWtgpWBK//lmGbzuWtswbVE/WTAA0h04
         REKw==
X-Forwarded-Encrypted: i=1; AJvYcCWcYWed9coDAsCE3onV0cOab2qpc+FSR3UzS1la3UtZPp30FFzb/ZRxCykio1wmeAAiHDmChj0Z4/RM/EoNq1S2X1HHlrJJYBWjcIRdpsVaprp8zI9Whb71lxFjdFzqnOs9uguzbIZmztbXBOYOGZbhJkhlYlSBpuyj0NXF61u2NZoxFA==
X-Gm-Message-State: AOJu0YwtFAeC7gWZ2yjzNbTutSKFPRCor6zlkSv4IRKsgJSPYbmlL9GD
	BRg3JyFvaTRcDkdp5ylOr9bmHOEV1SQocNna3HPzX+yacSR4/zjse3Iu9/EEfXVSqzg6UKUA07a
	RVl71AKkZuk3mWowMqn9mGL6pVwk=
X-Google-Smtp-Source: AGHT+IGvme1+2nqVdUlUVWWPbeRnIKdBxkCmpHPmxfNFfW8lq/GJj2BrgNP/IyAW3+vRu4LIzPCJ9Vvn2PLJreZqU/0=
X-Received: by 2002:a17:90b:1942:b0:296:df84:da3 with SMTP id
 nk2-20020a17090b194200b00296df840da3mr6944564pjb.35.1707819418425; Tue, 13
 Feb 2024 02:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212115043.1725918-1-robimarko@gmail.com> <c97d10fa-39c5-4e5e-93ce-1610635cb4d4@lunn.ch>
 <CAOX2RU6OwiymM_O_62VETgkBNUQP1TuOKJmm0D1ZUXBA7ZPJNA@mail.gmail.com> <7c5dd47c-26b9-4a12-af93-6139ae85e864@lunn.ch>
In-Reply-To: <7c5dd47c-26b9-4a12-af93-6139ae85e864@lunn.ch>
From: Robert Marko <robimarko@gmail.com>
Date: Tue, 13 Feb 2024 11:16:47 +0100
Message-ID: <CAOX2RU79o_5KRJZUJKA_++rrFXn66oLU0jOVHZnA1wHf2kA7RA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: qca807x: move interface mode check to .config_init_once
To: Andrew Lunn <andrew@lunn.ch>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com, 
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 20:48, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Feb 12, 2024 at 07:09:04PM +0100, Robert Marko wrote:
> > On Mon, 12 Feb 2024 at 15:51, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 12:49:34PM +0100, Robert Marko wrote:
> > > > Currently, we are checking whether the PHY package mode matches the
> > > > individual PHY interface modes at PHY package probe time, but at that time
> > > > we only know the PHY package mode and not the individual PHY interface
> > > > modes as of_get_phy_mode() that populates it will only get called once the
> > > > netdev to which PHY-s are attached to is being probed and thus this check
> > > > will always fail and return -EINVAL.
> > > >
> > > > So, lets move this check to .config_init_once as at that point individual
> > > > PHY interface modes should be populated.
> > >
> > > Just for my own understanding, not directly about this patch...
> > >
> > > priv->package_mode is about PSGMII vs QSGMII for one of the SERDES
> > > interfaces? We expect the individual PHYs sharing that interface to
> > > also indicate PSGMII or QSGMII?
> >
> > Yes, that is the idea, all of the individual PHY-s in the package
> > should be indicating
> > the same PHY interface mode.
> >
> > >
> > > But what about the other SERDES, which can be connected to an SFP
> > > cage. You would normally set that to SGMII, or 1000BaseX. When an SFP
> > > module is inserted, the correct interface mode is then determined from
> > > the contests of the EEPROM and the PCS needs to be reconfigured. So
> > > i'm just wondering how this check works in this situation?
> >
> > I just went to retest SFP support and it works as intended, as soon as the SFP
> > is inserted, PHY will get reconfigured to "combo" mode so that fifth PHY can
> > support both fiber (100Base-FX or 1000Base-X) or regular copper connections.
> >
> > So, the check will not interfere with SFP support.
>
> So for the port with the SFP you also have phy-mode of PSGMII or
> QSGMII? That then gets changed when the SFP is hot plugged?

Yes, that is correct and when SFP is plugged in it will be reconfigured
by the driver into combo mode as that port can actually be used for fiber and
copper at the same time by changing the priority.

Regards,
Robert
>
>         Andrew

