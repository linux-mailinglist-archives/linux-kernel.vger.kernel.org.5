Return-Path: <linux-kernel+bounces-83302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D79869197
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A79B21B86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D528613B293;
	Tue, 27 Feb 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dBFLCaLq"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE513B28B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039917; cv=none; b=UK/o+MxjqaaORb0Oc8X2jicf8qel/xbg3E+phNWhxk0+hHWQyTJx9h5TDlWypoOYQMGeiu+OU4MhiYYTLKKfZEvZZWr3ksnCkq+wiBNeMSF4CXdbVnbZOZO+HPcBf7RWWgmKW104XfNln66tzQKe91bvT7BGVMtybYs0Oq0J2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039917; c=relaxed/simple;
	bh=XIdqyDQpxejpU6Xbxt+vThMLN3OZbO3x1VzJ061nang=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNOSzKQ0WkyG/saVicxpMXRt64SnAwYzku7TaAOYnNM9MNLN7DxyctEU84VTchSLJEYqYZ08friOtrCAbkr4bU0JloZYv0g6c7VjmakjsjN7voJivTRUrIolQzu0W7OUC+JSXlg/mWUFRtVZ4+KSuPUcO5zkpVqCF3LAzn9tAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dBFLCaLq; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so2769299241.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709039914; x=1709644714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MJvKpz29jkQyBneNtGPQJRAHLJnHtGshFmhRL3AhTM=;
        b=dBFLCaLqv6bPiBHvUYsU+VvHWDUN0oTzVzKfcFe8xX3uSQIyIiRORBZgO92CrdMDG7
         ypK6++bcvNE/aBeZ42xFosgiyO9tJgMrLrRHQxepe5ORWcl+OuwNcWujSmKtLMPUkv6w
         PlXu6bY1ILuKYmUNZ4r0HUBFb/irZh9YyYMpxLtwCrz5f0PAffMzwFqi2grFNNpnwHId
         JcS0orFVmvPTiYiMDio2KEiXciKUbyDVM3497V2eYQ2vzMnl2R+Hhr6C79eOtpBjICOq
         Cg426IHU6N20NL32DbI+PPGAQ/p5qZts6+2hcLxPr9ULoGGqt4irDp1fqO0GCsV2bDo5
         I+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039914; x=1709644714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MJvKpz29jkQyBneNtGPQJRAHLJnHtGshFmhRL3AhTM=;
        b=moLygR5qwQEYMvQdJdeiXMqQHG92h4n+nd+6duFDZfS9P1aVZJ33HviP1Zexc+qquX
         cExA3spVlm5QL8idKuQvWijD7JhhUXxS/udbQ/0BRRgnbxzU2A++/Skb8l/ym/ZsC/Q6
         +BPZQ6DSm9JbHykJKk1/8C1FVIfUc8KHrm5mCgQjFI9VR+JUCtY7ZqVXp5zWYFsM12v4
         6L98E+prVlSpPALmxxdxL/BJElSK9LFA4OpTXO5AqDNhelp/KJcpeGXzXn1/rATrWvTn
         Am1kzZTsXQe+tGXYsGku4klUtfe+NbhHNjyHTW2gfR5vgdwCAl3Cde/5TetxRHOGftY0
         fIDg==
X-Forwarded-Encrypted: i=1; AJvYcCWRp5dsKSmX1gtqZSzZoK1CTnoPUFFCKgTX6NxsqkFtMjAaQGfi6AuDsHG/beSO5Bqk/XwxLhStfjQo4JqxlsAStJHAFWQTaKQRBkLQ
X-Gm-Message-State: AOJu0Yygg+8B9Mn3AwvcqhRPWeY5QRserUQ7lZdzhflxbGlSTZji36PJ
	Vl288PkqtcAKT6DhDuCNAI1iRE7PGpf4tRlepx7jomjEVeA7NVdnTGgOx1tsbKdt1TJAsXH3D3D
	fSoe4yG1jCfy8Fb+pbNzDr23WWolkyK2Ql+DV3A==
X-Google-Smtp-Source: AGHT+IGFmZ4niK8yNBEqazbNpJaXrpKFX2pVzYNeNDBMOldwUgZekD8G6UAhaKmwhhECxJf9gr9cCnrgYNlum2RUL8o=
X-Received: by 2002:a1f:e602:0:b0:4d0:36e3:40c3 with SMTP id
 d2-20020a1fe602000000b004d036e340c3mr7050322vkh.13.1709039914615; Tue, 27 Feb
 2024 05:18:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223065254.3795204-1-swboyd@chromium.org>
In-Reply-To: <20240223065254.3795204-1-swboyd@chromium.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 27 Feb 2024 14:18:22 +0100
Message-ID: <CAMRc=McvYEuK-0bfF67qDbb5FS017NcMkOGaLtWucx3LYL0DMQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Pass consumer device through to core in devm_fwnode_gpiod_get_index()
To: Stephen Boyd <swboyd@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-gpio@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:52=E2=80=AFAM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> This devm API takes a consumer device as an argument to setup the devm
> action, but throws it away when calling further into gpiolib. This leads
> to odd debug messages like this:
>
>  (NULL device *): using DT '/gpio-keys/switch-pen-insert' for '(null)' GP=
IO lookup
>
> Let's pass the consumer device down, by directly calling what
> fwnode_gpiod_get_index() calls but pass the device used for devm. This
> changes the message to look like this instead:
>
>  gpio-keys gpio-keys: using DT '/gpio-keys/switch-pen-insert' for '(null)=
' GPIO lookup
>
> Note that callers of fwnode_gpiod_get_index() will still see the NULL
> device pointer debug message, but there's not much we can do about that
> because the API doesn't take a struct device.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Applied, thanks!

Bart

