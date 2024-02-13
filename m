Return-Path: <linux-kernel+bounces-64505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11C3853FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B0FB22428
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B6762A02;
	Tue, 13 Feb 2024 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0ya3bvw"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9DD62807
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865635; cv=none; b=SgGl/OrFkUeZd+mZ95dtgytzWayiAnAxb+hLCRhERfkW6+vzFtqLoyxbXKGBVuAox0R1Hx5EQIhwlqBoRQkKWFmf3rzfkz9YRvNgaZ7tZI3OOjlO55r9lFBu9khEPcF8Y+uthCFIGZx7PYtKw9oioAO6HLKg/dVm4j2ZEvQFstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865635; c=relaxed/simple;
	bh=MjAOKycBPzBk4VO9jkOkv9nBTectr6pmu0X6Zna2BAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoW7zd2Fy7cTGbXuJ4G+X7MUjEZjfC7rfoGJdw3J7sEt1KXa9V9NJWOD+qO2sk74CDUny5naEp1vjDKF/5+yr7QX9/a/xvt4kjTnq8SRh0VVeT73enmUyfg6U1gCKaTR8LANyKzggoC/vkGPTuGw7O7LW9BOiM4DP9x9IM2UJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M0ya3bvw; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5063987276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707865632; x=1708470432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjAOKycBPzBk4VO9jkOkv9nBTectr6pmu0X6Zna2BAc=;
        b=M0ya3bvwdjzmfbQmWgeeOPVTgAmATTw/AiXusdZXqHr87FBmqE3yJcAb36e7/dW73r
         rkHaB4dQGzBwpztpthLfnK9yeM2PmCpRoVSo9DTKTZodwsx5w/Dt5LXuND+76+zMKTX+
         E6A02VHP1FhCYWolYnUyXkNeuAXJnqsYmctJdpKt1LITjJUWRODA9s4bxNgGkbutb5HF
         qBoAVjiR4Ig+M2sgxkkaaPBzarXe5/gkIBeyNB+7Kpfe8xx/K1f7RHuzfCA//AWkr0cI
         ru86TZY+WZa8ierXsqezE8DD6V+XddnSYEvEXohoChDfIFyZ48dYPHpbWlbcFAqzOWOu
         m96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865632; x=1708470432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjAOKycBPzBk4VO9jkOkv9nBTectr6pmu0X6Zna2BAc=;
        b=a3u+yeHgHs/8HnmMs/kpOv3YePSRTILSoN9azc8X5PZzgnSR1pHaNpjIY0x6z/2/+F
         G0N7DS8QPbFiGK/yJ+WGc6MraQzSMIPws9YvIPvTIX/DMrqFtqWrA5CJvUGehQHMnDIB
         JSmIZDG8ryk8sr/RV1av+q8f4QXgml205k2rJFnL2aNev5CrsDLnC/bjKlYifg36oy2X
         3QwZl/rKcJkMUiTlL7UAwvet/b/TrRDXlkkLzITJYCM6qP4uFLjWBvTLDaNzPyMn3htJ
         kRNo15VlAWH2NRunWeA8EMtwDiZi5u5LbU3BWiQKEFySBm0zT0LJI1pJ0+DwFZxRCD6I
         fhdA==
X-Forwarded-Encrypted: i=1; AJvYcCVxrP951idR5RvuYR8Sg7kYYYKx8x3bYS1N8JDWBvjqnS2PcAa4bBT1jgF1ou/lnRB/HA8abzh4YbGKCtj3urpY09gzsCEy3FZ+pIpD
X-Gm-Message-State: AOJu0YxRyUH1otiktNkcso56Npm/LkYenKTvRhhrA+8bhw+YDgq80Ahb
	ggvHoykTvnaH1VjgCymhIjE967bhftqQIsBZWVHzJQdweemkPcHJBMkwNQJiD1zm8eyRW3jle0V
	f3Y+7rp1u23KVzPcNr4vOGyLVeKqkOdIfD8K/aA==
X-Google-Smtp-Source: AGHT+IH0A57JXze3tzIP18mqi1HPtHwASPch1852QaRs+J14eOrw3rz4b87JD/2SNy7XjqOkxXDiVmzM6XYJUMCpeIY=
X-Received: by 2002:a25:8691:0:b0:dc2:232d:7fde with SMTP id
 z17-20020a258691000000b00dc2232d7fdemr792874ybk.13.1707865632236; Tue, 13 Feb
 2024 15:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-2-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-2-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:07:00 +0100
Message-ID: <CACRpkdaKRPV=mRkTcOMGgnozxNS=fojWJ4nSnK1GEBSGSM9NMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/15] net: dsa: vsc73xx: use
 read_poll_timeout instead delay loop
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:04=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:


> This commit switches delay loop to read_poll_timeout macro during
> Arbiter empty check in adjust link function.
>
> As Russel King suggested:
>
> "This [change] avoids the issue that on the last iteration, the code read=
s
> the register, test it, find the condition that's being waiting for is
> false, _then_ waits and end up printing the error message - that last
> wait is rather useless, and as the arbiter state isn't checked after
> waiting, it could be that we had success during the last wait."
>
> It also remove one short msleep delay.
>
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

