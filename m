Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76277C5868
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjJKPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjJKPpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:45:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F57493
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:45:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41b1a3329f2so118151cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697039133; x=1697643933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgB5ImVhNM/QI8rgc4CZqHFxucrjIchAqAaUbbPMb8k=;
        b=vFHmAtNAjW96fI66fwu6kotzo36+wSoFn1hIGb3vpsQTOsmBY8EdBUPyN/RJ5cZqJ4
         avd1NQRdozXYQSzLGt1Xy2igB7hMuF3TsGZPMg2QTkAdKc+9v2f+HQHq2gCEzgG2Ry4B
         xJipVPkLj4CCQLoH5UslEkdhPQAutLaSTRw7eQS4BzBJGFEB+Lme/duM3XwQ7UbAXs6H
         QO535mcDRTAewhE+N5O7BXuI3GDs9GDV0FDD7WLpAgmrFq5eGpnX7BGxxJs1QIDjTwks
         w3kCLSiw5vMGE+twqIIzeyoDEB445BD8oAUyjPhbielwe1lORPTCgzK/HwlKLPYgTMGD
         eeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039133; x=1697643933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgB5ImVhNM/QI8rgc4CZqHFxucrjIchAqAaUbbPMb8k=;
        b=Cf6N6naqNbzxG4anasw7hSI9zkKEfNZvJUgp7JhZri0mQZWpLicUM/5dzO4VPbdPH6
         p/K2U+CyeAhhx5FWF2CKhtbLKicuo3QicOm9wLIZPbC1OImuzrxqeJkuD7bePvFAqtoh
         Oe2SqNXz3xl9dz04jdR6lQFMX1YqQttb2kcNicSn5XGQK8HsZR0rY/iVk+i6kxvWk+Ss
         BJ8hj4ZXzOd+gSSorKb9IhKDB50K0Vng17ciW1L6Mgp7W9IrUC9Zovoqlnc3c7egl3Dv
         8dmqmAQ14DgP0RtfSS5ZPbpFJgeQeabpHe4kwhwko92ypGJk+RsWx6t+ZLyPvk7cy8Py
         hejg==
X-Gm-Message-State: AOJu0Yyb7hUSnmkgKNhM/hUBXK6cfX8gY2yb5h3gNvF0DkIVtD80aJeE
        Qsf4TJDzMV3MQoDj89ejts2bN1/FoGBSZwo5jyo=
X-Google-Smtp-Source: AGHT+IG2zx5JqexdUuTbyPo/25xvNszaxrIOkjeuPvNp0MwzgZMj4lbYB4LwgI3Q7QdFTaV4mz/h0Q==
X-Received: by 2002:ac8:7d10:0:b0:417:9a94:870b with SMTP id g16-20020ac87d10000000b004179a94870bmr24831509qtb.35.1697039133612;
        Wed, 11 Oct 2023 08:45:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:66a6])
        by smtp.gmail.com with ESMTPSA id b21-20020ac84f15000000b004180fdcb482sm5463227qte.81.2023.10.11.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:45:33 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:45:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20231011154532.GB461170@cmpxchg.org>
References: <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <20231011152525.GA461170@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011152525.GA461170@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:25:27AM -0400, Johannes Weiner wrote:
> On Tue, Oct 10, 2023 at 05:12:01PM -0400, Johannes Weiner wrote:
> > On Mon, Oct 02, 2023 at 10:26:44PM -0400, Zi Yan wrote:
> > > @@ -1614,10 +1652,43 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
> > >  
> > >  		order = buddy_order(page);
> > >  		move_to_free_list(page, zone, order, old_mt, new_mt);
> > > +		/*
> > > +		 * set page migratetype 1) only after we move all free pages in
> > > +		 * one pageblock and 2) for all pageblocks within the page.
> > > +		 *
> > > +		 * for 1), since move_to_free_list() checks page migratetype with
> > > +		 * old_mt and changing one page migratetype affects all pages
> > > +		 * within the same pageblock, if we are moving more than
> > > +		 * one free pages in the same pageblock, setting migratetype
> > > +		 * right after first move_to_free_list() triggers the warning
> > > +		 * in the following move_to_free_list().
> > > +		 *
> > > +		 * for 2), when a free page order is greater than pageblock_order,
> > > +		 * all pageblocks within the free page need to be changed after
> > > +		 * move_to_free_list().
> > 
> > I think this can be somewhat simplified.
> > 
> > There are two assumptions we can make. Buddies always consist of 2^n
> > pages. And buddies and pageblocks are naturally aligned. This means
> > that if this pageblock has the start of a buddy that straddles into
> > the next pageblock(s), it must be the first page in the block. That in
> > turn means we can move the handling before the loop.
> 
> Eh, scratch that. Obviously, a sub-block buddy can straddle blocks :(

I apologize for the back and forth, but I think I had it right the
first time. Say we have order-0 frees at pfn 511 and 512. Those can't
merge because their order-0 buddies are 510 and 513 respectively. The
same keeps higher-order merges below block size within the pageblock.
So again, due to the pow2 alignment, the only way for a buddy to
straddle a pageblock boundary is if it's >pageblock_order.

Please double check me on this, because I've stared at your patches
and the allocator code long enough now to thoroughly confuse myself.

My proposal for the follow-up changes still stands for now.
