Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7EF7F656E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjKWRar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjKWRae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:30:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52E71710
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:30:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41090C433BB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700760635;
        bh=GcOst3/22+6cuv9lswU+ry4+GdAAZVPRN7gJdD9N6n4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qz7mod4/HwaHJK0JAB3ytD3MH8bBSYf8iVVbxyfCL1i/Zs6EaxhyzZ0+HRfgGgLRE
         7KYF+Vw44ia7HO0mtZe6yNWu2wGG5dX7LTzWtPvh5MEXCxFa2Opa4yGNWXBwiqumzT
         OQoZP7jTRMTNAN9wgg0KoDA+vKwqyQPTwQy/IXCqlURybqriy7jxNCQRmvtEEdhBEp
         9Xj0bqmhY869YhySGf3rjhIWMZSOwhzaFPKHnbgQXjg1zVoB8XolM9ff6mKYt0gLHq
         xg18bmw/eeDCgNR1WtWJ8g7EWNw/CAxaofPrCUhSgPJqL78JV0q0plchZ5E05HZRz6
         e2oH4RK5uPd8w==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso914961a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:30:35 -0800 (PST)
X-Gm-Message-State: AOJu0YxMSdDYBW3XW0AHr6rh+V41/Qc2VDbjs39hnkJjcdb1YhrqdCRn
        LU2KSCFvJ/j7lkWs7nBD8A5GGISjp6KswA95wR14pw==
X-Google-Smtp-Source: AGHT+IHytp+/fh45uHnBzItufzEx7eCFYQ74dyRHbptCqeFGDEMvkjRENl6X2MFJeG5mhjUejhBp+JsLaOU1M3fpJ2s=
X-Received: by 2002:a17:90b:1001:b0:285:6f1a:4a71 with SMTP id
 gm1-20020a17090b100100b002856f1a4a71mr149425pjb.32.1700760634650; Thu, 23 Nov
 2023 09:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20231121090624.1814733-1-liushixin2@huawei.com> <ZVyp5eETLTT0PCYj@tiehlicka>
In-Reply-To: <ZVyp5eETLTT0PCYj@tiehlicka>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 23 Nov 2023 09:30:23 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO=Y6frTxMbR92XhzuC8Z8ALDWFLq2Mj3t0j+C9YXOaJw@mail.gmail.com>
Message-ID: <CAF8kJuO=Y6frTxMbR92XhzuC8Z8ALDWFLq2Mj3t0j+C9YXOaJw@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     Michal Hocko <mhocko@suse.com>
Cc:     Liu Shixin <liushixin2@huawei.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 5:00=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
> > However, in swapcache_only mode, the scan count still increased when sc=
an
> > non-swapcache pages because there are large number of non-swapcache pag=
es
> > and rare swapcache pages in swapcache_only mode, and if the non-swapcac=
he
> > is skipped and do not count, the scan of pages in isolate_lru_folios() =
can
> > eventually lead to hung task, just as Sachin reported [2].
>
> I find this paragraph really confusing! I guess what you meant to say is
> that a real swapcache_only is problematic because it can end up not
> making any progress, correct?
>
> AFAIU you have addressed that problem by making swapcache_only anon LRU
> specific, right? That would be certainly more robust as you can still
> reclaim from file LRUs. I cannot say I like that because swapcache_only
> is a bit confusing and I do not think we want to grow more special

That is my feeling as well. I don't like to have too many special
purposes modes either. It makes the whole process much harder to
reason. The comment seems to suggest it is not effective in some
situations. I am wondering if we can address that situation more
directly without the special mode. At the same time I am not very
familiar with the reclaim code path yet. I need to learn more about
this problem space to articulate my thoughts better . I can dig in
more, I might ask a lot of silly questions.

Chris

> purpose reclaim types. Would it be possible/reasonable to instead put
> swapcache pages on the file LRU instead?
> --
> Michal Hocko
> SUSE Labs
>
