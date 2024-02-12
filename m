Return-Path: <linux-kernel+bounces-61242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD321850FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FB2822D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982F06FB6;
	Mon, 12 Feb 2024 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XJ/dvrFp"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F4FBF2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729604; cv=none; b=Ag6ipWTZjtSUX5rRmDZDW4abRBqG7sH3yDAiG2ripCJGQ8i1tS0XdCPvkB+gdRlbSD6gNggh9KLfpltZk+MZn/xxI1mn4OByoAPzAgJw34KNbpufBafDbcXjrcyTAbxvqjHkWx9TFRP2QF30oKozKg1g2MVeEMw2R2cJT6wdIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729604; c=relaxed/simple;
	bh=n9Ov502+N3u49Z6R6ct/dWB+FR+V6UVDXzvlJNlA6/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyMGhR7C47A5KohRpcBPtLQwh6mPfuMOoD5+UeK9qlX7N03TZ7m3sMpUMhi22R3B44Ec5Qk+5cIjdUxBtVeE4IxwhwvNRd1Kaq469SihCHKiLxt7HsagUhVpzy4gGok+ww7Dl1xVbEquz/zw7PikENmhxS//fQopS1weA8T4IWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XJ/dvrFp; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so1141351241.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707729602; x=1708334402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9Ov502+N3u49Z6R6ct/dWB+FR+V6UVDXzvlJNlA6/A=;
        b=XJ/dvrFpttiQ0eQAWsv6BNf28mhumKXDBJL1kRyE5XvscwtHjwCHH5e9Df4dR8sVRj
         1xvcCsY6MKuj3VtfNahIH9UiG79XntdW0IVzEvXbrXcz2j34pvgrMH3VwgkD6d+V9Xq3
         RsvIDHJVyKEHSJc/DHvqExwb6Rlq4EVaCyDZ4ypUhFKrD2DTngy8/IepEPyPPh+NkvR4
         MXAghX71DJOFEyYpgf0+gdloMuPaAxhKWh1OTdlRiVNENRGrxPh1YP1uswd1ZeDYBDtE
         /Nnw7lfkTLudfiS1x5SUby3xr5hhIPF67gi/2pvq3BCqiLxEpOZPGe+kSvAEnGCt/0mT
         IxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707729602; x=1708334402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9Ov502+N3u49Z6R6ct/dWB+FR+V6UVDXzvlJNlA6/A=;
        b=er6ayIYXXxJbWyME3zW8ojPd7OQQYO0Zji3Ei7N/oDrpj7ALRwE4xC8ExOt2V4+FCH
         7YKT2HC1RRLN4k4Im4hZlEceFfgblY3mOJmrBSUGm5vrfexf8YPxvR4yRLwUJG8EuA8H
         eii66hgBdAcE3bIg/wXP+un/YTTjQYKDCsEuPn/+/j2+7vlTrWuedAQImt6QOOvJXl+W
         gmatJaV067pzeqJJOaolM6wAuJd+xKbckyPVSO8y586lqix7VdZtWUi5UVfbdLWzHdAW
         vprvmjJXS+lDG93kPA+giZevf3B4W3LnDJSCic+TjQauEl7UeIltM6E5pPaobH8+3M7P
         1RYA==
X-Gm-Message-State: AOJu0Yz2WBSlEXzs2s9H+IWQMuSZy4zRZVAR37cZYnF4sdj/ex4YCbg7
	n8mJAYmI4FZxq1iWvzmieznOMRaoJKnL0kIJ4mZViK38KGCjH22UNyqxIxclZoxKqP2wyyWiAyQ
	t9Jxn+1GcKXVM/DIqukpQzJaIesZb5LkqJGmT4Q==
X-Google-Smtp-Source: AGHT+IHSNotxSJ3ltewKqxnRlk/iLnxwhZoi5Ou1X3qQ81yggKFAcv995ilite4ToFQmhx0SV+6LFcU5SayNI88fb6M=
X-Received: by 2002:a05:6102:495:b0:46d:2336:fcc0 with SMTP id
 n21-20020a056102049500b0046d2336fcc0mr3136855vsa.25.1707729601851; Mon, 12
 Feb 2024 01:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 12 Feb 2024 10:19:50 +0100
Message-ID: <CAMRc=Mfezg_tt7Fd8AiJmL2ryQRp9pjozdOnM9Ak7mFdNVw34Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: constify opaque pointer in gpio_device_find() match function
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 9:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The match function used in gpio_device_find() should not modify the
> contents of passed opaque pointer, because such modification would not
> be necessary for actual matching and it could lead to quite unreadable,
> spaghetti code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks!

Bart

