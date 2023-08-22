Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C128784C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjHVVe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHVVez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAD9CDF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9607C65007
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE2C43391
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692740093;
        bh=sTYLGwr0V50j9YnnrrFQseiF978eUCHUgXKQmpVIZns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PVLkMFsRPSng2FPiib+3A6/61y4RNXym38RbIxPyW9HbZZ2BJrVjeJLHLtHOBpEY1
         wrBURY9+7Kn8oyi0dg9R85SUcsm1iFwfhF8Bm6+qbTcTOzz7d562p9v6LK3ckfM+kk
         +g29Z8Aoyiffdhft5NMxos7re6bdTWSWfQ5MP0hy3nDEktNARXtG7FaBdAwxuxfwIk
         AH+SjMCv+9/yLWmMZQMuSibDL3fU6Aaq/KrEpcO5ujfIVc62x9qLo7iwyq2u8mEi9A
         HvzshaU8OSTHlCcNRh03Lf1zyMB69PwdQ/fG+wZOckEgpo1r85pHkADugfPwNpzu7J
         IFo+ea/o50uGw==
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-26d0d376ec7so3419802a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:34:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YwCP6WLGYxHORc56i/ddIK4UTmoIcUkde0HEQQ0h2EutWvN390P
        AZ7C2qNVlTq6mZ9qHYRF2G/bI1izC5CW3rxF/YxHXQ==
X-Google-Smtp-Source: AGHT+IEwDfiGO2rg580SUkha4C61Urqu/4xsS9urJUgNFjE1IJe5veyMKjckIFs0eYSbW2YruYsw4F7W6od0vHPoAPI=
X-Received: by 2002:a17:90a:fc8e:b0:26d:416a:d9d2 with SMTP id
 ci14-20020a17090afc8e00b0026d416ad9d2mr9625027pjb.45.1692740092376; Tue, 22
 Aug 2023 14:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net> <CAF8kJuOsWo5RfDcfnWZfnqYXjf6bkkxdXG1JCwjaEZ1nn29AaA@mail.gmail.com>
 <CAADnVQKzzj4f-FPPqmnvMttc=_v7ZXmitc2wgNM0bJpm9FcpsQ@mail.gmail.com>
In-Reply-To: <CAADnVQKzzj4f-FPPqmnvMttc=_v7ZXmitc2wgNM0bJpm9FcpsQ@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 22 Aug 2023 14:34:40 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOFcVsAWt_sMKvSgw_vpikX0-+T4388pJn_F2-2sW_4Kg@mail.gmail.com>
Message-ID: <CAF8kJuOFcVsAWt_sMKvSgw_vpikX0-+T4388pJn_F2-2sW_4Kg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Sperbeck <jsperbeck@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
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

Hi Alexei,

On Tue, Aug 22, 2023 at 11:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 10:48=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > Hi Mel,
> >
> > Adding Alexei to the discussion.
> >
> > On Mon, Aug 21, 2023 at 3:32=E2=80=AFAM Mel Gorman <mgorman@techsingula=
rity.net> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 11:05:22PM -0700, Chris Li wrote:
> > > > In this patch series I want to safeguard
> > > > the free_pcppage_bulk against change in the
> > > > pcp->count outside of this function. e.g.
> > > > by BPF program inject on the function tracepoint.
> > > >
> > > > I break up the patches into two seperate patches
> > > > for the safeguard and clean up.
> > > >
> > > > Hopefully that is easier to review.
> > > >
> > > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > >
> > > This sounds like a maintenance nightmare if internal state can be arb=
itrary
> > > modified by a BPF program and still expected to work properly in all =
cases.
> > > Every review would have to take into account "what if a BPF script mo=
difies
> > > state behind our back?"
>
> Where did this concern come from?
> Since when BPF can modify arbitrary state?
>
> But I wasn't cc-ed on the original patch, so not sure what it attempts to=
 do.
> Maybe concern is valid.

Sorry I did not CC you on the original patch submission.  I should.

Here is the link for the 1/2 patch, which has the step to reproduce.

https://lore.kernel.org/linux-mm/20230817-free_pcppages_bulk-v1-1-c14574a9f=
80c@kernel.org/

It is using an older version of the BPF program. That spinlock
allocation was fixed
in  commit c66a36af7ba3a628.

Chris


>
> > Thanks for the feedback.
> >
> > I agree that it is hard to support if we allow BPF to change any intern=
al
> > stage as a rule.  That is why it is a RFC. Would you consider it case
> > by case basis?
> > The kernel panic is bad, the first patch is actually very small. I can
> > also change it
> > to generate warnings if we detect the inconsistent state.
>
> panic and warns because of bpf prog?!


> bpf infra takes all the precaution to make sure that bpf progs
> can never cause such damage.
>
> >
> > How about the second (clean up) patch or Keming's clean up version? I c=
an modify
> > it to take out the pcp->count if the verdict is just not supporting
> > BPF changing internal
> > state at all. I do wish to get rid of the pindex_min and pindex_max.
> >
> > Thanks
> >
> > Chris
>
