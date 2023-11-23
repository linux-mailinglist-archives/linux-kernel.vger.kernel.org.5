Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63E77F6300
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbjKWP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346240AbjKWP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF781BC0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700753240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5h6+cWGrz23YrwqeZDYI017fAYOSZdJb9rWkUmkd9M8=;
        b=BsBh6eBRghYRUxL332LiSHgcF1iwoUgOhJtaEPDhEtxUsIfjFCsQE+ewZFI4Ji007Ai3L6
        DmtYzdi84T3Mtpis8bHtT4xJ3if2SJ7yHVi8cw55xJhnVGE7eEiumlDn4d50wkMW2klvto
        lwlyD/1v2+KwHBNfCMpgzkPxYXe72EM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-3JXbwu5TPt-M_f2hGWZFSQ-1; Thu, 23 Nov 2023 10:27:19 -0500
X-MC-Unique: 3JXbwu5TPt-M_f2hGWZFSQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a06b43afcso1659146d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753239; x=1701358039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h6+cWGrz23YrwqeZDYI017fAYOSZdJb9rWkUmkd9M8=;
        b=h3gSQfg5al1rwafKs2mjC43mvgN1DJXmioloIaFpBDzyZcTCJwbWw1AqLkL7hk8xfz
         nQgvEshFvvrppI1H5GQJo9mT3cBDkyx285LQ8B3S5yb/RBI6X1tOGMfLCM/Z3tg8gAvE
         O5P+XK1QmEyeDVGNNbAiD10cVQpHnZN9c7HW9fxtJ/utay0ss0VpGN6z9BE1UAZUfkl+
         TX5ndokhB1QApF7Zciv3VuVTczQIDAXb/wIWLGBreTRzhYIKDQ019ruX2bJaoID0/c/D
         QqT7gRBrVCFX9reK1Ta2PuSK3BGkCFNEB5JpzF2Z0Leq4ZVpK/QtlXZP0XyDjI5zxVmB
         c/Rw==
X-Gm-Message-State: AOJu0YzCnl5AY1Kcbxegv915M3geYeDFNUSbRDcoZFQQT5YKa2MomSG0
        VR4bY7uoF7CNS9Cqyre/p0uOORzRfmCQWUpVqgwe9w/tUDAqtXjGPigNogyzmnfnXBNPcwFI6uX
        TYybZPTiYEfpssSa4v4C5Kl0+
X-Received: by 2002:a0c:cd84:0:b0:679:e920:8cd8 with SMTP id v4-20020a0ccd84000000b00679e9208cd8mr5882099qvm.5.1700753238793;
        Thu, 23 Nov 2023 07:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkvNKZEqH2ak52nhp8X2gBafkO8yc53zv/hP53yhnuHDSS+q0WRPYSzaBGEY3q9PwqUY/POA==
X-Received: by 2002:a0c:cd84:0:b0:679:e920:8cd8 with SMTP id v4-20020a0ccd84000000b00679e9208cd8mr5882075qvm.5.1700753238487;
        Thu, 23 Nov 2023 07:27:18 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id w24-20020a05620a149800b0077d587e5589sm531883qkj.27.2023.11.23.07.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:27:18 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:27:15 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 03/12] mm: Export HPAGE_PXD_* macros even if !THP
Message-ID: <ZV9vU6sHbDOHB_rv@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-4-peterx@redhat.com>
 <ZV7+Dc1EeVNyV1lL@infradead.org>
 <20231123095304.GD636165@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231123095304.GD636165@kernel.org>
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

On Thu, Nov 23, 2023 at 11:53:04AM +0200, Mike Rapoport wrote:
> On Wed, Nov 22, 2023 at 11:23:57PM -0800, Christoph Hellwig wrote:
> > No way to export macros :)
> > 
> > I'd say define, but other might have better ideas.
> 
> Make HPAGE_PXD_* macros visible even if !THP

Sounds good, thanks both!

Besides, I do plan to introduce a new macro in the next version to mean
"THP || HUGETLB", so as to put PxD code segments into it and not compile
when unnecessary (!THP && !HUGETLB).

Currently what I had is:

config PGTABLE_HAS_HUGE_LEAVES
	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE

I didn't use something like CONFIG_HUGE_PAGE because it's too close to
HUGETLB_PAGE, even if generic and short enough.  Please speak if there's
any early comments on that, either the name or the format. For example, I
can also define it in e.g. mm/internal.h, instead of a config entry.

-- 
Peter Xu

