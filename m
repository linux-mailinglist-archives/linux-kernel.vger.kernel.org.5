Return-Path: <linux-kernel+bounces-59357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E9D84F5C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00E928825C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8438F381DD;
	Fri,  9 Feb 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyYNF0PC"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649642E847
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485058; cv=none; b=PpU8JNqUHvh4LNoNDPZ/ghUX1Q3Ir9Y0Im47o3BqfaCq2nZZ/Mx0Iy2zj2LG2sEFwi0bSkBsMAEu8uWHvwOcyMi+MVHFLmLxHMwdC51jRVegeUWiicdSVDcXjSsXw5sJ3yrskWURos0/Uj/pDKcXaStvz4AtjP/h1dfarpWo4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485058; c=relaxed/simple;
	bh=O0Z/dpFBHnf2aGHeu+zM2P9An2C3mvbpnSWoRPcjfd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IG7+yYuNS0fWI3oCg6eW2Z5YBtlmMVngpiZSNh14UANheE/D+kWrKYNO0IjpXsqNITfSkU+S/F6HCrLMamgsuyrLq8MdlEVVrlAsiNyaW7u/4Lenb7q6lPm5+x89LhBGkaynpB4snYTu4zSya3mD4D+DNtVyjTlkbwduCcV7vGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KyYNF0PC; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604aaf2d047so10731027b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707485056; x=1708089856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0Z/dpFBHnf2aGHeu+zM2P9An2C3mvbpnSWoRPcjfd0=;
        b=KyYNF0PCBjuFsCKJKi37Y5DPCtM4CYREZ+teXA3IDsryEzkins5vmZHK6Ajoq2Ffh4
         JKuxD3Umv2o/Y7MlJX71W7RgQNUenPETBu2SF/hfNTt90zBGiZilSW6QCINDWaeY3jMG
         Nhf/Sfqg4jwaCRe+Yonlo7EGei4dOzbpNr3JUOzhCquygacZngEISO8cuzjRTtISO4be
         CWq01Bud6m2aiat9dPJmZTWKfduH/RQbLP2V5wFOTmAQhn4sgICui4EUOYFSqNhflDKG
         Kf1aDCNuWjA5IWov2zt4+G6ICJEooyq+cYuz1kd13WTN4zJ6yxLN6SpKeEFoabCLU5sN
         s5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485056; x=1708089856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Z/dpFBHnf2aGHeu+zM2P9An2C3mvbpnSWoRPcjfd0=;
        b=aw2gOOsY4oLSwxQTAy48s+/p6sR0/mQYKORoC+4ZqKYr6DTfaVa1DwbYdko9ldWtaE
         ywBf9aSXbLOFbFrERmoVrGctmVe4J0zs+xXBUbdF81iwHXsDNf8mOuZbler8wW+QeTvZ
         ClqkU4FRB07f6FPY0KEbBrpd4PSx0+B5sPBsT9JMv02fjU4LT9DqnXTIlxmIDRBxc+j9
         A17jgZOJWiEjIEL/C5acG5fWKLDhpLxa0sE54tHLpg5FsJ07BKaTLoRNHrOtjreLdxh/
         JmlTYkXKn5c3AZstlLWVmjYnHVpYRc4XHEX/DOGy3rppasym0yPc652oI6KVN7hapYOV
         N1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkPyoazeQt2QrBinR3QWvkgtFYKnBkp7FAAET1b8yeuU/RCBa8Ms84ZWv8ECwFdnfXpZWeyoBI9DIQuOvmTJHJ2S+X9KXTq+3pqWHn
X-Gm-Message-State: AOJu0Yw5aT796G6TupbjpO+QfSUQl1AEugsEN+Iab6bx86TmdLrQvgI2
	cJyXCVIA0q3+Nx1hjtltTbrVOv7zrbCDkTPu9V69N/Wuxl9wFB9W3dlTuf4UpYMHKnwxK74B+Ts
	GtN5f25VDtbpzOlaP7tS2beCQ4NapNYBKJ+0GxQ==
X-Google-Smtp-Source: AGHT+IEE6opJCMSFPZxtYJ9lhFWs16+8O0MbjYP18a9YLE2vj3AHs+OBbahALeN3Jp5iQV6eaX/MkCWq2fEOffZqRs4=
X-Received: by 2002:a0d:eb8f:0:b0:603:c982:2877 with SMTP id
 u137-20020a0deb8f000000b00603c9822877mr1584995ywe.19.1707485056513; Fri, 09
 Feb 2024 05:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-11-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-11-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:24:05 +0100
Message-ID: <CACRpkda8GLnzUHjD8nwcQYzX0xaQVsFHpPJjMkp9R6WvyFSZSw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 11/11] net: dsa: realtek: embed dsa_switch
 into realtek_priv
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:05=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Embed dsa_switch within realtek_priv to eliminate the need for a second
> memory allocation.
>
> Suggested-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

