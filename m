Return-Path: <linux-kernel+bounces-38691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF3283C426
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DCFB210C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F75F567;
	Thu, 25 Jan 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UfH5Y4j+"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509045EE60
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190971; cv=none; b=CB3Q4XSukCRo4kC4HboeoCfRfJbNvD5mud3dZxqIXVi9ymu0MW09d8JcfjU9tcyTacKfNozr+K0/umm5DAgIg/odE7hG6BcdkLs7T6nFGRQeVZOwBvvfX9xIyUZE49/p27ypblf/tmOa4IAmhwGVUaDkI5gWXMu8XW6br7Gtfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190971; c=relaxed/simple;
	bh=1W9WzjA31f+QWbBJtAN4LPmsaACvO46+1VesrnmG9rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxnqPGBqOaev6F8LuaLyk7cnmxkRKgZQjd/xhNGs6DOkoWvSXTaKV+ITUszxGYMLqfLziVnj9599u32EorM4ljDkyuBPPXZWv18SQVSwSfF8vEQBOPOdnWLD7DzDHvBsvuvHsbDCCwBGuljk+f4+XWSfNgnYGR+ne3HYRQKDHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UfH5Y4j+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf0390eddbso51259221fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706190967; x=1706795767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl7ci9bKGwzAV/Piftg1NztgrDQGV69BjHXq7xOdai4=;
        b=UfH5Y4j+kuXggm336J3xoPKSIVwor79inW1F7FHtG0E2Kl9iC9jI0MWxMN7CgfmoAI
         cGPZdyifhJHvBA8izyu8IXhTMvTpb57sEuamDvz0ub/BKe7J4s24ReAHBNK78eGgrnSU
         DsziiWCXVAiFgFsHXByVPMd9IHV72JkvrtVFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190967; x=1706795767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gl7ci9bKGwzAV/Piftg1NztgrDQGV69BjHXq7xOdai4=;
        b=A5zO68qBCbhfwcfJumQPxCKfeJrNzLdc33oBBViGmpznlBWDBpLEkseWRU9lr/wm8t
         oJx//upq5Jv2W5rn7bZyPAMxUbLgyXdnMRG4et6FGNhpnQ3En4npEJUG2+cKc7xuObqQ
         vI/5l496vNu4AErJYUgM3AMdfQJY6jlMpuo8H0DoNfw+LaR5LVfHkqfaaISqSdaSUv/7
         ZRzIgs0CvLge5KA6b75W4QqUr6OtUp9sDbNMUMaHO8SX4UaoAv8IJ+XePIkRPELWO8/N
         6R42wJjzk44dkSvrvnSsnsZaP9rB1FQ3SArmcc2yPQI0m0nENge/7pbFK1fohWHoBImM
         qRzQ==
X-Gm-Message-State: AOJu0YyELtszW4rQEjdHBzTW81XjEokK/fV3MWAiO2L2PcibSu1rMSi5
	i297GdEb148j3pr/FouTlTfgjrFtXDWRi0bcbmaf5zk/P0kJqaL4ZkJgqKlePuIBagobj5W1dCE
	FsPOJJDPsbQmE9zePHQOecE2nYa8g3YU1ksgX
X-Google-Smtp-Source: AGHT+IHTL+gSOIeOXE6322kBzt5pebjRQ17maiu2CeRm/+cwYjTPWnzcXjMAr3OR6+BB3/cIFHz5oUrMSyVWo2pt2X8=
X-Received: by 2002:a05:651c:201:b0:2cf:33b7:9050 with SMTP id
 y1-20020a05651c020100b002cf33b79050mr700956ljn.12.1706190967013; Thu, 25 Jan
 2024 05:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119084328.3135503-1-lma@chromium.org> <20240119084328.3135503-4-lma@chromium.org>
 <170618986350.1469172.17149163593213396683.b4-ty@kernel.org>
In-Reply-To: <170618986350.1469172.17149163593213396683.b4-ty@kernel.org>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Thu, 25 Jan 2024 14:55:56 +0100
Message-ID: <CAE5UKNp5oorZMJwor=8Z_2wtCSS23Q1-25_RNoDHNi1USx5_7Q@mail.gmail.com>
Subject: Re: (subset) [PATCH v3 3/3] mfd: cros_ec: Register EC-based watchdog subdevice
To: Lee Jones <lee@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Radoslaw Biernacki <biernacki@google.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 2:37=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 19 Jan 2024 08:43:27 +0000, Lukasz Majczak wrote:
> > Add ChromeOS EC-based watchdog as EC subdevice.
> >
> >
>
> Applied, thanks!
>
> [3/3] mfd: cros_ec: Register EC-based watchdog subdevice
>       commit: a1958f84deb5cdba020af725fc5003a05af4819c
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>
Hi Lee,

I will send V4 of the patchset to address Krzysztof suggestions, in
that case I should skip adding V4 of this patch and have only patches
1 and 2 in the V4 patchset?

Best regards,
Lukasz

