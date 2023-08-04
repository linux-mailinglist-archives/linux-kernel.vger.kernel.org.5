Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D804C77061C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjHDQhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjHDQhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:37:21 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFC195
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:37:19 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63cfa3e564eso13786736d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1691167038; x=1691771838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUJy9CxyJyDezGa57jwVulgOP6Mhmh9lxMHoUFNxQOg=;
        b=N8zywGIpRTGhPC/hd5Uaa9XnP65QfObz3MOaQDHYBSgg96x0lu4ubKHgZyvQjRg+92
         VimNYt6Qi+T2OSX2whxjKdAwU5/KjPFJAJ8FQDdIS6jXwklryXprXrKQGXj9+OlCaDkz
         3BPikSVV1zG++16OImjNF+EnR6jfDlpZjFzRRbEI2TKM1ALXkZgWSYisS9iRkCf9uPpL
         wBCvyMsghryoppGBxdYYnIv8JITuv327O30KANkFj9SkQRGLPKdUnIYxkMPnuCb+6MV2
         utPvzU/Zd0n7b7YmTIV2gNEhgfjpPjenS3EcryRbLfQHd44dgYs/kyhVn6CXzmHTcpuN
         jP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167038; x=1691771838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUJy9CxyJyDezGa57jwVulgOP6Mhmh9lxMHoUFNxQOg=;
        b=Q38IVRCl6brupI/d2wXFri/VvyhrrWp6nPqafCmgrqQVkxzbosVSLRsbtyLNvIXWe5
         BaE7TVuyChGdjlC5xQn1NwUXx3Njbi+q+hO0G4FaKzxwSIWUjwPawICJ3mpMuzeKlVxC
         WHEgDZukEz2uq+hisIdzWQqR+er5zYBjZ8q6MMZjjpxKzntPQvpA1QchatJg4ZhEnrC4
         OYnPyDTF+pQCGAYDWtDgAbDTMdEYn2oV8DOJnHx4AmJ9rhapIgNeiGNMDnzrGy5Tq9On
         V0FHUuFgrINbBcfAxqmHlVIHHiYvJLzC2QzZcvknWObDyLFX7gSFR8tbotazbhO8/zB1
         aGjg==
X-Gm-Message-State: AOJu0YwAInqmTZ+M2pZuXebXsQsQKUg6Vdzu1q6S19qA06XCOEL+bpo9
        UiycLbsJIefHxPCWH/imdslKcA==
X-Google-Smtp-Source: AGHT+IGvEQu5HgCOytuEIOWYX6CR56Y/2e5JSlxsagFnROkz1i4u6xSjaOns8WHVi48AGsOpTahDqQ==
X-Received: by 2002:a0c:e10a:0:b0:62d:f806:7f80 with SMTP id w10-20020a0ce10a000000b0062df8067f80mr2235164qvk.13.1691167038197;
        Fri, 04 Aug 2023 09:37:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9910])
        by smtp.gmail.com with ESMTPSA id e29-20020a0cb45d000000b00632266b569esm782221qvf.87.2023.08.04.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:37:17 -0700 (PDT)
Date:   Fri, 4 Aug 2023 12:37:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: fix test_kmem_memcg_deletion false
 positives
Message-ID: <20230804163716.GA337691@cmpxchg.org>
References: <edpx3ejic2cxolhoynxvwal2i4a35akopg6hshcfxker6oxcn7@l32pzfyucgec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edpx3ejic2cxolhoynxvwal2i4a35akopg6hshcfxker6oxcn7@l32pzfyucgec>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:37:33AM -0400, Lucas Karpinski wrote:
> The test allocates dcache inside a cgroup, then destroys the cgroups and
> then checks the sanity of numbers on the parent level. The reason it
> fails is because dentries are freed with an RCU delay - a debugging
> sleep shows that usage drops as expected shortly after.
> 
> Insert a 1s sleep after completing the cgroup creation/deletions. This
> should be good enough, assuming that machines running those tests are
> otherwise not very busy. This commit is directly inspired by Johannes
> over at the link below.
> 
> Link: https://lore.kernel.org/all/20230801135632.1768830-1-hannes@cmpxchg.org/
> 
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>

Maybe I'm missing something, but there isn't a limit set anywhere that
would cause the dentries to be reclaimed and freed, no? When the
subgroups are deleted, the objects are just moved to the parent. The
counters inside the parent (which are hierarchical) shouldn't change.

So this seems to be a different scenario than test_kmem_basic. If the
test is failing for you, I can't quite see why.
