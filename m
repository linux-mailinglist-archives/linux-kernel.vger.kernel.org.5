Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA31A803D03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjLDS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjLDS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:29:43 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFC1FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:29:49 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1fadb9ac169so2653554fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701714589; x=1702319389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q98w33mc6+s9A9wtHHFHE8JJnBQGyFexGo0rxM7RDmY=;
        b=adMW4sx+sMTUUaH8g8KeV7Y9HQU5IrbGSTcTQ2dY4TwIZs8p2Zmm0jSPIY3uYvuDzI
         i3UfBIpBCV4N2tRSv0IOrIlUaQqqIjOeRmwyyTQbS/JSwRrAqhGnWm+ZoyNiNXVhq/PJ
         khhF/i17txXEP934K04X5AaxBEsmLCelwqcFLLHsjYYLQtvRKHso6LRIImEhzwZjPxTW
         5ZrdVVG9LfP0CsxJLcfXMHjh0UoZaO1gRDg0737PeUcFPGOfPq9LQmMbwZZYIbDUgv53
         JXlDPIYdER5fdx9+YKjm4eML/gjrc13cIb3ChCZSuL/on/YrrsedWGbsPn30H+oBuKDv
         Fj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714589; x=1702319389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q98w33mc6+s9A9wtHHFHE8JJnBQGyFexGo0rxM7RDmY=;
        b=U/Am1lA3A1K9S3bCsiaXTGevoWtM6aBaQOpUqhh5fzpi82xvH3FC7K03mQrgGIPOUq
         15uqMrYt9jXZsLaBrIEeptOu0y7yrSEcMxCkPWCjDRiH7muAMFT/ddm3reE/WXmdULRu
         0Y+1MvqJhAQW/ghv4CNpwuZ98MGW/QpNCzIPFW/978Qk9YFjW9jNv6hw6efRLB9r0Lf8
         UCiiXe83nkh774/KoUsraL8X5+Bc5aXjfiaJ3Fgxcv7S2vIIgA3lh3SukE88UzKQpPfG
         sSbSoOazIVVXr+S6D91l4iHePRV8a5WXCoGhKuY9ZWTecyNH/GiBWItYdzzjG5x/CjXP
         BnmQ==
X-Gm-Message-State: AOJu0Yxfs3/7527CWY1g3cIQ/GbIYWwKBbuLp4R1YavHyshV3r8CKGQN
        ExDssCUH6AcOZyX1+vQHEHG8tlY4fphvu1Pzo3c=
X-Google-Smtp-Source: AGHT+IFM9JkjyOPfFe5FFesofTO8QjpC1HMWpndmSWOomEp4GGuWn0kXHiMGFIhyu0BwvuDsaAwlQPYYo3e1X+VIQfI=
X-Received: by 2002:a05:6870:7813:b0:1fa:1ca3:ced8 with SMTP id
 hb19-20020a056870781300b001fa1ca3ced8mr2735574oab.52.1701714589221; Mon, 04
 Dec 2023 10:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20231204102154.3309670-1-alexious@zju.edu.cn>
In-Reply-To: <20231204102154.3309670-1-alexious@zju.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 Dec 2023 13:29:38 -0500
Message-ID: <CADnq5_PZ4pzhSXCQjO7bs3WPHSbkOe57GVN+wxzza5NVzMWb6Q@mail.gmail.com>
Subject: Re: [PATCH] [v2] drm/radeon/trinity_dpm: fix a memleak in trinity_parse_power_table
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Dec 4, 2023 at 5:39=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> wro=
te:
>
> The rdev->pm.dpm.ps allocated by kcalloc should be freed in every
> following error-handling path. However, in the error-handling of
> rdev->pm.power_state[i].clock_info the rdev->pm.dpm.ps is not freed,
> resulting in a memleak in this function.
>
> Fixes: d70229f70447 ("drm/radeon/kms: add dpm support for trinity asics")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>
> Changelog:
>
> v2: Adding {} to correct the if statement.
> ---
>  drivers/gpu/drm/radeon/trinity_dpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeo=
n/trinity_dpm.c
> index 08ea1c864cb2..ef1cc7bad20a 100644
> --- a/drivers/gpu/drm/radeon/trinity_dpm.c
> +++ b/drivers/gpu/drm/radeon/trinity_dpm.c
> @@ -1726,8 +1726,10 @@ static int trinity_parse_power_table(struct radeon=
_device *rdev)
>                 non_clock_array_index =3D power_state->v2.nonClockInfoInd=
ex;
>                 non_clock_info =3D (struct _ATOM_PPLIB_NONCLOCK_INFO *)
>                         &non_clock_info_array->nonClockInfo[non_clock_arr=
ay_index];
> -               if (!rdev->pm.power_state[i].clock_info)
> +               if (!rdev->pm.power_state[i].clock_info) {
> +                       kfree(rdev->pm.dpm.ps);
>                         return -EINVAL;
> +               }
>                 ps =3D kzalloc(sizeof(struct sumo_ps), GFP_KERNEL);
>                 if (ps =3D=3D NULL) {
>                         kfree(rdev->pm.dpm.ps);
> --
> 2.34.1
>
