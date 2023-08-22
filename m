Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C21784BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjHVVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjHVVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB2DE5B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:15:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EAC5640F7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD39BC433D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692738908;
        bh=MPbFfaZldMXlI27DS7EBhl7quqrFpeY43YsFEJAs7UU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sik++5Uyw113bC8cKezX0FDtsFcIIroIzQY3bQUcONLqHnjN/8Z8dJGeO3p5db4Dr
         LlNfo/I5/a/i+syS2obC9bUMj5mgzyaCO6ycD1hxTcCix2ygs41yyF7Q3RZI5hlpLO
         87BJtOTC+uZwGQeU0MNn82cC+DB9/9/mNQmWHp9U9mF3gter6Zhu/Xy1FeVZaTZuhL
         y0WFWb49zfSWdRGp3V3c1LDIZumYXVDIkwaM/imUiMcy4xKpTYW/zikp9LG0J2+OH8
         +un0aKTaE1JW6WK4bjaO8EJOO3TYwJ9nY1rYNrhHHTKXyHSFdEoAZpIsgCWuQ/YH5g
         nIVRDjUKKaG0A==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-26b3f4d3372so2742938a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:15:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YycUjPAZuIdOZm+p5uBVCtNRmWx1ongyaY5y3u/lZSQsTNgZGAC
        Dy3gCKcaGyvWUMQNpmPljtdLl+aX1vZ4XMUyhLNvVQ==
X-Google-Smtp-Source: AGHT+IFHTIL/CvJlJyVaElLrd6kc8ODsEXB546o+Sp/8q50aFHn602zc6J0hnjKa17q4FEA68hJn2XG5cgeG3rB21Ow=
X-Received: by 2002:a17:90a:2f47:b0:268:fc26:73a9 with SMTP id
 s65-20020a17090a2f4700b00268fc2673a9mr7640322pjd.40.1692738908301; Tue, 22
 Aug 2023 14:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net> <6a18b295-92ac-1633-0b79-6aaf18a8496d@huaweicloud.com>
In-Reply-To: <6a18b295-92ac-1633-0b79-6aaf18a8496d@huaweicloud.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 22 Aug 2023 14:14:56 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNq2Y5AAAQn66bTEfjkQ8kfPokmGgBLDPwEWUC=MO9NcQ@mail.gmail.com>
Message-ID: <CAF8kJuNq2Y5AAAQn66bTEfjkQ8kfPokmGgBLDPwEWUC=MO9NcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        david@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, Namhyung Kim <namhyung@google.com>,
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

Hi Kemeng,

On Mon, Aug 21, 2023 at 6:27=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
> >
> Agreed. We assume pcp->count is protected by pcp->lock. Instead of make c=
ode
> work in case pcp->count could be changed without lock held, it's more rea=
sonble
> to modify pcp->count with pcp->lock held in BPF program.

The lock is holded when pcp->count is modified. It is going through
the kernel page
allocation API. The issue is nest memory allocation inside spin_lock()
introduced by BPF.

The execution sequence is like this:

       count =3D min(pcp->count, count);

        /* Ensure requested pindex is drained first. */
        pindex =3D pindex - 1;
        bpf_injected_spin_lock_irqsave {
                 alloc_page();
                 original spin_lock_irqsave(&zone->lock, flags) ;
        }

Chris





Chris
