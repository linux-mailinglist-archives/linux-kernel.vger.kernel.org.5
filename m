Return-Path: <linux-kernel+bounces-136631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED1289D64B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C389B2381C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08583CB2;
	Tue,  9 Apr 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTwGcgzD"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4082D7F;
	Tue,  9 Apr 2024 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657219; cv=none; b=YeMjx6OBkMwksm2Krlp1aTk5eBz5/14OwrjoLHxWTVXqnm7gkChnGNzLu7fJcFINYAHFuXzPaJzeR+IA4W81h1EfqEh0/6CuMK6XOkg58hQGjXTKOoUAbjZZOpIliETbVPhiWX6OLS2YS58OimAy3V7Gq7sF20qCl97TntJ+wyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657219; c=relaxed/simple;
	bh=1od+6GPq5pbV6DS4pMNA1qWk2fASvx0vw1BVnXaMKxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYM90kROMcpM4kG0dzI91CHftywehGhikd+P+bULl77rutoscqUqtYD8E2QBqvZ1ZuERr2mnHz8N4ZavnchREjdSG7spd9l7+wk9U0QWPhrhx4ZlVR9Qaq9X5uPKWrsrhs5cd9rTnYTrI8pqfsb7SBDBMJISaym4bSkEZ1qL8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTwGcgzD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed4a80c19eso260529b3a.1;
        Tue, 09 Apr 2024 03:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712657217; x=1713262017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN1BLV01IgpoQTWEsMyLEiQ/+qIuzUOwceRziV5xY0w=;
        b=PTwGcgzD5xkro7ViAIPnp3ckdRYgY7/zMrgVaSjPv0UnQpoP7jw4isFX9ZgI2xqFJa
         bgAXRFOwk/ZEeEWBx9dJvmU1AjXbd8OL6YjvjEVRny9tGvPnVDpa8AEK6d3zXok67+q9
         9t6qoUHQT/xIlbX8uEVrNIv8uG6Y5aczL+dLDSQvX3dpILKCl8PR7fuqhTOLYL/t1ijB
         vvP255qDm2BYzi5sWVXXb+7v9rCnez6Dcxv6gbfYOnvmppWsbM4OPyQ3DHSMsdQ3lyGb
         ElzpDOt1izfn38bUBuwqBCIeR2RQ5gDIV3qYzXxGrlrZgog37zfU/+o+NwAR27N6jfAU
         fkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657217; x=1713262017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN1BLV01IgpoQTWEsMyLEiQ/+qIuzUOwceRziV5xY0w=;
        b=MJF6zP4v7lkFlJC1qDgBDlAlnDETWLmF9t+7oOr/WCquJsStBK6o3gXBzF4w5OhH7U
         fWLpA+wd2Wg29+GR6yyBI3DiDnaAv/bKTOF0B9FuIVUrLQaeVa7tKwmjxKvgbQtqg7Pk
         WKKTv1CpujwyGdruVdL3c7smsp0VjfkldIbL697fHgvZt2141p7cgDHuGcvKoguoS2HY
         AdODMZhjwXqbmCrrB4pyEvvsjKJJSlWFDZCI9ua1ugMmcP409V6oLbqDt8vJtgC8uakW
         1SkgYKUKG9We4vMM67mKpnu969KbhiZbNVEI3lNbUuN9RFKdSB5Q5AsfgLtZr1pSLMc5
         WjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx2j8BgQSEOmQ+KKwJU621rxWOqX3DqV0Xc56JY8NMyUlW6k73f+N5fPHfuUmbwelzqe33aoQaRJNbTdNgyOMb4Xyz5mXLBbqsMVsU/UQkz5cI+oc0HeQpklt739rfSiro1/8VLZOAMTOB8Sfd1fdALZCByLf+iYixowilxZeu6qn8EQH5
X-Gm-Message-State: AOJu0Yy/FGzywk2h1wYzqGbaour373+CqBD3GzZkMxkOAj6o/YLFwbyY
	xYnEJ0wuOer7MApLxVAyAhz0uf2/tPXGm3b4Wc3dJiRnvLXtZ+hlXgDJ5KFvgsqEgrwAz+UgMny
	PO/UdRbBwTt2AI53EXD50ybHSU50vy3nEceU=
X-Google-Smtp-Source: AGHT+IHQoCVGiINYUvQfKxTrsUtBLAkQj+AXwq2x9u/Og21z/Gjz5hL7wTzbKPixjBrhy3BiUueA2htTaWWB2sOdK00=
X-Received: by 2002:a05:6a21:3383:b0:1a8:2d22:2025 with SMTP id
 yy3-20020a056a21338300b001a82d222025mr575979pzb.0.1712657217545; Tue, 09 Apr
 2024 03:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1712652644-28887-1-git-send-email-shengjiu.wang@nxp.com>
 <1712652644-28887-3-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5Cku1kifsnWJOr0Zd-5+49j-KB67iHZDcvUsKwrhVPtLA@mail.gmail.com>
In-Reply-To: <CAOMZO5Cku1kifsnWJOr0Zd-5+49j-KB67iHZDcvUsKwrhVPtLA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 9 Apr 2024 07:06:45 -0300
Message-ID: <CAOMZO5BfJBkyw2q3wi4q3yjEmQowg7Zsw8yEFyANMYYez3ai+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6: exchange fallback and specific
 compatible string
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 7:02=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Tue, Apr 9, 2024 at 6:08=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
> >
> > exchange fallback and specific compatible string for spdif sound card.
>
> Ok, but please explain the reason.

I mean, why can't these two .dts files be changed to

compatible =3D  "fsl,imx-audio-spdif";

, like all the others?

