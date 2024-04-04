Return-Path: <linux-kernel+bounces-130831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C089B897D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC481C21FF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F21B28D;
	Thu,  4 Apr 2024 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR1ZsnBt"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97D182BB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196657; cv=none; b=bgTpgeCxJJ2g65TjnZInrztKYTgkQV0pjUIK4w1JZaG7Sucea/gcqnFbO+1Xmx7oCRO5jTjSEF6NkuweOC7KFBpkCZRbBcIRzFmffLGwyzDv5/MtIj4YmlER/lXN4XEEQA/JylkHtvNKrr6eV+DnWiYQsQqCYFQnkwZNvgx+UkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196657; c=relaxed/simple;
	bh=FQ2Kpn6OR1Yj2YH/Ck3c4xee1Q84WBt2pj5wiZW8nuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjfIwDW57AQiXvFpBXOzisx6QPafoO5cIFjQ6IY02s0fhtTwjY+VqQlo1Zk67yvJeuTJzd6Bn+KPluh1i2x8x0kPlXM6OoTRZmNEpaC0zFmAdBp0BWLsVf49sU+8D0iL3y2KvrFHt+Ec+dOvHb6h10DG2VyOc6dMD3IvV+7NGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR1ZsnBt; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso10552b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 19:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712196655; x=1712801455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wkpcaJkFJunlvwReooNL9ITLKXSaHwLNKZGZ8SavM8=;
        b=TR1ZsnBtotkxLd+/9zq63QbkeimldwHoQlS+qpRwsaaFS2jFtKFLCiLX7uj5p47LyN
         8tpRVBGvoHAaW2UjqUaPJ2oaV65JiVFGY6P9Chos97OFJJXXXOip7yEKTR477s9IlG7j
         rr29Gr3xqdtvbarKlMHu2PyGzaFdIAQ0HUFdUvwMXpQHLlKvCLXPzUzCoeOaLiqJ91+m
         CEUR9SU23vHUB9imLwApB7fUemWENHR9HkLDoYZvXMuqABIu1ewflDEwjpkKxbiUVLCc
         dRWcD1KwYNEV9piLZ30g2E4h7EQANiGSjJ9s0NdK18um5LjcuDRoovn2geYjA/NNFzDR
         RsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712196655; x=1712801455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wkpcaJkFJunlvwReooNL9ITLKXSaHwLNKZGZ8SavM8=;
        b=Wuwsu96yucQ1fnTHuMBcnPNGGVRKf6O2a6umlfiPvzA+P5QxPIpq64lRHDrC2vvrNW
         LbeLefK3+vrqWg4X1nn/4xwu8s7GItdRrpzndzU4IUBQWjRsLDCDNxXbGwYy/9VqxVqz
         W7mmQKzyaZZZbS9M0eJqkvZYaFM30eQqI8oV01bMQCHlvIuGKbFzNnERVQZu0zJcFgUQ
         O5/x9TzpJjt3Lvi2zSF6gFbVCHtcw1fhLTFnCDApw/De6KGN9zBcHQbfHoh9bO5jEPKV
         1nMR4iLXSrgqbYn0UXpFa2cjy+1/S4JMnwhE3jwPy/bP0wDM0FB7M3LUya4CmIh70SMy
         AFFw==
X-Forwarded-Encrypted: i=1; AJvYcCWkXlQ+iZxLJLKd+E3BwZ08edMrZeDJSHULl3pFFqLH2ZUXGHknqlUVs0RfgMJ24S3mVKQ0QMi3lyj4aWDgjJpWiRy2iBUtlndnq7XV
X-Gm-Message-State: AOJu0YxPgCIIuntooAC20NEeD2cywv260TcOJEy60L7lKkr7FXeYs43m
	f2Ty8lLQhUVekBKlw/d1EWx3V+hhk+praX4aJQrHv4LOk8rcYGyQFNOky3TPTFueWYgLHU9ZAX9
	nkogTxqLuUKUJr2m/vzMS6TviNHA=
X-Google-Smtp-Source: AGHT+IFwklTm3EE801F31u8hWJqGXig4ZoOFish+EmeCusB5nrpCAv3+pAoajMt4I24ikV7HPUKxxWQ//1yJMLC//Z8=
X-Received: by 2002:a05:6a20:3d01:b0:1a5:6c14:f558 with SMTP id
 y1-20020a056a203d0100b001a56c14f558mr1633660pzi.13.1712196655059; Wed, 03 Apr
 2024 19:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403234729.175168-2-thorsten.blum@toblux.com>
In-Reply-To: <20240403234729.175168-2-thorsten.blum@toblux.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 3 Apr 2024 19:10:42 -0700
Message-ID: <CAMo8BfJiawBvXes5MubrN+NJuVkwByrZN_DnH7btcsXY6Ngx_g@mail.gmail.com>
Subject: Re: [PATCH] tty: xtensa/iss: Use umin() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Zankel <chris@zankel.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:48=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux.=
com> wrote:
>
> Use unsigned size_t to improve len data type and umin() to fix the
> following Coccinelle/coccicheck warning reported by minmax.cocci:
>
>         WARNING opportunity for min()
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  arch/xtensa/platforms/iss/console.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks. Applied to my xtensa tree.

-- Max

