Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97BB7A62EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjISM33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjISM31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:29:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758BF9;
        Tue, 19 Sep 2023 05:29:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECCC43395;
        Tue, 19 Sep 2023 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695126561;
        bh=5VORfjBKt407PuE1DSiCwSrwx82eCmS4Ql34Bu25t14=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EBAM0vgJd9vu7RGQiUjMHcwX2JjusZDYcektrrv5NJ65UIHA/gof7kwyb31nUSyIv
         usI4p1XcZKezcmVHM1WCfhjDPKYKtyzfmvButeheNRz+wauBFnA5tVwnsBD68XgPbj
         r8QB+/tVUO8qB4/WDhcflw27liI8KeS3D9ytohxL7kBIU6pqq5k3x+3dzlP5/71ilf
         F5VAGUgHLHimNDoN+6roJBFLswEHhOxMVIU5zjrCQF7qmieFHpnaVBGMzbVcgypWQa
         G15p5DZI4d29knhUKAzAQ+d8SFAKDusDb/EQ/k63GkzCAK5EG3+bZc22Y6Z2YVHt9p
         tgWHNFavZHrLQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-501eec0a373so9138812e87.3;
        Tue, 19 Sep 2023 05:29:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yye1+w9DXFBNc8eFUxjKX36/AmXATc9iFSs/01HFurjK4mZdoij
        /WoeHqXNLJ4+zlJT/Ku+Xf1Z6p8TM14N1w7e0A==
X-Google-Smtp-Source: AGHT+IEVLojBsxIJobP2x2i35bqsGfF/aglol6AshwsOiJioUvgL9J61LpQzeoKrAcrBapWfOYZng1uiqWFZjhtk2Dk=
X-Received: by 2002:ac2:4c27:0:b0:500:a6c1:36f7 with SMTP id
 u7-20020ac24c27000000b00500a6c136f7mr9217639lfq.3.1695126559638; Tue, 19 Sep
 2023 05:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230912121120.380420-1-robh@kernel.org> <20230912121120.380420-2-robh@kernel.org>
 <20230918100102.GA17472@willie-the-truck> <dcb12b18edc02634be3ac9909fa70602@misterjones.org>
In-Reply-To: <dcb12b18edc02634be3ac9909fa70602@misterjones.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Sep 2023 07:29:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLXBDaAUKDjRCyiuZeR4khxKzN5Q2_LhUPg34YDGpjmGg@mail.gmail.com>
Message-ID: <CAL_JsqLXBDaAUKDjRCyiuZeR4khxKzN5Q2_LhUPg34YDGpjmGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: errata: Add Cortex-A520 speculative
 unprivileged load workaround
To:     Marc Zyngier <maz@misterjones.org>
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

On Mon, Sep 18, 2023 at 5:18=E2=80=AFAM Marc Zyngier <maz@misterjones.org> =
wrote:
>
> On 2023-09-18 11:01, Will Deacon wrote:
> > On Tue, Sep 12, 2023 at 07:11:15AM -0500, Rob Herring wrote:
> >> Implement the workaround for ARM Cortex-A520 erratum 2966298. On an
> >> affected Cortex-A520 core, a speculatively executed unprivileged load
> >> might leak data from a privileged level via a cache side channel.
> >>
> >> The workaround is to execute a TLBI before returning to EL0. A
> >> non-shareable TLBI to any address is sufficient.
> >
> > Can you elaborate at all on how this works, please? A TLBI addressing a
> > cache side channel feels weird (or is "cache" referring to some TLB
> > structures rather than e.g. the data cache here?).
> >
> > Assuming there's some vulnerable window between the speculative
> > unprivileged load and the completion of the TLBI, what prevents another
> > CPU from observing the side-channel during that time? Also, does the
> > TLBI need to be using the same ASID as the unprivileged load? If so,
> > then
> > a context-switch could widen the vulnerable window quite significantly.
>
> Another 'interesting' case is the KVM world switch. If EL0 is
> affected, what about EL1? Can such a data leak exist cross-EL1,
> or from EL2 to El1? Asking for a friend...

I'm checking for a definitive answer, but page table isolation also
avoids the issue. Wouldn't these scenarios all be similar to page
table isolation in that the EL2 or prior EL1 context is unmapped?

Rob
