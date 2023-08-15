Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087F577D5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbjHOWXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbjHOWWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:22:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F269F1BFF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8235565888
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB00BC433CA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 22:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692138163;
        bh=kQSBRWBi8w3NAxb3/o0euE/FrGaiNTPbDxNlP/LaNTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T+x0AExMTGuhaCnbNNIZrNPCbPSkZVzKUX51iKYw7LBxASyPBZDj6oQFY+yJfA+Sf
         lliX17zYNC5gA5KKkneS45IwT+QAE1eqqrtAVTq+U4c9EGd85q7YPWwBp7jh2ShUw6
         BhDkuDG5qCYDh1Eq5MNzyZmMYNOFNBzAPnUfXGEZYFReI1LE+NRpUBG1thDqQqhLuC
         M2/pMRdWSci/F/pLMmdP+uQyHq6WGeOaxlK9XX6NNspCZ3gZNEfk4N3Qj9LCu/Buv7
         iinpn8RhwUjacs5JZWevz47sQGlcVJLudZvAEd62na90Xqp6O8EGnITbx/TYeNolvd
         quf39bVUn6h3Q==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-26813478800so3410108a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:22:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIQnoR4bvBUur6ANXAULsKLxqIRbkRohzsobeGAD+R9AjT9XdN
        p4gTYtp9eckmptegQs8v+Q0pWEgQ9TJrUArd4tskvg==
X-Google-Smtp-Source: AGHT+IF/dNJIIMvQuyTVMacyW9rpsylu/NyFQjBApDOSZmkpoRerh1lTCFDCtM0Li1lLVAIPNjaolCN28HdhuyYF/iU=
X-Received: by 2002:a17:90a:ea8f:b0:268:5c3b:6f28 with SMTP id
 h15-20020a17090aea8f00b002685c3b6f28mr10500439pjz.19.1692138163234; Tue, 15
 Aug 2023 15:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230620194644.3142384-1-yosryahmed@google.com>
 <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
 <CAJD7tkZ7dLwny7-CX7qCywZPtki+fDuESGfv+B9QG87cSsrHVQ@mail.gmail.com>
 <20230811141920.2f9bab6f21ab635ff1bd63ac@linux-foundation.org> <CAJD7tkbfKxCOoxNCgtbaAg4LXFbf=afaxei0SbKU2B=HFpPf6Q@mail.gmail.com>
In-Reply-To: <CAJD7tkbfKxCOoxNCgtbaAg4LXFbf=afaxei0SbKU2B=HFpPf6Q@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 15 Aug 2023 15:22:32 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPhP4q5ObisoyWZ0QdqUrTeNBec3P36PNz=KHLiXW6SrA@mail.gmail.com>
Message-ID: <CAF8kJuPhP4q5ObisoyWZ0QdqUrTeNBec3P36PNz=KHLiXW6SrA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: multiple zpools support
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Yosry,

On Fri, Aug 11, 2023 at 4:21=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Aug 11, 2023 at 2:19=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Thu, 13 Jul 2023 03:35:25 -0700 Yosry Ahmed <yosryahmed@google.com> =
wrote:
> >
> > > >
> > > > I'm experimenting with some other zswap changes - if I have
> > > > extra cycles and resources I'll try to apply this patch and see how=
 the
> > > > numbers play out.
> > >
> > > That would be amazing. Looking forward to any numbers you can dig :)
> >
> > So this patch seems stuck.  I can keep it in mm.git until the fog
> > clears, but would prefer not to.  Can we please revisit and decide on a
> > way forward?
>
> Johannes did not like a config option so I proposed it here as a
> constant (like SWAP_CLUSTER_MAX and others we have). This is a value
> that we have been using in our data centers for almost a decade, so it

I dug up the previous V1 discussion and this V3 discussion thread.
It seems obvious having multiple pools having locking contention advantage.
The number does not lie.

However the number of pools is hard to decide at compile time.

Regarding the per CPU pool. That might work well for a small number of CPUs=
.
When the system has many CPUs e.g. a few hundreds of CPUs. It means having
hundreds of pools which is  a bad idea.

How about just setting it as a run time value(size/bits) and can only
change pool
(size/bits) when zswap does not have any active stores.

Chris

> has seen a ton of testing. I was hoping Johannes would get time to
> take a look, or Nhat would get time to test it out, but neither of
> these things happen.
>
> I obviously want it to be merged, but hopefully someone will chime in her=
e :)
>
