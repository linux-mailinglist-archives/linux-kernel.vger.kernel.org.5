Return-Path: <linux-kernel+bounces-59348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ADF84F5AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1F61C22457
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D9E33CC2;
	Fri,  9 Feb 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPzgIgFk"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3E1E52C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484682; cv=none; b=fhUnAndf7YE+cDZMsBlglm76uUn73FyJ1gqqegKG+BUkxIir6TlZ6QRaBxAYhOCg7KrMMMjoWgqHdqhAwxabAJ5QZQ0uGce1Z5zxsbJT8KIxHwj+0r+cLJL9ZzfDvrwna3WC1vqGiv+criBP45IoEFlLCJV1TgeuQuYvbsmupys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484682; c=relaxed/simple;
	bh=Mim8vD8gJESe/0fUDuSiNMYfNHsNLNW6PUf+sKUsmmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li91wp4d3fZMf0NiQn5c1OhHJEAzhMPN9sniDPcgz6YkOtbyyl5euN9a3v9TA2TcOxhxOWSigrqOdvEjrF0nQU7qkWnsUxXobYVOv3FAwchyh7d0YPn4gR/yARK2cFLLrnzlnB/A7S6iGRUUX0OivwCGaqY/LhVeEWCMhUlTszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nPzgIgFk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6049ffb9cedso11381747b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484679; x=1708089479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mim8vD8gJESe/0fUDuSiNMYfNHsNLNW6PUf+sKUsmmc=;
        b=nPzgIgFkObO0MOc3p2guR2EGNA9uycENx1/ttXnVcyTdBOkE1NsDiggiF2+2EurKYC
         FjhpT3X5sBPZAKv490e4/WlIkddhjRJWKA6ZVEHpjvQfbgIAnj2RIu4TF3pT90p3SlHs
         KlpPGaUcVu9RzQROoissIYYaIiXshhuybTbQz87t1oJYWcOnQWrqnQAT6t00doVPNv5M
         /L4JsmCNgV9SZtj3eVFf2lWsA24lFwLbu/uIUpoD5yUuS/5tAMZWMsmVmjlolZ3xZx15
         WycMnoG8b4XUyfhvan71FD1IHkx+kvL9wwOqqUbc4X235Q1JIn6Fu02aX7TKHlGHxetL
         6IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484679; x=1708089479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mim8vD8gJESe/0fUDuSiNMYfNHsNLNW6PUf+sKUsmmc=;
        b=tdAHm5akQXCWgvqqsvjV/vcUayvW+RC9ayXtfwu06trIJbI8HuM3cDpRs82P7cMNGp
         lbwo0srIb6Y0quxnq5zFu7ZtPGxmUMjhyxriaqrL+3HUvV8yRgDbPi0iytQgMw0OS7qh
         eLSnzGfrOC7X+Hu6MB56nlkxWEe5oz/YLCJOs+QUAGjOkgnDohfan6DfcDsSh4CQRBMT
         TZyhP3MB7pkFC9jk59h5YzRTMFpD6DXnaYBFr8qYY8bGHULvc0Keu9PdzvX1kJfL6IW/
         8QEp8iPKb2TFx11pNAzu++I5k5jKo0ZOKnBdC2OnGpdFnau1P6pUCjUkivChmicilGGR
         G7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXE+TQDEwI996tr/orO9ozYFdqvdovgyEJVLoXxUZ9+VBDU97yvLYs0V0qKcWcXa8K1oGngUGgCkdjDDRVDq9LiOy7VpUZKZFSFbz+v
X-Gm-Message-State: AOJu0YwzXeoyRgU4rw1RC/746LNdE7tcBwNxcN2WxNchEPHwEHMXenl1
	ll8x/D1HWvanpfCIu8h3gJGZLeK/2AaXaoJf7RhSVyxNwDVmV8XcmDxQbj5eLrnxt3lowlA1+48
	OH1/J1Y1OvqAVku2ji4aFoUKaBLMfH3q7Qk//Ug==
X-Google-Smtp-Source: AGHT+IFHT66k1WhwsagbjF5zSBn7DbWunprn10+GW30Mc1Txx10f+fBBGhs8Ga0o7pdvWU8CUBQ9Ep34Dd1f1e8Om98=
X-Received: by 2002:a0d:d696:0:b0:5ff:4e43:8430 with SMTP id
 y144-20020a0dd696000000b005ff4e438430mr1356875ywd.1.1707484679550; Fri, 09
 Feb 2024 05:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:17:48 +0100
Message-ID: <CACRpkdbw+mJsGb=6iu6f+mGoi+vouu6TPztaD5SyuG+n8Staew@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/11] net: dsa: realtek: variants to drivers,
 interfaces to a common module
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The current driver consists of two interface modules (SMI and MDIO) and
> two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO
> modules serve as the platform and MDIO drivers, respectively, calling
> functions from the variant modules. In this setup, one interface module
> can be loaded independently of the other, but both variants must be
> loaded (if not disabled at build time) for any type of interface. This
> approach doesn't scale well, especially with the addition of more switch
> variants (e.g., RTL8366B), leading to loaded but unused modules.
> Additionally, this also seems upside down, as the specific driver code
> normally depends on the more generic functions and not the other way
> around.
>
> Each variant module was converted into real drivers, serving as both a
> platform driver (for switches connected using the SMI interface) and an
> MDIO driver (for MDIO-connected switches). The relationship between the
> variant and interface modules is reversed, with the variant module now
> calling both interface functions (if not disabled at build time). While
> in most devices only one interface is likely used, the interface code is
> significantly smaller than a variant module, consuming fewer resources
> than the previous code. With variant modules now functioning as real
> drivers, compatible strings are published only in a single variant
> module, preventing conflicts.
>
> The patch series introduces a new common module for functions shared by
> both variants. This module also absorbs the two previous interface
> modules, as they would always be loaded anyway.
>
> The series relocates the user MII driver from realtek-smi to rtl83xx. It
> is now used by MDIO-connected switches instead of the generic DSA
> driver. There's a change in how this driver locates the MDIO node. It
> now only searches for a child node named "mdio".
>
> The dsa_switch in realtek_priv->ds is now embedded in the struct. It is
> always in use and avoids dynamic memory allocation.
>
> Testing has been performed with an RTL8367S (rtl8365mb) using MDIO
> interface and an RTL8366RB (rtl8366) with SMI interface.

Tested on my RTL8366RB on a D-Link DIR-685 as well, works like a
charm:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

