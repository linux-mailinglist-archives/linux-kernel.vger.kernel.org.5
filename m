Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B417782D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjHJVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJVtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4D2728
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691704107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T1ExLvwy+wUPzZuAeU99YLpuaOF9jFHCSTBDaGG9zOU=;
        b=U+w4MPreEI4Q4krQLTIwKJ3soPl2HfgFmX7MsahZvAf0kyFi7A88AQdXp7Jih5rQPQcsR1
        KZHeP3f7SVBMQwvn5gDUGh3PLOXoh063QbCOTtxKiQt3TG29T4usTr5uL8rqxe2oqVSO88
        104LgQ9gbDY8ozLF/02EpQ3rBmHp4XA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-kL_K0ri4Pv2EfniqrSYwqw-1; Thu, 10 Aug 2023 17:48:22 -0400
X-MC-Unique: kL_K0ri4Pv2EfniqrSYwqw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63f96fcb4ccso3811656d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704101; x=1692308901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1ExLvwy+wUPzZuAeU99YLpuaOF9jFHCSTBDaGG9zOU=;
        b=kr/ACqdhIeX5ul/2fSXBJYqSHnDuHO6Joldi7OryOW1U0TUptKD8+p5VeiWtkQA/xb
         WsVAtGxATO4c17MH/Ebj0OSdgQY47L0Bn7N2LsQXga7aXrHMRrDtTDzufrk4MO0VMcMs
         fEufCN+hQ3xCMjNE1qHJiSp9oGHCPKa8kvrImGTY4d5K+6e3PVSMB1rNhqxfun0C2KAn
         wo06qcZVdvXXMy5yS98dZGpGgDPYrGEj+InejmvAASudjkQn/0Y3j5jAr3el9J0qlXDs
         3m2oUNjzllujNFdotOmYfQvM4WvRi6UFpGTPFrUpFgPw3uuIq2rDl0732Ql23Fc5WWbm
         8wAA==
X-Gm-Message-State: AOJu0YxjJSwT6ss9ZFZZMdKWtaNcYemrdnyMLS+iQlOJGLtG7/DgdHW1
        6h96alFZ79Rr1HvNdAcVvB6uHhgvS24qSyUkvaboObClNaz8+UmExpcHN9Euq0kXQ9Pq9RFAu7b
        5HZNJsFtPxyMCTyoN8TzgmIWg
X-Received: by 2002:ad4:5f87:0:b0:63c:f852:aa3a with SMTP id jp7-20020ad45f87000000b0063cf852aa3amr3922480qvb.4.1691704101694;
        Thu, 10 Aug 2023 14:48:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKQjfkLEtHK4TgBS5tvBCJy85maQwvYfEU+5Pht7gJJOOJ/2gXOWy0MnGa+bfiZMEcuCLmRw==
X-Received: by 2002:ad4:5f87:0:b0:63c:f852:aa3a with SMTP id jp7-20020ad45f87000000b0063cf852aa3amr3922466qvb.4.1691704101441;
        Thu, 10 Aug 2023 14:48:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b20-20020a0cf054000000b0062ffec0a18esm758095qvl.84.2023.08.10.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:48:20 -0700 (PDT)
Date:   Thu, 10 Aug 2023 17:48:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNVbIyHcqeKUDuSg@x1n>
References: <20230809083256.699513-1-david@redhat.com>
 <ZNQD4pxo8svpGmvX@x1n>
 <ZNRYx8GhYftE4Xeb@casper.infradead.org>
 <7e31254d-8889-7e79-50e1-2630bd493d59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e31254d-8889-7e79-50e1-2630bd493d59@redhat.com>
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

On Thu, Aug 10, 2023 at 10:37:04AM +0200, David Hildenbrand wrote:
> On 10.08.23 05:25, Matthew Wilcox wrote:
> > On Wed, Aug 09, 2023 at 05:23:46PM -0400, Peter Xu wrote:
> > > Hi, David,
> > > 
> > > Some pure questions below..
> > > 
> > > On Wed, Aug 09, 2023 at 10:32:56AM +0200, David Hildenbrand wrote:
> > > > Let's track the total mapcount for all large folios in the first subpage.
> > > > 
> > > > The total mapcount is what we actually want to know in folio_mapcount()
> > > > and it is also sufficient for implementing folio_mapped(). This also
> > > > gets rid of any "raceiness" concerns as expressed in
> > > > folio_total_mapcount().
> > > 
> > > Any more information for that "raciness" described here?
> > 
> > UTSL.
> > 
> >          /*
> >           * Add all the PTE mappings of those pages mapped by PTE.
> >           * Limit the loop to folio_nr_pages_mapped()?
> >           * Perhaps: given all the raciness, that may be a good or a bad idea.
> >           */
> > 
> 
> Yes, that comment from Hugh primarily discusses how we could possibly
> optimize the loop, and if relying on folio_nr_pages_mapped() to reduce the
> iterations would be racy. As far as I can see, there are cases where "it
> would be certainly a bad idea" :)

Is the race described about mapcount being changed right after it's read?
Are you aware of anything specific that will be broken, and will be fixed
with this patch?

I assume mapcount==1 will be very special in this case when e.g. holding a
pgtable lock, other than that I won't be surprised if mapcount changes in
parallel.  But I must confess I don't really have any thorough digests on
this whole matter.

> 
> 
> In the other comment in that function, it's also made clear what the
> traditional behavior with PMD-mappable THP was "In the common case, avoid
> the loop when no pages mapped by PTE", which will no longer hold with
> sub-PMD THP.

Having a total mapcount does sound helpful if partial folio is common
indeed.

I'm curious whether that'll be so common after the large anon folio work -
isn't it be sad if partial folio will be a norm?  It sounds to me that's
the case when small page sizes should be used.. and it's prone to waste?

-- 
Peter Xu

