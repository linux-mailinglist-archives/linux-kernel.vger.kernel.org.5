Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F61763A98
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjGZPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjGZPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:13:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B5E11B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:13:18 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76731802203so607009085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690384396; x=1690989196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOppSR5vSHMc40APmcMzvAsvziT5KwEmkPNskmCaQgY=;
        b=razagjx5BCylQt5gjh9JrWZm0vXpRLG/piHYhTLKRLsw9zcpX1u5k0Vs+hrO22eo3e
         SfkcFjXF8k7a6zX2GsTDxVI2P7C+p9cdeVVWqBacemwDslPEmqfniR9mE8nddDPpabCq
         6dpDA4eXbXF/C7KRKLKH9oiVBg422CJtTD+CuvLV8xPXFpUPKo+R5iLBGqZvb3s/Lcgh
         hcK6qEOL48zST1lv9PuFKcWCke1qdlDDBpP5Om1APf4OhVh7DuHGAn6rqniiipNv2AJS
         PvL182LpjVrdjNiaGRVqcfKAt3ZgIZ/o2SV1UV7SVi8513mRcui/7i7sk96Jke6mFDC+
         XSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690384396; x=1690989196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOppSR5vSHMc40APmcMzvAsvziT5KwEmkPNskmCaQgY=;
        b=Qvhu9VXq3Z/6SfIXZr/TnsSrjZw/gXFWxTt3iWgVDka+ytE5Qile/001UyVq9XVZh0
         k8eZZ+UckBCsAF3tVPOPnBN/TzT6CQveoaF+wBQpa91EhFuczuGgVCBd6NWSUzUuwtX5
         3jgBJ72l01O5Rmp6GU84XBkd216VmnxXZW8oR/029pjmuw3gDzS2fwpBwAC1SbMCL7aK
         BnVuR6WT+Xo+wyOu1Sht+v7hSf1PoqrQzXpUg8ZClbvVCBRxV8OO7IRF05iwjF/ZnCTX
         EQwIE8VKIMJyUYVQQPZLUH8ChK0EqO9yKF/COuP4JJzfzyARvBI+dbgk8YofpfyTFWIO
         ogHg==
X-Gm-Message-State: ABy/qLaxrW3T7POCH5Y7pwvoxvCT+yntu4VkcGN626sgaB98N/VfLtzj
        gy7JTXryiuJeccl9aKtyWCj3Pg==
X-Google-Smtp-Source: APBJJlFecabGZMkHefQhOYETrzqZggXS46ZDMFNpHahsxsOZeHwJwD3Wm+TOSeeugGs4BmH72plYFQ==
X-Received: by 2002:a0c:aa99:0:b0:623:690c:3cd7 with SMTP id f25-20020a0caa99000000b00623690c3cd7mr2342136qvb.47.1690384396635;
        Wed, 26 Jul 2023 08:13:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id a26-20020a0c8bda000000b006238b37fb05sm283391qvc.119.2023.07.26.08.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:13:16 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:13:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
Message-ID: <20230726151315.GB1365610@cmpxchg.org>
References: <20230726002904.655377-1-yosryahmed@google.com>
 <20230726002904.655377-2-yosryahmed@google.com>
 <CAJD7tkZK2T2ebOPw6K0M+YWyKUtx9bE2uyFj4VOehhd+fYnk8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZK2T2ebOPw6K0M+YWyKUtx9bE2uyFj4VOehhd+fYnk8w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 05:36:45PM -0700, Yosry Ahmed wrote:
> On Tue, Jul 25, 2023 at 5:29 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > - Fix a subtle bug where updating a local counter would be missed if it
> >   was cancelled out by a pending update from child memcgs.
> 
> 
> Johannes, I fixed a subtle bug here and I kept your Ack, I wasn't sure
> what the Ack retention policy should be here. A quick look at the fix
> would be great.

Ah, I found it:

> > @@ -5542,19 +5539,23 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
> >                         memcg->vmstats->state_pending[i] = 0;
> >
> >                 /* Add CPU changes on this level since the last flush */
> > +               delta_cpu = 0;
> >                 v = READ_ONCE(statc->state[i]);
> >                 if (v != statc->state_prev[i]) {
> > -                       delta += v - statc->state_prev[i];
> > +                       delta_cpu = v - statc->state_prev[i];
> > +                       delta += delta_cpu;
> >                         statc->state_prev[i] = v;
> >                 }
> >
> > -               if (!delta)
> > -                       continue;
> > -
> >                 /* Aggregate counts on this level and propagate upwards */
> > -               memcg->vmstats->state[i] += delta;
> > -               if (parent)
> > -                       parent->vmstats->state_pending[i] += delta;
> > +               if (delta_cpu)
> > +                       memcg->vmstats->state_local[i] += delta_cpu;

When delta nulls out, but delta_cpu is non-zero... subtle.

This fixed version looks good, please keep my ack :)
