Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3665763ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjGZPVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjGZPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:20:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA54AE77
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:20:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7656652da3cso523044185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690384857; x=1690989657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TR6oQPY6JNSBn86BXUT6Jb7RsPiu2t8ttrP3Qk1ckmA=;
        b=kEYIf12WH7QjPdNoSCv0WUSbARvQjmtVxX7NfaQzrYxV1/+nRefphJ/BTVVpb3PI3k
         tDFiu/YtGXzrb7LxUR36pX2VIcIE4gHAqkuNB3cwZSL76h5iTQjva8lKEpiF5mixmS9j
         zB/QcNjxJqpZs0gjpSEB7cQ4TxsEnvvfcOAkvF72PHHpzXrX5hHIncAuMkUoFmSw29aN
         JZcwXccKyQocpVHQG72luYQIe6XFkG0KPfRT9NwyYpkFvDisRm1YB/A5Egv0H0ixL38b
         OZ54MHmoHTmvqEI8a/dnmJJEjpzdkkfjyjwLJuB4INwzRuRMAb3gXkjvoN4j4vRJw8KA
         vfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690384857; x=1690989657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TR6oQPY6JNSBn86BXUT6Jb7RsPiu2t8ttrP3Qk1ckmA=;
        b=LrYBl05vrNXPTkCpF2/b+4z67bGVo1k4eGV7/3VwvxS8DiA/Hn9wJXLd+QmC5CZTcy
         cjDrJ7yRHkdtQDwIA5NlNioFJJSGmWLsQkt8PgWjMVUddXz1pq8ec2jIK/g5pmrjyrPN
         WO5A5U0R6mKOQ/83azmPqZPgm/+aad+WMWsT+rwERqbku7PwdaHBNJQVvMrKLyYo+dG4
         J4mcDYcOH4aJ37ez4D0guJXS7Z7xMIArkxx6l6M9mA9tD0fqx4k1sSIb8XCnbcjjebzx
         cuAy2el2pgOzuIyw/g3sUuHcQEtCQHRM1PG+39g1ghUjNOqcxgvK4/fdDvGHp0Lz8KYZ
         kU6Q==
X-Gm-Message-State: ABy/qLbji8OlvEsdX8wMuFqyZ2WS2OIHfNT6b4Th3tfvkWwb7raRfQmI
        rOCQg0rH5M/SeSvG0KnzBbBP6NVsXCsT7gGpha52VA==
X-Google-Smtp-Source: APBJJlGswU8a7rZBj9c7i7QTAuHK8PtGySK4NWfnyRWJE19IhhMxg6vqaARuuRM1bWQTzLLA2YyXAQ==
X-Received: by 2002:a05:620a:450d:b0:768:125c:cded with SMTP id t13-20020a05620a450d00b00768125ccdedmr3115630qkp.14.1690384857073;
        Wed, 26 Jul 2023 08:20:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id g12-20020ae9e10c000000b00767291640e8sm4424608qkm.90.2023.07.26.08.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:20:56 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:20:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
Message-ID: <20230726152055.GC1365610@cmpxchg.org>
References: <20230726002904.655377-1-yosryahmed@google.com>
 <20230726002904.655377-2-yosryahmed@google.com>
 <ZMCBzUH7qIdc3Y2X@P9FQF9L96D>
 <CAJD7tkZDpni+VM61i-jUgvn=TkZ5CySotTmUAFQPwMSjDfOEWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZDpni+VM61i-jUgvn=TkZ5CySotTmUAFQPwMSjDfOEWQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:20:02PM -0700, Yosry Ahmed wrote:
> On Tue, Jul 25, 2023 at 7:15 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Wed, Jul 26, 2023 at 12:29:04AM +0000, Yosry Ahmed wrote:
> > > Currently, memcg uses rstat to maintain hierarchical stats. Counters are
> > > maintained for hierarchical stats at each memcg. Rstat tracks which
> > > cgroups have updates on which cpus to keep those counters fresh on the
> > > read-side.
> > >
> > > For non-hierarchical stats, we do not maintain counters. Instead, the
> >                                                 global?
> 
> Do you mean "we do not maintain global counters"? I think "global" is
> confusing, because it can be thought of as all cpus or as including
> the subtree (as opposed to local for non-hierarchical stats).

"global" seems fine to me, I don't think it's ambiguous in the direct
comparison with per-cpu counts.

Alternatively, rephrase the whole thing? Something like:

"Non-hierarchical stats are currently not covered by rstat. Their
per-cpu counters are summed up on every read, which is expensive."
