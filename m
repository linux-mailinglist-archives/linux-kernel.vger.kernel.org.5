Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88387E2C1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjKFSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjKFSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:35:53 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395E9E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:35:50 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f0f94943d9so93558fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 10:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699295749; x=1699900549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FyxgsqyDTTsJmSPOBc9fyUquINbkS3ed/Fwy5DuS5A=;
        b=WTJc45eAC3Liz92nMC3yr8MCbUuxzuZFvf08t0v6K16reumnRmqYBfjGAmbMfcFivs
         V6g0owscaEk5Xcj2RiWjBYq7pqpxzpVt8UPI7kTjJXRA6zG/eYqcOuvOKR9MlylGBxVJ
         HPAx//rbXVLhWV7sq3XABGimwV2eeymnl04ozizdRFlnvW0Xy8tw1BGvhCAMrvqMso6e
         vtm5W2xdnrg0v95ZIu6BAdMUn7dFIMm0w70tH10VbJzYX3sA2YWH92PIkJi9xjS7NlZM
         kcO+VhqrmbAuSFNI+0s2BHM8PxiWEJBAo2gYJfsNnS+Ryx4PHlo47OM4/qYYlktXh6/O
         mf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699295749; x=1699900549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FyxgsqyDTTsJmSPOBc9fyUquINbkS3ed/Fwy5DuS5A=;
        b=JqZZC0+huFRvq8YOWs+Wjr5eGepu5voU7qe4tSGqHQJqsYgeVUvsSQH6LKdVJ+Yo+k
         iulabPP2fwdL87OW43CivvpmkvBWxNBl4DXpjLSNDnU1r7DPu1J555eAXIm166lJeagU
         1B7nhl8Utlw+oU7NaNKOVLSQ3fL1yNykU6pdoWd+qj/3bnDHZXek2NXtQ/HiEz4YzBh3
         8Q3Hvpo2dkFRpReJMn5cNHM15L18c73prLLgVVFzm6GM8pltykwlPTAf+gviG/ZNN9Xl
         GX7xDlOuOlSDwjqj6ZdE6HX3Sjx+2UGQVGbpihuEx6jIM43m1saggoTSXlbCvGvCMNJ3
         UpQA==
X-Gm-Message-State: AOJu0YwoqYA4QUlMuUT5KYM0F4MmsM779yprUX7+KqRZenrTBeNP6KdI
        /968kZbCbMdaMx17rwRDXgkrL+gTXbPanLEX6MU=
X-Google-Smtp-Source: AGHT+IHyNL5Y+NlJaXyaf72PDsyLKHnkDv/n1KFwzrC23GcvbcqxrMtSr+TtQ1Bx4YzC0Pa2/GTEedzxkelIazWbdrA=
X-Received: by 2002:a05:6871:7293:b0:1e9:b0fa:de4c with SMTP id
 mm19-20020a056871729300b001e9b0fade4cmr718153oac.33.1699295749256; Mon, 06
 Nov 2023 10:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20231024181134.48066-1-bragathemanick0908@gmail.com>
In-Reply-To: <20231024181134.48066-1-bragathemanick0908@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Nov 2023 13:35:37 -0500
Message-ID: <CADnq5_OS+15+u-4w3Ca9Q+ivm8U1P=6r-pOrC9fCbZSAUR=5hA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: avoid variable reinitialization
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, daniel@ffwll.ch,
        airlied@gmail.com, Qingqing.Zhuo@amd.com, alvin.lee2@amd.com,
        wenjing.liu@amd.com, jun.lei@amd.com, Samson.Tam@amd.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
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

On Tue, Oct 24, 2023 at 2:11=E2=80=AFPM Bragatheswaran Manickavel
<bragathemanick0908@gmail.com> wrote:
>
> The member variable enable_hpo_pg_support is already initialized
> and hence the reinitialization instruction can be removed. Issue
> identified using the doubleinit.cocci Coccinelle semantic patch script.
>
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> index 99d55b958977..1fd9df8da09c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
> @@ -739,7 +739,6 @@ static const struct dc_debug_options debug_defaults_d=
rv =3D {
>         .disable_boot_optimizations =3D false,
>         .disable_unbounded_requesting =3D false,
>         .disable_mem_low_power =3D false,
> -       .enable_hpo_pg_support =3D false,
>         //must match enable_single_display_2to1_odm_policy to support dyn=
amic ODM transitions
>         .enable_double_buffered_dsc_pg_support =3D true,
>         .enable_dp_dig_pixel_rate_div_policy =3D 1,
> --
> 2.34.1
>
