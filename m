Return-Path: <linux-kernel+bounces-127000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85F89459C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B68D2820B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42AA537F0;
	Mon,  1 Apr 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v0/6EELo"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FAF524C4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000465; cv=none; b=kVzieqfk1ZprWJ3lrQxFpZOtBQF9X//UjP435AbBly8bZa/C2q+9Q9FQq2zELJRXk1P0XA4nh4DA4vs4amTa2yFTef36XIInKbCQT3cF6nCYBlZOnl1mleZyv/1eE8HRuKvdEfhdFdOx78NcbeJo0N7O2ymk+Du2h5Y3vJa5fXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000465; c=relaxed/simple;
	bh=18veSBurcj4Zy0ovVkcbXDSq6z8G14uZnoed51VrGs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/Av6whPESxznQbNoQFMtkv5Or7jvHjTWF6awfeYo2qHFqZjcdGoGGA9PwwYSD24st05cpDtEj5WEvwLIcrrkeCvn784zWpDLktkEdjSxdFavMFJlXRIyvmrIcAtW9156bSYvVNF3dVVxtI7p9orb2bMf901N8q4HE7FT60MSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v0/6EELo; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d718efedb2so58756891fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712000461; x=1712605261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18veSBurcj4Zy0ovVkcbXDSq6z8G14uZnoed51VrGs8=;
        b=v0/6EELozykvAAFym+L88Q7AqJqKB/xAjNLsp+At2J+xHsvsXPhYJ3tRYzRwpLQQvl
         fpVGK3J8vJz3yqv+L5oBJZsF6SwaycEBiZDcoBiOv/o8vo5OySlE1jo4zM9mj3W0OZAB
         kP0ol6KUnPDhlcVdcKB599q2uLviTBIIUB+HMkSruufiEz7WiU1+EA61ke1pNXosc5pW
         9yc4ZGhxO6ET95SFQzTF2cI1SLlPube9/MJnVNtKpH9mKOMdXzr0pkMeuJ4Rma/8H1iw
         hUMjpZBl+isl9EdcH75CE4kmCoLTPeg0msOVmDl08gcwHkmw52od2We4HVyfcxG30l/Z
         dxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000461; x=1712605261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18veSBurcj4Zy0ovVkcbXDSq6z8G14uZnoed51VrGs8=;
        b=Dc5o8RJFQp2cnpYanD2RN/vMNYMPwpHBEmUO2ybmRjKXH1b/rzkC5XZs8hadIh9D5A
         AZLh/ImwMnZlaky54CMpMmnxUXTfeST7LnJ/uDdKAY07wgFWF7ZFHPDcjdNJ2k15H0sk
         hL7m4Wki12QsujyqmZfPnLZR8ifODUmRqtb3+xNh16ppBsl3jCnXqzZ6ozKJn5lk+Yk6
         BWb8MlLGJEDjry72FN7zdB+xUJ6BSfQYsZB+bc1DxwpJYl0A5dOTEutJ6dK4kknWdmXp
         Zfs1jTGx21+0U8WLHdHjkJCnVca5UVKV0JHHaOcugkUF2zRGZAqHqVd0wgqL52NUC7dm
         /OdA==
X-Forwarded-Encrypted: i=1; AJvYcCUF65SQXmMzQ2jM9dzTZzqiEnbQ0ehCXI6jygivm8xpFDqm8hAh6+yCZqUvQrt6/aOuSlH7RPBu/MBIqy/D8NklSypR2ocmYEmD2MKJ
X-Gm-Message-State: AOJu0YxmZCPTE2z+0Y95YwBc3AneG9rD8s0fuAm4u4Apzgi6Rj9ZzFzw
	f3ujQ0fs6nP0AKyGwLgPhqnATUtSOfQJztDa5VRyQeE58KM2gJ2r21Kk1zyMxrd8JYBy98YV9Pe
	D8GC6/xSkprgTzWB3jzHLOL8NEOqmcfv0i/ztyw==
X-Google-Smtp-Source: AGHT+IFEZ8XahK9BngJd58iuzQu8IyjebX4QQq2XzZIfDHs8ynLOM3rPpXsyA/GW4d5ZA3rsUGjfOg+JTRpT14xd2M8=
X-Received: by 2002:a05:651c:a0c:b0:2d7:1e2b:6284 with SMTP id
 k12-20020a05651c0a0c00b002d71e2b6284mr7833633ljq.27.1712000461409; Mon, 01
 Apr 2024 12:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-5-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-5-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 14:40:50 -0500
Message-ID: <CAMknhBEd=P7vEh9tWE_czCUBsQaD2Hm9D9+-uAd_qFjVdgCYjA@mail.gmail.com>
Subject: Re: [PATCH 5/6] iio: adc: ad7173: Remove index from temp channel
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Temperature channel is unique per device, index is not needed.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

This breaks userspace, so the commit message should explain why it is
safe to do this (e.g. driver hasn't reached mainline yet, so won't
break existing users since there are none).

