Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33C7A89BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjITQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjITQrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:47:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D01AD;
        Wed, 20 Sep 2023 09:47:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6308C433C8;
        Wed, 20 Sep 2023 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695228469;
        bh=r30aIpQQhCZ4Z6suXNj6hTQWuZkVh/YVJ+fHWZJ6sQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fF8JZ9ACKhwCgLuGteyztXl/KlDWOzEfe2T3hkxdt9bYqiwgnokNcFdKhEi+menH8
         tULXp1XABocr2Xl+qPXnN/lZGHenoZL8k+yovjEwHb1+8AK8wlJSL7z4jPcyiOrC2J
         NTd+ZjSjfzeZplDBAFSzpTQNUuTXvBB5PFvCuhsyvgIdBcYc+AAS3J0v075JtyagtN
         nBI3jiTId2CBc+Jls9/aDqTBHOyRo1FvpkJ7hjCqHHniUuvLcTQ5mcJl+ZVpgRurb3
         yRFgY1+N+jWl2N8hEvlk/B9WxwRqt5YV8Vie72zpq21foU70HPf/nV3mqkAiqocv/K
         Qxyu2HLJB+Dug==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50335f6b48dso83983e87.3;
        Wed, 20 Sep 2023 09:47:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YwXPQkhys82Kh2Q5wOd6c1azMamqwBI/bJQf02u53usV5pjxBdm
        ALZ8FvgSo2GZH/95bIc89rrt3SN/KAESigjnpQ==
X-Google-Smtp-Source: AGHT+IGiTh+zc7qYXjKUQyoPg3HpMv3+MHhqTU1tl3azptdXxTWh6ldrFFQPGAtHCvEawv+9b+rjj03MynaXJqtGaiI=
X-Received: by 2002:a05:6512:329c:b0:503:3781:ac32 with SMTP id
 p28-20020a056512329c00b005033781ac32mr3030609lfe.41.1695228468007; Wed, 20
 Sep 2023 09:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230912121120.380420-1-robh@kernel.org> <20230912121120.380420-2-robh@kernel.org>
 <20230918100102.GA17472@willie-the-truck> <dcb12b18edc02634be3ac9909fa70602@misterjones.org>
 <CAL_JsqLXBDaAUKDjRCyiuZeR4khxKzN5Q2_LhUPg34YDGpjmGg@mail.gmail.com> <86zg1icop8.wl-maz@kernel.org>
In-Reply-To: <86zg1icop8.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 Sep 2023 11:47:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJsQaA4N6xGenzZ=P2r+PR=x=bcB8ikrJzrJOn1FgKYmA@mail.gmail.com>
Message-ID: <CAL_JsqJsQaA4N6xGenzZ=P2r+PR=x=bcB8ikrJzrJOn1FgKYmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: errata: Add Cortex-A520 speculative
 unprivileged load workaround
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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

On Tue, Sep 19, 2023 at 7:50=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Tue, 19 Sep 2023 13:29:07 +0100,
> Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Sep 18, 2023 at 5:18=E2=80=AFAM Marc Zyngier <maz@misterjones.o=
rg> wrote:
> > >
> > > On 2023-09-18 11:01, Will Deacon wrote:
> > > > On Tue, Sep 12, 2023 at 07:11:15AM -0500, Rob Herring wrote:
> > > >> Implement the workaround for ARM Cortex-A520 erratum 2966298. On a=
n
> > > >> affected Cortex-A520 core, a speculatively executed unprivileged l=
oad
> > > >> might leak data from a privileged level via a cache side channel.
> > > >>
> > > >> The workaround is to execute a TLBI before returning to EL0. A
> > > >> non-shareable TLBI to any address is sufficient.
> > > >
> > > > Can you elaborate at all on how this works, please? A TLBI addressi=
ng a
> > > > cache side channel feels weird (or is "cache" referring to some TLB
> > > > structures rather than e.g. the data cache here?).
> > > >
> > > > Assuming there's some vulnerable window between the speculative
> > > > unprivileged load and the completion of the TLBI, what prevents ano=
ther
> > > > CPU from observing the side-channel during that time? Also, does th=
e
> > > > TLBI need to be using the same ASID as the unprivileged load? If so=
,
> > > > then
> > > > a context-switch could widen the vulnerable window quite significan=
tly.
> > >
> > > Another 'interesting' case is the KVM world switch. If EL0 is
> > > affected, what about EL1? Can such a data leak exist cross-EL1,
> > > or from EL2 to El1? Asking for a friend...
> >
> > I'm checking for a definitive answer, but page table isolation also
> > avoids the issue. Wouldn't these scenarios all be similar to page
> > table isolation in that the EL2 or prior EL1 context is unmapped?
>
> No, EL2 is always mapped, and we don't have anything like KPTI there.
>
> Maybe the saving grace is that EL2 and EL2&0 are different translation
> regimes from EL1&0, but there's nothing in the commit message that
> indicates it. As for EL1-to-EL1 leaks, it again completely depends on
> how the TLBs are tagged.

Different translation regimes are not affected. It must be the same
regime and same translation.

> You'd hope that having different VMIDs would save the bacon, but if
> you can leak EL1 translations into EL0, it means that the associated
> permission and/or tags do not contain all the required information...

The VMID is part of the equation. See here[1].

Rob

[1] https://developer.arm.com/documentation/102517/0001/Memory-management/T=
ranslation-Lookaside-Buffer-match-process?lang=3Den
