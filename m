Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1537F81372A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443633AbjLNRDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:03:20 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E12A7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:03:27 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-20335dcec64so1042033fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702573406; x=1703178206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEXnTnqjpa7nm9vgp7D5PjeKTa53gHhoihHSu75cHl4=;
        b=hLqweie0p9lG/3MVL8ngA/6a+qG0/l4QsBBM+Tj1QebMPzITAQyDoJvuQO8NurkpXN
         zkTGzbxqCfrgeI0xQF4lz2v1Dc3ZyKqzmmiCT5p7BG6U+28Ym3YaQcE06hcuXOY6EX1Y
         zU7896GLGvMbum4XrO1dYdJnWgNeU9nkBBJBefiEM0RMQUy6Re8tZ/6RmIu2QTWJMzQo
         jWCWFHajHBRMyslA8iy6g9fEODaz1O2PO0djhDuERSuvnIpVvugte4POMBIfLc8pLHLV
         pIVN7WTKYC0pFuk5rygID1y4jk8LjW9hXk4yLWTF136dwhhFenEjbHxwum0VAieQ/lcV
         MSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573406; x=1703178206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEXnTnqjpa7nm9vgp7D5PjeKTa53gHhoihHSu75cHl4=;
        b=tQ/vTfpl9EE5jK23I3sliSYvFu+t9sADsHYIlz43PCzPjnXTfwIEQXtf+eIsVYR+31
         t1sylZ6Bn0bd2723kf+EhtgcYa7YTG69FTVZMDZbN/3T5UXeZyqsjS26UqWO5UX0MZS8
         y4pactQ3mN0rwSu4W4T8PVINsCbEm2sLe9yldN8yKUoaHRnfQPmkSuhp2U2eCW/sJolM
         67PBoDbu0zbpzEMeFL00v21mEzW8/iplQhPFQixyL/Oiimul4DW8jVkpdwSLcWsUC5pg
         cNWh3KU25NvK4jw0YJL52A8y4qlwxSWeELWVvZCKm7k5wPRlFr7fccqNYNdeldJRhawl
         bPLA==
X-Gm-Message-State: AOJu0Yy0EgMCUAFQagW3p0GrQ+P1sAWMJcyFhnmanG54tOY6caj7cRGT
        mevyIZMjGWCxRnk+5ZA2kRGzYBrtkWZqhOr/Hns=
X-Google-Smtp-Source: AGHT+IEHQe0sa0Hs3zuw66/YXZe0qIycTF9cpBKtgFuNygldhFgNPAck39sdFcnprEAS8iQm5a7ybs4Elkfe0DhAoEw=
X-Received: by 2002:a05:6870:d10c:b0:203:3902:61f8 with SMTP id
 e12-20020a056870d10c00b00203390261f8mr2662871oac.12.1702573406322; Thu, 14
 Dec 2023 09:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20231214152413.3483199-1-alexious@zju.edu.cn>
In-Reply-To: <20231214152413.3483199-1-alexious@zju.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Dec 2023 12:03:14 -0500
Message-ID: <CADnq5_PHqy6oQhyycN8xjApo+-1YxuYpJxm+2MwwWCd+mLX6XA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix a double-free in si_dpm_init
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     Lijo Lazar <lijo.lazar@amd.com>, Guchun Chen <guchun.chen@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenneng Li <lizhenneng@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
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

On Thu, Dec 14, 2023 at 10:59=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> w=
rote:
>
> When the allocation of
> adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries fails,
> amdgpu_free_extended_power_table is called to free some fields of adev.
> However, when the control flow returns to si_dpm_sw_init, it goes to
> label dpm_failed and calls si_dpm_fini, which calls
> amdgpu_free_extended_power_table again and free those fields again. Thus
> a double-free is triggered.
>
> Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index fc8e4ac6c8e7..df4f20293c16 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7379,10 +7379,9 @@ static int si_dpm_init(struct amdgpu_device *adev)
>                 kcalloc(4,
>                         sizeof(struct amdgpu_clock_voltage_dependency_ent=
ry),
>                         GFP_KERNEL);
> -       if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries) {
> -               amdgpu_free_extended_power_table(adev);
> +       if (!adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries)
>                 return -ENOMEM;
> -       }
> +
>         adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count =3D 4;
>         adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].clk =
=3D 0;
>         adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[0].v =
=3D 0;
> --
> 2.34.1
>
