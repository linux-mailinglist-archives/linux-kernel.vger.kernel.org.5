Return-Path: <linux-kernel+bounces-50536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34946847A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18FE28E52D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0188681723;
	Fri,  2 Feb 2024 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlbGjUpE"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC128062E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904980; cv=none; b=DszJfegiKF0xGgwyXv94O1QS4yxEzrxrDSY7K7paSIheZ2Tq78pn6tq0WCDmcwMzT/smgtZRO0w+MwloIQNZr0Wvbtc9mb2dbmOZfxlUwl8OP2lmlBONbtEm1e8C2kJW2L6v66ljDn9YcD5JoceJh8A2TV7kPGZis+n3lvv2xuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904980; c=relaxed/simple;
	bh=D+Z7TWwcAtWu/ZfezdqmbuSnYk69GnMovrOjB4gRIaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYd+dkwna6H6PF2oH22Ubw+liWWAjPKcw542/nOg0nqOqIIDCmyeIhaZFlIy+9XtG3H3isD1q3YFL+jQDnSkYdlueVnDNOyHrYFaZeYK0m8YJnFH2x4auGHdv9o3O5Sp2e8X13k4wnsc1rkLpFvz7plKkPXuWTxm93nBqaFlPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YlbGjUpE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a88ad0813so51881cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706904977; x=1707509777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/YAw3L55aC5kXJ1OC6qpduxr2eZyNH6Gl/E97WVz/o=;
        b=YlbGjUpEtndL4ESw/mllj4fSo5oxDqZC4XsjIHFQAyfKK5/ehrfUz4w16c04lvpi/h
         iUH0E4c2NEt/8bx+o67AeacNU4p51M7CMYH1R7tbde66ZILU2JGqoXoRc63kAu2LsxWL
         Lzpqr14WDaNXuawVSG+l/HZGPqLVqYmfCnNqBRYEE+KmekOJ3IthH724Y6E4j1dFbbuP
         BoFmYaxUBya2LTcMaXZcl7kHHGuE/kPyBdRbHOGUY+va5JLk2h7bISkjSsXyruuwhgXb
         nL9hDck5JOegWJbS8HergwZ0efykzIX5SUoaaJW9zWFY9zdvvffeGy/rXuRcCjA2uBCz
         +EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706904977; x=1707509777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/YAw3L55aC5kXJ1OC6qpduxr2eZyNH6Gl/E97WVz/o=;
        b=QFJIwe2Ha3sB9Tmj2st3BjzmiSx4BLzyHybEUFMNxaNUa1L9OxLFXjw095MeM9yE/d
         SJjQubOwP/3mggkrjp2rgDUkllKgWHJ+oFqyWbBKr0IwkNyVUNyHxyyP9Hv2SRoqI4hX
         C/ZSdZBfidOrb3u/sKd3BfMh9R+r/4k/UXofrgSauaPYlBUtuGXlabLenp/OSN/DT+OR
         cNm2tQXYiFtCduA1NW80kwAZOU8SKmU+OnZvpdc7rhdbVPQkL4DYtpgNMzIg8v6em3wn
         51srtTsnZ7t5ya9okAqPDpRRoh9Dx2okEcaBMK3nh0lAv62ikZlpoeC6U0t28Clft/TQ
         hjog==
X-Gm-Message-State: AOJu0YxY3YIgZ1fzd+VcQJ3tqP73/wn1z+IApwZ/vcAduEdMOTS3XVA4
	dDIckWrQHhia450vLB1NjFLM0pi72vCnTpXaVaDly+kuyebUpRXRPcAEuiZlm4VuUpyJ/vuB98L
	AcGxQ5XUP4JqC4E60lkv1eLzqM1XBlui+SuSi
X-Google-Smtp-Source: AGHT+IGbunbL7fYRGBQ5S8wwMT6ranidv7JKOXh/UXkQZypSu0gtmvvH3y43WGPtcqy6V2DArx+zVQoYmBsKEqIQkhU=
X-Received: by 2002:ac8:6658:0:b0:42a:84cf:1005 with SMTP id
 j24-20020ac86658000000b0042a84cf1005mr6736qtp.20.1706904977310; Fri, 02 Feb
 2024 12:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201060437.861155-2-davidgow@google.com>
In-Reply-To: <20240201060437.861155-2-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 2 Feb 2024 15:16:04 -0500
Message-ID: <CA+GJov6Swgvc+wrCvW3Ujqh_UW1BSRDrp9ccHUX2CVRjWpe1dQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: device: Unregister the kunit_bus on shutdown
To: David Gow <davidgow@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Maxime Ripard <mripard@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Chaitanya Kumar <chaitanya.kumar.borah@intel.com>, Jani <jani.saarinen@intel.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:06=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> If KUnit is built as a module, and it's unloaded, the kunit_bus is not
> unregistered. This causes an error if it's then re-loaded later, as we
> try to re-register the bus.
>
> Unregister the bus and root_device on shutdown, if it looks valid.
>
> In addition, be more specific about the value of kunit_bus_device. It
> is:
> - a valid struct device* if the kunit_bus initialised correctly.
> - an ERR_PTR if it failed to initialise.
> - NULL before initialisation and after shutdown.
>
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Signed-off-by: David Gow <davidgow@google.com>

Hello,

I have tested this with modules and it looks good to me!

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>

> ---
>
> This will hopefully resolve some of the issues linked to from:
> https://lore.kernel.org/intel-gfx/DM4PR11MB614179CB9C387842D8E8BB40B97C2@=
DM4PR11MB6141.namprd11.prod.outlook.com/
>
> ---
>  lib/kunit/device-impl.h |  2 ++
>  lib/kunit/device.c      | 14 ++++++++++++++
>  lib/kunit/test.c        |  3 +++
>  3 files changed, 19 insertions(+)
>
> diff --git a/lib/kunit/device-impl.h b/lib/kunit/device-impl.h
> index 54bd55836405..5fcd48ff0f36 100644
> --- a/lib/kunit/device-impl.h
> +++ b/lib/kunit/device-impl.h
> @@ -13,5 +13,7 @@
>
>  // For internal use only -- registers the kunit_bus.
>  int kunit_bus_init(void);
> +// For internal use only -- unregisters the kunit_bus.
> +void kunit_bus_shutdown(void);
>
>  #endif //_KUNIT_DEVICE_IMPL_H
> diff --git a/lib/kunit/device.c b/lib/kunit/device.c
> index 074c6dd2e36a..644a38a1f5b1 100644
> --- a/lib/kunit/device.c
> +++ b/lib/kunit/device.c
> @@ -54,6 +54,20 @@ int kunit_bus_init(void)
>         return error;
>  }
>
> +/* Unregister the 'kunit_bus' in case the KUnit module is unloaded. */
> +void kunit_bus_shutdown(void)
> +{
> +       /* Make sure the bus exists before we unregister it. */
> +       if (IS_ERR_OR_NULL(kunit_bus_device))
> +               return;
> +
> +       bus_unregister(&kunit_bus_type);
> +
> +       root_device_unregister(kunit_bus_device);
> +
> +       kunit_bus_device =3D NULL;
> +}
> +
>  /* Release a 'fake' KUnit device. */
>  static void kunit_device_release(struct device *d)
>  {
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 31a5a992e646..1d1475578515 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -928,6 +928,9 @@ static void __exit kunit_exit(void)
>  #ifdef CONFIG_MODULES
>         unregister_module_notifier(&kunit_mod_nb);
>  #endif
> +
> +       kunit_bus_shutdown();
> +
>         kunit_debugfs_cleanup();
>  }
>  module_exit(kunit_exit);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

