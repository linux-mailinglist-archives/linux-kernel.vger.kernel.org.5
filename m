Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90A779A8E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjHKWTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHKWTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8E31703
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691792307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmeas2NEzxsPQpZufMSchtFdVh8A95sRbIu+0MZwtg4=;
        b=fLUNQ60FqxHQwfZ3xxC63cIjxiPyaEKzuHh4biyB7XuWnYhwP/QcezItG9RcGEZJrKtI7O
        htzpGaoOI0/XwEeJgI4ik84dhHeauOWOtI/DeKhY7V1eTbEzPIuc25MO6K7JgG7PdHkuHG
        ul8dMMDoil9CCgT/KKAJIGDmfXMpQsc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-AsqtAgRkOh6wPpYunxTtlw-1; Fri, 11 Aug 2023 18:18:26 -0400
X-MC-Unique: AsqtAgRkOh6wPpYunxTtlw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76cb292df12so73060285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691792306; x=1692397106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmeas2NEzxsPQpZufMSchtFdVh8A95sRbIu+0MZwtg4=;
        b=Wdkt6V78x/ICRNSfvpIwQlWdErQj57dCw+/Ny7agCZw9LtchRZ9tleCvz/uVuGWAAz
         CKMaGC8IVd/WcsE/bq/ZrYmUdzpNMowQuYUCUM3MTZ9EXOjDvgBk/9N6u2+piy+8c3UD
         AxfIHcUzEkr0K7BBQxD4r+22iX1Nj12nziXCAycng5Wnlfxjwcc/U4oYAlVGgsyodRQG
         1Y42OkkQbXoZm/LrB2YGW93nr76Zd4Cncu5c08B8+5Lz7uPtPGk4d80eWHbKsPMVoD97
         ao9BENEVNRZDvN8RF43tYWdLQvXxMOE+zSx3GNsLOfXHbktcFef18FX+uVhT1ZkzGrFy
         pWaA==
X-Gm-Message-State: AOJu0YyMjZdOePXpGw8fSP/mJuJNmn0OEHIZXugd4sqwPUySmnecQ8Q8
        294s5axqV1wKx8WNezLFkFzfh5BhBQx5vbgbICTvMO2Wd68prePgZZeW6SFRAwT3ljet0/P6BuA
        rTr6Xwn7bSWcJGLeeVtaWlB0Z
X-Received: by 2002:ac8:5995:0:b0:40f:f509:3a85 with SMTP id e21-20020ac85995000000b0040ff5093a85mr3138543qte.6.1691792305853;
        Fri, 11 Aug 2023 15:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUxOrMW7NnKDkIKGGX7eyKW3GFX6pksc6x+BXUwwIhVMYQQt6D3U4Z0wLLpDBFfKmHZ6W4Fw==
X-Received: by 2002:ac8:5995:0:b0:40f:f509:3a85 with SMTP id e21-20020ac85995000000b0040ff5093a85mr3138525qte.6.1691792305540;
        Fri, 11 Aug 2023 15:18:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h11-20020ac8744b000000b00403ad6ec2e8sm1444566qtr.26.2023.08.11.15.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 15:18:24 -0700 (PDT)
Date:   Fri, 11 Aug 2023 18:18:23 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNazr4ylywFZcIcG@x1n>
References: <ZNUbNDiciFefJngZ@x1n>
 <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com>
 <ZNVPJ9xxd2oarR3I@x1n>
 <ZNVbObUGbos73ZJ5@casper.infradead.org>
 <8222bf8f-6b99-58f4-92cc-44113b151d14@redhat.com>
 <ZNZRTmvkAlm4yeAd@x1n>
 <b001adf2-238d-1708-673d-6f512a53e1e9@redhat.com>
 <ZNZarsR7cVn/QH+H@x1n>
 <8aac858e-0f12-4b32-e9df-63c76bdf2377@redhat.com>
 <14C73423-C643-4B72-B3DD-573F5636B5E0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14C73423-C643-4B72-B3DD-573F5636B5E0@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:11:55PM -0400, Zi Yan wrote:
> On 11 Aug 2023, at 12:08, David Hildenbrand wrote:
> 
> > On 11.08.23 17:58, Peter Xu wrote:
> >> On Fri, Aug 11, 2023 at 05:32:37PM +0200, David Hildenbrand wrote:
> >>> On 11.08.23 17:18, Peter Xu wrote:
> >>>> On Fri, Aug 11, 2023 at 12:27:13AM +0200, David Hildenbrand wrote:
> >>>>> On 10.08.23 23:48, Matthew Wilcox wrote:
> >>>>>> On Thu, Aug 10, 2023 at 04:57:11PM -0400, Peter Xu wrote:
> >>>>>>> AFAICS if that patch was all correct (while I'm not yet sure..), you can
> >>>>>>> actually fit your new total mapcount field into page 1 so even avoid the
> >>>>>>> extra cacheline access.  You can have a look: the trick is refcount for
> >>>>>>> tail page 1 is still seems to be free on 32 bits (if that was your worry
> >>>>>>> before).  Then it'll be very nice if to keep Hugh's counter all in tail 1.
> >>>>>>
> >>>>>> No, refcount must be 0 on all tail pages.  We rely on this in many places
> >>>>>> in the MM.
> >>>>>
> >>>>> Very right.
> >>>>
> >>>> Obviously I could have missed this in the past.. can I ask for an example
> >>>> explaining why refcount will be referenced before knowing it's a head?
> >>>
> >>> I think the issue is, when coming from a PFN walker (or GUP-fast), you might
> >>> see "oh, this is a folio, let's lookup the head page". And you do that.
> >>>
> >>> Then, you try taking a reference on that head page. (see try_get_folio()).
> >>>
> >>> But as you didn't hold a reference on the folio yet, it can happily get
> >>> freed + repurposed in the meantime, so maybe it's not a head page anymore.
> >>>
> >>> So if the field would get reused for something else, grabbing a reference
> >>> would corrupt whatever is now stored in there.
> >>
> >> Not an issue before large folios, am I right?  Because having a head page
> >> reused as tail cannot happen iiuc with current thps if only pmd-sized,
> >> because the head page is guaranteed to be pmd aligned physically.
> >
> > There are other users of compound pages, no? THP and hugetlb are just two examples I think. For example, I can spot __GFP_COMP in slab code.
> >
> > Must such compound pages would not be applicable to GUP, though, but to PFN walkers could end up trying to grab them.
> >
> For FS supporting large folios, their page cache pages can be any order <= PMD_ORDER.
> See page_cache_ra_order() in mm/readahead.c

Ah yes..

> 
> >>
> >> I don't really know, where a hugetlb 2M head can be reused by a 1G huge
> >> later right during the window of fast-gup walking. But obviously that's not
> >> common either if that could ever happen.
> >>
> >> Maybe Matthew was referring to something else (per "in many places")?
> >
> > There are some other cases where PFN walkers want to identify tail pages to skip over them. See the comment in has_unmovable_pages().

Indeed.

Thanks!

-- 
Peter Xu

