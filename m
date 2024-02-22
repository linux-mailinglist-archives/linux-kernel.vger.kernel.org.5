Return-Path: <linux-kernel+bounces-75907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9885F086
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDEC1F23CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324BD4C7E;
	Thu, 22 Feb 2024 04:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUZxXtRv"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4110E6;
	Thu, 22 Feb 2024 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577267; cv=none; b=rRQxPVuyxySzOI6I0M0UPR6R5gGKn/F55E8+VkuCTup/wygYR//c40OGOv5opj1tHy4a33PD0zOFEUR/2txjGkGQSz6x/gP0Oakwm2+7NL6SFuAJd9vveW5eP6zgbKubYJdJEQmoa3yT7JhKRN1son/Zr6ZD4kC3xS1m0OyZ8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577267; c=relaxed/simple;
	bh=UeNo7Treptz3RUyiQTbwwLEw6a+8/F6tea3I16MzUxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eq7i1Vs0oSj939y8P+cOK2G7ULyDICHwzkJFYduktA0X4UiIBjBmtVY7VKdFNSFp6HbsbOGhZcoERgSkgP0m+tUmJHaAuYBUzl9csCpPsizqw+3HyzKX919NjYrwkGdjHYkTfc0kogVaOlPN1Hv/R2P80xjuFBEsXWxUdAnsz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUZxXtRv; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-595aa5b1fe0so4864510eaf.2;
        Wed, 21 Feb 2024 20:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708577264; x=1709182064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0AD0YCnQqqjpDGFWW9RzaHFEvNTNgA3R308dgKQBK0=;
        b=gUZxXtRvgbVGvAOidc1qfrexj0Ae8g9f98Iu64/LILGAGg1sMxYIi+atw6rFFLuMcm
         FeGJ/d7hMeiIT9KJMX3gyvEuBoPv/Tmasx+2GaaPQUiIFufReOATGRBslaudGTt8g02W
         IWm6UVT1dPsdHsRi7BEU/faBKIlQBgbgfVUX1cOqqhFfZiuIaD5lyJUIbAabSFJGBk9z
         ZfzCeLfWq1eRNYtmfO9ws1zHkUJwgtiNsUWCqu3ja3TqRiqe2cOjl1ceVfB4bxRTkZit
         A3Y9NVqZuIN04tefs/DY70EvGt2QyBsa9OaAH614Y14au08XuyPn4to54zdW9OZRnnkV
         chig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708577264; x=1709182064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0AD0YCnQqqjpDGFWW9RzaHFEvNTNgA3R308dgKQBK0=;
        b=a99jMzKZ/ACwKNak0idrkenFZbu9gzxuhBk1SAXwLqFcNNBgaFSerrTEGtYQH7wULl
         qYAbFYoIFOKLBQX/gH1X43TjS0xlL1IScAp+032/6KKWPUMie+gEc11eNyDna1cczIi+
         kfmHr0Y+cm37wLZKlYHAxdUwLg/J9xHKmDdfDihpjqZp/dymkZBFvU8Z+v+4yWfOgw+p
         hoPNJWo2OYFDoWBhE6mqhgj4fAgnT9/COILObn+SkRw86Xf/PMfev+xXSTX1JbB9RaJN
         Jg25gdGkTfRYp6t2bQxOA6fubOhJ7mDmGI73xDRmYu2OWnKQTlKrFS/nOwAAT0GXDTvI
         EErw==
X-Forwarded-Encrypted: i=1; AJvYcCU4UcVGiNTd6D7zZZyQL+rQqtsyeokuKsBUn0h7LFeYsid85bX4fkSG+dIueIKZEyZTQy0380/CEstudOY4h/PL3OgwCH1NOYm1R2hveThL3UX+Gq8zSGSjjx2T/d0KA31j9NCj1/+88qhDC6YRVnpzxOK/Y4nvBJY3rRyQjA==
X-Gm-Message-State: AOJu0YxlF9MbMYaDIzhK8aPUEbCPL2aAbNtxOpVjdgwW/BcN5YMQslC3
	JE4WQowVvJpVZoYRGBnAZpyE5QS9MksxnOMalpCwc40XdJmiq4CqZ2BanH7LeFid2KahQ2zoDAO
	0+YZulUhO3gGVH0TbsrV+DmVcUNLGfcuk
X-Google-Smtp-Source: AGHT+IFT4RsENCibuAcCOiaUsVyVQ3wUtPOaylT8Cu8LEgQ8tuVRqR0bf6JV5jnLIMhZ0nuBWenDTxAl3yi1UozFGBE=
X-Received: by 2002:a05:6358:5919:b0:176:cf18:d0bb with SMTP id
 g25-20020a056358591900b00176cf18d0bbmr21288902rwf.13.1708577264582; Wed, 21
 Feb 2024 20:47:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131042509.4034723-1-jcmvbkbc@gmail.com>
In-Reply-To: <20240131042509.4034723-1-jcmvbkbc@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 21 Feb 2024 20:47:33 -0800
Message-ID: <CAMo8BfLXW1tYG9bNQZciBC+NSS+1debXLSYkjNOQe200+aWFEg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: tools: drop overridden CFLAGS from MAKEOVERRIDES
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

On Tue, Jan 30, 2024 at 8:25=E2=80=AFPM Max Filippov <jcmvbkbc@gmail.com> w=
rote:
>
> Some Makefiles under tools/ use the 'override CFLAGS +=3D ...' construct
> to add a few required options to CFLAGS passed by the user.
> Unfortunately that only works when user passes CFLAGS as an environment
> variable, i.e.
>   CFLAGS=3D... make ...
> and not in case when CFLAGS are passed as make command line arguments:
>   make ... CFLAGS=3D...
> It happens because in the latter case CFLAGS=3D... is recorded in the mak=
e
> variable MAKEOVERRIDES and this variable is passed in its original form
> to all $(MAKE) subcommands, taking precedence over modified CFLAGS value
> passed in the environment variable. E.g. this causes build failure for
> gpio and iio tools when the build is run with user CFLAGS because of
> missing _GNU_SOURCE definition needed for the asprintf().
>
> One way to fix it is by removing overridden variables from the
> MAKEOVERRIDES. Add macro 'drop-var-from-overrides' that removes a
> definition of a variable passed to it from the MAKEOVERRIDES and use it
> to fix CFLAGS passing for tools/gpio and tools/iio.
>
> This implementation tries to be precise in string processing and handle
> variables with embedded spaces and backslashes correctly. To achieve
> that it replaces every '\\' sequence with '\-' to make sure that every
> '\' in the resulting string is an escape character. It then replaces
> every '\ ' sequence with '\_' to turn string values with embedded spaces
> into single words. After filtering the overridden variable definition
> out of the resulting string these two transformations are reversed.
>
> Cc: stable@vger.kernel.org
> Fixes: 4ccc98a48958 ("tools gpio: Allow overriding CFLAGS")
> Fixes: 572974610273 ("tools iio: Override CFLAGS assignments")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - make drop-var-from-overrides-code work correctly with arbitrary
>   variables, including thoses ending with '\'.
>
>  tools/gpio/Makefile            | 1 +
>  tools/iio/Makefile             | 1 +
>  tools/scripts/Makefile.include | 9 +++++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
> index d29c9c49e251..46fc38d51639 100644
> --- a/tools/gpio/Makefile
> +++ b/tools/gpio/Makefile
> @@ -24,6 +24,7 @@ ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS=
))
>  all: $(ALL_PROGRAMS)
>
>  export srctree OUTPUT CC LD CFLAGS
> +$(call drop-var-from-overrides,CFLAGS)
>  include $(srctree)/tools/build/Makefile.include
>
>  #
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index fa720f062229..04307588dd3f 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -20,6 +20,7 @@ ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS=
))
>  all: $(ALL_PROGRAMS)
>
>  export srctree OUTPUT CC LD CFLAGS
> +$(call drop-var-from-overrides,CFLAGS)
>  include $(srctree)/tools/build/Makefile.include
>
>  #
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index 6fba29f3222d..0f68b95cf55c 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -51,6 +51,15 @@ define allow-override
>      $(eval $(1) =3D $(2)))
>  endef
>
> +# When a Makefile overrides a variable and exports it for the nested $(M=
AKE)
> +# invocations to use its modified value, it must remove that variable de=
finition
> +# from the MAKEOVERRIDES variable, otherwise the original definition fro=
m the
> +# MAKEOVERRIDES takes precedence over the exported value.
> +drop-var-from-overrides =3D $(eval $(drop-var-from-overrides-code))
> +define drop-var-from-overrides-code
> +MAKEOVERRIDES :=3D $(subst \-,\\,$(subst \_,\ ,$(filter-out $(1)=3D%,$(s=
ubst \ ,\_,$(subst \\,\-,$(MAKEOVERRIDES))))))
> +endef
> +
>  ifneq ($(LLVM),)
>  ifneq ($(filter %/,$(LLVM)),)
>  LLVM_PREFIX :=3D $(LLVM)
> --
> 2.39.2
>


--=20
Thanks.
-- Max

