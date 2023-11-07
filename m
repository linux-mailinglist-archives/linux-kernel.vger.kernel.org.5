Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCD17E49C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbjKGUVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjKGUV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:21:29 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD51726
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:20:59 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7789a4c01ddso404740685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1699388458; x=1699993258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSdfUIdEj0JA4xAkLjr8iNFR7V/inKgzjZ3p1JC+wVI=;
        b=wbTGB4vXh45h82huHIt/7BpA/ApT3oOCzdgFWO0nJsdiffpoag2wBNSp+bjLqGo7aO
         uznIXl5OzHlQd9s9F/XawbHziOP5ivXaHQugrXXGG69ypLt7ug+B0o9Okyvsa6078/pF
         KKIma+wLrPZGeDiGaYou882zt625KPE/kgdwLbpMJJ1iZIbgxWr+ApURdRfFc1jMj0sY
         dM2AP4Ie1pdnj5UdkMez2tCx75oOic72fdWapsOhjUPZRpNCBCHv75fI76NmWBt9ZSco
         ow2h8RobhB2PfSl1kQxO0MmiS9OaI7Md59Nff3NHuAvnJzaJ9j8gRFz4WKhQHtAnmNyS
         1IFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388458; x=1699993258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSdfUIdEj0JA4xAkLjr8iNFR7V/inKgzjZ3p1JC+wVI=;
        b=KYphEAI8KrJm784bc47ufFuT6qTAcKx9ydl+4gHGn0bfmfog+1MsafEqp55ih3NNF7
         YUFZUq7qS92JGLPkkQX9KHilzr1SwVId1qbnIlxpBTADtfIA+peORt7mNKkmPF7TDdul
         7KAEj9yl0jU0b73gEIxziIjfzKJ/VVK3gNmHGbLd0LlwMsHds2tLlm9qCFRw59AVaIOf
         WGR3pyWZsGg7XGQ6TPePZgHjdieZG8ddF0wB+C0hQT0tsLCIqXOcQGY1brU2olmVH4gk
         lXYhQalwsKlkv66TbFUfwrmwrZ5v4S6SrIGY07AO6VpJ3Lz0bU4IPsnD1dPKjT9yutzH
         joGQ==
X-Gm-Message-State: AOJu0YzxCGN1xwtGq3m9LzLGGj90jos8VunHHAEEyGZDcxiU98oloUHT
        HWvToNt7I0flcRxA6h/R1pOqOQ==
X-Google-Smtp-Source: AGHT+IGAqZDGsu4Irs+7ieqmt9vQpahnugUEkyICW5wIB+nND391lD3smddVlqQSiC/XBVJyLF9xcA==
X-Received: by 2002:a05:620a:459f:b0:772:64cb:bc64 with SMTP id bp31-20020a05620a459f00b0077264cbbc64mr36515549qkb.12.1699388458324;
        Tue, 07 Nov 2023 12:20:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:86b7])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a228400b007678973eaa1sm245681qkh.127.2023.11.07.12.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:20:58 -0800 (PST)
Date:   Tue, 7 Nov 2023 15:20:57 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        akpm@linux-foundation.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <20231107202057.GA3798394@cmpxchg.org>
References: <20231107181805.4188397-1-shr@devkernel.io>
 <ZUqRia1Ww0+wNfKr@casper.infradead.org>
 <20231107200616.GA3797353@cmpxchg.org>
 <ZUqZH2jUgrYeCY3z@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUqZH2jUgrYeCY3z@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 08:07:59PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 07, 2023 at 03:06:16PM -0500, Johannes Weiner wrote:
> > On Tue, Nov 07, 2023 at 07:35:37PM +0000, Matthew Wilcox wrote:
> > > On Tue, Nov 07, 2023 at 10:18:05AM -0800, Stefan Roesch wrote:
> > > > +++ b/mm/huge_memory.c
> > > > @@ -2740,7 +2740,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> > > >  			if (folio_test_swapbacked(folio)) {
> > > >  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
> > > >  							-nr);
> > > > -			} else {
> > > > +			} else if (folio_test_pmd_mappable(folio)) {
> > > >  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
> > > >  							-nr);
> > > >  				filemap_nr_thps_dec(mapping);
> > > 
> > > As I said, we also need the folio_test_pmd_mappable() for swapbacked.
> > > Not because there's currently a problem, but because we don't leave
> > > landmines for other people to trip over in future!
> > 
> > Do we need to fix filemap_unaccount_folio() as well?
> 
> Looks to me like it is already correct?
> 
>         __lruvec_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
>         if (folio_test_swapbacked(folio)) {
>                 __lruvec_stat_mod_folio(folio, NR_SHMEM, -nr);
>                 if (folio_test_pmd_mappable(folio))
>                         __lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, -nr);
>         } else if (folio_test_pmd_mappable(folio)) {
>                 __lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
>                 filemap_nr_thps_dec(mapping);
>         }

Argh, I overlooked it because it's nested further in due to that
NR_SHMEM update. Sorry about the noise.
