Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58221779A73
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjHKWLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHKWK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:10:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AE81716;
        Fri, 11 Aug 2023 15:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAC5E64B4A;
        Fri, 11 Aug 2023 22:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188D1C4339A;
        Fri, 11 Aug 2023 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691791853;
        bh=N8lpigPkvlxlig325fbyaTImOPZkDbDukkfY6bibi4k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oiLmKr3SBSdDL3sDxTS6aPUrfhjRbHMUZF5t1SOUvaq+3+t1wq0XHtVHW/E9gzGoy
         rr6E7qE7ej6FIjvDztI8eibsfJ/e4IJEo/bAZpvDoKnMxs8T4POFrJXLjAtwLLav/M
         LbuMYV7E3cEB5FJj10iucd1IemgC65zFpBITHVWb+j2peLQRZBCtBwpC73rJIUDt6D
         tSQVCOLWtq5PiDcILdill9IG1vcqHT1s0BUEkZTCmO8u3vu75xaEtApoTAiQ6pRZlE
         X252IHBujsr63ckTzbkt2EqYaHLH2N1MSmSiQ/UaoczmaJxm9DaXlIiw5zWSOtOc3a
         +y86OpqD+SI0g==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56ced49d51aso1572357eaf.1;
        Fri, 11 Aug 2023 15:10:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YxGlZvxqDx+fxbWD8T4FW77USEwTrY5Ae94Xd+81BeeGBzlqyHj
        HPhKvs//saCchXv/eK986uE5enknbmOHcHs6vxE=
X-Google-Smtp-Source: AGHT+IGn1gQn4CG7x4Y66qfsYEz2RYlI/GdSoTxRIWymQmm7uMPiGClKZum+y67wV7ik5jOQYxKVmHuCQntmPwL9x1A=
X-Received: by 2002:a4a:240c:0:b0:564:e465:5d5c with SMTP id
 m12-20020a4a240c000000b00564e4655d5cmr2107496oof.2.1691791852125; Fri, 11 Aug
 2023 15:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <20230810141947.1236730-3-arnd@kernel.org>
In-Reply-To: <20230810141947.1236730-3-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 12 Aug 2023 07:10:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQo5hri-9JmS_kot1mQ6WHCWAeu+SnW19daWMC1YK5BWA@mail.gmail.com>
Message-ID: <CAK7LNAQo5hri-9JmS_kot1mQ6WHCWAeu+SnW19daWMC1YK5BWA@mail.gmail.com>
Subject: Re: [PATCH 02/17] [RESEND] irq_work: consolidate arch_irq_work_raise prototypes
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:00=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The prototype was hidden on x86, which causes a warning:


What do you mean by "hidden on x86"?

arch_irq_work_raise() was declared on 7 architectures,
including x86.




>
> kernel/irq_work.c:72:13: error: no previous prototype for 'arch_irq_work_=
raise' [-Werror=3Dmissing-prototypes]
>
> Fix this by providing it in only one place that is always visible.
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/irq_work.h     | 2 --
>  arch/arm64/include/asm/irq_work.h   | 2 --
>  arch/csky/include/asm/irq_work.h    | 2 +-
>  arch/powerpc/include/asm/irq_work.h | 1 -
>  arch/riscv/include/asm/irq_work.h   | 2 +-
>  arch/s390/include/asm/irq_work.h    | 2 --
>  arch/x86/include/asm/irq_work.h     | 1 -
>  include/linux/irq_work.h            | 3 +++
>  8 files changed, 5 insertions(+), 10 deletions(-)
>


--
Best Regards
Masahiro Yamada
