Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73D7D02B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbjJSTrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345159AbjJSTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:47:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0968114;
        Thu, 19 Oct 2023 12:47:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C58FC433CA;
        Thu, 19 Oct 2023 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744820;
        bh=kJyJ53sEdpPJK6eagpUQpoxGIQ2v4UNjTrtx9ncWMjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nDFWVqRHy/C2zMBklJ2uAXHxqdaqyNK8XEpcMD3XPazOM4a+k7fcBDHTcyt7zP87m
         BRoGBXdMVFnsreuu6oAkhuB84Hn7yaCb6NtgFo0JYvA3ethDF4zLq0EODdip5BHnJE
         uNajNGFKDO4kgMYHhw53oYyl0Y8B9iYX9dY4q9AYVwM0z/6HkDJFlFodgiHOLguqIM
         a6jWNYdB5MF1p3tiZZDjPIJs5Zj0f+gmi17m+01RO3fzNFX16MtotBWDwfdaIdUI5t
         NHh9LOeIDN2aqzeZcgTB2Pb3Wzp5dC9gE8fUCg38u0sOYm+9uWfgvpKULSivuohuFX
         KhFVy1K+yKSeQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-507adc3381cso14464e87.3;
        Thu, 19 Oct 2023 12:47:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoZWO2y+cBuFpssxAWespnrakCz4ZBLqydAWh3Cu/VhFbPTc3z
        VAA+tcySJUJGYt97go9z05tA7p6kBMEUz+bHpQ==
X-Google-Smtp-Source: AGHT+IEv0Yxf1FOVuXFGWen4jDWLp5PE11XXP+QWf6ZcfW0Lwd4xFfWSkOUQ2pkinfmyVX+ucqLtX8D9FLXWah8BxeU=
X-Received: by 2002:ac2:5328:0:b0:500:b74b:e53 with SMTP id
 f8-20020ac25328000000b00500b74b0e53mr2215352lfh.46.1697744818512; Thu, 19 Oct
 2023 12:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231019184825.9712-1-quic_obabatun@quicinc.com> <20231019184825.9712-2-quic_obabatun@quicinc.com>
In-Reply-To: <20231019184825.9712-2-quic_obabatun@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 Oct 2023 14:46:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pUv29277spzXB7QJ=OZTwGy_FmW55CzQPWYLPktA0EA@mail.gmail.com>
Message-ID: <CAL_Jsq+pUv29277spzXB7QJ=OZTwGy_FmW55CzQPWYLPktA0EA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] of: reserved_mem: Change the order that
 reserved_mem regions are stored
To:     Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 1:49=E2=80=AFPM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
> The dynamic allocation of the reserved_mem array needs to be done after
> paging_init() is called because memory allocated using memblock_alloc()
> is not writeable before that.
>
> Nodes that already have their starting address specified in the DT
> (i.e. nodes that are defined using the "reg" property) can wait until
> after paging_init() to be stored in the array.
> But nodes that are dynamically placed need to be reserved and saved in
> the array before paging_init() so that page table entries are not
> created for these regions.
>
> Hence, change the code to:
> 1. Before paging_init(), allocate and store information for the
>    dynamically placed reserved memory regions.
> 2. After paging_init(), store the rest of the reserved memory regions
>    which are defined with the "reg" property.
>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
>  arch/arm64/kernel/setup.c       |  4 +++
>  drivers/of/fdt.c                | 56 ++++++++++++++++++++++++++-------
>  drivers/of/of_private.h         |  1 -
>  drivers/of/of_reserved_mem.c    | 54 ++++++++++++++-----------------
>  include/linux/of_fdt.h          |  1 +
>  include/linux/of_reserved_mem.h |  9 ++++++
>  6 files changed, 83 insertions(+), 42 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..6002d3ad0b19 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -27,6 +27,8 @@
>  #include <linux/proc_fs.h>
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
> +
>  #include <linux/efi.h>
>  #include <linux/psci.h>
>  #include <linux/sched/task.h>
> @@ -346,6 +348,8 @@ void __init __no_sanitize_address setup_arch(char **c=
mdline_p)
>
>         paging_init();
>
> +       fdt_init_reserved_mem();
> +

You removed this call from the common code and add it to arm64 arch
code, doesn't that break every other arch?

The very next thing done here is unflattening the DT. So another call
from the arch code to the DT code isn't needed either.

Rob
