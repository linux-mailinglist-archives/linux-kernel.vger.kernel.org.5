Return-Path: <linux-kernel+bounces-156733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C298B0771
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2509B2858A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8719C159579;
	Wed, 24 Apr 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5QjoJCT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58F142E62
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954886; cv=none; b=qGmrxuozg16uAQd2TBE76xMYvAvftVROta/KvVUc46/IDW6VKlYfk5nBsXdmmyva1GwHunxIVEu50DfeWdmFZgk22mAHnGfdCQLK905vI09dAc63PJSNZAlWb9YV/UTJLPN70f6BfLhiObwtMHqTiQj3Fo9mvVRjH3dGcErqV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954886; c=relaxed/simple;
	bh=YTGioqHw4bG0d3wWLA0C6k3sKtV4jev6rrEIMgbLhO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8FcEyv1n38OmyGHOeU6rk1WMxI7psDaAb5m59bUZYTxVOHcbXQz3X7Q+ebJzBjV992WcV7Td4tXVhb1/y4rbAYuPC8++FoMAXbSjNoYXM+VErCwdahKhqDEuMfwqbSZOU238WPvi39ed0/sJDqomtn9QbHiqePA+/EVmXojiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d5QjoJCT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2de2f5ca076so18064371fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713954882; x=1714559682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTGioqHw4bG0d3wWLA0C6k3sKtV4jev6rrEIMgbLhO4=;
        b=d5QjoJCT4tGPOUizncdMovUNpMyoBw50xu8aeFD05oztfFAcqdy3Bdul0lreOWRwCo
         /IZUPO6onAUVtXA5+RVzgIc5ZrLbM4AmKZ42OLHrE3wX9eLtEUX89LX59CaisXGvLJc/
         Mq+zwfEP3QqhcR2gtyvJ8GE3qKWIDXvLWmcZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713954882; x=1714559682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTGioqHw4bG0d3wWLA0C6k3sKtV4jev6rrEIMgbLhO4=;
        b=Ticl9ZOmaYh14P6Kt6Qa8YgOWrRZcR6qlBXttmzWUfnSSMn3UsH9kZesAoRvnZak6J
         jgSfSJwzFTIMg7nftJzyrwz0CL6eYJobPPLthAP4hF2aOnfvB2GSjmwj+cr1jfIlL2YI
         RTXztAI4sZkXG/lWBWL6AR4MYeWall242wzCz7WmKVwpkLza3qddLzj+kE3xs1aSHz4/
         Ni57BuXrg9q5Dn55cvC7a+gUc/j5Imh8429aT6dQan8NhIOVGOzcAzmsieXScFzaZR5u
         d4AnoLmxGgxzu2SdPkes5ndhAXn6z6gHoiTWG76atDYtj6fVTr8fIPCGgfbfVsoT9XN3
         bA0A==
X-Forwarded-Encrypted: i=1; AJvYcCV3dAFyDAzetHzT1ltm3/BdicI5dPFps/jXhQ6clm10avw+Knc9W6oNk77Kr4GC9LlttZZAhdHBij2d8fvBLRT1WoKYnlFxkV3hbvOf
X-Gm-Message-State: AOJu0YzszRbUmLqZGX1YGJ5OmYtvNrQ5QSTAMj9nfaFgiGz6kJiW76fI
	pDAJbDO/iIk3KwDGAl4w2yVdY8w1ymbb8tGxxf3SVnrRemm6XrZ7TN4NFrEK5Y342LdGOPhCCvr
	ubchZdqQu/988PSVCzxQkpfEHuLFVapoYmrRH
X-Google-Smtp-Source: AGHT+IH1SKEuMcbXbVaOT7b6LPKCdH0Hxd/9lwuaSIGld/FRJW7iu8EV/TAGnf3V8FIPftxocbi/e/dy8Ket9y/FUsU=
X-Received: by 2002:a2e:3c0b:0:b0:2d8:5e21:8ec5 with SMTP id
 j11-20020a2e3c0b000000b002d85e218ec5mr1359535lja.48.1713954882016; Wed, 24
 Apr 2024 03:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423122518.34811-1-kl@kl.wtf>
In-Reply-To: <20240423122518.34811-1-kl@kl.wtf>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Wed, 24 Apr 2024 12:34:30 +0200
Message-ID: <CAE5UKNpSNtPbdMKDb7pDTpSiCNndkYP7KC+m6xSd6aMMQvQ2tQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] HID: i2c-hid: Probe and wake device with HID
 descriptor fetch
To: Kenny Levinsen <kl@kl.wtf>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Douglas Anderson <dianders@chromium.org>, 
	Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Radoslaw Biernacki <rad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:26=E2=80=AFPM Kenny Levinsen <kl@kl.wtf> wrote:
>
> This revises my previous patch[0] to add the sleep STM chips seem to
> require as per discussion on the original patch from Lukasz and
> Radoslaw[1]. I had initially tried without as it had not previously been
> needed in the similar logic in our resume path, but it would appear that
> this was simply luck as the affected device was woken up in that case by
> "noise" from other sources.
>
> To reiterate, the idea is to add the retry that Lukasz and Radoslaw
> discovered was necessary, but do away with the dummy smbus probe and
> instead just let HID descriptor fetch retry as needed, aligning more
> with the existing retry logic used after resume while saving some noise
> on the bus and speeding up initialization a tiny bit.
>
> I added Co-developed-by tags, I hope that's appropriate. We should await
> an ACK from Lukasz on it fixing their hardware quirk.
>
> [0]: https://lore.kernel.org/all/20240415170517.18780-1-kl@kl.wtf/
> [1]: https://lore.kernel.org/all/CAE5UKNqPA4SnnXyaB7Hwk0kcKMMQ_DUuxogDphn=
nvSGP8g1nAQ@mail.gmail.com/
>
Hi Kenny,

Your solution works as it should - I have tested it on my Eve with
enabled debugs and
the retries works as expected with power-on, reboot and suspend/resume path=
s.

I have also disabled cros_ec_i2c driver to be 100% sure it doesn't do
any i2c transactions on the bus
and again the touchpad initialized successfully (with a retry) on all paths=
.

So you can add:
Tested-by: Lukasz Majczak <lma@chromium.org>
Reviewed-by: Lukasz Majczak <lma@chromium.org>

Thank you Kenny for your work :)

Best regards,
Lukasz

