Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52B876B27F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjHALBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjHALA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F2422D;
        Tue,  1 Aug 2023 03:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6064614B3;
        Tue,  1 Aug 2023 10:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8E1C433C9;
        Tue,  1 Aug 2023 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690887267;
        bh=VO7pcsxb+oB+wsS8Ud4w4F+HV0+ydxKFE3sGoD1VYDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LvsYD/hTg82xvObqT/fOTuY/qbEyrDy2SiPENS5hu4V2VV+Wb2p+Cpn/ufHQXK8A/
         iqzqoxFbb9DkGLkDaQsLprSKQ9Wl7kTgUPk63stF57ZKx2izMAU1qDtaY7JTenp2ai
         7x9dH1p4cdmmkH6UosrkXjt3czFgdzrT58WO9IC7nkPwtrB8kuy5FSmCit6CJ8IGUW
         jSgInZdEghSOynt3rlrHieQGbTasBh4gk4tmbxtx+KEKuDhgKBAfhbFda9CCVtS6Mh
         B7lpMyYk4VCTVTgipPjwgVAsiqhXacDMQSjN8O2t5OH8gG6Vj6vtOJiw09/CZTX9hX
         RpLT7chS3o5Lg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so11562527a12.0;
        Tue, 01 Aug 2023 03:54:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLZHSCj2xRiGY/s/wDSM9+2pbRnD7N/dlz08wGTB71FdpSn5Ewf7
        lRk7OGWPqbYoBrgwKbVd6JrZczm2qj7HmUogrNY=
X-Google-Smtp-Source: APBJJlFukzChUGvsSOXUWygUB+0GArc3ZLcnrvtrngLoHxRu+4XYsAq8yQC+cOozTfOJnJ5RtEFuOWHH+6HmrOhgMKM=
X-Received: by 2002:aa7:c309:0:b0:522:3a1d:c233 with SMTP id
 l9-20020aa7c309000000b005223a1dc233mr3075933edq.11.1690887265380; Tue, 01 Aug
 2023 03:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230801081335.523097-1-kernel@xen0n.name>
In-Reply-To: <20230801081335.523097-1-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 1 Aug 2023 18:54:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Tq7E5sSHUq+FSgs-GpHSMmmp=KDPBpKJt1vXRkMv9Cw@mail.gmail.com>
Message-ID: <CAAhV-H6Tq7E5sSHUq+FSgs-GpHSMmmp=KDPBpKJt1vXRkMv9Cw@mail.gmail.com>
Subject: Re: [PATCH 0/3] raid5, raid6: Accelerate RAID math with LoongArch SIMD
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

On Tue, Aug 1, 2023 at 4:13=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wrot=
e:
>
> From: WANG Xuerui <git@xen0n.name>
>
> Hi,
>
> Seeing the LoongArch port recently (finally!) gained the ability to use
> the vector units, I've subsequently ported the RAID5/6 math to LSX and
> LASX (which are LoongArch's 128-bit and 256-bit SIMD extensions), with
> nice speedups observed. They are reasonably straight-forward conversions
> of existing code, and I hope the comments I put in there are helpful
> enough for anyone not familiar with LoongArch assembly to get a rough
> picture of how things work here. Performance numbers are included in
> each commit's commit message.
>
> This series needs [1] ("LoongArch: Allow usage of LSX/LASX in the
> kernel") as a prerequisite, or the vector context would likely get
> corrupted by the vector-unaware kernel_fpu_{begin,end} calls. I tested
> the changes on top of next-20230731 with the raid6test build fixes [2]
> applied, but the series should apply cleanly to v6.5-rc4 (or maybe any
> other tag) too.
Thank you for your patches, but the kernel coding style prefers /* ...
*/ rather than // ...

Huacai
>
> [1]: https://lore.kernel.org/loongarch/20230722072201.2677516-1-chenhuaca=
i@loongson.cn/
> [2]: https://lore.kernel.org/linux-raid/20230731104911.411964-1-kernel@xe=
n0n.name/
>
> WANG Xuerui (3):
>   LoongArch: Add SIMD-optimized XOR routines
>   raid6: Add LoongArch SIMD syndrome calculation
>   raid6: Add LoongArch SIMD recovery implementation
>
>  arch/loongarch/include/asm/xor.h      |  68 ++++
>  arch/loongarch/include/asm/xor_simd.h |  42 +++
>  arch/loongarch/lib/Makefile           |   3 +
>  arch/loongarch/lib/xor_simd.c         |  92 +++++
>  arch/loongarch/lib/xor_simd.h         |  46 +++
>  arch/loongarch/lib/xor_simd_glue.c    |  71 ++++
>  arch/loongarch/lib/xor_template.c     | 109 ++++++
>  include/linux/raid/pq.h               |   4 +
>  lib/raid6/Makefile                    |   1 +
>  lib/raid6/algos.c                     |  16 +
>  lib/raid6/loongarch.h                 |  38 ++
>  lib/raid6/loongarch_simd.c            | 417 +++++++++++++++++++++
>  lib/raid6/recov_loongarch_simd.c      | 501 ++++++++++++++++++++++++++
>  lib/raid6/test/Makefile               |  12 +
>  14 files changed, 1420 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/xor.h
>  create mode 100644 arch/loongarch/include/asm/xor_simd.h
>  create mode 100644 arch/loongarch/lib/xor_simd.c
>  create mode 100644 arch/loongarch/lib/xor_simd.h
>  create mode 100644 arch/loongarch/lib/xor_simd_glue.c
>  create mode 100644 arch/loongarch/lib/xor_template.c
>  create mode 100644 lib/raid6/loongarch.h
>  create mode 100644 lib/raid6/loongarch_simd.c
>  create mode 100644 lib/raid6/recov_loongarch_simd.c
>
>
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> prerequisite-patch-id: 85d08a9828893250ae78dbca9d6e6f8dac755f61
> prerequisite-patch-id: fe0bba41e0bbc676454365ed16fb13fc0aac6ee0
> prerequisite-patch-id: 84ef8212b74e696ce019255bbfd9679d7516f7f7
> prerequisite-patch-id: b1f8fc4e4acdaff7f821a9fcbd063475178e037b
> prerequisite-patch-id: 82aacbf27f249fdefe40dd6bcc712e5795256926
> prerequisite-patch-id: ae4e026e18f92ffcc93f6b135a3bd48fbdded39a
> --
> 2.40.0
>
