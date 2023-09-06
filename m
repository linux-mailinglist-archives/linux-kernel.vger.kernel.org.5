Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A6794438
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbjIFUD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbjIFUDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:03:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5847198B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:02:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2A8C433C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694030579;
        bh=hCqaMIdEhA3SmQiyjnQL0J1feZ7iNwMgpH2jY9OGPFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sJk4Ca1ssfhyjPB6xxlcYJ6s+A6neb3RM51oG9xKmBjRYoOdX7BxMclDNQZWMFtFd
         SZp/dScsLE4RWhKLVIZ8sgbfht43vkgERV+bXclDVtl42VgV854GlicP8rCjNoXK1j
         ZaoTW1wGl4dn83BdqkwfxPBAuKfLTDlMEJQ+LCLQrgU3W8utzAOTWMvjngN+ZoGHl8
         xXa+NqGPFQJgLqbvLJWzTw0gDx5NHs03MqbJwUVFFACWfukZg0LMNcBKWCgeJUBszI
         29LTP3qkvPhhQ0zHCbT7idnOn3VD9ZoePZqgKgtdfM1CcD3FlPrg6TLXp4ldc/OOVR
         eMgFgV5xk8KCw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso4370721fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 13:02:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YwRnCeB+6qOIfIlin06Xn3534+8O0Nu6HTeOaAmZxJT8xCKRJwU
        zYhaKLFY0Nor61Z0nNf8iP8mbdR/mrje0CP4zWA=
X-Google-Smtp-Source: AGHT+IFbajcCeDBKX5gcqTUxjF6xdaFSmClHG9Ht+RBgZ1BZCOfexCILTUy/DJyVAWif1cTMIKLf0yLHONMVZ/rD+Q4=
X-Received: by 2002:a2e:90d6:0:b0:2b9:412a:111d with SMTP id
 o22-20020a2e90d6000000b002b9412a111dmr3495356ljg.42.1694030577468; Wed, 06
 Sep 2023 13:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230906175215.2236033-1-song@kernel.org> <20230906195814.GE28278@noisy.programming.kicks-ass.net>
In-Reply-To: <20230906195814.GE28278@noisy.programming.kicks-ass.net>
From:   Song Liu <song@kernel.org>
Date:   Wed, 6 Sep 2023 13:02:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4eGj7ByybEF3c_fURys367U3_gyF_Y5zpsnKUtiqOr+Q@mail.gmail.com>
Message-ID: <CAPhsuW4eGj7ByybEF3c_fURys367U3_gyF_Y5zpsnKUtiqOr+Q@mail.gmail.com>
Subject: Re: [PATCH] x86/vmlinux: Fix linker fill bytes for ld.lld
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
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

On Wed, Sep 6, 2023 at 12:58=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Sep 06, 2023 at 10:52:15AM -0700, Song Liu wrote:
> > With ":text =3D0xcccc", ld.lld fills unused text area with 0xcccc0000.
> > Example objdump -D output:
> >
> > ffffffff82b04203:       00 00                   add    %al,(%rax)
> > ffffffff82b04205:       cc                      int3
> > ffffffff82b04206:       cc                      int3
> > ffffffff82b04207:       00 00                   add    %al,(%rax)
> > ffffffff82b04209:       cc                      int3
> > ffffffff82b0420a:       cc                      int3
> >
> > Replace it with ":text =3D0xcccccccc", so we get the following instead:
> >
> > ffffffff82b04203:       cc                      int3
> > ffffffff82b04204:       cc                      int3
> > ffffffff82b04205:       cc                      int3
> > ffffffff82b04206:       cc                      int3
> > ffffffff82b04207:       cc                      int3
> > ffffffff82b04208:       cc                      int3
> >
> > gcc/ld doesn't seem to have the same issue. The generated code stays th=
e
> > same for gcc/ld.
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: x86@kernel.org
> > Signed-off-by: Song Liu <song@kernel.org>
>
> Please provide a Fixes tag, I'm thinking this (otherwise trivial commit)
> wants to be backported for sanity.

I guess we need:

Fixes: 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker
fill bytes")

Thanks,
Song

>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
