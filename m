Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD987E498E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjKGUGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjKGUGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:06:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CBED78
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:06:18 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cb76f3cf0so38624581cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1699387577; x=1699992377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=55lKD58CSWiBTKri8vJYjhibnCHFWQzcAQZlaP1nFrQ=;
        b=bSnv5Eku580EiuXUbs0cd0BzNSXL4espHh2AiirJrmY+cKR9pMJxJAV/588lqsOLcZ
         mJZBrH9TqOkSlp/F/PHAth6WSnWlJ0gNR2nHMHKMBUa+lOMNPeOvRSlcXiCjoBeecozu
         o70MMbVqBMm2L8QEVn4ATWab17SfmyDE7+X89cpqnurrVgAbN7HgesqEc/GiyeRO2mzT
         JmjkUyUg/tEPU41dWFTpBSfIGWhtu6BpGacNfFa3tA8f3nLgDQsUjEcKPbHyUpvlfql6
         kwF3LKqpILl4T/zqO6P3OQ7Tp72/qlMToKapcyQ4zyX3qnyF8rLrHaWl1sI26bbiIuCv
         j3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699387577; x=1699992377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55lKD58CSWiBTKri8vJYjhibnCHFWQzcAQZlaP1nFrQ=;
        b=Hi/hmwy2R6UAN2jn4jx7lpcGzfx0WhCRTTZBA376bCsQJ+XHx/PuI0HXnkAceyNzfY
         qOGQ/AjvOCXWim0PQjsNQgvBtBJOmKU63VFaUdC/wIC35aPJdrCKT6LJbIl0df8XcVLC
         U7LIZIUeyOM4f0V/Pf/YT0/Fj1xrm2G8afK1kitebvtahdhiwiry91/8Wkj+tV0jx9MI
         Uf9GcORyvWKu3FkZy4vorpSly7y2gpj1Bcg0vTrwcl6f3g1BvW0ym1KO2FSKFLxWix2e
         xQlviS68dgTclEdPu6qTHSnycudLHAQe2WknQkwaaiO4ZHnQQ4N3OCtslccxhCOMy1YK
         83IA==
X-Gm-Message-State: AOJu0YzxMvVSnPueP1pZgRYTJOkXhXblzelfKVS2UbBDN6x4OU9Wa0iq
        P9zckwjzZzd1HIGBym9IGVeAgQ==
X-Google-Smtp-Source: AGHT+IHNGyiB71fHv3CuAu7RO94OVfUQtCEaLhqImk34eBJ7oT5XoYlB7MvDeInK08DfY8GkHNDOFw==
X-Received: by 2002:a05:622a:2cd:b0:41c:bbbc:2ede with SMTP id a13-20020a05622a02cd00b0041cbbbc2edemr36123938qtx.14.1699387577691;
        Tue, 07 Nov 2023 12:06:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:86b7])
        by smtp.gmail.com with ESMTPSA id k16-20020ac84750000000b004033c3948f9sm16296qtp.42.2023.11.07.12.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:06:17 -0800 (PST)
Date:   Tue, 7 Nov 2023 15:06:16 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        akpm@linux-foundation.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <20231107200616.GA3797353@cmpxchg.org>
References: <20231107181805.4188397-1-shr@devkernel.io>
 <ZUqRia1Ww0+wNfKr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUqRia1Ww0+wNfKr@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:35:37PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 07, 2023 at 10:18:05AM -0800, Stefan Roesch wrote:
> > +++ b/mm/huge_memory.c
> > @@ -2740,7 +2740,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >  			if (folio_test_swapbacked(folio)) {
> >  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
> >  							-nr);
> > -			} else {
> > +			} else if (folio_test_pmd_mappable(folio)) {
> >  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
> >  							-nr);
> >  				filemap_nr_thps_dec(mapping);
> 
> As I said, we also need the folio_test_pmd_mappable() for swapbacked.
> Not because there's currently a problem, but because we don't leave
> landmines for other people to trip over in future!

Do we need to fix filemap_unaccount_folio() as well?
