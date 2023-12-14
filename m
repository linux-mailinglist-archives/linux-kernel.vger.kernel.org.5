Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DFA813749
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjLNRGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:06:32 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391EB7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:06:38 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-202d6823844so3134974fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702573597; x=1703178397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw0RodZSdxJA0iLxv7tkLpUrFdAojr9L6Vs6gKIIOys=;
        b=M5aZ8AjvC3sCCL5HtasFJDLWGuqZQ5CG7SwX/FarXHgjZTPHFNba8Ei1sY/IpyYh4A
         SnEwBTsf3bcpzOEnj8V3VSt7mve6XJjJX/VBntex7pZd2HERQjpqUactw4WCTWPPpYbN
         IIh6c9YjfZXs1aQTz1IQGAv+hgWeFWrl2Ir74mt/5ySuJyTmLcxxuHGwF0lWh50tRdrJ
         jQo10tA/q/4NUL4fKUL/n1316V4iTMX2qfGabZC5de/EfBQvkS68G3QE7CKkRPd7iOGr
         NiT9LZ9tn/ywEpPlODkqnnU4ikTHc0MzbRT+nQYteDkuZ8OMOaIOk5IMgGYT/qTiGjTN
         Nd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573597; x=1703178397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw0RodZSdxJA0iLxv7tkLpUrFdAojr9L6Vs6gKIIOys=;
        b=ekNS6N+42UJblQbtNOuMXWnhhHqkfjJ/100CMczIEqBAdqnV+QyiGitKC07sQXTzfF
         SWNTZJrY3J2op55zw2cEx8MI0Py2b3R2RiC12PA1kVsA0l927INeBkRyk+TvjA72vW/K
         fBsa/YycTxYGJgxPc4ky5Bzxo2BeLFuFueHVjaQaQWm/YXtGo6+s7nayTos/yUy2ryUn
         DBZjnWZ+ezjUHl/uz1/RRzY29e56I89vBnK7Ap3GELsTNGHP55p8OsKYfdB5iNuAQ6RU
         jeiWT7bEbFJO5LxC+gT5vQmmsKJbqdaDqY609Ub3pCK96dAD4dtEABK8A0BhwfTbqW/U
         djUQ==
X-Gm-Message-State: AOJu0Yyarl4LrrlecNjVdrkNm89GfaZaOwhfp4RWZk06FpOEWGp1PMf1
        J+vj4djhCyyw6QMdk0HvxMTGzr79X4YBTzPcU08=
X-Google-Smtp-Source: AGHT+IExNNoad7Bj8XQBRJ5WCf95CmDbkzKCuwvVnxC9gAiPmYDsKYy6JXEAUEPxTCZKr8tl2TD7sMsnEmTVcPwK7m8=
X-Received: by 2002:a05:6870:168c:b0:203:2e8b:1a1d with SMTP id
 j12-20020a056870168c00b002032e8b1a1dmr3061586oae.11.1702573597292; Thu, 14
 Dec 2023 09:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20231214162500.3483936-1-alexious@zju.edu.cn>
In-Reply-To: <20231214162500.3483936-1-alexious@zju.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Dec 2023 12:06:26 -0500
Message-ID: <CADnq5_MYKE+GssKugrLZ-0zj1=JxJayxxp4kviVh6kOPi2abZg@mail.gmail.com>
Subject: Re: [PATCH] drivers/amd/pm: fix a use-after-free in kv_parse_power_table
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     Ran Sun <sunran001@208suo.com>, Jammy Zhou <Jammy.Zhou@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Le Ma <le.ma@amd.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Dec 14, 2023 at 11:57=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> w=
rote:
>
> When ps allocated by kzalloc equals to NULL, kv_parse_power_table
> frees adev->pm.dpm.ps that allocated before. However, after the control
> flow goes through the following call chains:
>
> kv_parse_power_table
>   |-> kv_dpm_init
>         |-> kv_dpm_sw_init
>               |-> kv_dpm_fini
>
> The adev->pm.dpm.ps is used in the for loop of kv_dpm_fini after its
> first free in kv_parse_power_table and causes a use-after-free bug.
>
> Fixes: a2e73f56fa62 ("drm/amdgpu: Add support for CIK parts")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/kv_dpm.c
> index 5d28c951a319..5cb4725c773f 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -2735,10 +2735,8 @@ static int kv_parse_power_table(struct amdgpu_devi=
ce *adev)
>                 non_clock_info =3D (struct _ATOM_PPLIB_NONCLOCK_INFO *)
>                         &non_clock_info_array->nonClockInfo[non_clock_arr=
ay_index];
>                 ps =3D kzalloc(sizeof(struct kv_ps), GFP_KERNEL);
> -               if (ps =3D=3D NULL) {
> -                       kfree(adev->pm.dpm.ps);
> +               if (ps =3D=3D NULL)
>                         return -ENOMEM;
> -               }
>                 adev->pm.dpm.ps[i].ps_priv =3D ps;
>                 k =3D 0;
>                 idx =3D (u8 *)&power_state->v2.clockInfoIndex[0];
> --
> 2.34.1
>
