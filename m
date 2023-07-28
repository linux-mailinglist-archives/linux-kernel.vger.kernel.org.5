Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B0767734
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjG1Uu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjG1UuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:50:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8CC30DA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:50:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31765792c7cso2627959f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690577422; x=1691182222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E17cPNd2JHzAg3XLoM3Zw1DUtM3X2m+hWgsCVuqmSVk=;
        b=W/LbinD4Enfk+95f1i9+07bWEIlxhNOTGdsSp2hvp+q9c+rQOMicWs73b9Wav3eRi4
         i+0mpmlDo82O4Uv72peL1MmBNa65WF7ZTBM/hcm86AWEdA8cQBljEK56rYh9QIHQQXqv
         U7yCW/iA41LuPgI06QQPzMk7IKzj0+nxu+Hu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690577422; x=1691182222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E17cPNd2JHzAg3XLoM3Zw1DUtM3X2m+hWgsCVuqmSVk=;
        b=BKmD0XaAU+Gdl3S3rZme6oZDysXhUF8/kgc/YiYjTW1cYQs//guCm2EjkMJoOdznwk
         dTwG2sBkLssV0tdGTTiotPqsZgu5cJyXlEjBSU6DZYUIZntRYK6tpHP1gz3AbZZDxIvO
         6yTcZrgEGXq5gvX655MsdCwhrG/G62pu1/ysLHz40fPET1NuXQJxxeLayRx9vSJoc41L
         ZBfTAUdISxOcJH/ZTebiBMiP4rR23UvmbBOQnnspjuf3bYc6S1tf7NVIBH6ybnYcJCD5
         5TGjNab6Y50ej5XZmGnIY6KUGryUKT3lk0nR3oXyb24507DpDogmCO8AV9bFhz0tjPZN
         tCpA==
X-Gm-Message-State: ABy/qLZn8T9uHNHjO/HbVv1VVuWoN7F2YvhjuWIFnmT9rU8em7pAhtwc
        nFhmwgOOhfs/xShw+fpCSL5X7rOpPipUkrP6AC+3U4y4
X-Google-Smtp-Source: APBJJlGp6PR1WAaO58P6TqA6TXOzbvctIWGBzI+qzlMu4p6sCJvfjO48Bn4DAZyXsaptpnPMmcBJmA==
X-Received: by 2002:adf:f148:0:b0:314:3a4b:6cc6 with SMTP id y8-20020adff148000000b003143a4b6cc6mr2513134wro.53.1690577422501;
        Fri, 28 Jul 2023 13:50:22 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906c30400b009926928d486sm2433402ejz.35.2023.07.28.13.50.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 13:50:21 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so565384a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:50:21 -0700 (PDT)
X-Received: by 2002:aa7:dcc6:0:b0:51e:2a1b:6de with SMTP id
 w6-20020aa7dcc6000000b0051e2a1b06demr2181151edu.40.1690577420993; Fri, 28 Jul
 2023 13:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com> <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n> <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
In-Reply-To: <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 13:50:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
Message-ID: <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone fallout
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 13:33, David Hildenbrand <david@redhat.com> wrote:
>
> So would you rather favor a FOLL_NUMA that has to be passed from the
> outside by selected callers or a FOLL_NUMA that is set on the GUP path
> unconditionally (but left clear for follow_page())?

I'd rather see the FOLL_NUMA that has to be set by odd cases, and that
is never set by any sane user.

And it should not be called FOLL_NUMA. It should be called something
else. Because *not* having it doesn't disable following pages across
NUMA boundaries, and the name is actively misleading.

It sounds like what KVM actually wants is a "Do NOT follow NUMA pages,
I'll force a page fault".

And the fact that KVM wants a fault for NUMA pages shouldn't mean that
others - who clearly cannot care - get that insane behavior by
default.

The name should reflect that, instead of being the misleading mess of
FOLL_FORCE and bad naming that it is now.

So maybe it can be called "FOLL_HONOR_NUMA_FAULT" or something, to
make it clear that it's the *opposite* of FOLL_FORCE, and that it
honors the NUMA faulting that nobody should care about.

Then the KVM code can have a big comment about *why* it sets that bit.

Hmm? Can we please aim for something that is understandable and
documented? No odd implicit rules. No "force NUMA fault even when it
makes no sense". No tie-in with FOLL_FORCE.

                 Linus
