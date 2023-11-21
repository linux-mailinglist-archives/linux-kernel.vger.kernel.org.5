Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1E7F2533
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjKUFUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUFUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:20:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B0C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:20:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F08C43395
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700544041;
        bh=JtavrUIxlyshUyyi8vAOsYEh7+zxgbA7A7azHwQBTEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h1gaFBnmNWBvyPbmZ48AD8dfeGT4q9dhkMRjE4+ML67hhTb9TEzs8J/bjXIAAHItk
         IC3O+KoHTKlXxLPF7kWsnHWEhb3GxNwN6Qs5GYnyec4GOfdUFjpZL6LIbKUB1EqZdt
         15e5acu7EMZasxmwA0/bzaxbqk8NArV9wQNnFn5Asa1xnUMydd40PxajW5kBm0rD+t
         CJegbdREwj9ZdiGeWABWralhy+KoKV0ZtOAhpQFNv+T44Hfg2f15G/4WSEuOzUVFXw
         VJZNpVY8e9/v/BmeQQ80Xx97/AjeTJJdzBfoQ8FQtYJYYBTa/sqehZnFm7QTwVPFaa
         DjfoqAaiB/+rQ==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-280165bba25so3540966a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:20:41 -0800 (PST)
X-Gm-Message-State: AOJu0YwVZXpcxXv2Oeiazf0okzP9beLruPLgUb1hERa1+ihKa371IcvY
        fb9H9FDAWeHJHtS9AQQRucKwi4haKOXmKSWHjnhLdw==
X-Google-Smtp-Source: AGHT+IF/+JBQQSrFIknsu/zotU14EgQAKBUcoBMwu5b/jCbbnFeUjQeXH6aRbIb4k1OjLsgsDEa4Bfk93a+/USefQ7w=
X-Received: by 2002:a17:90b:38c2:b0:280:e0:9071 with SMTP id
 nn2-20020a17090b38c200b0028000e09071mr8413728pjb.28.1700544040906; Mon, 20
 Nov 2023 21:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-9-ryncsn@gmail.com>
 <87r0klarjp.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7DX30BpNR4kFPUMRat37F11rpnmb8ia2RetAaf7oZbE+g@mail.gmail.com>
 <87a5r7c3o1.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5r7c3o1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 21:20:29 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOP_7Z+av6p260oj4BEO=5W0246LWfc_dx8iKc8o3NU6g@mail.gmail.com>
Message-ID: <CAF8kJuOP_7Z+av6p260oj4BEO=5W0246LWfc_dx8iKc8o3NU6g@mail.gmail.com>
Subject: Re: [PATCH 08/24] mm/swap: check readahead policy per entry
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
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

On Mon, Nov 20, 2023 at 5:12=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
> > but this series is growing too long so I thought it will be better
> > done later.
>
> You don't need to keep everything in one series.  Just use multiple
> series.  Even if they are all swap-related.  They are dealing with
> different problem in fact.

I second that. Actually having multiple smaller series is *preferred*
over one long series.
Shorter series are easier to review.

Chris
