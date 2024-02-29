Return-Path: <linux-kernel+bounces-86806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A600B86CB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E9D2835B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73612FB29;
	Thu, 29 Feb 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qW2PHaIm"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBD12EBD1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215935; cv=none; b=ci3XkkeyLS+/jH6NlWW6akTFAmVUDWX3YM9v35NzWiuVuUfHvrOBXgnUd7GN6FRUpNi5xaMxDGjgxEnYJP/tz62rRSolNtXwcsPOYhgs0kTW+yabeTpf9sAq7LU/kl9440h/mBcQk0rmu0qh4DqwyfC5zlPbDFXgzcUD0/2gsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215935; c=relaxed/simple;
	bh=CvLDc1XcjbF1F7NzLO6PHxnaCxyOqxfcXll9ig8clKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdksF1M/gCMzALnNvmP7EjHNSdQ/2RmydFP0UpBPokeNioEWvbegwhG0OccTFGWAj9c+l30r9RWfzO2du22SaK0L55tKKLiUMIU3WIVb9/kzHjYcDpKjjq5Lf7iVD+4bTfvTVznnIrymOqJgj+Qre/u9/zP3EQauZnZL3luRD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qW2PHaIm; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso1038153276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709215932; x=1709820732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvLDc1XcjbF1F7NzLO6PHxnaCxyOqxfcXll9ig8clKk=;
        b=qW2PHaImxY/wGo6lfdvj0bTPJgkNFtmtma/qM6KM13lmeB/FICw+aOa0VYFj5uld0D
         YR+WduKxVfpGYJrLn8iVjd9rO1fuph4a67wqaFh9fSQFxy3Mywn55EEsFTl3uTMfQ1EA
         mnLF59f8BdO7JHeffXyyGIX+QSAzFeDi00mcL2Zsz8ik/Bb04BzfkhVRSY0HGb6cNKoj
         5uXo7FPYuvOgwiM4eO22urHkhY/T3b6WPZ6ThbL+n0p4z0sk5hXTmPm8ODvZb3GmU3La
         1Gns0To+tia5rH5VsBykkwd9+lxodD3zuxLvpZk9qClH6HXyHyZKfnf+m7mmnKhfMFX1
         9TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709215932; x=1709820732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvLDc1XcjbF1F7NzLO6PHxnaCxyOqxfcXll9ig8clKk=;
        b=Jro7siRL233wFjqnjoVxENYJaUrSrB+BiHOJUbi9GCTrBD9qYMmhErwsTQPgq2T2jG
         +LrzcYgiT4lZ4u+touKtOijYdrxFRfDvpQxX/cCuyEvIvGrALYqQch2JZQkEnfMQFOm0
         elDsGvkHk5WWi8YNqPSjl05qzTiw8xCCbIsVmsHMcW1T7QI/BHmvS+ixWai0/DlOjsob
         ZdbBK6lNjXdjwXYKpr7zBsSe6HkuRO5qpgp4aD8/imh4zjeSvMF29JRB/WrRMcVVbwmP
         KINxuNLOAyr8OU27U2TTcosWyWkiRozjq9Lm7ASJWIgH8yGrQ9casD5QKXmD9eehS+Oz
         feWw==
X-Forwarded-Encrypted: i=1; AJvYcCXUIZrQysw2aTReNt4tSSioG1xNoD98moDxsZJSoKEUCSf/F5H3stlkzvpzaRJMurdTDVpGHMtyiMvqtuSNMrwqXlKh9s2fkHlEOaDY
X-Gm-Message-State: AOJu0Yw+/Uq2k2GLFMzD3iUIAOodOoAChw/j+96qTcFJsJO+A+Ihm6cu
	oAm4THxhz3P+zDRZmz6QIW2JKeB26nNLsaHr6otIjFtBwJiq3cPDYkPaxlEQmmYPRLiZL9dilDg
	ACRpeuMda0lfKd8y/INLjtZrCUkqAo+sfyaGABw==
X-Google-Smtp-Source: AGHT+IHxnZN7aHNIGYMA311zt+7uvT7fk6b9fb24xADoJn/BmejCf0pjyDbjm52YexRoGE+uFY9V6BUytI28dnMCTLY=
X-Received: by 2002:a25:890f:0:b0:dcc:7c0f:2222 with SMTP id
 e15-20020a25890f000000b00dcc7c0f2222mr2458086ybl.22.1709215932355; Thu, 29
 Feb 2024 06:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 15:12:00 +0100
Message-ID: <CACRpkdZPx4vyq8bHbQj_CbyrMprbdsLgCbW+T+c6vGPqFDJmdQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] gpiolib: Align prototypes of *gpio_count() APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Two out of three GPIO count APIs take device pointer. OF case clearly
> does not need it as it immediately switches to device node inside, and
> ACPI abstracts that to struct acpi_device pointer. Unify all these by
> making them to take struct fwnode_handle pointer. This, in particular,
> will allow to create fwnode_gpio_count() API if needed. The need of that
> was discussed here [1].

This looks reasonable to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

