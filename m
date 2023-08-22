Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57746784C03
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjHVV3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjHVV3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:29:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D771ACEC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7327864784
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6E7C433A9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692739783;
        bh=+E/v1Yg2nZID3Pl0uyib8D26RMJvBa7TzNDSOx1oSPg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uimEdM7vXwYpRzna3gxTOky9Det48dCxMOcfkB7cROuFOXUE2Q67pdlbzhK1mni21
         u8TCHipG8NnnwAGr8fTDHq9itfTa+obTLhVBEDyFnnwSmLs+yxF4a4dk/F4c+XmcSo
         CuBtx/oLfaxdEkKiZOu4YEuUTgLA/0zxE5pA50Yd8gy6pwuuBJFSnVYHF3Fd9sWIFj
         /xgExlZk19+tuAgQfSl/P/Tghf7Nog565u+3ts5wQsOFEUJowsniV5ECI1bE+BIRZ9
         Ihh6S9WrQZSShGsSVgTZf7jDw+sda8cPvqK0VyrfUluquszxJW/FIECZrtABnsTfGd
         s7HBOvJ9p9uPQ==
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-56b0c5a140dso2118528a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:29:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YzXUISZFu0H/m4XfalV0wRwBmTFOuD4fYhgiSEy8ZZ273CVJPUa
        JM99tS04CClBcfbb+1rBLL2brDrVWBIxjI+4V9WMhg==
X-Google-Smtp-Source: AGHT+IFIB0swyM8xpWhGkUVLGS7gqygBk2T2nO7KRZ+WwvtmrgSp7uuvmlZuRqTG2CCPsbQMfQOIk22cdDciqnH1Q9o=
X-Received: by 2002:a17:90b:14d:b0:262:f449:4497 with SMTP id
 em13-20020a17090b014d00b00262f4494497mr10119014pjb.2.1692739783071; Tue, 22
 Aug 2023 14:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net> <6a18b295-92ac-1633-0b79-6aaf18a8496d@huaweicloud.com>
 <CAF8kJuNq2Y5AAAQn66bTEfjkQ8kfPokmGgBLDPwEWUC=MO9NcQ@mail.gmail.com> <CAADnVQJNQ+9D+3y-jLh3KVczcSo_Piz2O9-V9Grh3c1NQZujsA@mail.gmail.com>
In-Reply-To: <CAADnVQJNQ+9D+3y-jLh3KVczcSo_Piz2O9-V9Grh3c1NQZujsA@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 22 Aug 2023 14:29:31 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOT5cSQNqO6-gf=M+hFxb2-nHT1eZnEvqGYGGC8qHn39Q@mail.gmail.com>
Message-ID: <CAF8kJuOT5cSQNqO6-gf=M+hFxb2-nHT1eZnEvqGYGGC8qHn39Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Aug 22, 2023 at 2:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> >
> > The execution sequence is like this:
> >
> >        count =3D min(pcp->count, count);
> >
> >         /* Ensure requested pindex is drained first. */
> >         pindex =3D pindex - 1;
> >         bpf_injected_spin_lock_irqsave {
> >                  alloc_page();
> >                  original spin_lock_irqsave(&zone->lock, flags) ;
> >         }
>
> bpf doesn't call into alloc_page() or slab alloc or pcpu alloc from
> tracing progs.
> All memory is preallocated.

Here is the other patch submission thread which have more detail of
how to reproduce it:
https://lore.kernel.org/linux-mm/20230817-free_pcppages_bulk-v1-1-c14574a9f=
80c@kernel.org/

It is on older version of the kernel.
> Can you reproduce the issue on the latest upstream kernel?

Hope, the fix on the BPF side went in as commit c66a36af7ba3a628.
I am not aware of other cases.

It seems the consensus is so far is that we don't support BPF doing
nested allocation on spin locks.
That will implite any function called under the spinlocks as well.

Do we care about adding more warnings on this kind of allocation at all?

Chris
