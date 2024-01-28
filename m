Return-Path: <linux-kernel+bounces-41481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE0A83F28E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0CD286877
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54578639;
	Sun, 28 Jan 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biZnbTlH"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB28646
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401849; cv=none; b=gw8Bs9gvmAMarXyD3fFeQKaaUx/Dgx2Tx20ovjDJr2qsj/1RnU5Wfj2OvzHjzXsVjdeW1UzI8+BjKInsOvxqlmoPPwV79hAQoH8n5PoHFGksIs9K7dfL8k7gtwcBlUJRk0r2MRCw7kegZEJqckHM/JD6F1fWf70g6ZoihBvsXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401849; c=relaxed/simple;
	bh=6XeWa9wReTzghX8am264WYPfkFIN/SSiF0UBjGJ3W+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4amLRCbMsRZ4cYrKUMx3EHfrvWVXMOiflAZOuRqd1RmVTkLBqPf6ccApQmpFviwx4OLiDB1hY87jzqI7VuERZer3HZx9qatzmWxmbX04L9Ns/tUcstUBqf/LrQEyY47ZyGoEYhVujP4uCMsNDnMc11OxmF3x8UMaSKs/AP9w/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=biZnbTlH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ff847429d4so21208487b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706401847; x=1707006647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XeWa9wReTzghX8am264WYPfkFIN/SSiF0UBjGJ3W+k=;
        b=biZnbTlHrEq91I6Zv/G8RfPNW1HlPoUVK7+0XNmxySddAq/gZFt36KUFk6eadAF94W
         5EB3iww3ZwdX0LQrcdb7enk7WKD4j0QiAYyxIzT0DHsgHDokvrgYRJqLhZrt1GZlY9N8
         bWy+NZDuZpgVNZCd00UZht54zVSap0vff+TYB361BGlIrqqSv7FSb1eZWFFiiJY7yOXm
         1FvoTiaBg1OwrIvsbitb/SNEzUO67KY4ohMyxhhf82XDbMVLK7rL+oL2xHJskwxvUi19
         79leAfmPNqnNdaoOGuYU9PwU4wxCzzYOsJcalxucmNt1TZf63zwT+yt6ku3h3UQPv0g9
         jjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706401847; x=1707006647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XeWa9wReTzghX8am264WYPfkFIN/SSiF0UBjGJ3W+k=;
        b=BaSh+ZS5+JT7MQDIJm7E7kNOBSxctI7U42lsvPhQ/xrHoXKTKzG2BPLjHuQwwxWlWx
         ipkAzRQmiI8aXNJtQH9Z38iT8fdJqdw/+APPsDiVTKQAad7bO4TGP6Gn4rtokd/aoDJG
         qlA0Tol7w65vi/JpDmgHJE3UdkDY5ec56Q/XmOeYyu5o9RjQN8FMwATnikIlcmydb+EW
         j4oZMUxoWDztvUW3LvVFiHSSMMe12Cbp0+qHw6DuZ0Yz08ZWJYfHFtVVIbWCVVOod1Bv
         N58XKoRjNQ3e8s0JgV7dRfeVZ1GtsARPRYg1sL9lEc7dMhop9w79jt4g15KypZwifSzP
         eUSg==
X-Gm-Message-State: AOJu0YzmQJocx3IcXQd+Eni8tors8fP/MByhKbdE1FDkSY7tmbZmJSKi
	8GGDhtVIrdu1Fi/UrPFuDPd/gguE7MOwIf4FduCHggslMot7n95oXdaK1M1rAX75bC4BB2rHW0q
	uKh8bbS3V0je9GBsJsslopqP3ZCKpVvQQyoRUbw==
X-Google-Smtp-Source: AGHT+IGxs3s4swA7aJvEB7pT6rtvh2/gd0hceFpjYEOEUxrbCgEYQOKDnDUlCO+e5gXGU0buzAnJVxVqviu2TJZaXKE=
X-Received: by 2002:a81:8450:0:b0:603:bb3a:cfc9 with SMTP id
 u77-20020a818450000000b00603bb3acfc9mr1244584ywf.71.1706401847078; Sat, 27
 Jan 2024 16:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123083511.21063-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240123083511.21063-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 01:30:36 +0100
Message-ID: <CACRpkdaSdB1TZ9qM6YwJTExNMw1W9Rb450kt=6tJLKUixEeDSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: amlogic: narrow regex for unit
 address to hex numbers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:35=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Regular expression used to match the unit address part should not allow
> non-hex numbers.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij

