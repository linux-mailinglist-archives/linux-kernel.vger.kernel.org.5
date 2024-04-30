Return-Path: <linux-kernel+bounces-164516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BEB8B7E82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C101F231A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF12D180A78;
	Tue, 30 Apr 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3fQ7nWt"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344A1802D7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498214; cv=none; b=ET68SLS4yqgSTC4dUx8Z25oLh0dCUs1A/wJQUnwqDxomKSSC0cVCVynOxHt+vuxOoqarXRiqqV5Y5gRKi/s6eoLzZZY1ZNwJSuIlKpm4j2n8Y3UKlQduqTkS+Ptx3yvOROAhhcyBr+gZ9Q8WsmRH/vBcNTrGCerkC8renPywjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498214; c=relaxed/simple;
	bh=BR9Wkd6miBhzfBRCvTbhOcpLA80oqmQjUGpUH96Ratk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV4XAxaE2Ojs0JhhsYyuM+JlsMkJtcoGbvDeIbsN3IpoYqnqAFqncfGHfT5tPHEsI/5LgpehdtzkMhDsafkKDhHwkDu31a5yG1kr2zf+8B/42Nh85yaOJoouXwVn1J59hrzdJFiCKfZaaFdEJYrbyjF4bfzFD8KpqsoPc3tmk5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E3fQ7nWt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso947a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498211; x=1715103011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awaW7AT0wOcGmKhgMWqej99cmUwIAXC84LCX446x4FU=;
        b=E3fQ7nWtq0h9yfZi/OzLRPTB2tGnydDkoPI1hk3+4siYKA3C8bStTw9+poPooBbbZY
         wpHOyB3udWf7SMQd5EumaDO/N5Vi38cZdZWKs27l8ssk6OYKKhPpP6vzgNpzLVEf73zq
         6Ko2G1+Gxtk+uuiJCUCn3sPRHMFKLZQ+OprCkert8yjmvB3tnqai3Aes1I6cePUlgc0k
         rMKCBgIrsQzf+tb/4hdP/iq1kUoXMz7FgC6d/RTLBTRKBsoasjIJC09iE5imzZRZqERe
         mrsUvIPDEggWeoBQ4PCvQ8BL5DmB0WuERrGAA2Y5SDsD5UM1r3d8LGgVoSJ4aliWkoo8
         U2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498211; x=1715103011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awaW7AT0wOcGmKhgMWqej99cmUwIAXC84LCX446x4FU=;
        b=KT+yafOzVuki97Bmn/HOezk2vTECjTI252Zt6gVzUGRoIMgtb+F2Vy95vsCYVrlVOZ
         aTjSaZSHOe13Tb9PYszlvEDQz2Jkgt6CgG5IGFP63J9Y8J7AsCfPctlng0QozqRD/bsp
         qXpoKbW8vAAvNuZPYRE9r8e1bZrk4ABFBCkls4cza5f+iWHjip3DjHz+McbrKErOQ+sJ
         Ym5A+XpGaQOqUEUrJdxVIFPXbq5WWqvaK+zrj7cVldPgwllAqFU5Q5Ys+irfnqfMC2O8
         qJCTkR2SoDcH+64OBOVIyi8Yjfm5EcgvGbOe9T7S5M7fTh+zQKm/iYuKpC/cGAJAJyE6
         OG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqvMe/1UO8CRIhVEErO0XreDFFS6Y6n4gNseW7371mHsCJcvLGUvkuKA8jI32suLvQIX5foe4MfcPHlWdyXDDlrnK+QNQWtp+C3sOC
X-Gm-Message-State: AOJu0YxZZSdsoWJbQAgm9wTBsW8ckB6xLyf0cE8/yUlNiYUaGbIQDFCz
	6DV20ByfyQe3HdI+UPnqlwLlz3TDFmdvBHhuParfVjdmtMS2CobYWAwTxTHnFG0BV3qj63z/QVP
	GTipi/Eu1iTn6Dtz1b7Mva3YQIbo+EaI2C7Ah
X-Google-Smtp-Source: AGHT+IH+9i4rJwPsBQqyArNc6DyoylM2VtMH1uR90G8+UmkTIaIfFTHI45q8A/gfsHjMbdT2dAMNGIl7Sk7gnVSSnaI=
X-Received: by 2002:a05:6402:3105:b0:572:9960:c21 with SMTP id
 dc5-20020a056402310500b0057299600c21mr145767edb.7.1714498210546; Tue, 30 Apr
 2024 10:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430010628.430427-1-edliaw@google.com> <2024043037-debate-capsize-e44c@gregkh>
In-Reply-To: <2024043037-debate-capsize-e44c@gregkh>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 30 Apr 2024 10:29:43 -0700
Message-ID: <CAG4es9VL8CdROKVygYi3YAo3ZuugXgiyt6uhf+3yq6s8iKfQeg@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] kselftest: Add a ksft_perror() helper
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:51=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Apr 30, 2024 at 01:06:27AM +0000, Edward Liaw wrote:
> > From: Mark Brown <broonie@kernel.org>
> >
> > [ Upstream commit 907f33028871fa7c9a3db1efd467b78ef82cce20 ]
> >
> > The standard library perror() function provides a convenient way to pri=
nt
> > an error message based on the current errno but this doesn't play nicel=
y
> > with KTAP output. Provide a helper which does an equivalent thing in a =
KTAP
> > compatible format.
> >
> > nolibc doesn't have a strerror() and adding the table of strings requir=
ed
> > doesn't seem like a good fit for what it's trying to do so when we're u=
sing
> > that only print the errno.
> >
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > Stable-dep-of: 071af0c9e582 ("selftests: timers: Convert posix_timers t=
est to generate KTAP output")
> > Signed-off-by: Edward Liaw <edliaw@google.com>
> > ---
> >  tools/testing/selftests/kselftest.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
>
> This commit is already in 6.6.29, why submit it again?

Hi Greg,
I double checked and I don't see this commit in 6.6.29.   As far as I
can tell the earliest it has been merged is in 6.7.1.  Do you mind
rechecking?

Thank you,
Edward

>
> confused,
>
> greg k-h

