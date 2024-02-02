Return-Path: <linux-kernel+bounces-49902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5834D847134
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB1E1C27018
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7971F4654D;
	Fri,  2 Feb 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ErlnoUYW"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E344652D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880787; cv=none; b=UVRxs0jFOOc1mpQoSrecXu1A69usfu0lZgAXCn377dnx9jCWfjoUeWY78wrrhrNgfERyr/O8dFYuylx5WY1FW9H1PLC5U9r9oHYSuKBWRUVhpatlv+tHet/n54MvCD5y0Wn+I/tMo0MVYMl3irLrhyV0U7ipSnEjWWJmsvExUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880787; c=relaxed/simple;
	bh=t91s0mL/o0byDIL+UXIyCYRJ4C8dkVrkqJnTEQgrmH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZ4krZnd8erWpu/Q5u0tM7Ri0Sd6Zm6vrxSaCpWwWM0l/U2mKFGIa0+7j7UH587D5H+tIMPLYpzOSG7gpHdnvN7I1N0GIcKvSBqAx1gK+JG7Qbtfo7rvzghbJqT8vpYuFYPCLp2lJ+dhCKntlf8/WcqR7kINYjXkTkLD2u+xEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ErlnoUYW; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-46d02f41a2cso166530137.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 05:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706880785; x=1707485585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t91s0mL/o0byDIL+UXIyCYRJ4C8dkVrkqJnTEQgrmH8=;
        b=ErlnoUYWXYPVA79hDEROn4USe0cQFhU8zKicBGIviEE65yDnCKchPAwJqW6hl+lT2M
         Wlm8ulAvyhg46SZndgPubXzP1yQh4yzsetQj5KqMIywtRGvLJF7Jb753zJK6dZec9DNT
         IbJMRemBZkbzYUTmj8acPGXV0fe9mNFxBeUyNWwegotB4HwVhgMuWus0pIXe6Fx68F3n
         MqV6ShkkYnpHoiakgYWRGTFqaLxF25Se9EjS9M+M+3lGiIqKV3MEbsRYnAgIHI6Ko/nT
         ZcbubRvn9jWrUbCIVSK3+FoWX1EKMEi4MF8OfsHQd/LA+SQsb2A/kj30AKt+TLslfs49
         oYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706880785; x=1707485585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t91s0mL/o0byDIL+UXIyCYRJ4C8dkVrkqJnTEQgrmH8=;
        b=SN6jfW+A5PT2Yjs4+tD6LqFAFgZ70NeGUzUDJOJY7tbVIqPHMLz51XZsa8vk8qywgp
         78R1KL5JNVL6USZMF2Xhjuyprs2wrEhkjJU2OIoW/OnqfXEvIKSYNf/kWJanwr3+i6r2
         /PLCEYDtvE7+hRAOcH0mHP9ANQC+QOcn+UQsh4aTfHGN0yYeHFkAschVNv+Kj1oZHbvz
         G9jeUIrs3X9NbQQ1Npo5Qt0UtAssYlwvt9tlwCZWC8qQs5+677y4WK63NPkEAmZyY7uK
         LmP5rlJzuq1hzuf6Tr1k5EKMbZLOmOpGTvhqjRbA2z0zQ3NuJ5ZjrjeJAlJjIuSwCiYc
         DIfg==
X-Gm-Message-State: AOJu0Ywlwzhz/yNH2Q/3H7OA3ATySK62gqrOqFNbWlRzW1aoqAJk57sq
	Y1wtQIeBTvPXX0x4SBh2MHOkVl2ajr43WAjKwgDnczREUVcYbP+y+bGmI05a8YO0O6KyFSTLZdN
	4bt38flFsni900MGAoBMgvIvI3EI0WrR/cejA9g==
X-Google-Smtp-Source: AGHT+IFGWRQkNHVpKRzENL6DBKR2SJ8NyE2HtNOW9n2HP7M7/CMGrLj/MqT1RHfg72HDMgBmriRlG2kdzZc3opEAJhY=
X-Received: by 2002:a05:6122:4599:b0:4c0:1037:eade with SMTP id
 de25-20020a056122459900b004c01037eademr1050005vkb.15.1706880785225; Fri, 02
 Feb 2024 05:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124205900.14791-1-martin@kaiser.cx> <20240124205900.14791-2-martin@kaiser.cx>
In-Reply-To: <20240124205900.14791-2-martin@kaiser.cx>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 2 Feb 2024 14:32:54 +0100
Message-ID: <CAMRc=MdZQ+TGQTAQLGqeT0DidgVUxSTTkXHwNwiat-ADahjwSw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] gpio: vf610: allow disabling the vf610 driver
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Peng Fan <peng.fan@nxp.com>, Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 9:59=E2=80=AFPM Martin Kaiser <martin@kaiser.cx> wr=
ote:
>
> The vf610 gpio driver is enabled by default for all i.MX machines,
> without any option to disable it in a board-specific config file.
>
> Most i.MX chipsets have no hardware for this driver. Change the default
> to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.
>
> Add a text description after the bool type, this makes the driver
> selectable by make config etc.
>
> Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO=
_VF610")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---

Applied, thanks!

Bart

