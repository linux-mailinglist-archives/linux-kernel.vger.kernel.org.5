Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12E37704A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHDP2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjHDP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65904C3F;
        Fri,  4 Aug 2023 08:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5278562075;
        Fri,  4 Aug 2023 15:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69FDC433C7;
        Fri,  4 Aug 2023 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691162867;
        bh=8fa4il8HCXs0qhuDsLDmgjuv5qD+YDBsnJ7lUCizcck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZOq3vX2j8iKIJoOltM+NzQGy3+vNfpQEf5yCNmh8lVSD+m4mMLrpKDTpEh7/FHkP5
         x4C1HKTfbbnf/kvjH4qWp08n0nW1TFqJhxReU0yQn58gRo26yFeDPvjok2iD47bAE5
         P+DJmiSfvkfghA9FTc7BGO6bqMtiKsznSeugh2JEK4oyXN5lW7avUG8mlfbNc9mUKV
         qaq4+3ldNJ2Z17DWju29EECG9gJJP7bMDwQ9tCu8Zp339fFt36/99dYDFwnYGavKbC
         BKQcayZ83XO/EqZ3AJ3TCfeQONMc858OmKFGKPWZinoE1ObQ1/VGCk4YKdULceOcZ2
         fBCcAYT7f4/HQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso2802373a12.2;
        Fri, 04 Aug 2023 08:27:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YyRKntpNe/V82ElnT0FA12YBkvnaVjGkFCOwEIVK1IHchWAcGv0
        Ueh6b4wfw8uKV8Qxhox2wUW3813dAvLCjBH8T+Q=
X-Google-Smtp-Source: AGHT+IF75UPfOMa93S7oEBe1PWACXRIccOkLHBcfsS/W5qdPf+1wOC8RkoS9XtVay1r0FoTENOhr8wWoV3sS4FLn2Uc=
X-Received: by 2002:a05:6402:12d8:b0:523:22d9:6c40 with SMTP id
 k24-20020a05640212d800b0052322d96c40mr362936edx.17.1691162865955; Fri, 04 Aug
 2023 08:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230804124611.2051048-1-kernel@xen0n.name>
In-Reply-To: <20230804124611.2051048-1-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 4 Aug 2023 23:27:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H681+pput57E2vHz_V7A_oNy1Av6aCDN6eP0wBQqo7kAg@mail.gmail.com>
Message-ID: <CAAhV-H681+pput57E2vHz_V7A_oNy1Av6aCDN6eP0wBQqo7kAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] raid5, raid6: Accelerate RAID math with LoongArch SIMD
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui and Song,

This series looks good to me, if no one has objections, I will queue
for loongarch-next.

Huacai

On Fri, Aug 4, 2023 at 8:46=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wrot=
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
> other tag) too; it doesn't depend on the raid6test fixes.
> The base-commit and prerequisite-patch-id info is available for
> minimally recreating a working configuration for both the kernel and
> raid6test tool.
>
> [1]: https://lore.kernel.org/loongarch/20230722072201.2677516-1-chenhuaca=
i@loongson.cn/
> [2]: https://lore.kernel.org/linux-raid/20230731104911.411964-1-kernel@xe=
n0n.name/
>
> Changes in v3 (no functional change):
>
> - coding style tweaks to the recovery code
>   (Patch 2 is not touched because it is much more resembling the
>   original int.uc code before unrolling.)
> - more detail in the commit message of Patch 3
>
> Changes in v2 (no functional change):
>
> - minor commit message tweaks
> - changed comment style from // to /* */ throughout
>
> WANG Xuerui (3):
>   LoongArch: Add SIMD-optimized XOR routines
>   raid6: Add LoongArch SIMD syndrome calculation
>   raid6: Add LoongArch SIMD recovery implementation
>
>  arch/loongarch/include/asm/xor.h      |  68 ++++
>  arch/loongarch/include/asm/xor_simd.h |  42 +++
>  arch/loongarch/lib/Makefile           |   3 +
>  arch/loongarch/lib/xor_simd.c         |  93 +++++
>  arch/loongarch/lib/xor_simd.h         |  46 +++
>  arch/loongarch/lib/xor_simd_glue.c    |  71 ++++
>  arch/loongarch/lib/xor_template.c     | 110 ++++++
>  include/linux/raid/pq.h               |   4 +
>  lib/raid6/Makefile                    |   1 +
>  lib/raid6/algos.c                     |  16 +
>  lib/raid6/loongarch.h                 |  38 ++
>  lib/raid6/loongarch_simd.c            | 422 +++++++++++++++++++++
>  lib/raid6/recov_loongarch_simd.c      | 515 ++++++++++++++++++++++++++
>  lib/raid6/test/Makefile               |  12 +
>  14 files changed, 1441 insertions(+)
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
