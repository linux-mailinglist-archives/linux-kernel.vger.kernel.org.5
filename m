Return-Path: <linux-kernel+bounces-59335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8860D84F591
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237591F26AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADFB376FB;
	Fri,  9 Feb 2024 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v22Ciwcd"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C723374EA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707483831; cv=none; b=SH9nlNswjfRVWi5YUGNHA/rsf5yIOZJdHcVFSwpCM51LeRpcVvWq4ZUpeG2Lo/PMQV3SuBYQEsz6XVdh+iuW66vPc7NhOCGUhoDGQnHV8LV+C6tjkywPY+8go+AAEzWXJDUst+Fl7NWHRgo1Pbcgy+D4Jcs60IRej5izDfygoPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707483831; c=relaxed/simple;
	bh=5Dm9Sef/c0+IpFJXoQ2G422bYW6l04FNCs0Rkmqa12M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ehobv/CQNTvbwwcEIP8WF6gV3PUvtxrVSCIvE3oU7xTS6f9zDyuV0xNfEhZsDX5DYUUMoukHA8bSEB6sYrZEgoWNqbYYCnlAFrzpaGU+6uI+zMp3b3Jp1RMy9PzqRdm7cGM4CPpjPNkZWF9i9I6w4C/0ghzLUk9NBUIf8XAU0DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v22Ciwcd; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6049c6f79b1so9576467b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707483828; x=1708088628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Dm9Sef/c0+IpFJXoQ2G422bYW6l04FNCs0Rkmqa12M=;
        b=v22Ciwcds4T3MyPWiB40+Wf1vWqBy7jR+WL5BZdtGB4Ca3YhwT0quDJAlUcftL64Ql
         8ETjeWJgWYkYyFQzoQSmtTcIZ8TtjPIlRf28VPYygjHfVsUhRxe5iVq2C3d8crZ3rfWl
         8ISnCJL9tPcutOl+68ay6xDtjiIZnfY46bXKGn9yq+c0sxsWlYscr0ztJawxh1i27b8t
         E3b5AtG1EGv4Ab4qMasWVpOPrQlfOE+TbPb5HpiHrbgpYUcwAiXWOTKQlMcPqb7s8vl/
         MyTPnSfVf871qUYI04xpS764S7HMuVcGqHGPlMT9VxRKfrafBpb4l10hFS098ZqQe5N+
         LTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707483828; x=1708088628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Dm9Sef/c0+IpFJXoQ2G422bYW6l04FNCs0Rkmqa12M=;
        b=xLApi9nbrfQMSxuiKvjetzlWWdtVF/8naqp4YnEo3wGKEmguqkjMnA329UM6CbnV2w
         HfZnjhiYeEaO2sYxX9SZXVfgY/q+NQCxPwXhANeSwxJbZXc7Px/QxGxU55njzhg1pLIs
         c5qTF2VG6OWzTszuhu9iJ2QpuDONA1Cf7QtzlLStlXSVp7q2tK3M9BAk1jYfSdZSKTJb
         u2mwuvD70nKnMZUyovNQi5edmtMguYk69IVy8H1i+r1UkF6IC6ZxaEUzU0Pya+6lLR8h
         1NCMeh9tEwxcXJCS7MmprM/XCYakCnAaYCySU/VgEzmFsTjuLdShRGgi+mulvEJljAg6
         f7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYSc4a5OMFgAXl3dvxSaaPdubkZGTeftgZ4Qv+4nAyU3z6NVPjBZnZSKrXGEz3y6zmHjRkVsgaRu0r26vsMooMWia83e4Poa7h+4AU
X-Gm-Message-State: AOJu0Yzaa/814pK7zH6rW2hdUSlRN8wIw+vXo1FG0MJq6NN5bhc11ioY
	qjCmR04qPPZwL/Neiwg6JewEeZCcijEktd7cy7Raf3c3m11I/8W7t7V5go5Gz5Ynf6KQ2XQAGVH
	LL58CkXaPIQt1WZl9hgFJX7PCqPSdbZMmsPfvAg==
X-Google-Smtp-Source: AGHT+IHRaA9PmrrTXofU680GgYl5PKjfjw/jXlmCDUvWjB8I8wzpchTgQklCETuZqhqnS7GOsPBXmvMdhWJv5GWfAAk=
X-Received: by 2002:a81:a045:0:b0:602:ab33:5f5 with SMTP id
 x66-20020a81a045000000b00602ab3305f5mr1426479ywg.11.1707483828518; Fri, 09
 Feb 2024 05:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-2-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-2-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:03:36 +0100
Message-ID: <CACRpkdb-BwCaKkjs5y3wUoznjyj1sCw0WVrWwMs880zRHsXRfA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 02/11] net: dsa: realtek: introduce
 REALTEK_DSA namespace
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

> Create a namespace to group the exported symbols.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

