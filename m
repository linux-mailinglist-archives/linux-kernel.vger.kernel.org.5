Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9524813766
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443744AbjLNRJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:09:19 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7FAA7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:09:26 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9fd7b14cdso380708b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702573765; x=1703178565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CNk90HKBipLuoBWfUeXQZLtJYhN9IVU6m1y0XruPTY=;
        b=iMDqD5glMHkD5cwnb6tSnkl+tGOBF5nwvOcZfH/QrQE4xLMaJYg9z7GJy8nW5r4y+P
         U/53PbNKolzexfaWlNRBAskguKQEAqTKMpLyYoqgVyHnFockwfmAnZTkBGKwe3m4epwZ
         MimrcrvIzgZ8IulHqlHjHhBzwSQKdpQzQRarTdZj/CfF5f3popUKQm5HkOIr8W6s98tB
         3g74slDp2KXBPtH5M0M93iZYqLSkcy/TIWLo8Lr/hKyJ2ldXDyzx3YiB8N0IpzRMT2rD
         pixKOvwDTvjqLBtjlbYP12ATPAoIwRyzR+KVbsBMJ2SsXf4C0SdJ/PmvUng4wWrgQdu9
         XJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573765; x=1703178565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CNk90HKBipLuoBWfUeXQZLtJYhN9IVU6m1y0XruPTY=;
        b=l31X6A+i1xq+xXMoTWyyc5Ts6uHSMFxyKSMlHxawEu+R1wYo6M1mDNiDm1KRecrk5n
         wC5qibIgqfWvuiwDP2qCi4XLhUdrV6R6SLijwT2eNF8rNUF2XivqGwEnTBZkNnnn97Ww
         erUdl4yBZDyaMtdqG7AKFbvOt29yERrknDhFzvs/wBMRkF/JxisQh/5luC9ctV5L/+Ci
         4M/pMIi/wf5GDH8e5Q+t7SGBXGWjPkwkITzLmO/WmaO6oZZ5VSQui92OvxVmUFPhQ23S
         1x2ujrGjBENGk0k25v2GIbkQr3LaBJXG0MjWmBSslRAwqo/obcPJ2uRKFFl/xPVPJ+JZ
         zAhQ==
X-Gm-Message-State: AOJu0YzP+d1vDTMzIEY//Rv6G2N6xrlkrEWHXxZzlniRE62CCBLry0hu
        721eCadDDqyIPpLAuoDMqbyGx4Ch+oPgV+d/Smw=
X-Google-Smtp-Source: AGHT+IGUV3iGnP50aJIfnevuJJL7nzP5vfn/xDODENvQRDdTTOd8ZToD7opG++DF5O6ARF7EaMYCremugouz+CXKAFo=
X-Received: by 2002:a05:6808:13d3:b0:3b9:e632:7f99 with SMTP id
 d19-20020a05680813d300b003b9e6327f99mr5221377oiw.17.1702573765310; Thu, 14
 Dec 2023 09:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20231214165843.3484373-1-alexious@zju.edu.cn>
In-Reply-To: <20231214165843.3484373-1-alexious@zju.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Dec 2023 12:09:14 -0500
Message-ID: <CADnq5_OFhh_-qn9DdKWM5mhRWKfHWX027K95qyBUsqUao6vwHg@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/radeon: fix two memleaks in radeon_vm_init
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

On Thu, Dec 14, 2023 at 11:59=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> w=
rote:
>
> When radeon_bo_create and radeon_vm_clear_bo fail, the vm->page_tables
> allocated before need to be freed. However, neither radeon_vm_init
> itself nor its caller have done such deallocation.
>
> Fixes: 6d2f2944e95e ("drm/radeon: use normal BOs for the page tables v4")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/gpu/drm/radeon/radeon_vm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/=
radeon_vm.c
> index 987cabbf1318..c38b4d5d6a14 100644
> --- a/drivers/gpu/drm/radeon/radeon_vm.c
> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
> @@ -1204,13 +1204,17 @@ int radeon_vm_init(struct radeon_device *rdev, st=
ruct radeon_vm *vm)
>         r =3D radeon_bo_create(rdev, pd_size, align, true,
>                              RADEON_GEM_DOMAIN_VRAM, 0, NULL,
>                              NULL, &vm->page_directory);
> -       if (r)
> +       if (r) {
> +               kfree(vm->page_tables);
> +               vm->page_tables =3D NULL;
>                 return r;
> -
> +       }
>         r =3D radeon_vm_clear_bo(rdev, vm->page_directory);
>         if (r) {
>                 radeon_bo_unref(&vm->page_directory);
>                 vm->page_directory =3D NULL;
> +               kfree(vm->page_tables);
> +               vm->page_tables =3D NULL;
>                 return r;
>         }
>
> --
> 2.34.1
>
