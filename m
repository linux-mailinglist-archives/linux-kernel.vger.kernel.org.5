Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F57A62B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjISMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjISMWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:22:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432AE3;
        Tue, 19 Sep 2023 05:21:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16145C43395;
        Tue, 19 Sep 2023 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695126115;
        bh=Xr77RdjoeN0z20L00thV/A7rQAaSN7R1FHU4N7VjYYQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hj8hYfkAAndJs8H22CHLVDNHy1zD6xB6w3uANPxPprU0qLeHyjw6DSLsEJ9KSaaBx
         jq9z0gjpChuLF3L1SjmbjZIAQ14su7/S8qxmtt3n9UmZNg3nqDivH7mUxX+54h89fA
         E88A+xwaXh+78LyaGxDLimmulMnPgZI2rpuelygDehr7UMOqpQblZFIOlBI2sGH0GE
         7mWp5pZFiChwKP1ochLJSCqBFbdBpodJlMl2OF4z7uFIllARBDW4/23B4sn4eiF8Dn
         Uuh7hOlOXkRHox+mGHWmhMr1MEbPJ/c/A6QC2WZvQwRXeQ8Eg+GhTHJQpQyIAiKYGZ
         zAbzyB6UeKWeQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-502defbb0c3so9399049e87.0;
        Tue, 19 Sep 2023 05:21:54 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz97GgSSdb9M38+yJMLOPLrVyq+nke84j37IECzVR1JXVrBkglF
        eQUI2Cy4nv7eXBp+xmXzIHD4BfxtdBS1tL0m0A==
X-Google-Smtp-Source: AGHT+IGZ+q/CZ8ihPU+3vszfUTb3H1YpoJmvFyKP14El1bVcrpQgc78dAL/8ANG/qARJU9k7Bj0b4xbMgk+oHxzCckI=
X-Received: by 2002:a05:6512:3a8b:b0:500:b88c:ea79 with SMTP id
 q11-20020a0565123a8b00b00500b88cea79mr11710980lfu.54.1695126113262; Tue, 19
 Sep 2023 05:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230912121120.380420-1-robh@kernel.org> <20230912121120.380420-2-robh@kernel.org>
 <20230918100102.GA17472@willie-the-truck>
In-Reply-To: <20230918100102.GA17472@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Sep 2023 07:21:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLZTHsUuET0=MEF+1RC_+YqzcY5Ba9ztKJ3jX7K9hmcMw@mail.gmail.com>
Message-ID: <CAL_JsqLZTHsUuET0=MEF+1RC_+YqzcY5Ba9ztKJ3jX7K9hmcMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: errata: Add Cortex-A520 speculative
 unprivileged load workaround
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
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

On Mon, Sep 18, 2023 at 5:01=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Sep 12, 2023 at 07:11:15AM -0500, Rob Herring wrote:
> > Implement the workaround for ARM Cortex-A520 erratum 2966298. On an
> > affected Cortex-A520 core, a speculatively executed unprivileged load
> > might leak data from a privileged level via a cache side channel.
> >
> > The workaround is to execute a TLBI before returning to EL0. A
> > non-shareable TLBI to any address is sufficient.
>
> Can you elaborate at all on how this works, please?

Here's the write-up if you haven't read that already:

https://developer.arm.com/documentation/SDEN-2444153/0500/?lang=3Den

> A TLBI addressing a
> cache side channel feels weird (or is "cache" referring to some TLB
> structures rather than e.g. the data cache here?).

AIUI, the TLBI is simply enough to ensure the permission check happens
on the speculative load. It has nothing to do with actual TLB
contents.

This core has FEAT_E0PD and FEAT_CSV3 which should mitigate this
scenario, but this case is a narrow uarch condition which bypasses
those checks.

> Assuming there's some vulnerable window between the speculative
> unprivileged load and the completion of the TLBI, what prevents another
> CPU from observing the side-channel during that time?

The cache hit is private to the core. How would another core observe that?

> Also, does the
> TLBI need to be using the same ASID as the unprivileged load? If so, then
> a context-switch could widen the vulnerable window quite significantly.

No, the TLBI can be any context and/or address including unused addresses.

Rob
