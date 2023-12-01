Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9F800FB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjLAPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjLAPtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:49:49 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7688F3;
        Fri,  1 Dec 2023 07:49:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-423f47eb13dso13082301cf.2;
        Fri, 01 Dec 2023 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701445795; x=1702050595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIOIORw3aaUR3nHg3ffhpU+ENc4hund5RQEDlsNO/ng=;
        b=B778XN3OrtRNx5/5wOOKdZ6MEiJIq6gBMbzASlK6lqCvGorshJixSY5gl7Z0kyJYi+
         l8nahGbC/6TvrupY6MohiMpNEo55QmLNNgc60BQDtLhky2tSpv2SJswNKoHbkOYsI1RJ
         T8KX/aQexBCMa1u8lkmHhiuk0FhStycf5j3Q9dsZ6gB64Ma70aqg3KMSCiFmumwogR3r
         NvcExOv6n3QOzdo0ciEGByPDEo8CkAvnVHzcAMSu5li1BHlMz/VqXREYpjZr0uvsJZPp
         rgtkdhjCVozO+QXW3O/gvqqXOuZBSYlHZVjrULV8j7y5tcGwo4v4kMi/04ja2H/ow2td
         ibSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445795; x=1702050595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIOIORw3aaUR3nHg3ffhpU+ENc4hund5RQEDlsNO/ng=;
        b=rNg4SOHowQ5uvMQ2m5NWB6/uzn5/SrA7SwW3G2d1kZsEu3KUA9zX/KzolC9dJMKdpE
         cbXVzVjrh49CarBBkoJ1i0w6WvjXhN1fUmksr5Eb4ewK5oigICYvQASpZFKtwrj47rtJ
         u6CtAOE1pvRMRoHnihOuOhaxnK8GbxPl6KIyCamJs4L7ZdkQ8wEd1vY1WbYsz0gZmJ7T
         v6a3aSAkkgB5MCZax3tP/KKxUzwkYNpmSOEkcAb2I4xZ+5Bzk5Ap2XOz9t4goNzK4UC9
         HDHDLWbltz2QU9lkw0vUPt9hKBFSbooMmFgf6wk9BsemISZw5kj5+h8fcGWzX0+rAgeR
         crQw==
X-Gm-Message-State: AOJu0YyV4kR7NGjzv3WZDuqO1sae7zMoKHMA8wu4lubNCJ8RG4S0zD/c
        napEtruLSrq6aZeBtqYkvls=
X-Google-Smtp-Source: AGHT+IHVti7teZ+DQpKGAAdlbNT04Gq3tNAn+c5AOfl+JJ7V/mz9Lv+OlZlGqgBV+HsG6LRV7+HdcA==
X-Received: by 2002:ad4:51c2:0:b0:67a:26ff:f1fe with SMTP id p2-20020ad451c2000000b0067a26fff1femr21536643qvq.57.1701445794768;
        Fri, 01 Dec 2023 07:49:54 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:400::5:29e2])
        by smtp.gmail.com with ESMTPSA id b14-20020a0cc98e000000b0067a1a5abae0sm1578209qvk.93.2023.12.01.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:49:53 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:49:51 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <ZWoAn4tiOiohvqZ/@dschatzberg-fedora-PC0Y6AEN>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
 <ZWmoTa7MlD7h9FYm@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmoTa7MlD7h9FYm@tiehlicka>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:33:01AM +0100, Michal Hocko wrote:
> On Thu 30-11-23 11:56:42, Johannes Weiner wrote:
> [...]
> > So I wouldn't say it's merely a reclaim hint. It controls a very
> > concrete and influential factor in VM decision making. And since the
> > global swappiness is long-established ABI, I don't expect its meaning
> > to change significantly any time soon.
> 
> As I've said I am more worried about potential future changes which
> would modify existing, reduce or add more corner cases which would be
> seen as a change of behavior from the user space POV. That means that we
> would have to be really explicit about the fact that the reclaim is free
> to override the swappiness provided by user. So essentially a best
> effort interface without any actual guarantees. That surely makes it
> harder to use. Is it still useable?

For our needs (limiting swapout and avoiding swap-depletion) we rely
on two semantics of vm.swappiness.

1) Lower swappiness results in less swap-out, more swappiness results
in more swap-out - for the same workload. Our proactive reclaimer
monitors swap-out and lowers swappiness in response if we exceed our
target swap-out rate.

2) swappiness = 0 results in no or very little swap-out. We rely on
this to avoid exhausting swap due to proactive reclaim and triggering
OOMs.

We already depend on these semantics of vm.swappiness *today*. I think
changing either of these would be seen as a behavior change from user
space POV irrespective of this patch. The proposal in this patch only
allows for vm.swappiness (whatever its semantics) to be configured
separately for proactive reclaim.
