Return-Path: <linux-kernel+bounces-117452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197F88AB91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA2F1F6567D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D9F12F59F;
	Mon, 25 Mar 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Grt+7jrK"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7721C2A1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383598; cv=none; b=UZgwjqAQSO5q/jOZMa0Ype2Da8dR65mNwbQ0im4d3VfdgDNkFRvUaXspQs559jmyrWKpKHex6HPEfaxDW9nN38iy83lOFpDN1xFOFwt0UXeBD0Nq0Edxj+bVsnopsA7C+2hw+BTXh+idsm6865/TIPvBc43Jwo785eDve1gHJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383598; c=relaxed/simple;
	bh=uOV5MCWT9pDoDGzplATxiEhOJo8GdM18dNDgTj0skJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ET6n560SWAiE4u7FvoKCOZVg+iu9s3OImJ76ErG61hEU1E6IPiG68j34nN7SxS285yKuS/aY78hj475dJEpvx84DfOgW9NNdy6ST4FqFliBvsJsYUqYKoI9IMSESi6HF/g0z7ZWYJ6qJI1CqHOEnf+CwhUx+m7dhCYoSB8QsW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Grt+7jrK; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789db917876so278460685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711383595; x=1711988395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M+RNRaHQeXuCFayOM1dYEtW20x69QDnHCFDaOPJPF0=;
        b=Grt+7jrK3HlzN2+0um0h4Ab0fbyCWhM6vYXhyThG9kOM4CB4r44ibZfeaVayrYjGp5
         Cz+ZVpmoPG9TBD/UbE57VPZ2KNOHkmWYKn1IHErD8e1TpWUsfteCRPzj79erzcZZJqx3
         YrgrJdvWe/5ZaxLneClFNqXPTmB+tqqfgillo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711383595; x=1711988395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M+RNRaHQeXuCFayOM1dYEtW20x69QDnHCFDaOPJPF0=;
        b=CVQoPhh5rpWjaFISoIlvv5F9hLt3sybBj24Ckc87AE4cZmxPD68URGFOwf8bzy453B
         5/zQHgh23FbzzhxISBFd0pIVfYFHmZQjqy9cqpwVOELkKYC4u/1+zMw2o3CgJz2B+yQC
         799DHhOCnSH/fSDPk34BbQ+0ZnT+PPAi8OL4vT4ftQnh2lbg6GsIAnudg6XkdAzF6l2C
         RA4ho994nVsgl5tTy4BbPvwgntSpFs+aGYLtChQX5W+yphhyL8BGkDqkJCAwa5NahsM4
         JL2rFWpvtiUb9PCp3/UcK3abfzaCwxMmePH0Pu4kjbUCCl/ZP0V0HmF6iQqbhAISNXPY
         CniQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh4RJfz2by5Tu1xOMd2xvJYuwORAWsnD/nWJLRygjQkZJ2aK0AoKAjdM5kjYhbn2j0jj93TBh6MU7eg2KmDjNNtF/oLDrg95I3muWB
X-Gm-Message-State: AOJu0Yx0qU6WLJtwgOa203ndvD/MqnDABNPZgk0+hfGr0AK9DqU5xGgs
	VuUZwk2Lvf8dWAK2ckvARH0DVBNWiFu06zCZkwGxlL5+AaUB30PVFyK5D3Yk73J5orwylQRPbrA
	=
X-Google-Smtp-Source: AGHT+IF+eIrf4qVfxO0e+AmWVHrnT7JgtwZZAN8eXji7ptxNa+iyEjuwvVHZr6Aww2YUAwR5VQCIoA==
X-Received: by 2002:a05:6214:e61:b0:696:82ce:a2ce with SMTP id jz1-20020a0562140e6100b0069682cea2cemr6728885qvb.8.1711383595114;
        Mon, 25 Mar 2024 09:19:55 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id jm14-20020ad45ece000000b0068fb6fb217csm4248858qvb.122.2024.03.25.09.19.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:19:54 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430d3fcc511so467881cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXA6tjCRf0peKnKgnGmt0Dz2w6i6TuA6kfGx2MlOHsH51uLWQ/VUSkziyyYe6UAHxSdy+kf8ASFe/HPG8TJjGCh1SgGCdl29cs3jF01
X-Received: by 2002:a05:622a:1909:b0:431:c35:150f with SMTP id
 w9-20020a05622a190900b004310c35150fmr1202359qtc.14.1711383594159; Mon, 25 Mar
 2024 09:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325054403.592298-1-sboyd@kernel.org> <20240325054403.592298-5-sboyd@kernel.org>
In-Reply-To: <20240325054403.592298-5-sboyd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 09:19:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ws-LYcpiitibPBPRhqrbS8rTo_7xtPPw2kA+qBzybOxQ@mail.gmail.com>
Message-ID: <CAD=FV=Ws-LYcpiitibPBPRhqrbS8rTo_7xtPPw2kA+qBzybOxQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: Get runtime PM before walking tree during disable_unused
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 24, 2024 at 10:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Introduce a list of clk_core structures that have been registered, or
> are in the process of being registered, that require runtime PM to
> operate. Iterate this list and call clk_pm_runtime_get() on each of them
> without holding the prepare_lock during clk_disable_unused(). This way
> we can be certain that the runtime PM state of the devices will be
> active and resumed so we can't schedule away while walking the clk tree
> with the prepare_lock held. Similarly, call clk_pm_runtime_put() without
> the prepare_lock held to properly drop the runtime PM reference.

There's a part of me that worries about the fact that we'll now be
doing a pm_runtime get() on _all clocks_ (even those that are used) at
bootup now. I worry that some device out there will be unhappy about
it. ...but I guess the device passed in here is already documented to
be one that the clock framework can get/put whenever it needs to
prepare the clock, so that makes me feel like it should be fine.

Anyway, no action item, just documenting my thoughts...

Oh, funny. After reading the next patch, I guess I'm even less
concerned. I guess we were already grabbing the pm_runtime state for
all clocks while printing the clock summary. While that's a debugfs
function, it's still something that many people have likely exercised
and it's likely not going to introduce random/long tail problems.


> +/*
> + * Call clk_pm_runtime_get() on all runtime PM enabled clks in the clk t=
ree so
> + * that disabling unused clks avoids a deadlock where a device is runtim=
e PM
> + * resuming/suspending and the runtime PM callback is trying to grab the
> + * prepare_lock for something like clk_prepare_enable() while
> + * clk_disable_unused_subtree() holds the prepare_lock and is trying to =
runtime
> + * PM resume/suspend the device as well.
> + */
> +static int clk_pm_runtime_get_all(void)

nit: It'd be nice if this documented that it acquired / held the lock.
Could be in comments, or, might as well use the syntax like this (I
think):

__acquires(&clk_rpm_list_lock);

..similar with the put function.


> +       /*
> +        * Runtime PM "get" all the devices that are needed for the clks
> +        * currently registered. Do this without holding the prepare_lock=
, to
> +        * avoid the deadlock.
> +        */
> +       hlist_for_each_entry(core, &clk_rpm_list, rpm_node) {
> +               ret =3D clk_pm_runtime_get(core);
> +               if (ret) {
> +                       failed =3D core;
> +                       pr_err("clk: Failed to runtime PM get '%s' for cl=
k '%s'\n",
> +                              failed->name, dev_name(failed->dev));

If I'm reading this correctly, the strings are backward in your error
print. Right now you're printing:

clk: Failed to runtime PM get '<clk_name>' for clk '<dev_name>'


With the printout fixed and some type of documentation that
clk_pm_runtime_get_all() and clk_pm_runtime_put_all() grab/release the
mutex:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

