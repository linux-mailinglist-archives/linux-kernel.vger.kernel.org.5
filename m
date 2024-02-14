Return-Path: <linux-kernel+bounces-65232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD4B8549C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13305B21A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F5353386;
	Wed, 14 Feb 2024 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLFZf1YE"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E07524B2;
	Wed, 14 Feb 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915384; cv=none; b=FA51TUZu4B1uYJIXz3f4M5u+OV8ep3shfSt+l2qILFjBeVlpAfjZQCEd2EWIyUHJ/Eh/p9VXI4rx++NxpIfQXT4g9WSLjxMQwb83o8kNi76vBivcJ/wvOmD5KwLK1URwZ5SGF2KPZs/5Z3ezP3DipgfoxUSHDoVLgFCGrkGiAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915384; c=relaxed/simple;
	bh=BvZiBFtd1/yR2YlF7wcWOokDKadIUElG7972GToHNVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5jDeWJPQW9alww/MUetu5PZll9oo59daNByCvEkvdLjMi57vTF2fCI5N+qaezjLIpvXxvwB1vblFJKDWl8rXNRrqV2J8QEVDRp01I2DrlKkmY7czKbnWJATqJs0XPcuLQsCMPpsR+p8w7+HxiRRPwbVIGcE/YmRynlpTWt3Ca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLFZf1YE; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso2845702241.1;
        Wed, 14 Feb 2024 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707915382; x=1708520182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XHZsoNoLoEFnlnV78+Lk34bmjhSEU006PIr8jhyp/4=;
        b=HLFZf1YEhhbQPgrCkVhhXBYj4uPF03NCN8w4Ee9prwU07wsoIHi+MmyInxQbnfeC4i
         y0NkKPPuR48dj49CM689n0wKuH+RFCwCxOYIxv3Jy9qK5CHpzlmHpO5YMNdhFXCZeizf
         ZV+9BaP3gFwAk5FdGupIAEy2g2AmLrsOL9OgLFzdT+nf3jJfD9Iwq5aAkgzw2XXHEVx6
         eGMLCID13kLiH9aP0wojEpGl4tv9+iAgjikkRLFjvYxdnxL6U00pYR6jGy2U6up+V2kq
         IWAcTimOmKvdy8N6Nipv39s/O6xGkb1fYltWAXJcpPYOK3NRDggF/Tjla249C+RdCI2J
         K/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707915382; x=1708520182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XHZsoNoLoEFnlnV78+Lk34bmjhSEU006PIr8jhyp/4=;
        b=MEz6s50T0MdkrndBijlhsR7vCZ2fo4BgwKJxMeT0+0FgnIP2lipspHe8aoYMBMrXKJ
         +vtwVlFXZuyaJhn0+CVANsKOhzENF2yR7BFIuyfLGJTlBlIUsk16D3unqmdPrVpv6DdS
         hHQEPGGkG2geVrWcO1zElgywiMRAzD//8t8rl3jDKsD1LRxVK5pO//5CrEIda+wrYX9i
         +Bn8bQJZU3hbXSrYKyT/UvAWTrHoHO4imCr97mFI3EbhbcBIEykyRy5J90AmAjudcZcE
         y4/yOWxdd9XyDRhrlVNpRCRJ6oJrkrRkh0upEkU7MfAO1Y7ZfRQyUH8NDlqqQILyQQ2U
         e4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX6piNWLm5jbB82HgCnwAGtcCL8lfufJtlQcdGpbcqlCCwvUZcRTXtTp6scuQySX7bedpnNIRISD0QwJ4oZ12lRivyF8invbv9Y+4FV
X-Gm-Message-State: AOJu0YxlM62V5raFBXKS37pzzrvJ1dUYXmQBEE/4Xw25mA+kik9lqE+t
	Gn0/luZIW/0F6CMrMn2NXDDZg+fEeKeXf1hJk4PuO4nzlz+gdd5YTvfMgfVtXdEl/4B6Cfji5K3
	s2ICmQ0v7EgNew2zhoJLJ4HlPJAk=
X-Google-Smtp-Source: AGHT+IHFduVz+Cu6aMTUgwJZ7KlSTtydgd57+6W1PCptyTCAmb/MDIqrhFLH/CK/s4uBTPBfRUcgdghDDJ60fi08ffA=
X-Received: by 2002:a05:6102:942:b0:46e:c78e:380c with SMTP id
 a2-20020a056102094200b0046ec78e380cmr3224519vsi.1.1707915381929; Wed, 14 Feb
 2024 04:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-3-paweldembicki@gmail.com> <6db0fd10-556d-47ec-b15a-d03e805b2621@gmail.com>
In-Reply-To: <6db0fd10-556d-47ec-b15a-d03e805b2621@gmail.com>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Wed, 14 Feb 2024 13:56:10 +0100
Message-ID: <CAJN1Kkz9NPMuoKsm4XdmGS=Y9=SkYM-_EZhqxBojfGZycegtjw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/15] net: dsa: vsc73xx: convert to PHYLINK
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 14 lut 2024 o 00:19 Florian Fainelli <f.fainelli@gmail.com> napis=
a=C5=82(a):
>
> On 2/13/24 14:03, Pawel Dembicki wrote:
> > This patch replaces the adjust_link api with the phylink apis that prov=
ide
> > equivalent functionality.
> >
> > The remaining functionality from the adjust_link is now covered in the
> > phylink_mac_link_* and phylink_mac_config.
> >
> > Removes:
> > .adjust_link
> > Adds:
> > .phylink_mac_config
> > .phylink_mac_link_up
> > .phylink_mac_link_down
>
> The implementation of phylink_mac_link_down() strictly mimics what had
> been done by adjust_link() in the phydev->link =3D=3D 0 case, but it real=
ly
> makes me wonder whether some bits do not logically belong to
> phylink_mac_link_up(), like "Accept packets again" for instance.
>
> Are we certain there was not an assumption before that we would get
> adjust_link() called first with phydev->link =3D 0, and then phydev->link
> =3D1 and that this specific sequence would program things just the way we
> want?

Yes, it was the simplest conversion possible, without any improvements.

Some part is implementation of datasheet (description of ARBEMPTY register)=
:

        /* Discard packets */
        vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
                            VSC73XX_ARBDISC, BIT(port), BIT(port));

        /* Wait until queue is empty */
        ret =3D read_poll_timeout(vsc73xx_read, err, err < 0 || (val & BIT(=
port)),
                                1000, 10000, false, vsc, VSC73XX_BLOCK_ARBI=
TER,
                                0, VSC73XX_ARBEMPTY, &val);
        if (ret)
                dev_err(vsc->dev,
                        "timeout waiting for block arbiter\n");
        else if (err < 0)
                dev_err(vsc->dev, "error reading arbiter\n");

        /* Put this port into reset */
        vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
                      VSC73XX_MAC_CFG_RESET);


I agree that VSC73XX_ARBDISC should be moved to phylink_mac_link_up.
Other things could be optimised and it needs more care. (eg. This
implementation doesn't disable phy when the interface goes down.) I
plan to tweak it after the driver becomes usable. Please let me know
if it should be fixed in this patch.

--=20
Best Regards,
Pawel Dembicki

