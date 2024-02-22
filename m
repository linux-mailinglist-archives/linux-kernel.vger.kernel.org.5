Return-Path: <linux-kernel+bounces-76097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD3785F2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27C61C222C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E2199AD;
	Thu, 22 Feb 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM2SZDf/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D217F3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590450; cv=none; b=KoeRjWqOgaSI+36QMm1i7UeDOdC+r6JbI1p4fS6Murp8BIn/SPrhNHDgjxltWFRdy+nNfjp3lnDDY6Cwes6b+9jCAr4FAvJaWmjFXnoaV9G39KORJcmpwhWjamQ1MzrSdsoEJaHbexuyKthP/Q0A94j2j9osluNU5soqlu+1lPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590450; c=relaxed/simple;
	bh=z+mGQTZiNVs7YPpi0HFlCESGNSOQ2weUxYSp90GF+2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPOiSCQFHokFi67ydzzzcMBQGg24UAg7UTROlvf4zpM16iEDasXJ/TNIekPfWteq7Ht7rF09FPrbxqaPLkSj8w5+zv10te/L7udgwCe/+jsZZtM9AAdJVd2ZJgjLxklEEkMrCsMK6FxIZ2M/Mqu18S6HRMVHZjQqrnohiV1FnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM2SZDf/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so8872265a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708590446; x=1709195246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+mGQTZiNVs7YPpi0HFlCESGNSOQ2weUxYSp90GF+2c=;
        b=jM2SZDf/Y+AoApATOgVJAcyRwPZz1rjnZm5fsVGv7E1tLVMh6oiqFvm6oXTkAVpdNC
         Si8uCmiR+YjkH4JXrs2YtxsSS3ftJwOK/JILLLbFUCKW6a1+ns7UQqRT8QKRE2KFFK32
         9Ee2Iwu+FXOSIMku/UhLqQHbkGqXsweDvFQcycWvzZUTxzNVevLb93dPL+tci3noJ3ir
         +p8qo0V1wFSiZ6bvL2N2MKFRl4OfvQM3OxLsLXqcp/Dw3Cdv0iBFXPY8YlocHJJC0dhi
         /KtZ8v0m4fU3UCSaZx5NUfF2B1+MtYQOoKHRyH7ako/xiHtBO++J3zQN56+BU/lS8nsq
         BecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590446; x=1709195246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+mGQTZiNVs7YPpi0HFlCESGNSOQ2weUxYSp90GF+2c=;
        b=UCwsBKsamSga+7tZffFoIiib6rnZSpqDdNPRhbK5OAhTZtQAYMpExSnCyasKysk+5a
         1N09Q7xtMn+75dv2uGrdLoQLfzgwsx2XavSQneHqqCTCI6bKylG6X7ccAVjJQ+uVtMAQ
         9KF/E0xZNMdna9Hf1y8q27khUjK2y/0C6UcWSdi9mUj+lmU64MkR3tVY0+61LMFKJ0D3
         u9xkebSCNoYIxSy6Em/jAfoE25NP/31z/o4raEtwwy1tJTirfdB0Ji4fVQbnJKrCNNPS
         AudeQccg2uYuEukTGtELxL4DPZXI6vPLo7ZHFi11TPo83sSyfwlckBahky3I3arWYEBE
         PYZw==
X-Forwarded-Encrypted: i=1; AJvYcCWje7jsfTdYHtB3HNM7g2ypnxFTbEv8x1UxmaNSoNZ0hyX+wnHEM5/ZiNQzbwrFBnV9O9oiwKCFKS7PeaOjyqapmrEY+T9pKk1AG44Y
X-Gm-Message-State: AOJu0Yw+2gKTM+3YDbuo9JykODrQKs0K9hU5qeElHjSZjIisSYUbBLQF
	KZGoeo31mL31aOEw4L4TZuBZL/0Mo1+oa117HBzf/R+JdtFtg73xrDtAvnuKkK4spthFrOWZc6h
	DK8L4kFi8gSkqziSs01A+Nl0ijTY=
X-Google-Smtp-Source: AGHT+IH2Qxnh/Y2XD23vYD1Rel2Nz8fobiOlpuTkZaAifcP3I3bxGmThw75ddoQezkJDTJSoo2AeQwi1VWrr/mFx8C0=
X-Received: by 2002:aa7:d887:0:b0:565:fc0:6f1a with SMTP id
 u7-20020aa7d887000000b005650fc06f1amr2379463edq.24.1708590445774; Thu, 22 Feb
 2024 00:27:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220164005.1345603-1-daniel.baluta@oss.nxp.com> <05b7bf7f-9b5d-4ae3-a295-82f2b46abb4a@pengutronix.de>
In-Reply-To: <05b7bf7f-9b5d-4ae3-a295-82f2b46abb4a@pengutronix.de>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 22 Feb 2024 10:27:13 +0200
Message-ID: <CAEnQRZBD1+5JbFWCguL2U7-me6gEta_-XuUZQ3GkDq9=Wck8LA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Use a proper mailinglist for NXP i.MX development
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, shawnguo@kernel.org, aisheng.dong@nxp.com, 
	peng.fan@nxp.com, f.fainelli@gmail.com, Daniel Baluta <daniel.baluta@nxp.com>, 
	shengjiu.wang@nxp.com, Frank.Li@nxp.com, linux-kernel@vger.kernel.org, 
	haibo.chen@nxp.com, mirela.rabulea@nxp.com, kernel@pengutronix.de, 
	kuba@kernel.org, abel.vesa@linaro.org, laurentiu.palcu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 7:38=E2=80=AFPM Ahmad Fatoum <a.fatoum@pengutronix.=
de> wrote:
>
> Hello Daniel,
>
> On 20.02.24 17:40, Daniel Baluta (OSS) wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > So far we used an internal linux-imx@nxp.com email address to
> > gather all patches related to NXP i.MX development.
> >
> > Let's switch to an open mailing list that provides ability
> > for people from the community to subscribe and also have
> > a proper archive.
> >
> > List interface at: https://lists.linux.dev.
> > Archive is at: https://lore.kernel.org/imx/
>
> I think the R: should be changed to L: then?

Correct. Will change it in v2.

