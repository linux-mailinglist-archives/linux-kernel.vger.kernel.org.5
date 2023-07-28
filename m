Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD12766C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjG1MCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjG1MCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195A49C5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F301761FCB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A397C433CA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690545680;
        bh=1/UmSwM6laJjJfl4c22BmZn/PgYb/NIjRBj/+WbLxQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z2p3bhYsstCSQsrPUJCbWGlQ2i6kpqJ0Fgg4FM3ctamG5M/FXKhAVcumBbAA4UiBI
         Sx+1fM38CqIrmm60Le7zvWq2YVIn40945jHMWe9v2RUAfB+epAqqApjLQhtcFswMmM
         v1oWZhY47beNRmDO+ZkwQRzquAyUJKaudxEEmrQGvDihmBrOM2aRq964rr73+wl70b
         iu4tnKSBOg9kkmBM2ugrGZSc5MjbwX4fse53lBcDGYB/f6c20CdH0SCM8PX+slLXci
         VJVwqoBM4f9klYGxey8ilhohL6solprr8oQzksDiRGkkL2/B9/+Vdif5YO1LwQdl9S
         ZG0/PPeqXvL9Q==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so2665292a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:01:20 -0700 (PDT)
X-Gm-Message-State: ABy/qLZeiye0bhe+C8WkSJkj/vOxxikTP4ZNVz3oc1xfak2XOUBPCJdW
        +dcmS0V8VGa9NOAnNETlXZpVeW1nwZy1/kUl2Lk=
X-Google-Smtp-Source: APBJJlHEfyGgPAYcqNOw6srjukfIwgKqw571Tya4scu1+5ZCK644utqy+5IG6h2ZfO/GZRfPCw5Jtm8FNa+Bpo1QA2Y=
X-Received: by 2002:aa7:da81:0:b0:522:2f8c:8953 with SMTP id
 q1-20020aa7da81000000b005222f8c8953mr1454781eds.39.1690545678516; Fri, 28 Jul
 2023 05:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221124094845.1907443-1-debug@rivosinc.com> <20230720001852.GA572618@google.com>
 <CAJF2gTRFvSvEvQeDugdp73o7w4ArdtQ99JScEbLkaLnFcftVcA@mail.gmail.com> <CABCJKueNhc8qCbZbHJqdCB+PHHy0u5ETP4uWfpWBRaOMX6U6hA@mail.gmail.com>
In-Reply-To: <CABCJKueNhc8qCbZbHJqdCB+PHHy0u5ETP4uWfpWBRaOMX6U6hA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 28 Jul 2023 20:01:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTThgCp8-KzghR0cFqDWXxZ2byLtLVF91GdRvBid7U+_aA@mail.gmail.com>
Message-ID: <CAJF2gTThgCp8-KzghR0cFqDWXxZ2byLtLVF91GdRvBid7U+_aA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Deepak Gupta <debug@rivosinc.com>, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:34=E2=80=AFAM Sami Tolvanen <samitolvanen@google=
.com> wrote:
>
> On Thu, Jul 20, 2023 at 8:06=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Thu, Jul 20, 2023 at 8:19=E2=80=AFAM Sami Tolvanen <samitolvanen@goo=
gle.com> wrote:
> > >
> > > Are you planning on resending this patch? I see it didn't gain much
> > > traction last time, but this looks like a much cleaner solution for
> > > selecting the overflow stack than having a `shadow_stack` and calling
> > > to C to compute the per-CPU offset. The asm_per_cpu macro also would
> > > come in handy when implementing CONFIG_SHADOW_CALL_STACK, which we'd
> > > like to have on RISC-V too.
> > I remember we ended up with an atomic lock mechanism instead of percpu
> > offset, so what's the benefit of percpu style in overflow_stack path?
>
> The benefit is not needing a separate temporary stack and locks just
Oh, you convinced me it could save another 1KB of memory.

Acked-by: Guo Ren <guoren@kernel.org>

> to compute the per-CPU offset. With CONFIG_SHADOW_CALL_STACK, we would
> also need a "shadow" shadow call stack in this case before calling to
> C code, at which point computing the offsets directly in assembly is
> just significantly cleaner and without concurrency issues.
>
> Sami



--=20
Best Regards
 Guo Ren
