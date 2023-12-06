Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875F28079F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379551AbjLFVB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjLFVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:01:54 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1926D5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:02:00 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4258b6df295so69461cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701896520; x=1702501320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yifCF1VbJnELrR9rcLxOhPbVYwLPVD7PFjDkqvqydCg=;
        b=SqfmM9oOYCwZr/o9UFclMIc2wq/rrtfKLcWYc33j3TVGbzDQuj5Yyjze6a0tZlHrMV
         lln7RQwS5sP6YIbYe/Uu9VnLNFZo+o3Z5DIo3LpTyfy0/WFD+w+zuO+pDjyh/UN8uknM
         YcmNBFVl8N6k73BYrBYcW1uJHisloMZtxeUjQR4Bcg5GOQkziCuAXC8V/pz8jDcPYyvb
         0TAXW+9bwramEMiqv+jI7Ixi7q1XUADE6y/4hRID4ML+y6mijpYaRWlofhAmccgFI0HC
         PfcmNfF4tvUecTdsQ1UYgpFgYUd9HZPAr3RW4M6awKVr9Zjr+1o1plHUWK4YRXRGbJk5
         c7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896520; x=1702501320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yifCF1VbJnELrR9rcLxOhPbVYwLPVD7PFjDkqvqydCg=;
        b=eXj/+hzmqGkgyWq9NGkHaO/8C3S5N8Qb1cTJVkPuA5JoMOaKDJl0tw5XEG6+aSiLcC
         sWV5qj1LfzbvLxCb6rOKfIRr52E13SIN3TKsh6YnfHxrMshCYsLvbW9uFhnjpWvhZNq3
         9Rk4MKGHom0xHqiNXv/9lEw99RW0FJdbW/RLBQ4DLJWCmlExOmh6ev0JZxvJbTZKQIuf
         RqFNWL8PTK8LxPUg24F+gSbkYFyEMT0bPmiWg3wZOpFpiCHHxE/VL2UvGa7im3DKQjdD
         yHtJAl2jsFOvJRsEOnJm18dIr8QYjnlQBSeoGpNtdDlG0NITD4h5R97yr7SrODzJS1/p
         awlA==
X-Gm-Message-State: AOJu0Yw0uyr73iObk849Un03SxsnnX7js9Hn06MDQgT59GHrhM4dF5G3
        Yl2a4q9r0bCfHSyQqIMiBhmljoadb5nEEiyLIoFDSg==
X-Google-Smtp-Source: AGHT+IGiFrc38Sccv4CjPvOU0r5lMittiKYasKUKiimaBSSAotEQ8KyvklYRY2AzbCNblYSa2sS7+oRyO2pSpnPgxy0=
X-Received: by 2002:a05:622a:509:b0:423:d767:1486 with SMTP id
 l9-20020a05622a050900b00423d7671486mr451366qtx.28.1701896519956; Wed, 06 Dec
 2023 13:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20231204172646.2541916-1-jthoughton@google.com>
 <70dcdad7-5952-48ce-a9b9-042cfea59a5d@arm.com> <CADrL8HVNBD=5akoTi3e0d6w=162Wak2cB2bc7jwQ8-DCAC4N1Q@mail.gmail.com>
 <54be0bd1-9397-4b7c-9b3c-6680c5d4c248@arm.com>
In-Reply-To: <54be0bd1-9397-4b7c-9b3c-6680c5d4c248@arm.com>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 6 Dec 2023 13:01:23 -0800
Message-ID: <CADrL8HUH8BoNRNuO1rGCjNMEdj-TDVvCg7GCpTPzNkHjuCsc1w@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: hugetlb: Fix page fault loop for
 sw-dirty/hw-clean contiguous PTEs
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Steve Capper <steve.capper@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 2:24=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 05/12/2023 17:54, James Houghton wrote:
> > On Tue, Dec 5, 2023 at 6:43=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> > Thanks for pointing this out. So (1) is definitely a bug. The second
> > patch in this series makes it impossible to create such a PTE via
> > pte_modify (by forcing sw-dirty PTEs to be hw-dirty as well).
>
> Yes; I think the second patch should be sufficient; I took a quick look a=
t the
> other helpers and I don't see anything else that could get the PTE to the
> invalid state.
>
> I have a series that starts using the contpte bit for (multi-size) THP
> opportunistically. This bug will affect that too I think. Your patch #2 w=
ill fix
> for both hugetlb and my series. I'd rather not apply an equivalent to you=
r patch
> #1 because its not quite as straightforward in my code path. But I'm pret=
ty
> confident that patch # is all that's needed here.

There is no need to apply a patch #1-equivalent for multi-size THPs.
:) If multi-size THP has the same problem as HugeTLB, patch #2 will
fix it too. I don't think multi-size THP has the equivalent problem --
in fact, I'm not sure how multi-size THP keeps the PTE_DIRTY,
PTE_WRITE (DBM), and the PTE_RDONLY bits in sync (they do need to be
in-sync with each other when the contiguous bit is being used,
right?).

I included patch #1 (with cc:stable) because it's a more direct fix
for HugeTLB that might be slightly easier to backport. If you think
that patch #1 should be dropped and patch #2 should be backported,
please let me know.

Thanks for the review!
