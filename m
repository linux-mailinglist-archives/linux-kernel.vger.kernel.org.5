Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B98E7FF9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjK3SoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3SoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:44:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555C910D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:44:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d39d74bc14so9068327b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701369866; x=1701974666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=upiPnSdDPUq7hHtl9SwPR71HvOH0YDjoF8X3pVlx4do=;
        b=d39xz5aCp98Lkh7pxGFZZQJMBD1zYF0AJLTaiDVC5H7RTxwh3JnHvby2naCv3aIqA+
         q1mpKQnQsIjTu8IR38LwTPx9TG2UHGobO9Mi5+YIp+j65tw1T6VuCvF8KU3MeqEAWbIg
         tf3ewXbNZQLxcOqFKdu2tx1I59wph0is3ZnYJQgcZSppxa2JuATU+VxES7ClZd0HFF9v
         H8v+WAOf6PGkOqFtxrqhk2gd63/e9skSxiNLYxcMcRQR/tLOF9eZ6qyrI46v5aZnylXA
         FV/lHNXBVwg2A2h5lP9EFhOZWKxLz22Jwn7q0HHwYC1Atu/dUvblLw1ArGhcTUFz/7u6
         tYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369866; x=1701974666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upiPnSdDPUq7hHtl9SwPR71HvOH0YDjoF8X3pVlx4do=;
        b=ioM77lkCvGL1Pnuq0fd7Z/reolCLwH/tddsSfyaP3rkYJoO6dovzrV2jQGjC/YKlZj
         rlcpZQuzFuaCcLqkiXMFjVOvNuSH6gFzfJtoiYHC8dyuLpMw2utiEqCuNQILb7dGqSbk
         eojZNKVLhYJrVkAqRc4S/BIgDnayeznsrQ2PfMsRtT0a4BDfG4ktQpK8ETiwMOmCWscI
         BDQtAJSBBUArf2+7XdwJrvWQnjfXrjEduC9j9KxcdiSOnPYgt2KIGFfHWHGmzl4K8orv
         6Cm8fJCfqJD/55crAVAyC/I4cFrOpAEnR4CEFKBJmmsPjgB0+kJEHswY8vH8kPez/pYr
         +/EQ==
X-Gm-Message-State: AOJu0YxXOWPGTw5LLNqVurH9be6aURd0OClbX9E1GAQyIH6c2rcWoEQG
        Di1Yfewot9/p/MkYHL96jRDssnUnMeoVhA==
X-Google-Smtp-Source: AGHT+IHazLL/GdN9pTlSOqSprD2MGFIuk76VQgPbuz/hebnvjnu/vaByiVZ+ySGXyZ042lDowWFTcrisA+c1Dw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:2e04:b0:5d3:cca8:1d59 with SMTP
 id et4-20020a05690c2e0400b005d3cca81d59mr26337ywb.5.1701369866502; Thu, 30
 Nov 2023 10:44:26 -0800 (PST)
Date:   Thu, 30 Nov 2023 18:44:24 +0000
In-Reply-To: <20231130153658.527556-1-schatzberg.dan@gmail.com>
Mime-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
Message-ID: <20231130184424.7sbez2ukaylerhy6@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
From:   Shakeel Butt <shakeelb@google.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 07:36:53AM -0800, Dan Schatzberg wrote:
> (Sorry for the resend - forgot to cc the mailing lists)
> 
> This patch proposes augmenting the memory.reclaim interface with a
> swappiness=<val> argument that overrides the swappiness value for that instance
> of proactive reclaim.
> 
> Userspace proactive reclaimers use the memory.reclaim interface to trigger
> reclaim. The memory.reclaim interface does not allow for any way to effect the
> balance of file vs anon during proactive reclaim. The only approach is to adjust
> the vm.swappiness setting. However, there are a few reasons we look to control
> the balance of file vs anon during proactive reclaim, separately from reactive
> reclaim:
> 
> * Swapout should be limited to manage SSD write endurance. In near-OOM

Is this about swapout to SSD only?

>   situations we are fine with lots of swap-out to avoid OOMs. As these are
>   typically rare events, they have relatively little impact on write endurance.
>   However, proactive reclaim runs continuously and so its impact on SSD write
>   endurance is more significant. Therefore it is desireable to control swap-out
>   for proactive reclaim separately from reactive reclaim

This is understandable but swapout to zswap should be fine, right?
(Sorry I am not following the discussion on zswap patches from Nhat. Is
the answer there?)

