Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3DA7AF712
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjI0ANE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjI0ALC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:11:02 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FC1780C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:36:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59bebd5bdadso121238347b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695764188; x=1696368988; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MNbo8WjlIbk+vD57Y9Z/H6BU+dtLvsY8sTpvqB5nJI=;
        b=kMYf+tnaiZoXizGxBLzqasJaXfRXZJRr/qOJ8z29dPX5DP402L0MpwarVgneBDkMVS
         5fTN1g3h8fGZPZdrrqsFKm2QL7Me95StZriXXa8h1wtHBtn1oDSM+zxvoG4nTtPfx5pK
         2aCW6GpR/RXspwA9s0bZxZb8cvULwkVT6LiqLf/QV2dW3XhQyqF0Y7C+V9uMd/gpfe3k
         U5MCp1O2+gRSgVo4ldyBOc+bINV3iDZYQ+woDAKan5Apnr7oE9BB32AETVIV3Vph1OGV
         qir5x84/ziXtAbSWnV8BEm6sNxknIEl4+SUED/UKYcZ5B4raN9zI61xheJqp0203EJFx
         hRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764188; x=1696368988;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MNbo8WjlIbk+vD57Y9Z/H6BU+dtLvsY8sTpvqB5nJI=;
        b=Qg+UzP1UnjH1n96z4MsxD+NkOc+Riaiq11BPyDJU9KbKNTcD/Xzecg8pGWZtT/gY2m
         moY0ntfOOQY/h0hQahwdh11XflEYtY/3fSiIAajzVsrBciCouL/jOYDMzgmOOTf8awZw
         67oyZ7cD4eenU16LvcWEePxTRJ/1X4MV+gJ26A4nuFlvx0mSJSsgOx75jbdOAExlWGjc
         R9AEbninBd1Y6wEeesPh9j9OBdWb70EdbLVAhIAwkb0wAlBmK4po45593YRAwMRpad5/
         1QlFlnKjBzAn58pBKKuBwoJj5kF/ZAMwLRbMA+cqC0tJu+01B2ZJUJcDTgzcKOSNuqsr
         h1cw==
X-Gm-Message-State: AOJu0YwkTpxVhSQmfuA8kx3NgMmKzVKERXyi86oN5dv6J0mHOstLtwXO
        SgGNLN4GvrPzsdXmbFpN2p++CQ==
X-Google-Smtp-Source: AGHT+IELIOjIzVR9C4NP9eVufHE/iePU436e3hIzTZyc8ipuHsADk8UsXov3hJAz4eamwIw3djhY8Q==
X-Received: by 2002:a81:a08c:0:b0:59b:e72a:e40b with SMTP id x134-20020a81a08c000000b0059be72ae40bmr278076ywg.6.1695764188458;
        Tue, 26 Sep 2023 14:36:28 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e11-20020a81690b000000b0059b20231f1dsm3258266ywc.121.2023.09.26.14.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 14:36:27 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:36:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 07/12] mempolicy: mpol_shared_policy_init() without
 pseudo-vma
In-Reply-To: <ZRIOzcI78x8BmGdo@casper.infradead.org>
Message-ID: <4fe84029-ad5-63cb-f2a7-3c83ea427bf1@google.com>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com> <ea413d84-8b43-91c2-feef-92998bc7c1e2@google.com> <ZRIOzcI78x8BmGdo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023, Matthew Wilcox wrote:
> On Mon, Sep 25, 2023 at 01:29:28AM -0700, Hugh Dickins wrote:
> > +		/* alloc node covering entire file; adds ref to new */
> 
> This comment is confusing.  sp_alloc initialises the refcount of 'n' to 1.
> Which is the same memory referred to by the name 'new' in __mpol_dup(),
> but in this function, the name "new" refers to the mempolicy called
> "old" in __mpol_dup().

No promises, but I'll see if I can make it look better in v2.

> 
> > +		n = sp_alloc(0, MAX_LFS_FILESIZE >> PAGE_SHIFT, new);
> > +		if (n)
> > +			sp_insert(sp, n);
> >  put_new:
> >  		mpol_put(new);			/* drop initial ref */
> >  free_scratch:
> 
> This is all a bit inefficient, really.  We call mpol_new() to get a
> new mpol, then we set it up, then we dup it, then we free it.  It'd
> be nice if we could donate it instead of copying it.  Maybe you'll
> do something like that later.

"later" is probably the operative word.  I do have an unincluded 2017
patch where I had that same realization, and wrote "I suspect that this
series of commits may be adding to an absurdity of over-mpol_dup()ing:
but that's for some other future cleanup, right now I'm just happy not
to be corrupting or leaking mpols."

Hugh
