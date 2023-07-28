Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3197676F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjG1UXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjG1UXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:23:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCAD4483
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:23:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso3310530a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690575810; x=1691180610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaL8vCWD2qZnjDMvOO1mSqawEYt68vZaybEyeqD8qzc=;
        b=iNa4V4wbqIB8YQAIu3YWecMdqgfDDBvx7YotKRvzxFMEkV1NPN9FFaahGfVAarwaAV
         kRJWDO6+avyfDWom2I0N3AENnd/ucA3n3b4Lmo9UgnRCWibEYgsywdeA1ZqkQqRmTlZh
         XV8dRItJxUnXX6LhTgM/AywiqSgw2XGInhu/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690575810; x=1691180610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaL8vCWD2qZnjDMvOO1mSqawEYt68vZaybEyeqD8qzc=;
        b=kIVOX4YYLFp/9cTcfYi/XiRwMDUa4XEAPyfHcdpd+R89rboXsEBIVENHRmWq1xROrh
         8/v2z8sbz4zy7f3EEFDeTXXnaaDWrROJcCnjWy0dqE9GGMWd0iWKMPOqXushHBCT8WO9
         fdKb+QY6sNS29jmZb3Rqd9U0dyO2AlGhenOQiCchN3pUNqg/KDcHwCszp+I2KMsZ50Bq
         v87CsKG1DFdysOVIq+3RgB5iLYv2N7IwaKoCv/RxjvL5QW17Bv4+mvWdgdSM3dzYKOiJ
         LY25dv5kFtKtHuf1+UoO0aMTMZPGVpllwUp4TBHzrlnpY8Ng9LY1y34KC+4+Fg1Y1nZW
         7kCA==
X-Gm-Message-State: ABy/qLZgkh2vnGvDQpJRYxtruVZ4UfUhxspFwIKsYx52GrMNCi7NUfyi
        F/X72WJZF8upqMFrGJw42/O8fhSmHXglvO8Mg/Bt0qez
X-Google-Smtp-Source: APBJJlHigtXRyVEV8ENaDW+HpguRA4tlcs/PT8wg8O2dQu/1MbIPumA/yk0kHLAbNY4lTajUuV7QIQ==
X-Received: by 2002:a05:6402:756:b0:522:561f:83c2 with SMTP id p22-20020a056402075600b00522561f83c2mr2513883edy.1.1690575809909;
        Fri, 28 Jul 2023 13:23:29 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id d7-20020a056402078700b005221ce96801sm2181181edy.35.2023.07.28.13.23.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 13:23:29 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso3310502a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:23:28 -0700 (PDT)
X-Received: by 2002:aa7:d507:0:b0:522:3a28:feca with SMTP id
 y7-20020aa7d507000000b005223a28fecamr2820293edq.24.1690575808575; Fri, 28 Jul
 2023 13:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com> <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
In-Reply-To: <ZMQZfn/hUURmfqWN@x1n>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 13:23:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
Message-ID: <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone fallout
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
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

On Fri, 28 Jul 2023 at 12:39, Peter Xu <peterx@redhat.com> wrote:
>
> But then does it means that any gup-only user will have numa balancing
> completely disabled?

Why would we ever care about a GUP-only user?

Who knows where the actual access is coming from? It might be some
device that is on a different node entirely.

And even if the access is local from the CPU, it

 (a) might have happened after we moved somewhere else

 (b) who cares about the extra possible NUMA overhead when we just
wasted *thousands* of cycles on GUP?

So NUMA balancing really doesn't seem to make sense for GUP anyway as
far as I can see.

Now, the other side of the same thing is that (a) NUMA faulting should
be fairly rare and (b) once you do GUP, who cares anyway, so you can
also argue that "once you do GUP you might as well NUMA-fault, because
performance simply isn't an issue".

But I really think the real argument is "once you do GUP, numa
faulting is just crazy".

I think what happened is

 - the GUP code couldn't tell NUMA and actual PROTNONE apart

 - so the GUP code would punch through PROTNONE even when it shouldn't

 - so people added FOLL_NUMA to say "I don't want you to punch
through, I want the NUMA fault"

 - but then FOLL_FORCE ends up meaning that you actually *do* want to
punch through - regardless of NUMA or not - and now the two got tied
together, and we end up with nonsensical garbage like

        if (!(gup_flags & FOLL_FORCE))
                gup_flags |= FOLL_NUMA;

   to say "oh, actually, to avoid punching through when we shouldn't,
we should NUMA fault".

so we ended up with that case where even if YOU DIDN'T CARE AT ALL,
you got FOLL_NUMA just so that you wouldn't punch through.

And now we're in the situation that we've confused FOLL_FORCE and
FOLL_NUMA, even though they have absolutely *nothing* to do with each
other, except for a random implementation detail about punching
through incorrectly that isn't even relevant any more.

I really think FOLL_NUMA should just go away. And that FOLL_FORCE
replacement for it is just wrong.  If you *don't* do something without
FOLL_FORCE, you damn well shouldn't do it just because FOLL_FORCE is
set.

The *only* semantic meaning FOLL_FORCE should have is that it
overrides the vma protections for debuggers (in a very limited
manner). It should *not* affect any NUMA faulting logic in any way,
shape, or form.

               Linus
