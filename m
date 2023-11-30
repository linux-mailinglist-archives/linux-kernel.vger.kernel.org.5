Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA57FFDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376984AbjK3Vq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376954AbjK3Vq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:46:27 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA1110D9;
        Thu, 30 Nov 2023 13:46:33 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2ec9a79bdso902849b6e.3;
        Thu, 30 Nov 2023 13:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701380793; x=1701985593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7kw1SluTyHuS8yhLQtATJ7V+RH9z5AGm8JV2/YS9U8=;
        b=OcfX/OUDOeuukd4WpimK/PFzkflmOaTZlpC/bymlQ4NQ/w942I9yYdmcpFHrcvc1tl
         bxmDDKwY++cCd0Da+nwa7+OPXY5+haqoNLeDVmffMnTnrm6uwdDYY8vfBROmcra/ylcm
         ZJsvSum0j3jAwXq8dahFV/pTHMFkgqU3bjoFEAtmA179tnaVHc6dFTJ/qviVAihf5iD1
         Wj+InDKMuq5D5Z0obopCjMhkNhTvbAv69VQ4UlAcVgQujeN16lTWOttg23dxaq9/eHxo
         9Q7Y2/FvxcL2JmrXh47cRvUsezdbXtOoe5q4DGRBcOh4aZFTSXPVNeCChz8L/URlFDoF
         acqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380793; x=1701985593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7kw1SluTyHuS8yhLQtATJ7V+RH9z5AGm8JV2/YS9U8=;
        b=gtQztwrjsrdlZzSoATF6dhUfTOiW3f7BJp8sAuLp1OZe5IAgTvt6fdFmjmXhzGQrNE
         KVhN6jlD3YdEV9PGiAKt+jQHoVS5v8x4mQut+taWBmJNLY+hF32P9nYHJQqRFw0psaCk
         YTV8GF5mDb4f07bu+tScd3A3wXO5s/Gv5oVFD5W7MbeDqwNqk6WhELbYoHIGxsPJfDGy
         PkY6Tn0pGaZkzfykyWcVHa8wgA7gX6nWs4+WooCCJipCTZlw6EqqIdrODvCXJQoJ9jra
         phZb330j/LCl153+ZqltgXBT6zYhEuAhvlBnXAhYLeYmV7UbbOSE9Y8/TtznN3T7o4A7
         LZ1g==
X-Gm-Message-State: AOJu0YyCJ1AJ4K0wDrpUrbNh9LaTuWyD2WGQranQJaI7y/jvcL/RCXfQ
        UucwMWA8frLueGkTpnnHggU=
X-Google-Smtp-Source: AGHT+IFt3eeK3wvzcN/i7Gz7UOv+pTeHBd5sEJ2IHfzZ+nl1IKWIB2GxU4N1giT2RlMwQ3Enzjbcjw==
X-Received: by 2002:aca:f17:0:b0:3b8:79a8:cc7b with SMTP id 23-20020aca0f17000000b003b879a8cc7bmr948016oip.16.1701380793258;
        Thu, 30 Nov 2023 13:46:33 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:5fb0])
        by smtp.gmail.com with ESMTPSA id vy13-20020a05620a490d00b0077da601f06csm865412qkn.10.2023.11.30.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:46:32 -0800 (PST)
Date:   Thu, 30 Nov 2023 16:46:30 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZWkCth0YWoPqLThZ@dschatzberg-fedora-PF3DHTBV>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130153658.527556-2-schatzberg.dan@gmail.com>
 <20231130133340.36140526608289898acb3ac5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130133340.36140526608289898acb3ac5@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:33:40PM -0800, Andrew Morton wrote:
> On Thu, 30 Nov 2023 07:36:54 -0800 Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> 
> > Allow proactive reclaimers to submit an additional swappiness=<val>
> > argument to memory.reclaim. This overrides the global or per-memcg
> > swappiness setting for that reclaim attempt.
> > 
> > For example:
> > 
> > echo "2M swappiness=0" > /sys/fs/cgroup/memory.reclaim
> > 
> > will perform reclaim on the rootcg with a swappiness setting of 0 (no
> > swap) regardless of the vm.swappiness sysctl setting.
> > 
> > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> > ---
> >  include/linux/swap.h |  3 ++-
> >  mm/memcontrol.c      | 55 +++++++++++++++++++++++++++++++++++---------
> >  mm/vmscan.c          | 13 +++++++++--
> 
> Documentation/admin-guide/cgroup-v2.rst is feeling unloved!

Oops - total oversight on my part. I'll add docs in a V2 if we can
come to consensus on this interface change in general.

> 
> Please check whether this interface change can lead to
> non-backward-compatible userspace.  If someone's script does the above
> echo command, will it break on older kernels?  If so, does it matter?

Older kernels will return -EINVAL with such a command - that seems
appropriate, indicating that the argument is not supported.
