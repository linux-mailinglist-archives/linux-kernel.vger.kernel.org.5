Return-Path: <linux-kernel+bounces-61065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E329850CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9F6B251E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901DF3D65;
	Mon, 12 Feb 2024 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI+JAULM"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9A1841;
	Mon, 12 Feb 2024 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707703840; cv=none; b=X2DvSgAxYqFfhkSmLE3WCYY5kdvtlz6LE9DrWTvhNb/+DTUj0czh/rkJXZSrZ6WILWjF0euy5UUhFgE77BKRyDQ8Q7PzNqnI8OF8RczlIGCLSRi8yLJ79vO02c1xe8CLsFr9PCI2yfWXF6lWtSkG6t01HJAl+pBQyqVnrV6brQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707703840; c=relaxed/simple;
	bh=6XqNeV8HICRTclL6GDae/YFFVPmhHEsvis2v55t51iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq+Lvd3HdA2Syt8XlBYsiN+ym9C+ypbKOBYJua5+VtM3PaSVE7RWFtqP2y6sYEC/NW3wXAdVHraPq30DKYgpJSILW286ehMkEjl3bAdSC30U3FqK+gk4Vy2lPQbrAefuxTGLLu2BLU+MPrv5p6AFnrBaf33+AWBiy+UvyzNcl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI+JAULM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60493e299b6so25884897b3.1;
        Sun, 11 Feb 2024 18:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707703838; x=1708308638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6XqNeV8HICRTclL6GDae/YFFVPmhHEsvis2v55t51iI=;
        b=DI+JAULMZ9PwJ4YJoXUsaD4dZjQtftF9t0XTIax6HtEjqMSQEtPSZC0fXbKnIHFa9R
         LXLbW2R8JurkGROwSg3ccNYouRQeUlb2cLsPeSlLuZcHzw5YmcEPfxe3f8n8mM6Uqcgf
         JKzQ8RSy191kC4XZd1NH1M1A31nOgDec+Jcd9g5r5uZ9xdFB/uCI+kDA29+KsnKw3c92
         Ws5U7Vr4DhULRmF/0Trovcl9Q+gVWW25x8LhDqqcGV2WW3YR3TX2UYy5iRqc38HGoYf1
         o2uZDPL0neKgVfATAIZl1tITJM7yv3v4psziv9P56vcHXd2vdOLZxMztwxLcBAZL1Y0v
         7fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707703838; x=1708308638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XqNeV8HICRTclL6GDae/YFFVPmhHEsvis2v55t51iI=;
        b=mVlWWJm5TxFTi8KFd8xnBx/79ELHjGCkHz4cKRsVIP+80wFuILgplDsQSdJ1+U5OVO
         pxLUA40fYTf9WBSWTr3pRmfCVWjDFkraQHqT9c6G7W0hyw4ZKavMHIfw1N22R5RpXEih
         IlXv7BYd0LsEK/rNkIUYTafoceprBwqvxfy4DMTJA0YAa8Ngy/0xki2cW5i1YdJ9MH3T
         47McgHoL7QuKHYPUI+HxRkOQ2GBylXPJnOgv8wN+HDo8X1wslVeVsqUDalnZyYRfg+6d
         0iZFu3hxsLq8c6fId2B6M6t0ecyFxEPjafjp+VyW/mUPvVR/UKBEf0XWeBx8YHzBD6UE
         gP/w==
X-Gm-Message-State: AOJu0Yymz9U4OBaZYw6s5K4UQHmC6M4sop5PSP2sHB1h7isU9mbmv192
	iNQXqbyzg6+zDr7zBRKt6ZA7ODMpRgxeFhVB8nXeI59oCZQoy/KRuw3Tlb5HvWEQGJKPCXW91wi
	lsWeoQIVu/p5UFok7JeKgC+NOoBo=
X-Google-Smtp-Source: AGHT+IHZVH2z4XzjxzYa7ZY/aj3j/96lF0YHhg6eswXwPgd8cDrQWDvUvHENdPBsxgVmuErpURN2XDu9u5q+rMSUgn0=
X-Received: by 2002:a0d:e242:0:b0:5ee:a910:107 with SMTP id
 l63-20020a0de242000000b005eea9100107mr5487218ywe.21.1707703838313; Sun, 11
 Feb 2024 18:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131134621.1017530-1-hayatake396@gmail.com>
 <20240131131258.47c05b7e@kernel.org> <CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
 <CADFiAcK_XjLNjzZuF+OZDWjZA4tFB8VgeYXVJHR8+N3XryGxwA@mail.gmail.com>
 <20240208072351.3a806dda@kernel.org> <CADFiAc+i9i29SL0PM8gzmDG6o=ARS6fSrTPKNyqh9RLmWWB78A@mail.gmail.com>
 <20240209173838.GH1533412@kernel.org>
In-Reply-To: <20240209173838.GH1533412@kernel.org>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Mon, 12 Feb 2024 11:10:27 +0900
Message-ID: <CADFiAcLCv=r8pyEYR_46LfTWdmmb+ssN99nKxB2EdNXf3guE_w@mail.gmail.com>
Subject: Re: [PATCH net-next v6] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, vladimir.oltean@nxp.com, laforge@gnumonks.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon-san.

Thank you for your reply!

> It appears that the series at the link above has been marked as
> "Changes Requested" in patchwork. Although I am unsure why.
>
> I would suggest reposting it, say with the tags supplied by Marcin Szycik
> as [PATCH net-next v8].

I have resent it earlier with version 8, including Marcin-san's Reviewed-by tag.

> Also, please don't top-post on the Kernel MLs [1]

My apologies. I wasn't aware of the proper etiquette. I appreciate
your guidance.

I was not aware of many things, so please do let me know if there is
anything else. Thank you for your advice!

Takeru

