Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31747BB059
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 04:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjJFCsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 22:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFCsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 22:48:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415DFD6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 19:48:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB854C433C9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696560500;
        bh=S+UavZRf4TVde+EA7hXdDDYlBSk/ccOB+/KHk1iz80g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VkuGMNWUI/INWYI7UAQ5hDFiJvSQwqvucBLoGelVQy34XYyJjVLSJpfovqnvoDl9r
         wMsFhn2dXzRKhQuZMtjNlIKdRfX5MrEDfToEvH9Mfs1+rDCM7Z3OP8e84+5xeIs3JP
         IWz2g9U/Ia4oB6sNLc6oyAwQrgo71YxbH3ItMdcSiv6zo5qyJfOCdvzXFg7LgLBiNQ
         dun5eOGuk8s64F4MaZFwk/s4FJH1v7a+U8icg1dAx3acq/Aq4QSCbqvua1KF5oel1S
         +xCw9GBJJqqQ/yp3KRlU5HYbNEX6oZZbloWupv66b8Gmua3K0hYA2jHoiWxXjvNRwq
         AXcgya9LgXHcg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so2821413a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 19:48:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YwHR6pIm+JxhVNIuQSII7tUUIQH3tlHpkcc8+KPWE9c257MIHb6
        iKm4BUJH2QjImNB6Rhd0o+U6HYCN7EaIeqVYTRk=
X-Google-Smtp-Source: AGHT+IHHJrOv7etXCufe5MYexC2R/ar0YERk9oUhukJTm0YaOv3zNAwX91pCk/3auUIH/dZW4AA5ZcAtrNbsYHKMwHw=
X-Received: by 2002:a05:6402:1859:b0:530:8a17:39e0 with SMTP id
 v25-20020a056402185900b005308a1739e0mr6630177edy.13.1696560499299; Thu, 05
 Oct 2023 19:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231001103433.3187-1-jszhang@kernel.org>
In-Reply-To: <20231001103433.3187-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 6 Oct 2023 10:48:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTROKwz01psgVES0Vq6G+krnYySW2BAXuHfhQHPsj-yFLw@mail.gmail.com>
Message-ID: <CAJF2gTROKwz01psgVES0Vq6G+krnYySW2BAXuHfhQHPsj-yFLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Sun, Oct 1, 2023 at 6:46=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> Previously, we use alternative mechanism to dynamically patch
> the CMO operations for THEAD C906/C910 during boot for performance
> reason. But as pointed out by Arnd, "there is already a significant
> cost in accessing the invalidated cache lines afterwards, which is
> likely going to be much higher than the cost of an indirect branch".
> And indeed, there's no performance difference with GMAC and EMMC per
> my test on Sipeed Lichee Pi 4A board.
>
> Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> the alternative code, and to acchieve Arnd's goal -- "I think
> moving the THEAD ops at the same level as all nonstandard operations
> makes sense, but I'd still leave CMO as an explicit fast path that
> avoids the indirect branch. This seems like the right thing to do both
> for readability and for platforms on which the indirect branch has a
> noticeable overhead."
>
> To make bisect easy, I use two patches here: patch1 does the conversion
> which just mimics current CMO behavior via. riscv_nonstd_cache_ops, I
> assume no functionalities changes. patch2 uses T-HEAD PA based CMO
> instructions so that we don't need to covert PA to VA.
Sorry, I didn't see your second patch. If you have used PA, just
ignore my previous reply.

>
> Hi Guo,
>
> I didn't use wback_inv for wback as you suggested during v1 reviewing,
> this can be left as future optimizations.
Okay. I just don't want sg2042 & th1520 to have a difference here.

>
> Thanks
>
> since v1:
>   - collect Tested-by tag
>   - add patch2 to use T-HEAD PA based CMO instructions.
>
> Jisheng Zhang (2):
>   riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
>   riscv: errata: thead: use pa based instructions for CMO
>
>  arch/riscv/Kconfig.errata            |  1 +
>  arch/riscv/errata/thead/errata.c     | 69 +++++++++++++++++++++++++++-
>  arch/riscv/include/asm/errata_list.h | 50 +++-----------------
>  3 files changed, 74 insertions(+), 46 deletions(-)
>
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
