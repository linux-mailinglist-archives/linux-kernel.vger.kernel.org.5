Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770B803039
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbjLDKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbjLDKZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:25:08 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA18D5B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:24:59 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d9a6f756c3so228896a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701685499; x=1702290299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFWwDfWuYKDzJoaI6ZRY85TeV2wN7kNmrNs2cUdQvx8=;
        b=PbjqKqp7KXNSyyE7Co5VvuZY40kPmykj9I29LXr2lMfR961EtggDb0p7N1yPE03b2Y
         OPaqsN/LSxVf+5ipIwXix3gJ4VprIQ9nRIxoT6Yj6qe+g3tB5v/6iAHqoFaRRtmDLTik
         HEcvd9GLnvl2rzV8DPf09Sq6xQ9fFbnDWPRU2lOFFG8UhZ7txvRFVEwwq84p2KQ6wyGx
         AuSBgDOYJrMkNZUUsLLuc7ba1ALcvlxnhpanXLtOmhoSsEhSKhf6xKxwj+Ug8O84jvzo
         Giaa0bo91eu4k+OuIAq/Q33DSoXuuhXpbFGktIdFllstJmHoksuMf93tIzmfom2dcuLr
         QUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701685499; x=1702290299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFWwDfWuYKDzJoaI6ZRY85TeV2wN7kNmrNs2cUdQvx8=;
        b=BdJAj80mE0/TGgZECBbFyrg1fYEMnI+G4D2x53IArSOJFNdEoNPlCjsDDWmx7CJSdv
         ktYkENET530q4nlMHlaK7qnNV6phOz9RZrefNyRQ8X1ECdBzsyZ+8X3bhuo+R9b5MOSq
         b8PpcAE0ASe1PS5w5F21vOkuMRE3ajYOSpftIuUf/PiW5sWY+0z8owH1wsiePklzztBl
         1YG0dWd4xPXU0fnovcr98OyTJRkuEY1+j2gOntBIOzsOtpLryvdmpofAdLI1ByLS81j8
         3KIWlbmsv1xX5FkS5FD2oxcgu1YLUp5TYO/+4q/hupSCEPSKQbr/cUQ1LTiduMNqlp8Z
         pdvw==
X-Gm-Message-State: AOJu0YweWmcQjgOttmW1pT6F3J4C7egxchrMSS0aiIgWVur7TD/Ndauz
        17jaUyJM9zUCTnqoy0ZYFmSR1edS/+PicQeKByMaul3yZCwetw==
X-Google-Smtp-Source: AGHT+IHGkRNTRTbTZQhFirRRD5A2IRs3d4pxRFeNNeut7yVnKoQ/U3bgcbBsI0K3NfKyZw8i1V+PhixojHzVojxIXOQ=
X-Received: by 2002:a05:6870:4998:b0:1fb:2c68:6c0b with SMTP id
 ho24-20020a056870499800b001fb2c686c0bmr2924886oab.37.1701685499014; Mon, 04
 Dec 2023 02:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20231204034309.3290173-1-alexious@zju.edu.cn>
In-Reply-To: <20231204034309.3290173-1-alexious@zju.edu.cn>
From:   Amos Jianjun Kong <kongjianjun@gmail.com>
Date:   Mon, 4 Dec 2023 18:24:47 +0800
Message-ID: <CAFeW=pap5t5_xBcpHhM5Sm-XE7wORnzkdQCGuSO8GMz_D95u7g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/trinity_dpm: fix a memleak in trinity_parse_power_table
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Dec 4, 2023 at 5:55=E2=80=AFPM Zhipeng Lu <alexious@zju.edu.cn> wro=
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
>  drivers/gpu/drm/radeon/trinity_dpm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeo=
n/trinity_dpm.c
> index 08ea1c864cb2..8bf56fb7b933 100644
> --- a/drivers/gpu/drm/radeon/trinity_dpm.c
> +++ b/drivers/gpu/drm/radeon/trinity_dpm.c
> @@ -1727,6 +1727,7 @@ static int trinity_parse_power_table(struct radeon_=
device *rdev)
>                 non_clock_info =3D (struct _ATOM_PPLIB_NONCLOCK_INFO *)
>                         &non_clock_info_array->nonClockInfo[non_clock_arr=
ay_index];
>                 if (!rdev->pm.power_state[i].clock_info)
> +                       kfree(rdev->pm.dpm.ps);


I just confirmed the memleak problem in the code. But the fix has a
problem, it lacks the brackets.

diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c
b/drivers/gpu/drm/radeon/trinity_dpm.c
index 08ea1c864cb2..ef1cc7bad20a 100644
--- a/drivers/gpu/drm/radeon/trinity_dpm.c
+++ b/drivers/gpu/drm/radeon/trinity_dpm.c
@@ -1726,8 +1726,10 @@ static int trinity_parse_power_table(struct
radeon_device *rdev)
                non_clock_array_index =3D power_state->v2.nonClockInfoIndex=
;
                non_clock_info =3D (struct _ATOM_PPLIB_NONCLOCK_INFO *)

&non_clock_info_array->nonClockInfo[non_clock_array_index];
-               if (!rdev->pm.power_state[i].clock_info)
+               if (!rdev->pm.power_state[i].clock_info) {
+                       kfree(rdev->pm.dpm.ps);
                        return -EINVAL;
+               }
                ps =3D kzalloc(sizeof(struct sumo_ps), GFP_KERNEL);
                if (ps =3D=3D NULL) {
                        kfree(rdev->pm.dpm.ps);


>                         return -EINVAL;
>                 ps =3D kzalloc(sizeof(struct sumo_ps), GFP_KERNEL);
>                 if (ps =3D=3D NULL) {
> --
> 2.34.1
>
