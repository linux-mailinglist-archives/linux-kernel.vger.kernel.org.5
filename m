Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748427F67A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjKWTi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKWTim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB31993
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700768243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xmOn5+FX7gFongPnnuombqlFZm27jJX8g7knRz4U4Fc=;
        b=Tm9POf0VUvJ6IlPmwpWos+8bxsDPJVfUTvl4x3TYcJ4jwG28IFLi592SLP+yUPhgJgSnM3
        2C1WRWXALzzPN2Ki0j5R/huaKYitO5MklpLHwjBNAPv64hBRko5tZa3JpwqqA6gxbJSXbl
        C86aQcBa718MeP6kHWYQ5EMfoonEIww=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-97tkLO_lMMus0et7M8vDFw-1; Thu, 23 Nov 2023 14:37:22 -0500
X-MC-Unique: 97tkLO_lMMus0et7M8vDFw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1f9efc41382so457fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700768242; x=1701373042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmOn5+FX7gFongPnnuombqlFZm27jJX8g7knRz4U4Fc=;
        b=TPpzVGIMTakgSEU2FdTWEa3VgKwpne/47y5Z/zn3xC1vPtjUdBdZCcWA5ZA0HunoJ+
         JaeeFca9wvnsqgTxm6AMpq/QTk2pXyZqPyGJoGJd4fa7UUuqNFXIhihiEvCOZvCgOmVn
         4+J8G6JX8n/ZONxzC4c0zkQz7j0Lru14Sx5cR/DmVjukFMlsL/bVqtbDO9EsQRxTYSiX
         QbGhRzY7smiwYUJY5nLcV4V4HhABOQtkBvigC+aJwjSjeoJWjmT22kz2XXPHUulGDYTx
         AVG0VVD+hiKUd+iF2YJD6PqtT2GZ4EPxxkIvfHIVaOuQgY1Ac7Q8jfr75o1Kii6cNPL5
         O0iQ==
X-Gm-Message-State: AOJu0YzDfyXkD3W5R3UcsmfO9EK5HvKLDmcSQPbM1sPtGYn0r9CW2bbO
        RBLgSfVX400WJdWCzweSYs7SN8DOV9IDvG/4L2wXtKLPXk4er8cp4Iid390qoBxt9k+6FwfcuYI
        o0BiAULsKnfVXFWZk/wOySiQr
X-Received: by 2002:a05:6870:d0a:b0:1f9:5346:2121 with SMTP id mk10-20020a0568700d0a00b001f953462121mr357560oab.4.1700768241736;
        Thu, 23 Nov 2023 11:37:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkKmRMwIRaB3Ih9vdlTMJmgge2PoiF567J/ze233V1+FMKyortqkbCHa/MQ2E7l3VCDMjKhQ==
X-Received: by 2002:a05:6870:d0a:b0:1f9:5346:2121 with SMTP id mk10-20020a0568700d0a00b001f953462121mr357535oab.4.1700768241485;
        Thu, 23 Nov 2023 11:37:21 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id kd26-20020a05622a269a00b00421b14f7e7csm690038qtb.48.2023.11.23.11.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 11:37:21 -0800 (PST)
Date:   Thu, 23 Nov 2023 14:37:18 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZV-p7haI5SmIYACs@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
 <ZV4co7wcI-_wK91F@x1n>
 <57be0ed0-f1d7-4583-9a5f-3ed7deb0ea97@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57be0ed0-f1d7-4583-9a5f-3ed7deb0ea97@csgroup.eu>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 06:22:33PM +0000, Christophe Leroy wrote:
> > For fast-gup I think the hugepd code is in use, however for walk_page_*
> > apis hugepd code shouldn't be reached iiuc as we have the hugetlb specific
> > handling (walk_hugetlb_range()), so anything within walk_pgd_range() to hit
> > a hugepd can be dead code to me (but note that this "dead code" is good
> > stuff to me, if one would like to merge hugetlb instead into generic mm).
> 
> Not sure what you mean here. What do you mean by "dead code" ?
> A hugepage directory can be plugged at any page level, from PGD to PMD.
> So the following bit in walk_pgd_range() is valid and not dead:
> 
> 		if (is_hugepd(__hugepd(pgd_val(*pgd))))
> 			err = walk_hugepd_range((hugepd_t *)pgd, addr, next, walk, PGDIR_SHIFT);

IMHO it boils down to the question on whether hugepd is only used in
hugetlbfs.  I think I already mentioned that above, but I can be more
explicit; what I see is that from higher stack in __walk_page_range():

	if (is_vm_hugetlb_page(vma)) {
		if (ops->hugetlb_entry)
			err = walk_hugetlb_range(start, end, walk);
	} else
		err = walk_pgd_range(start, end, walk);

It means to me as long as the vma is hugetlb, it'll not trigger any code in
walk_pgd_range(), but only walk_hugetlb_range().  Do you perhaps mean
hugepd is used outside hugetlbfs?

Thanks,

-- 
Peter Xu

