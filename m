Return-Path: <linux-kernel+bounces-22219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7C7829B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1574D289A44
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E311487B5;
	Wed, 10 Jan 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e71sjScO"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB7487AE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso4967664a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704892516; x=1705497316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2K17fFBJpR1/Y1vdZDJP422VcROIDsHIcrNjjivdS1A=;
        b=e71sjScO8RPwLTyihOY1+0hD566166UF0mq1g3Ok9wXFRz+fxtCSHtCgit9v9tBudd
         Hfn/k3kRSAcljLsvcYluQxgXhoY0yH3jANR9llXa1btYKcbrXkjBIIdpoLn3ZyLa5tch
         6oSN/PH17d0GE6jOJn98MZQq3H/xvhbepzwwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704892516; x=1705497316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2K17fFBJpR1/Y1vdZDJP422VcROIDsHIcrNjjivdS1A=;
        b=TMIiTs4v+8erZIm32axwcogkUbp2ln6D+hp3bHQF2fkS4kfzbeX3t5HknsqveZ7vSw
         8RRXmWBZovS4WyJxnwtzy6AFf88evvYXwqja7guAeJeD1XNzTz1sRuDnGRJGYFlA/bkM
         T4dCBT22PKYkDlT1aM4IQrSnBlRiCZoZlwcUywp5XDjUoJQUVe8Zfd/JZ/21hJbk+GV3
         n/23Ls2tf6JWg00uh1SRHmFxUgPWQ7PoF0n9Vz3cYg1jMTYidBC21ECEgeWSP25CON0s
         Vc/83reQRT59dzwq65Glv235SO76wrU8g9FTGO1/4lsECh6ZR7zU8YCOqgC43LwEvxqn
         7ZrA==
X-Gm-Message-State: AOJu0Yxr7mzUoW3LFTfr7s2jkW6K5eaQ0fJ8dGyIHoqba3JUexvIFYvp
	OunMyYwVTwcmbl7vGKGaxvru7frPEoFbrBYyXIh9+Z4EaMvO
X-Google-Smtp-Source: AGHT+IFaHRToEh7MctoJ9rqm7wMBN0baxAzYGL/DL39FO/FFRxTs4xDWhMyJnC8Oze1sKbSVLr7CcA==
X-Received: by 2002:a50:8d4d:0:b0:557:32bd:1fc9 with SMTP id t13-20020a508d4d000000b0055732bd1fc9mr274784edt.4.1704892516455;
        Wed, 10 Jan 2024 05:15:16 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7d04e000000b005574af4acd0sm1998318edo.83.2024.01.10.05.15.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:15:16 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3373a30af67so3836902f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:15:16 -0800 (PST)
X-Received: by 2002:a5d:444d:0:b0:337:555c:6b7d with SMTP id
 x13-20020a5d444d000000b00337555c6b7dmr378407wrr.173.1704892515835; Wed, 10
 Jan 2024 05:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228070941.3611649-1-tfiga@chromium.org> <CAK7LNASbgXSZNiwhMf8jm7511eyDm8oCqY=MzWhgWwNuVLk5Vw@mail.gmail.com>
In-Reply-To: <CAK7LNASbgXSZNiwhMf8jm7511eyDm8oCqY=MzWhgWwNuVLk5Vw@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 10 Jan 2024 22:14:55 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CRtgMUN8xZ_4BOv04KzCvXtrKHhWGQhhqgENyMCVWbKw@mail.gmail.com>
Message-ID: <CAAFQd5CRtgMUN8xZ_4BOv04KzCvXtrKHhWGQhhqgENyMCVWbKw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Add a build target for checking current config
 for issues
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 1:11=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Dec 28, 2023 at 4:09=E2=80=AFPM Tomasz Figa <tfiga@chromium.org> =
wrote:
> >
> > The new target is called 'checkconfig' and currently is basically an
> > alias for `listnewconfig` with KCONFIG_WARN_UNKNOWN_SYMBOLS set to true=
.
> > It can be used to validate if the current config is directly compatible
> > with the current kernel version or needs some manual adjustment.
> >
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>
>
> I rejected a new target in the past.
>
> https://lore.kernel.org/all/20230817012007.131868-1-senozhatsky@chromium.=
org/T/#m55c37e3091158f8cb008d9e0b5c6bf3f5ead225a
>

That was specifically for the unrecognized symbols warning. What I'm
proposing is a universal target that would include any possible
diagnostics.

>
>
> Instead, you can run
>
>   KCONFIG_WARN_UNKNOWN_SYMBOLS=3D1 make listnewconfig
>
> or
>
>   make W=3Dc listnewconfig
>
>

I can do so, because my team member implemented it and told me and
other team members about it. But how would someone who hasn't heard
about it be aware of the existence of this useful feature?

Best regards,
Tomasz

