Return-Path: <linux-kernel+bounces-131323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F589864D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531CD1C211BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E0A83CDE;
	Thu,  4 Apr 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVkYGhWF"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929B7F7C8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231106; cv=none; b=NS/ztvrAIBeqxCzn+ZwpCO9dSz5oCkHUgGo8VpVzVXlQlQ0NLo3yaFZZn/VaPZ5ATxRj0VEpiedBQ/PJGpCcbRzl4pNfHA5r295vNbhB+/F5EEE5kKnNk85jfSSoc3L5cvY1zjaTJ9ofOcXz4hfzHO2r5vmp3RaMcaUKrrV/FrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231106; c=relaxed/simple;
	bh=/eLKtqRVMeBA+chi62xtVXaYNjNu3QL5M36nmn2NBgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh+IErJDzIOzw/efxM5p164UUMQJWzSArl2vZtrNHlfCICJHqgO8PqZgl67kjC0HaEs8xQpTZZG0TK1U1pW+QwJhCouqZwzb3A/m58gz17cEWaAwct/FCT0vWU67TWN6Ee97ZcKXk7BMk2M8MblBnLHNB4SERpjWHpuVGl0B9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DVkYGhWF; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-616909c32cdso5061807b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712231103; x=1712835903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdNenNQMt+7XONzUW/9kB2yS6/Tol2kmLB8BmO6OGLU=;
        b=DVkYGhWFfDN55ztook7u/m7XQt0/1DqgYEDQnuFZDO2f9sTQTLBrFr98sgJSAEPBTy
         CYDUBrddaT3BTeeVQRTNHoomuhfbL0h3ksiBLbYWOwRkpk0Tk8UduqsZI0hnh9URk3Vg
         XHCtdeiQw2W5IchOzIDCB6jlUZ/zutD7CWvoo+hqXzZS6AOTaSjDRhSRQwL2G+dVBalC
         s6d3hKXJiDE7l3BHaoYQ6gKQMhHAHA2TUjRFQEU79gotNDh5VHhpOvhyC8A+VZm527jM
         sFjPU+MfqQUo9YVqifBt9t30tT0EnkjMtQ1g4bHx2DXAQ+TsgVtqR6jiAdxPCgN5o7ln
         BA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231103; x=1712835903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdNenNQMt+7XONzUW/9kB2yS6/Tol2kmLB8BmO6OGLU=;
        b=rtkm2IoI5vdrSz1aNO4OkEcFgaKN/OXv2lmyf656u1mW3077dqKE/b8EAiRRiPMfiG
         vAaE2gC8dmf7ohj07C1U+0eKFv9SiEvwEaUrFr8g1PMWZuDp5JXB/IWu12OFPmCUU7i9
         Qz81Kemt8fVZLKSeHMYVxeOxiLDAjk1flcvMeF2Ho+UGKAROM5168RI9HH8UYJbtIh0w
         upKTVVp70IauW9nuZNUvyxzE7Mzejm+j+Q+XGPqQBBqzJJIyXVQBLInkZ0NTjv5V0bGf
         hpk6NomMgEv3PyKQ3RQFz5s+m5VBchP73DsIhcI4kEwMIB37JVJS73J4N1mNf8tGDbzr
         iW3w==
X-Forwarded-Encrypted: i=1; AJvYcCWIJ04uzwRdWka6dPgCJgWosXLvciJvpFzBXD0jzKlqDM8u2DI/Kay2uRTYWr78L6MBzJYGWRWjIHy4Rx3G35lL76y3vC84AKuSaYRr
X-Gm-Message-State: AOJu0YwlB43WJ019DP4o1QlMeKogWsIpPej+WC40uHulEbt543KD3r54
	b6barYQZUcBgQzOP88J5tR7HxjJymkZ/kC8BcuxWXFUprOHrkMCxlgXscntZUSaVCWauyYy/Kqp
	av9EWaQ5I58xVkRgxNsqAxfPLZ6Fpic4WQBDNig==
X-Google-Smtp-Source: AGHT+IHx0tbRHl168yEBc6/WvmuxrXGfc7u38wmDLosnPzuHcIEhg0s1LVsQ751gQ9iNeQVSKkhCvmykx56Fu3EOO5U=
X-Received: by 2002:a0d:ca02:0:b0:615:8174:61a2 with SMTP id
 m2-20020a0dca02000000b00615817461a2mr2142897ywd.8.1712231102703; Thu, 04 Apr
 2024 04:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:44:50 +0200
Message-ID: <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: brgl@bgdev.pl, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cristian.marussi@arm.com, sudeep.holla@arm.com, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 4:02=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> The SCMI error value SCMI_ERR_SUPPORT maps to linux error value
> '-EOPNOTSUPP', so when dump configs, need check the error value
> EOPNOTSUPP, otherwise there will be log "ERROR READING CONFIG SETTING".
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
(...)
>                         ret =3D pin_config_get_for_pin(pctldev, pin, &con=
fig);
>                 /* These are legal errors */
> -               if (ret =3D=3D -EINVAL || ret =3D=3D -ENOTSUPP)
> +               if (ret =3D=3D -EINVAL || ret =3D=3D -ENOTSUPP || ret =3D=
=3D -EOPNOTSUPP)

TBH it's a bit odd to call an in-kernel API such as pin_config_get_for_pin(=
)
and get -EOPNOTSUPP back. But it's not like I care a lot, so patch applied.

Yours,
Linus Walleij

