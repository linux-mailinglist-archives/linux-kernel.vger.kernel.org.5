Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E017D2984
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 06:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjJWE5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 00:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjJWE5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 00:57:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8E7D5B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 21:57:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839652b97so22121805e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 21:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698037064; x=1698641864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGtz+/MQRxfrHAnpLCrq4BoXI5MCTMZCHiUBxRPLmA4=;
        b=XkpDxcz8EPSAKEWLhsycUqoH1jv+5syUJlRB1nXyosfQn2pUgker5qRWK0UQ7dre7r
         p5MQ1WDXbeTihFJ7SzCAuFRsVhWNadEflGsH0kiS0TePAI2KZ8Ic8bGzJ3lMPjWCR9+q
         Z+Go6/WODNYPLfoWn3c/Y7PqovfVjX6EZj1VoTZLTsTXZhPcwvJUNptv4O7MZw864xkF
         lRGBxre9E/hDp8Fq+IaGXPI1kF0ssGl8Rj5NsHNxCziZpk5Y4FCNjzIROcLT9hhQrpMA
         s4rUHxbzlbebQhnfUAVuOLzxKQekB/NQLFGTL21USBWxalSntp4+wMG1+5mm1jvVRIHA
         wTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698037064; x=1698641864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGtz+/MQRxfrHAnpLCrq4BoXI5MCTMZCHiUBxRPLmA4=;
        b=B34ZpGL63a6gvC2wyYxQwNCF9SDsR+1XSbnwMzZktU3lQ48RvchojsOhKSBwodNIB/
         59JNd+H3oGim63go2oz7rqe5Gg1jkl8mKiKuTaqC2oQefi7NFcBvJMq06clU6Pv2f1ex
         nHddLuCHN815BgRJ9azwkpK/DmzxiLXqhhJWCcH2GuaIBjeCXlcrqWe88S6aOWzWjjXt
         LIdIPzSVvfrdlxgAEk7xS/6L66EgqRJP/sPX2TU3rOBRqBuLHOruPEYT50oiel00BWRW
         y6VziJiigZaWpoetJQbDH6y/3nhO1n//MI4AMxKZBFiUw6Bbwbyvu8/eKZJpxifs9qDB
         cnLw==
X-Gm-Message-State: AOJu0YyZKseG8hMF+9/Vof2M4sXyUls324pU9PuWEM6uBvkT3CdyRnKE
        Zxy9bKI7oWauf02/mAY70A0dzg==
X-Google-Smtp-Source: AGHT+IHqIdzJg+L6hUh5BLy9YGIX2wSFREX8EVuNJRZShwD3/E5x+3628NUW3Ueua6+MNnid9Tvi7Q==
X-Received: by 2002:a1c:7c0d:0:b0:406:53aa:7a5f with SMTP id x13-20020a1c7c0d000000b0040653aa7a5fmr6526369wmc.10.1698037064341;
        Sun, 22 Oct 2023 21:57:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b004063ea92492sm8536386wmb.22.2023.10.22.21.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 21:57:43 -0700 (PDT)
Date:   Mon, 23 Oct 2023 07:57:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zach O'Keefe <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/khugepaged: Fix an uninitialized variable bug
Message-ID: <cc831c0f-fa67-410d-a4f4-c9774e75019d@kadam.mountain>
References: <a1f3242f-1aae-4b46-9893-36b11ee0a6dd@moroto.mountain>
 <20231020093407.02be8ef4984ce31a7222f69f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020093407.02be8ef4984ce31a7222f69f@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 09:34:07AM -0700, Andrew Morton wrote:
> On Fri, 20 Oct 2023 17:13:32 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Smatch complains that "hpage" can be used uninitialized:
> > 
> >     mm/khugepaged.c:1234 collapse_huge_page()
> >     error: uninitialized symbol 'hpage'.
> > 
> > Initialized it on this path.
> > 
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1062,8 +1062,10 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
> >  	int node = hpage_collapse_find_target_node(cc);
> >  	struct folio *folio;
> >  
> > -	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask))
> > +	if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nmask)) {
> > +		*hpage = NULL;
> >  		return SCAN_ALLOC_HUGE_PAGE_FAIL;
> > +	}
> >  
> >  	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
> >  		folio_put(folio);
> 
> Thanks.   Seems this was accidentally fixed by 
> 
> Author:     Peter Xu <peterx@redhat.com>
> AuthorDate: Wed Feb 22 14:52:47 2023 -0500
> Commit:     Andrew Morton <akpm@linux-foundation.org>
> CommitDate: Tue Mar 28 16:20:06 2023 -0700
> 
>     mm/khugepaged: alloc_charge_hpage() take care of mem charge errors
> 
> 
> Which was quite a long time ago.  Are you scanning old kernel versions?

There are two error paths.  Peter's patch changed the second
SCAN_CGROUP_CHARGE_FAIL error path but left the first
SCAN_ALLOC_HUGE_PAGE_FAIL error path.

To be honest, it's probably a better idea to just add a *hpage = NULL
at the start of the function.

regards,
dan carpenter

