Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E487FF7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjK3RLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3RKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:10:53 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895BA10D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:10:51 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1fa20395185so565992fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364251; x=1701969051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9iOH6Yd9Atg7CwHEtCTfnbvOXuGr9JGPZU/okAPF2U=;
        b=DJ1cht0yohO38k++Wkein6keRcpZx3Tmb3KRpcEmMeZaWJjM0BmyxTCV4hNW95ESHo
         xXrIrB+/Hc00HF5U9iu8lBC+AEZkAkD/Pn3pyMC0KF6XGrYYZgSZWFDid1jw3v66OfRS
         lnp2r2nd2yRjcfNJ+fnKXMUA2APV45Oci6naycvgyRzUotFc1lA7kl4D5EpaKIrYTfZy
         UM2tSBe+zWHn3BjgBsVD8QrcDAc/OYu6hGnBK5DEOTRp05RsJUKWM6VrcU/L0ZdZL2J6
         PWz4K9ZdjVGyfE85B61BHXrLpEek75Ab1+4gX9iJJC2GlZV/x5QrWPx1QV0VifhBEMhP
         mYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364251; x=1701969051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9iOH6Yd9Atg7CwHEtCTfnbvOXuGr9JGPZU/okAPF2U=;
        b=PHWQLXxvrBke5rOSJNi/J8wRvLIqYhmYylnaLUMMC4vjHKjCxn61/zYnTHcOjnvaNt
         fctTG7/M345i2u6UAl+b16yjutntjXrqZk3poPGAVlTxx6WGJebtdSvD2ycD3hQJvswV
         6144Zn6TwkVERKkDEKO5KyWNuRmE5BTroX/FBdzugu9GU4bN+YUfb8XAcs8Fe+tFaGU/
         eRnYqCEntM5ZWYGQw62OP0GYoGQ2gUP8jEB/Z0zzMKzAEgPsUxyZZ91ErdwZYDipYTBB
         hGazQsOoyfWJRgYPw7Ab9OF4suRVnaHqCweS6+q9mRAd3ftiEfZ13kX9EQkcYbFobK1s
         YDCQ==
X-Gm-Message-State: AOJu0YxDhpiBKBXjjyTvb/qbaXEYWDKyl61QQmJs/q8DnfjfO+tQhqcR
        bHpm6H/axelCKaYjxipnqPXCQai4gL1yAvX5+Fw=
X-Google-Smtp-Source: AGHT+IFga0LIgTJHbHwZ6AI3Nebtjpu1/mE6pEvvOWdhSB39jbFHga03BX1yiAShKg5YAMwBtiEtTsJM7ArB+zNs1Mg=
X-Received: by 2002:a05:6870:219a:b0:1fa:e115:ef6c with SMTP id
 l26-20020a056870219a00b001fae115ef6cmr114192oae.38.1701364250763; Thu, 30 Nov
 2023 09:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20231129152212.7879-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20231129152212.7879-1-n.zhandarovich@fintech.ru>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Nov 2023 12:10:39 -0500
Message-ID: <CADnq5_MZSG=g9UiYxWd0dAoqrkA7Bj-yVK0ExSMpsrcj8ML00A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r100: Fix integer overflow issues in r100_cs_track_check()
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Nov 29, 2023 at 10:28=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> It may be possible, albeit unlikely, to encounter integer overflow
> during the multiplication of several unsigned int variables, the
> result being assigned to a variable 'size' of wider type.
>
> Prevent this potential behaviour by converting one of the multiples
> to unsigned long.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 0242f74d29df ("drm/radeon: clean up CS functions in r100.c")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/gpu/drm/radeon/r100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.=
c
> index affa9e0309b2..cfeca2694d5f 100644
> --- a/drivers/gpu/drm/radeon/r100.c
> +++ b/drivers/gpu/drm/radeon/r100.c
> @@ -2321,7 +2321,7 @@ int r100_cs_track_check(struct radeon_device *rdev,=
 struct r100_cs_track *track)
>         switch (prim_walk) {
>         case 1:
>                 for (i =3D 0; i < track->num_arrays; i++) {
> -                       size =3D track->arrays[i].esize * track->max_indx=
 * 4;
> +                       size =3D track->arrays[i].esize * track->max_indx=
 * 4UL;
>                         if (track->arrays[i].robj =3D=3D NULL) {
>                                 DRM_ERROR("(PW %u) Vertex array %u no buf=
fer "
>                                           "bound\n", prim_walk, i);
> @@ -2340,7 +2340,7 @@ int r100_cs_track_check(struct radeon_device *rdev,=
 struct r100_cs_track *track)
>                 break;
>         case 2:
>                 for (i =3D 0; i < track->num_arrays; i++) {
> -                       size =3D track->arrays[i].esize * (nverts - 1) * =
4;
> +                       size =3D track->arrays[i].esize * (nverts - 1) * =
4UL;
>                         if (track->arrays[i].robj =3D=3D NULL) {
>                                 DRM_ERROR("(PW %u) Vertex array %u no buf=
fer "
>                                           "bound\n", prim_walk, i);
> --
> 2.25.1
>
