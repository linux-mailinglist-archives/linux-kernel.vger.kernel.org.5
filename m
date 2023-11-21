Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD57F2521
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjKUFOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUFOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:14:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23720DC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:14:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8209C433CD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700543644;
        bh=cMMYeOK0yl8K/W6tITA9adS7M/SnAYmBYlglt9NNBgs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RTMGDAw4aaIl9p63SCbvf+axeMK1Qpqu3ZhPt5GgZ72SZeyqNj33E/2+xbbksRwv4
         61r9DkAghPdqeBx+PVGeEYObOY3vfzZyfGBygpp/bXF1E8qhZ94Gj9vGGYaOWdk755
         9pTt0e4uiiyoTNjGcKwMe/gr2xUQcpqMLTW4qRJ4RWwzXq3Mux3ELfJXI+uMaS1u/L
         yv/zDpYcG/IBITnVcwxplWsfWDdmIQHvSNobCjNFaYnrK8uwhbRkjjns3EKHLyDkYY
         pIBYnIVPLzw+7FODaStq8REeKFaYJww/Hs6p4fhngNAszkpwzbFcwsPAmvF8/ljL+z
         lIzmeB6es7upg==
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so4083497a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:14:04 -0800 (PST)
X-Gm-Message-State: AOJu0Yw0b/8ESn977eowBtfnnS+hGjiGvM5csweN1tpfZUo6m9UGE3Ud
        LC5gabGUDjgrjyodWie8TFgsM4N0dot9lcoiprSWhQ==
X-Google-Smtp-Source: AGHT+IF0NKsOGVE4/S06V9QRUv3Od6NAqZLzmxWtZYNeQfRbyQ4Rft126xcQtE8CVrPOEaoBGzizRbs8iBXfndTXzHk=
X-Received: by 2002:a05:6a20:3259:b0:187:cbb1:a6a2 with SMTP id
 hm25-20020a056a20325900b00187cbb1a6a2mr10188139pzc.21.1700543644182; Mon, 20
 Nov 2023 21:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-9-ryncsn@gmail.com>
 <87r0klarjp.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7DX30BpNR4kFPUMRat37F11rpnmb8ia2RetAaf7oZbE+g@mail.gmail.com>
In-Reply-To: <CAMgjq7DX30BpNR4kFPUMRat37F11rpnmb8ia2RetAaf7oZbE+g@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 21:13:53 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN9nHx-ns4RsLgQEp2N_hEvyRGeUOmsbVxeWqBsC77ong@mail.gmail.com>
Message-ID: <CAF8kJuN9nHx-ns4RsLgQEp2N_hEvyRGeUOmsbVxeWqBsC77ong@mail.gmail.com>
Subject: Re: [PATCH 08/24] mm/swap: check readahead policy per entry
To:     Kairui Song <ryncsn@gmail.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 3:17=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
ime.
>
> Hi Ying,
>
> Thanks for the review!
>
> For the first issue "fragmented readahead window", I was planning to
> do an extra check in readahead path to skip readahead entries that are

That makes sense. The read ahead is an optional thing for speed
optimization. If the read ahead crosses the swap device boundaries.
The read ahead portion can be capped.

> on different swap devices, which is not hard to do, but this series is
> growing too long so I thought it will be better done later.
>
> For the second issue, "is there any practical use for multiple swap",
> I think actually there are. For example we are trying to use multi
> layer swap for offloading memory of different hotness on servers. And
> we also tried to implement a mechanism to migrate long sleep swap
> entries from high performance SSD/RAMDISK swap to cheap HDD swap
> device, with more than two layers of swap, which worked except the
> upstream issue, that readahead policy will no longer work as expected.

Thank you very much for sharing your usage case. I am proposing
"memory.swap.tiers"  in this email thread:
https://lore.kernel.org/linux-mm/CAF8kJuOD6zq2VPcVdoZGvkzYX8iXn1akuYhNDJx-L=
UdS+Sx3GA@mail.gmail.com/
It allows memcg to select which swap device/tiers it wants to opt in.
Your SSD and HDD swap combination is what I have in mind as well.

Chris
