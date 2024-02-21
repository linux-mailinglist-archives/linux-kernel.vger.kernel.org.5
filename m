Return-Path: <linux-kernel+bounces-75343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA085E6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2E71F215CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA286ADC;
	Wed, 21 Feb 2024 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0MVjdiRF"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED58664A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542410; cv=none; b=uig7KJJMcJTQjR7mpkvzNJmzlzL6xVS8HunyrCb6bgaRcnXLnUaFP63ucumhxWx2bcTtHJUM4TDfl4KVj/xL4Sr2esUJuAgNCGTd1y81BsMRHEmm1fSvtfWqe+h1uz+eFpIV3MYEdnExkfsJTzHwOkNWIYpjtZkDLbtZDtjIFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542410; c=relaxed/simple;
	bh=kcfco0q09KRbXlbQQeEDNzewpUTgOtWvGAGR2Dj8574=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZRbWLlwRMfBbCYxAez1q5bCqwiCOUuRicu6LxSFvAkDaTm97qytVcx61sdwICjWuvANo3mEi3siSS55plSZ90WCceQPxhAGdtcjiqBZmvyC7zXpq1IgADsOWuc2kVNYfYr19bkOYEg80zx6VscQAmGHpZy1eigNP7XhcoCCpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0MVjdiRF; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59fe5b77c0cso528015eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708542400; x=1709147200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcfco0q09KRbXlbQQeEDNzewpUTgOtWvGAGR2Dj8574=;
        b=0MVjdiRFkK7iaxkbtqqYFe4yEIBb5PtoEdcjfNuNrtwvD9SWc3FAaqy9sVMbI8Mde8
         2EapIlpHpLt72GZBsAOrp5Nr24Z5yGC/Y1fXNy44pHhNx5p6SlqJMMk+CEesLgkfndFT
         eHiT4H74uIxvWvxPava3MyhT2pjFFoqbKxhBh42yrGzKK4ZzHe/V5Embc8NxkBjINGu2
         sp72CwsCNiq1hkr+dpUIuZ6SzZ2VsTYdZ1kC8BGNFSy+eBvQJlGlzmy3kAhpXcuqNa3K
         kuUouSdlBbHF0WaSzKmiF65ROW2yt9xaxJzx/4BwYcWktMKzcWluic5FEBLwaBlnpWk1
         M8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708542400; x=1709147200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcfco0q09KRbXlbQQeEDNzewpUTgOtWvGAGR2Dj8574=;
        b=ChadkLaLBGNegFXhiyk6PbmFLmP5YsMo/V7crbKBUZrdQbOX3Hu6lVu1gr4y31KJfO
         8jtIAZkvlz8qVTiIQ874QmLJPtxb6KAnwXQ5fXSsSvXuqpPI1svH24K1Nxl10wbKco+d
         XtT8v8SQYytjhJaXQAAZrQgdpQh+7+RF9wgRQVMyzNByZXp+b7/h2Sd1nZl4/fkJqNyn
         boxzCQ4rGmrufI3E8b57oh1IYEMPiUkno6yhcFn5OaAPBB2Db36O3S0EN5MM6yME8reH
         7nkcKlX/9dMsylaBe6y/Fus6IKDnKGl2BbdEJytghS+wdHvnU+Yu+igszEHSywI9tZa+
         X9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnrIqf2i65RwQcsgahQu23erzNP+EVg9WjF0W/27ehE9YlhyT3OCgiXZ4jcMwuYqW362Ou0ulZ/6nXImxXy3muNAj9zmJOxU/UEiD1
X-Gm-Message-State: AOJu0YzpZtcprwx/vinr88cAw1y6k2RR57/Q5od/lntHbwyrENZJYO/J
	3WOWo6J7lJ87KL2muX1oIk6oQH6pxJIjrbyGEgUSKwov8lIfYU/DLHw2rmd2FPNGyya1h+DsbTJ
	/v6NLrkQ1mOcCYWWsl6zIaZO0bivnMcDQw93arw==
X-Google-Smtp-Source: AGHT+IF1SptazV6aoLbwXb6AsvXsynwnTUX/SLIVAEokAiWCqUDqLcGdMHsf9bAktVT4a5reeZ9YGl9B6Z2G2u09Xx0=
X-Received: by 2002:a05:6870:5b15:b0:21e:5f83:e698 with SMTP id
 ds21-20020a0568705b1500b0021e5f83e698mr14255030oab.52.1708542400397; Wed, 21
 Feb 2024 11:06:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182810.58382-1-brgl@bgdev.pl> <20240205182810.58382-11-brgl@bgdev.pl>
 <7pybw4wxlzxfl65yuqxzks5w7uq52hosyq53etlzas6i6o5l6d@vxd4sykcxora>
In-Reply-To: <7pybw4wxlzxfl65yuqxzks5w7uq52hosyq53etlzas6i6o5l6d@vxd4sykcxora>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Feb 2024 20:06:29 +0100
Message-ID: <CAMRc=MdAG7jehYbF1ZuEzpK5x9QpHNTvzxc6C=5wkCAP3OhGcQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/12] firmware: qcom: tzmem: enable SHM Bridge support
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 4:41=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Mon, Feb 05, 2024 at 07:28:08PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add a new Kconfig option for selecting the SHM Bridge mode of operation
>
> The Kconfig option is the least significant bit of this patch. I guess
> there isn't really a problem to describe, but let's at least mention
> that we're switching TZ to shmbridge mode and all.
>
> > for the TrustZone memory allocator.
> >
> > If enabled at build-time, it will still be checked for availability at
> > run-time. If the architecture doesn't support SHM Bridge, the allocator
> > will work just like in the default mode.
>
> "default mode"...SHMBRIDGE is the default mode from this point onwards.
>

Well, it is starting with patch 12/12 and only with arm64 defconfig.
The Kconfig *default* is still the regular non-SHM bridge pool. I'll
work on the naming convention.

Bart

[snip]

