Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F517834CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHUVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHUVWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:22:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B4311D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:22:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40fd276621aso24845621cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692652940; x=1693257740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xce0vmMn1gvMkKEgP8SciOlKPAtITGIb7QGEMytqaF8=;
        b=Ak4Gn2HWylrO/T/r4SzJshlnVyfDAHGOeNUz9ZhghusisFnCAi7w7cOaAAZZN1xGaF
         pbIG5wpxUM6hHxgwTyjk2uEmUx9aSY9prGdOm5dAigoJaRdE3VeG6Jyj7zfRNJ1cwtCS
         g4pIexKwZrtd8JfHwQufnJBhakTEkD8NY8K6LwzfWp+jZCPVf5+RSzqGQ5e+8kSMSMwI
         9kDrEBYbz9LmpO0l8UlClqzdy3kZGunS4gXa85rv/g6jkIXc1gBicsBgXew8/+sQQoZg
         ZQ4lH1utQWz1+DNnm75M/t2dHpbvWir/UudpA09J1oprZmmwgDSxiGHAA2cs7DNpu5c5
         ZZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652940; x=1693257740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xce0vmMn1gvMkKEgP8SciOlKPAtITGIb7QGEMytqaF8=;
        b=iLBgNVjceL+w0u236BwSNb8FqSvBHMNvEOYYcZ9WOI+Fm38SfHU7Fq5RQpyuHKHCHp
         m1vZo+0sYwGChdNo48FOKVHkye/8I92D0Ir9rkVKkm5IvLB9QRpdsbBnTTJk/W/2kf91
         Tis1yTOF58MlB3nN7HCig0+Bk+4XNhoDg4xM48ImnXFqeks90H6pjepuiT9q87hE7MCG
         Ty337YddX3jnlTVw/8RFg5Z2b8OE3HbKwPFQPMCupe5PnixHZNdw9SvSY0v8rcwN2ZiB
         TSxScwvamFhYlhisxAAGEC7vcdwMVhkcFJo4NeWbGkn5lBXWeJx4Az1+s1hJmGtMUrqs
         ni0g==
X-Gm-Message-State: AOJu0Yw3ILIGy4Vj/b4NNZLzF5EQ0MU7PJUZyWvOKksRyl38+YJdGjzh
        nXp8l4L1u5hgVK363eUFkH/Ol5+o7SM6Az4wSzLT1g==
X-Google-Smtp-Source: AGHT+IHBAB4GS08K6S/HYAbBsfqGccIZK0IyQOFY1AeNje6eraFnI5xfEwxkuq0fB5uCSRGT26pKFg==
X-Received: by 2002:ac8:5e4f:0:b0:410:8bcc:fbac with SMTP id i15-20020ac85e4f000000b004108bccfbacmr10068053qtx.7.1692652940437;
        Mon, 21 Aug 2023 14:22:20 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id h20-20020a05622a171400b00410957eaf3csm1101726qtk.21.2023.08.21.14.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:22:20 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:22:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: page_alloc: use get_pfnblock_migratetype where
 pfn available
Message-ID: <20230821212219.GC106501@cmpxchg.org>
References: <20230821183733.106619-1-hannes@cmpxchg.org>
 <20230821183733.106619-2-hannes@cmpxchg.org>
 <4DE7DCEA-796E-463A-8EF1-FB441BAEDD96@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE7DCEA-796E-463A-8EF1-FB441BAEDD96@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:29:36PM -0400, Zi Yan wrote:
> On 21 Aug 2023, at 14:33, Johannes Weiner wrote:
> 
> > Save a pfn_to_page() lookup when the pfn is right there already.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/page_alloc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Just notice that it is already done in:
> https://lkml.kernel.org/r/20230811115945.3423894-3-shikemeng@huaweicloud.com

Even better :) I'll rebase on top of this.
