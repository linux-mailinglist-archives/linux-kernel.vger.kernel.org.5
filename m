Return-Path: <linux-kernel+bounces-73876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD1985CCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE921C21DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479D20E3;
	Wed, 21 Feb 2024 00:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yojhpeu0"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA374694
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476493; cv=none; b=jlguDeFvnNpujAOs1Q/RaSg6OgfgIvHOIgFztPs862cUQW20s59l4GhtesRVM1XyZA4uC4P6F5rVyNnMsRdd1Qa/VrLPiaZh9rsbdF3KEMEZkJITaHKEmQFt12d1EviuUWHRt7VVsUykSr0CBQER8vUYfg5TfV0ewojFGnQ3u/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476493; c=relaxed/simple;
	bh=TAyHqIh7nSfAdd9tVNUMVeUz7n0RsJ5mQARd3J5Z7o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpFrFUc8jtE+5WjzLCBobFXRa5XUanlhdLacgS5oscgAed7A6kxTZOWyHCiHJmYxLRqgnzWAj9TvV4fshjuiq5L0pSMigAHp9VvH98Q9bFA/C3AzU0j1a3Pcw/8WovabN2V6/1dSlv/U6Tp20Zu7meRcwjuVDail4PL/AUManms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yojhpeu0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dbcf58b05cso48315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708476491; x=1709081291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugbs7Jg6VHvaoDcjZWVoK1eM0qfrHvcJKgPX5ZJOhD4=;
        b=yojhpeu0pFuyYppauTLZdFtb8sig8N2k9kllzwMQEgYr8+tYpqK0w1f4mZSbmadL6J
         fSsYu2DF3duD39sfN3pWRn3QEuxpJN5mx6M8pFHmm4iCnzfCqoOibeZDBsdlsAJ21daF
         RBGvrF8EwmcDQH3/8Mi+IXjuWZ8W3W3Ld/CPa5V6Ge5FxUuV9MjS12HOl8mVlmiHKbRE
         7TvEzm+DBFazxRgoAnDa03eHXfEU0mhYE6jKxa/GIanmNYxWwVdD3oGj8s8wKj3lsE0d
         z0zrUFM1GIdNjWz3M1lDWaCkGjobIxf2emMFFK7seedyfhTw/SIMdAOOOPrdswXxNlDa
         vl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476491; x=1709081291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugbs7Jg6VHvaoDcjZWVoK1eM0qfrHvcJKgPX5ZJOhD4=;
        b=Clwh6j693oiSZo2ObzSsZZmZN18HmuRQ4KvMTMuPCkSerxStUjSsog28DqziupyCQj
         Hc3o4K1cUjTodqVyR1+2SG3WIqoBfdgQbjGHrEkin9JvKkpEvrydc6hCUjZMpZWhe0tE
         kMR/Df9vK2BwmLFjIr0LfTLwi4PaAvQtpq4XPoRgD2IR1K+ljrj2p2UCxYSmCQlpqhI1
         oe3HrnG68vGZufvn6MO2fNhVEzQG1cYLq0ZX93i7VkklCbWiwN17mPgNNBH8FT1OpbHB
         2YqRyO4NoC72qgKLmlEAtc2tG6rb0SCNzptPq2f6mQoDBhIOFeNhKnIP1HopGs/brVJw
         kOGA==
X-Forwarded-Encrypted: i=1; AJvYcCUqyhlf01Yfvc1Ae5q+C0ZpAQU+GmeXh//+bkrDT1o0mOqzh9/ofvlh32T3nm628HKCu7rRp5yZI/YyYHdZ5rDftaOtoYKaV8blG4yz
X-Gm-Message-State: AOJu0YzYTV7oQKbp+p4ghjNVvqxHQ54pf4t8oFbjwja+Y24rII8uCY3X
	Q7Jo41IgP1wW6OaE6HIQXRphs/0aK0wTS1bq7Y/o6B6sBE8W1fRp/FmRqeiDbv3jE1RadmQsdeK
	94xyNQFH6jWP92REsQGYRiOjIVhlJVtfh2RSy
X-Google-Smtp-Source: AGHT+IGmomN+J320UJO3BPdb9kM8qujnyRAtdlS/NC9QqErQiwpvTPMbYWYYmX0JdfQqBKahJXCssDuKBj64fFUkwww=
X-Received: by 2002:a17:902:7207:b0:1db:de7a:9122 with SMTP id
 ba7-20020a170902720700b001dbde7a9122mr104606plb.4.1708476491323; Tue, 20 Feb
 2024 16:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com> <20240207011803.2637531-4-saravanak@google.com>
In-Reply-To: <20240207011803.2637531-4-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 16:47:35 -0800
Message-ID: <CAGETcx9eiLvRU6XXsyWWcm+eu+5-m2fQgkcs2t1Dq1vXQ1q7CQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] of: property: Add in-ports/out-ports support to of_graph_get_port_parent()
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	stable <stable@vger.kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 5:18=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> Similar to the existing "ports" node name, coresight device tree bindings
> have added "in-ports" and "out-ports" as standard node names for a
> collection of ports.
>
> Add support for these name to of_graph_get_port_parent() so that
> remote-endpoint parsing can find the correct parent node for these
> coresight ports too.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Greg,

I saw that you pulled the previous 2 patches in this series to 6.1,
6.6 and 6.7 kernel branches. I really should have added both of those
Fixes tag to this patch too.

Can you please pull in the patch to those stable branches too?

Thanks,
Saravana

> ---
>  drivers/of/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 7bb2d8e290de..39a3ee1dfb58 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -763,7 +763,9 @@ struct device_node *of_graph_get_port_parent(struct d=
evice_node *node)
>         /* Walk 3 levels up only if there is 'ports' node. */
>         for (depth =3D 3; depth && node; depth--) {
>                 node =3D of_get_next_parent(node);
> -               if (depth =3D=3D 2 && !of_node_name_eq(node, "ports"))
> +               if (depth =3D=3D 2 && !of_node_name_eq(node, "ports") &&
> +                   !of_node_name_eq(node, "in-ports") &&
> +                   !of_node_name_eq(node, "out-ports"))
>                         break;
>         }
>         return node;
> --
> 2.43.0.594.gd9cf4e227d-goog
>

