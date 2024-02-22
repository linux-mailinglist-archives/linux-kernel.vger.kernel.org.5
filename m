Return-Path: <linux-kernel+bounces-77212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1F786021D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9DD1C2545B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47012548E6;
	Thu, 22 Feb 2024 19:04:38 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048991E892;
	Thu, 22 Feb 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628677; cv=none; b=sDFoQZQSuII3WotWYLykdVFwyA4cc+f9NAaIPreCbOOZfQwlriTSPV/6KJRgpwXi1Iz4/FYCnsBW335BAHCANQI/QpVjkqdlMr8woJU8vUHH1FC7tv8ocRy4kmzQGUdxHfvSHA2jEsEq2+vo6mdnfS3tvgmQ7eHLgULR6i8ib5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628677; c=relaxed/simple;
	bh=Hyf9XBUFJSWplKcsdD5bVfC2Vm6PoE3r6Y1cEsPSsgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQyLOIs3un2VrsffUCkr5M3CJXiByq2x4Q7gKevjEo0FQ5KkY9ICy//2tjXr9k77/iBNEhvTC7v7mZjZR0VNr1uARI1eP38HfOonRWZSr2h2lngQshLK09itbdmByv4LxCRXl8CAecSmCC+A1GlD7lqhT9l0a1rXQwk7DJpkjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59f9045d18dso13351eaf.0;
        Thu, 22 Feb 2024 11:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628675; x=1709233475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTwO65sg0aGmGtYjpmCSGn3QMI62fbB0yNxoEusEEgM=;
        b=hKhY0MqseMju68rHVjkwUr1VpswDlb/IFd8wDhjyFCicQXSuxQA4AThBARF/xlxpCA
         hHSL+XYKARz3pm0/F9tCFDCBPvLa6tnii8onaRasaEQ48RaYfQCz7SlXZ3AIcL560QzN
         bKtQIiIXwvapNFcS3V+FuXTOGt4QhcwmF3Dmp/dH5GRKs9+ucGOr5GjBUdsWOq9nQWni
         S+2unDBAY5Lj6CINrWhAFpgGlnkJPG+HcZ42enAGBbokmUaDoFvumk0txH67xNkBYrvo
         ooHatxIPx1Qo9bfM2jJV57GSfpzu5iKK8dyXvsHGm0PifcVBVMFk1pbvil6Cd8Iv9UNk
         3kyA==
X-Forwarded-Encrypted: i=1; AJvYcCWbdx28WfuG3YjJ7lso4g0uxllYPT39crfw/cg7G/Hl13v977zcZCfNUJX4y1onrvrDy3XGmSsHZTcW+dSPZ8lTRz0qFPs7yggOMqSrihGMAZnFkFYcmUtPRU7EkEStHR53ik8aGu0bGICRc5Jb6mlY99+c1FUrX19KeGRnxJDBn2c=
X-Gm-Message-State: AOJu0Yy1IhIfIXcFk6mbKWmBrYbZwtkk1X/uhvlCVZ/QcigPTgRrKihq
	/z2kU7R/tzeRJYJKiuDc5MzZajb+dUfbEJnbeP3pEd0rH5J5tt3p32nMbflI+on4whOmH0KxpwQ
	rI/6sAEMGv0PbZM/pwzUYlTokwWY=
X-Google-Smtp-Source: AGHT+IHrhaKFggbS/LOCudwzMdpGnXQGEzl5H3Au+AI3s1upIQr/0vGwklLHZlwyU/bw+GiuHzuWZ2U/ZvdO2Ko+L4E=
X-Received: by 2002:a05:6820:305:b0:5a0:1c1e:a8c2 with SMTP id
 l5-20020a056820030500b005a01c1ea8c2mr4912128ooe.0.1708628674922; Thu, 22 Feb
 2024 11:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db6616c90d0e7de7658708b52ddca729679573bf.1707895925.git.quic_nprakash@quicinc.com>
In-Reply-To: <db6616c90d0e7de7658708b52ddca729679573bf.1707895925.git.quic_nprakash@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:04:23 +0100
Message-ID: <CAJZ5v0iMsqCguCWytVZugVN15z6+zrNiSSuK3XPSO8Oqdh3N8A@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Support to select compression algorithm
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Yan-Jie Wang <yanjiewtw@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	quic_pkondeti@quicinc.com, quic_kprasan@quicinc.com, 
	quic_mpilaniy@quicinc.com, quic_shrekk@quicinc.com, mpleshivenkov@google.com, 
	ericyin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:40=E2=80=AFAM Nikhil V <quic_nprakash@quicinc.com=
> wrote:
>
> Currently the default compression algorithm is selected based on
> compile time options. Introduce a module parameter "hibernate.compressor"
> to override this behaviour.
>
> Different compression algorithms have different characteristics and
> hibernation may benefit when it uses any of these algorithms, especially
> when a secondary algorithm(LZ4) offers better decompression speeds over a
> default algorithm(LZO), which in turn reduces hibernation image restore
> time.
>
> Users can override the default algorithm in two ways:
>  1) Passing "hibernate.compressor" as kernel command line parameter.
>     Usage:
>         LZO: hibernate.compressor=3Dlzo
>         LZ4: hibernate.compressor=3Dlz4
>
>  2) Specifying the algorithm at runtime.
>     Usage:
>         LZO: echo lzo > /sys/module/hibernate/parameters/compressor
>         LZ4: echo lz4 > /sys/module/hibernate/parameters/compressor
>
> Currently LZO and LZ4 are the supported algorithms. LZO is the default
> compression algorithm used with hibernation.
>
> Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
> ---
> This patch is dependent on the patch series, [1] (patches 1/4 to 3/4).
> This is picked in linux-next, [2].
>  [1] https://lore.kernel.org/all/cover.1705927916.git.quic_nprakash@quici=
nc.com/
>  [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/=
log/kernel/power?h=3Dnext-20240212
>
> Changes in v2:
>  Changes to incorporate suggestions from Randy Dunlap:
>   - Update documentation to specify the default compression algorithm.
>  Link to v1:
>   https://lore.kernel.org/all/3776355f920c1af44490e076072f93bafdf128cc.17=
07740870.git.quic_nprakash@quicinc.com/
>
>  .../admin-guide/kernel-parameters.txt         | 11 ++++
>  kernel/power/hibernate.c                      | 57 ++++++++++++++++++-
>  2 files changed, 65 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 31b3a25680d0..8f7fb911b2cc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1748,6 +1748,17 @@
>                                 (that will set all pages holding image da=
ta
>                                 during restoration read-only).
>
> +       hibernate.compressor=3D   [HIBERNATION] Compression algorithm to =
be
> +                               used with hibernation.
> +                               Format: { lzo | lz4 }
> +                               Default: lzo
> +
> +                               lzo: Select LZO compression algorithm to
> +                               compress/decompress hibernation image.
> +
> +                               lz4: Select LZ4 compression algorithm to
> +                               compress/decompress hibernation image.
> +
>         highmem=3Dnn[KMG] [KNL,BOOT] forces the highmem zone to have an e=
xact
>                         size of <nn>. This works even on boxes that have =
no
>                         highmem otherwise. This also works to reduce high=
mem
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 219191d6d0e8..43b1a82e800c 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -47,7 +47,7 @@ dev_t swsusp_resume_device;
>  sector_t swsusp_resume_block;
>  __visible int in_suspend __nosavedata;
>
> -static const char *default_compressor =3D CONFIG_HIBERNATION_DEF_COMP;
> +static char hibernate_compressor[CRYPTO_MAX_ALG_NAME] =3D CONFIG_HIBERNA=
TION_DEF_COMP;
>
>  /*
>   * Compression/decompression algorithm to be used while saving/loading
> @@ -748,7 +748,7 @@ int hibernate(void)
>          * Query for the compression algorithm support if compression is =
enabled.
>          */
>         if (!nocompress) {
> -               strscpy(hib_comp_algo, default_compressor, sizeof(hib_com=
p_algo));
> +               strscpy(hib_comp_algo, hibernate_compressor, sizeof(hib_c=
omp_algo));
>                 if (crypto_has_comp(hib_comp_algo, 0, 0) !=3D 1) {
>                         pr_err("%s compression is not available\n", hib_c=
omp_algo);
>                         return -EOPNOTSUPP;
> @@ -999,7 +999,7 @@ static int software_resume(void)
>                 if (swsusp_header_flags & SF_COMPRESSION_ALG_LZ4)
>                         strscpy(hib_comp_algo, COMPRESSION_ALGO_LZ4, size=
of(hib_comp_algo));
>                 else
> -                       strscpy(hib_comp_algo, default_compressor, sizeof=
(hib_comp_algo));
> +                       strscpy(hib_comp_algo, COMPRESSION_ALGO_LZO, size=
of(hib_comp_algo));
>                 if (crypto_has_comp(hib_comp_algo, 0, 0) !=3D 1) {
>                         pr_err("%s compression is not available\n", hib_c=
omp_algo);
>                         error =3D -EOPNOTSUPP;
> @@ -1422,6 +1422,57 @@ static int __init nohibernate_setup(char *str)
>         return 1;
>  }
>
> +static const char * const comp_alg_enabled[] =3D {
> +#if IS_ENABLED(CONFIG_CRYPTO_LZO)
> +       COMPRESSION_ALGO_LZO,
> +#endif
> +#if IS_ENABLED(CONFIG_CRYPTO_LZ4)
> +       COMPRESSION_ALGO_LZ4,
> +#endif
> +};
> +
> +static int hibernate_compressor_param_set(const char *compressor,
> +               const struct kernel_param *kp)
> +{
> +       unsigned int sleep_flags;
> +       int index, ret;
> +
> +       sleep_flags =3D lock_system_sleep();
> +
> +       index =3D sysfs_match_string(comp_alg_enabled, compressor);
> +       if (index >=3D 0) {
> +               ret =3D param_set_copystring(comp_alg_enabled[index], kp)=
;
> +               if (!ret)
> +                       strscpy(hib_comp_algo, comp_alg_enabled[index],
> +                               sizeof(hib_comp_algo));
> +       } else {
> +               ret =3D index;
> +       }
> +
> +       unlock_system_sleep(sleep_flags);
> +
> +       if (ret)
> +               pr_debug("Cannot set specified compressor %s\n",
> +                        compressor);
> +
> +       return ret;
> +}
> +
> +static const struct kernel_param_ops hibernate_compressor_param_ops =3D =
{
> +       .set    =3D hibernate_compressor_param_set,
> +       .get    =3D param_get_string,
> +};
> +
> +static struct kparam_string hibernate_compressor_param_string =3D {
> +       .maxlen =3D sizeof(hibernate_compressor),
> +       .string =3D hibernate_compressor,
> +};
> +
> +module_param_cb(compressor, &hibernate_compressor_param_ops,
> +               &hibernate_compressor_param_string, 0644);
> +MODULE_PARM_DESC(compressor,
> +                "Compression algorithm to be used with hibernation");
> +
>  __setup("noresume", noresume_setup);
>  __setup("resume_offset=3D", resume_offset_setup);
>  __setup("resume=3D", resume_setup);
> --

Applied as 6.9 material, thanks!

