Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A5D7AAE6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjIVJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIVJm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749FF7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695375732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHbKJQD99RHkPaRhhbHOWTPH6yUWis/4T4P+YrCjIp4=;
        b=J5JS471/9oUD5pcMz5GAwRDkvO2JfnQaBndtoqZIafUxxHCY/ius8zleNiAWYQI/zbbcab
        ZKQWtpi7Mo8Yw5ogDAb9m3fHPxf+BbuInMKFKXsFiToF0UUnCiQr1Nx0TWotuWs89oNkd+
        RHl5r5MAgAX5MSPaCrv6Vs2kvd5hBfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-2lPEIwvsMume4LXXx42iCA-1; Fri, 22 Sep 2023 05:42:09 -0400
X-MC-Unique: 2lPEIwvsMume4LXXx42iCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D16B08039D1;
        Fri, 22 Sep 2023 09:42:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E79810EE859;
        Fri, 22 Sep 2023 09:42:06 +0000 (UTC)
Date:   Fri, 22 Sep 2023 17:42:03 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Jaeseon Sim <jason.sim@samsung.com>
Cc:     "urezki@gmail.com" <urezki@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: Re: [PATCH] mm/vmalloc: Remove WARN_ON_ONCE related to
 adjust_va_to_fit_type
Message-ID: <ZQ1ha+wIaTJ9+aU8@MiWiFi-R3L-srv>
References: <CGME20230922061715epcms1p7cd5a37f4bba0abf4bc159b844bd8ee65@epcms1p1>
 <20230922062704epcms1p1722f24d4489a0435b339ce21db754ded@epcms1p1>
 <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQ1ftk5yDBv+p6A4@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/23 at 05:34pm, Baoquan He wrote:
> Hi Jaeseon,
> 
> On 09/22/23 at 03:27pm, Jaeseon Sim wrote:
> > There's panic issue as follows when do alloc_vmap_area:
> > 
> > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > 
> > page allocation failure: order:0, mode:0x800(GFP_NOWAIT)
> > Call Trace:
> > warn_alloc+0xf4/0x190
> > __alloc_pages_slowpath+0xe0c/0xffc
> > __alloc_pages+0x250/0x2d0
> > new_slab+0x17c/0x4e0
> > ___slab_alloc+0x4e4/0x8a8
> > __slab_alloc+0x34/0x6c
> > kmem_cache_alloc+0x20c/0x2f0
> > adjust_va_to_fit_type
> > __alloc_vmap_area
> > alloc_vmap_area+0x298/0x7fc
> > __get_vm_area_node+0x10c/0x1b4
> > __vmalloc_node_range+0x19c/0x7c0
> > 
> > Commit 1b23ff80b399 ("mm/vmalloc: invoke classify_va_fit_type() in
> > adjust_va_to_fit_type()") moved classify_va_fit_type() into
> > adjust_va_to_fit_type() and used WARN_ON_ONCE() to handle return
> > value of adjust_va_to_fit_type(), just as classify_va_fit_type()
> > was handled.
> 
> I don't get what you are fixing. In commit 1b23ff80b399, we have
                                   ~~ s/In/Before/, typo
> "if (WARN_ON_ONCE(type == NOTHING_FIT))", it's the same as the current
> code. You set panic_on_warn, it will panic in old code before commit
> 1b23ff80b399. Isn't it an expected behaviour?
> 
> > 
> > There is another path in adjust_va_to_fit_type() which could
> > return failure and will be handled in alloc_vmap_area().
> > Remove WARN_ON_ONCE() for this case.
> > 
> > Fixes: 45c62fc2897d ("mm/vmalloc: Remove WARN_ON_ONCE related to adjust_va_to_fit_type")
> 
> The commit id for Fixes tag is wrong.
> 
> > Signed-off-by: Jaeseon Sim <jason.sim@samsung.com>
> > ---
> >  mm/vmalloc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ef8599d394fd..4a82b6525d48 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1522,7 +1522,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> >  
> >          /* Update the free vmap_area. */
> >          ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> > -        if (WARN_ON_ONCE(ret))
> > +        if (ret)
> >                  return vend;
> >  
> >  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> > @@ -4143,7 +4143,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> >                  ret = adjust_va_to_fit_type(&free_vmap_area_root,
> >                                              &free_vmap_area_list,
> >                                              va, start, size);
> > -                if (WARN_ON_ONCE(unlikely(ret)))
> > +                if (unlikely(ret))
> >                          /* It is a BUG(), but trigger recovery instead. */
> >                          goto recovery;
> >  
> > -- 
> > 2.17.1
> > 
> 

