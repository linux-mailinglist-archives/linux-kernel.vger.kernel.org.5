Return-Path: <linux-kernel+bounces-41437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1121383F10B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433361C2227A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278A1E86A;
	Sat, 27 Jan 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1M6QTxM"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803431E536
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395521; cv=none; b=BtawJL8Y0FJMmLZ/KWWeIqW8NdAM4/KLFkanDpHycc0FBz5UP48iV9HiR65omPunu7ibaFhz7L50gVMiBFsY+9ozl6SXN3MW8w4SG+KvvUFWRoFc1iPTvg0+9lyFFfw9MmkqI7t3zGgWRR7DqjmHPGpYbaqSVHUw2cgkFlrcr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395521; c=relaxed/simple;
	bh=xecPV2ck7m8m2Bj+DmGE1mFxGjGKZBGhQIgMVrM494M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfCWlnkJOasdT2RFkgctIjMRWMMRd0PXZ+s9SwMHyU2c1hflClq8N+H29+pe4L3RB30mE58e+LilNZnI8r5qpGEUAPoRIFgDdaWiN1HEz4bz6vtlWSvkmFhzWLrCdjHa+5HkxQei7zdL+pfomMEo3WXzTSgMHIsK+1Z4nUHujx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C1M6QTxM; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-602d222c078so16501667b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 14:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706395518; x=1707000318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xecPV2ck7m8m2Bj+DmGE1mFxGjGKZBGhQIgMVrM494M=;
        b=C1M6QTxMTeuGuzXruYxcYuFIRvUGZGt492W0Y7vgugsMWoMu3QTtG9O4MVu/Gt/Y9V
         CN7xKjQqZhNHnvN/ONACIp7F+OEoxKKYiAwO5trI5rO67z2XgJe2jdVxS8EdQ0pDXwKP
         xQIXO00BPyxOT05N0B5PilQhKuXy0n2FUf6uVMF6VwcEM8MLom+tiVZMRIKI+p6u0kW/
         1cl8maus2YI+eLTQDpbgRb2D9sfmORWNxhtB8o30mgwUrzUtxLu2GTV0J57gPO5JlyxL
         CTCLQH0NqU6hfYKWtltduK9kpE1RKl9boNIVJwLMiIrpcA9uYj2qm2xP+//c0PWWmf/o
         4gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706395518; x=1707000318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xecPV2ck7m8m2Bj+DmGE1mFxGjGKZBGhQIgMVrM494M=;
        b=u4GFR3sU3XrDXH539K8XF6UgOPlAFnOlLbnWlB0vzz2OZxxzO9a/FjgEWUkLmtwv9h
         p7E79XdUzDljeWMzgt5rJm/HH+BXfWxLehOdIF9+dkeuWdWnHPPT2Xx2G/2ER+Sg0Spb
         bgxcR9YitJScyOtVcksOt+UNWzbhKcXF7f9c/19t9qfODUZMg4+dDFkCDGwG4WIyUykX
         o4kihjUInl5JdzPAKoQS2/DCy8Jc+OlcCx7DnNEEEgJTusWtIo8UUq3FhQEi+c9CLk54
         qcpDY5hvmmrTm6gC+CVQhxvLXXzOm9YRnuhzOyNg1TU/ctmnE5W0e+s2sI4Ln559aOND
         yc1Q==
X-Gm-Message-State: AOJu0YxxErkaVWOO/3uV5Hy1dn4f9J+UnhVE6GFeoPIF7sFCPAo02E8A
	Bnjv0UBS6NlkOvmveF4C8jFSdlVmVB86UKE6UHScXJ4bH2k9yoOXXJ39zl6lwYN1uYMsvOZzqTJ
	OrZJZ2BlJP+4Oo4T0la5gqy3GsY4P3UVeUzFLvg==
X-Google-Smtp-Source: AGHT+IFzlJ+CaxE/jxoveHqqwzGcPTygUDN5MaqZZdcd2xMYLO9DGN9sGaPRnhYjNznjTqvzvce8wlkY1JqxeSQA2NQ=
X-Received: by 2002:a0d:cc4d:0:b0:5e9:dca:1b14 with SMTP id
 o74-20020a0dcc4d000000b005e90dca1b14mr2359381ywd.7.1706395518464; Sat, 27 Jan
 2024 14:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103085058.3771653-1-nichen@iscas.ac.cn>
In-Reply-To: <20240103085058.3771653-1-nichen@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 27 Jan 2024 23:45:07 +0100
Message-ID: <CACRpkdZ_3tKpgj9f=fLO9fBtcBhjVTeGxmYP3OS_AWpH+Djz4A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: st: Return pinctrl_gpio_direction_output to
 transfer the error
To: Chen Ni <nichen@iscas.ac.cn>
Cc: patrice.chotard@foss.st.com, bartosz.golaszewski@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 9:47=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:

> Return pinctrl_gpio_direction_output() in order to transfer the error
> if it fails.
>
> Fixes: b679d6c06b2b ("treewide: rename pinctrl_gpio_direction_output_new(=
)")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Patch applied.

Yours,
Linus Walleij

