Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA579E923
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbjIMNYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjIMNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:24:18 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65F19B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:24:14 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-655d81971ceso24032216d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694611454; x=1695216254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAf3ai1JuGA4NVKNvsJwZNxVrsDBH8DKtDQzp9gt1XQ=;
        b=RMZagdEjGVAB6Kr6edTbwYoCmks45nPeJ2ZdAryJbpvmbXyBcUoHdA2DZ7zmFguyK/
         j4yodQCkyKqOX8WnO5+b/2bmn4JUai9uhQEurDEDk92qENJbl6RWr0NuskzS39tRQRhx
         exiidvrQbYoNU5PUfRLNBlDQjk2dv0FGY8oaMnTCSEOXDFyr+BKoKQDCgBY21uVTjpuR
         mj1IEm0EFyFLEdx413tkGT7StVHvv2oNnsJPLX8QIAlXYfxplDry4DQ5d+0GU1S5sSQZ
         u+xJYGo09x0S+EYScN9SHlfumHOcBMVb93dW1ERTWR90xbarAz8l2eEMce4g4/eSP8OD
         eK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694611454; x=1695216254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAf3ai1JuGA4NVKNvsJwZNxVrsDBH8DKtDQzp9gt1XQ=;
        b=sctbxZkPzOtBmrjfpL38hK6SiCRLQSP1ktxnjZiqBS7C5h/hyRcfTA1kl4LJpqD5HM
         JbdCulRpXyrlTKsny8dVJX3z4HcrcAKyIxT8Gz9WfVUzjecEmASIlJQSghkQwGlxBRye
         5OChro1K7ABwDqrGxaEH+083fRmRYj41NQ2RIaBzfKGZSzo0WKoXTxc+xFIf2/OJOcP5
         clqciZedEhmNb32hc6tjXzgQeyHq/c1Y523iK43QtaucIo8ityiwYhlehYA1omlj0tJQ
         EUFRjhiGFnsRTcCKdNyiAZviDHQ6Q9p13VvzRfQMrCnSSVNHNh5bEN9nmvwmiddIsnGa
         Tq2A==
X-Gm-Message-State: AOJu0Yyp7eWdtF/caLUIFINPbGchNRLBxvgNkDUw3LLdEdt82gASrhjK
        J92lO8cNPOymSs4YiHyTuL4GPQ==
X-Google-Smtp-Source: AGHT+IF9vwW2GPRldJIXMKcI9WkYNOX1cr4N2/uc5cVdKkGOWzuOZPuHQccnppK9u1pfdDZCHqAGnQ==
X-Received: by 2002:a0c:f804:0:b0:64f:5228:d4bf with SMTP id r4-20020a0cf804000000b0064f5228d4bfmr2241319qvn.62.1694611453706;
        Wed, 13 Sep 2023 06:24:13 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id d3-20020a0caa03000000b0064f741d2a97sm4480552qvb.40.2023.09.13.06.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 06:24:13 -0700 (PDT)
Date:   Wed, 13 Sep 2023 09:24:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Message-ID: <20230913132412.GA45543@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
 <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
 <20230912145028.GA3228@cmpxchg.org>
 <320c16a7-96b7-65ec-3d80-2eace0ddb290@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320c16a7-96b7-65ec-3d80-2eace0ddb290@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vlastimil,

On Wed, Sep 13, 2023 at 11:33:52AM +0200, Vlastimil Babka wrote:
> On 9/12/23 16:50, Johannes Weiner wrote:
> > From 429d13322819ab38b3ba2fad6d1495997819ccc2 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Tue, 12 Sep 2023 10:16:10 -0400
> > Subject: [PATCH] mm: page_alloc: optimize free_unref_page_list()
> > 
> > Move direct freeing of isolated pages to the lock-breaking block in
> > the second loop. This saves an unnecessary migratetype reassessment.
> > 
> > Minor comment and local variable scoping cleanups.
> 
> Looks like batch_count and locked_zone could be moved to the loop scope as well.

Hm they both maintain values over multiple iterations, so I don't
think that's possible. Am I missing something?

> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks! I'll send this out properly with your tag.
