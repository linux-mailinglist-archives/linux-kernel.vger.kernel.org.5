Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59F7F63CA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjKWQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKWQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7B1A4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700756378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCbhRTsSQmLGeB2Y6SZ9GGd5iZSLx7qmMRIcRmE96BM=;
        b=THdTOt7ZCi8HPrWfJY49ZEHw9vlwfMPzmZbJ8yHn6Ygmww81m0m+P9IYDS+nfz+oFgcchC
        F0kKs33N5nM3JN19rLtyaeLJE2AS27ht4B5AwZAKvRNEQpuLEAbYNhyyU/PO/eNb9N/oI2
        BTVvjjDGsSIdQBwFW9dtEa5uJZCpiEI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-u2q_yRu6Nni5EcawShSX4Q-1; Thu, 23 Nov 2023 11:19:36 -0500
X-MC-Unique: u2q_yRu6Nni5EcawShSX4Q-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b83d297fb7so239738b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756376; x=1701361176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCbhRTsSQmLGeB2Y6SZ9GGd5iZSLx7qmMRIcRmE96BM=;
        b=cNEKY4v5jsheaCKgWbqnWj67h10rSgklch7K/8vTJo62x3Hdj7f++eySgmZ2OPBWZ8
         oy9SWyXnYcmMb1D5V/qRFbT8Dgge2qjkzs7mGhlxfMCpSgT1slXe5Tna4KuhtIpp7usO
         Shqi/QxjQNZiHyMaEs0GkEKLiz+aV3Ugkn9V80ECGhP0szCb0ryUGvxBvC3GweZJ9Qvx
         ISwe9TPlSef4Z0g35fAwUhcLm94hGFI4BJt3r8JpByuO5Nyp/eOKrt+cgPYcRDlV90ed
         hlJIXZ3YWN4y5UTrcGhJBEQgu/baiTpp2m3I3b5v4Ne2tyH5voP2tjKJSVTQKyEL6o/s
         2IoQ==
X-Gm-Message-State: AOJu0YyNlfQTjbtNIc0WkI3HQxMYYDap9CiclB6e/8s6Jp2DvOK68LEW
        Xx8vDJWT2nlvstuGaZ1OVF186m2w7g0D4RAlo9EEu7uDuPpl2hmr+I8egBSEGJayw9zL7ieCvoc
        yNF5ubpzk6jYbpcAOHk4Letab
X-Received: by 2002:a05:6808:118:b0:3b6:db1b:67b7 with SMTP id b24-20020a056808011800b003b6db1b67b7mr6471457oie.4.1700756375989;
        Thu, 23 Nov 2023 08:19:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj341cAFbifzZn8hSKDGTqGwnVrVI9eN5MqbERDrXNX/6P/dAhTG4BNFEHbeWMfhYLK5o0iQ==
X-Received: by 2002:a05:6808:118:b0:3b6:db1b:67b7 with SMTP id b24-20020a056808011800b003b6db1b67b7mr6471427oie.4.1700756375756;
        Thu, 23 Nov 2023 08:19:35 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id e11-20020a0cf34b000000b0065b22afe53csm618347qvm.94.2023.11.23.08.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:19:35 -0800 (PST)
Date:   Thu, 23 Nov 2023 11:19:32 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 09/12] mm/gup: Handle huge pud for follow_pud_mask()
Message-ID: <ZV97lHHMtMTYPQHP@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-10-peterx@redhat.com>
 <ZV7/H6zTYodxVNl0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV7/H6zTYodxVNl0@infradead.org>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:28:31PM -0800, Christoph Hellwig wrote:
> > We need to export "struct follow_page_context" along the way, so that
> > huge_memory.c can understand it.
> 
> Again, thankfully not actually exported, just made global.

In the new version that shouldn't be needed, because I just noticed
huge_memory.c is only compiled with THP=on.  Logically it may start to make
sense at some point to have thp.c for THP=on, and huge_memory.c for THP ||
HUGETLB.  But I'd rather leave that done separately even if so..

In short, for this one, I'll drop that in the commit message, as I'll leave
"struct follow_page_context" alone.

> 
> > @@ -751,24 +746,25 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
> >  				    unsigned int flags,
> >  				    struct follow_page_context *ctx)
> >  {
> > -	pud_t *pud;
> > +	pud_t *pudp, pud;
> 
> This adding of pud while useful seems mostly unrelated and clutter
> the patch up quite a bit.  If you have to respin this anyway it might
> be worth to split it out into a little prep patch.

I can do this.  I'll also try to do the same for the rest patches, if
applicable.

Thanks,

-- 
Peter Xu

