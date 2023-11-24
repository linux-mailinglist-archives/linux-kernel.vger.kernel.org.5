Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD557F8552
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjKXU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjKXU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:56:07 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496891990
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:56:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507f1c29f25so3177943e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700859371; x=1701464171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcqIC0fmV/ll00aBVxgC4uh4E/Og3q6vGO7ezMrCe/8=;
        b=ahVc17fzEQ9gDWbk7QVVion6uqFTjO2zK89VFBUk5isVFOMbvkFpH8VHzy/IxqruU7
         Po3f9BYtRi8K8mcJtL4muJxjfGZYhq/S1Dp3WqebwO4HCB1dtSCHAe9SePatl2H1UfXg
         ceQPJY8gTrfQkhKc/4MkErrHtr3OeLnr6JKwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700859371; x=1701464171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcqIC0fmV/ll00aBVxgC4uh4E/Og3q6vGO7ezMrCe/8=;
        b=psuZ1yHEdN3VcJPEIoeLzlwMW4qwy6IPd6gq1r5vjOU5oVfPfrFw7LEuD/b+IZPN3m
         vQPpwlN8rFL1trz6F4ip8ccx3dldiy3zW9/41FipHx8qwlb721mpSTlwsCFYMzgud73n
         H5kdhFtMgL7yHt9QSG1XRY2mkzxQPLacVX3/rTkvLR9xaLKQpxfoZFw8AUcI2Kuc3KD3
         MEJCrFa0cfMyIIPRH1LW33KMYRysbsEai8jzPIPLNCft4DB+EE/JpXXwfrJS9rex/coO
         rv3YHKyjG38ra+dxU/51Bt0a/X3wnDHtm8GpkkmhamzMWVCq6YlhxQc9ZdKn2YB3kj3I
         q/wQ==
X-Gm-Message-State: AOJu0YyaKSwTP5yfiMqys/OPC8bd65ksMoh0rDBV5EMn5h3YNWg7GiTm
        ywkuhe0zqv2r8RRWKB9lzJo0GsFyGW+tuidO8GAm8C4q
X-Google-Smtp-Source: AGHT+IFM4sFr1g9HPNQy2JGF0RoTbf7T2irJxew/Mag3AlQbG3FR10Iuxa82FpxLkx6gMy549pKGDg==
X-Received: by 2002:a05:6512:3daa:b0:503:1722:bf3a with SMTP id k42-20020a0565123daa00b005031722bf3amr3848492lfv.1.1700859370964;
        Fri, 24 Nov 2023 12:56:10 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906218900b00a0988d69549sm1020473eju.189.2023.11.24.12.56.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 12:56:10 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-548a2c20f50so3168215a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:56:10 -0800 (PST)
X-Received: by 2002:a50:ba88:0:b0:54a:f455:50a4 with SMTP id
 x8-20020a50ba88000000b0054af45550a4mr2933261ede.20.1700859369812; Fri, 24 Nov
 2023 12:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20231124132626.235350-1-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Nov 2023 12:55:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgFRaS9FLJZEv0pbASVJ8rPSrTWHkYTmj83vRJh9Ehepw@mail.gmail.com>
Message-ID: <CAHk-=wgFRaS9FLJZEv0pbASVJ8rPSrTWHkYTmj83vRJh9Ehepw@mail.gmail.com>
Subject: Re: [PATCH WIP v1 00/20] mm: precise "mapped shared" vs. "mapped
 exclusively" detection for PTE-mapped THP / partially-mappable folios
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 05:26, David Hildenbrand <david@redhat.com> wrote:
>
> Are you interested in some made-up math, new locking primitives and
> slightly unpleasant performance numbers on first sight? :)

Ugh. I'm not loving the "I have a proof, but it's too big to fit in
the margin" model  of VM development.

This does seem to be very subtle.

Also, please benchmark what your rmap changes do to just plain regular
pages - it *looks* like maybe all you did was to add some
VM_WARN_ON_FOLIO() for those cases, but I have this strong memory of
that

        if (likely(!compound)) {

case being very critical on all the usual cases (and the cleanups by
Hugh last year were nice).

I get the feeling that you are trying to optimize a particular case
that is special enough that some less complicated model might work.

Just by looking at your benchmarks, I *think* the case you actually
want to optimize is "THP -> fork -> child exit/execve -> parent write
COW reuse" where the THP page was really never in more than two VM's,
and the second VM was an almost accidental temporary thing that is
just about the whole "fork->exec/exit" model.

Which makes me really feel like your rmap_id is very over-engineered.
It seems to be designed to handle all the generic cases, but it seems
like the main cause for it is a very specific case that I _feel_
should be something that could be tracked with *way* less information
(eg just have a "pointer to owner vma, and a simple counter of
non-owners").

I dunno. I was cc'd, I looked at the patches, but I suspect I'm not
really the target audience. If Hugh is ok with this kind of
complexity, I bow to a higher authority. This *does* seem to add a lot
of conceptual complexity to something that is already complicated.

           Linus
