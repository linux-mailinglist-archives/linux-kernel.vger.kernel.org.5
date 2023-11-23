Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F27F63D2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjKWQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKWQVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C996EDD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700756521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DuAPFZsLfuFJfSIFcGuyKOkcKTNhDR0UWQewobd1eDI=;
        b=ICcDA84yj0nj0hiAhW5DnrEnMiJSNUz7FJaoyQcuk5fWVUTh9Vv9IJaVJV5mhNJf2ge1KG
        omMb3LgGhUKrKJg95KNQy3iD6VGw0tnzD2IoMu5zS1pgb4oOSBAIVuZjO93gElD/XCCTT3
        bjRTD5RebyhSVAeqOCFPWkQQKMB+Lzg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-FBe7IkwuMxC-9i40e7gbQg-1; Thu, 23 Nov 2023 11:21:59 -0500
X-MC-Unique: FBe7IkwuMxC-9i40e7gbQg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a05428cceso1949766d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756519; x=1701361319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuAPFZsLfuFJfSIFcGuyKOkcKTNhDR0UWQewobd1eDI=;
        b=qtMKNZZt+kxdUoP5114brRiecdqQZWENY6wqWrrA2Ft8BRHVAdcEJklhzZVt10wSX2
         vJksnbyT/xWb/vgRea6aHEAzipyux9/XgiiILFTBsr+s2QLsqPFwA0d6ZOiSAERo2UEo
         SLDMPQUiAD27G/ukrVcumC4D8CcQlMeBVYS1CxUZTBpD/QsgDrCppWLDlag+lElLuxPL
         HFeqKzGmU5R3rl7VFCKwqlyjjdEIjSpGdsIro0NCUL1ZMr6MsFAlGFM5E0lLEr7OMwxK
         wwtGXDqGDBFpPUxJMfW2hd2G6MImnbH4KUR1/6LaJTYsnOI6yozyXr/3n+cBCXSy4IiK
         M1Sg==
X-Gm-Message-State: AOJu0YxIaMygvtIIndgeuCaLKa4lpNIV8pS5cDsnrksdAykEowG/GFGv
        wfatsrecACyUm3FFcdvvlf9itfbRTwK9pmk/R3U7ClJWvXxKyegU378eAjDMTY4VnVoB/EffdWQ
        Pzf1xs0FmQoOXQC44Iler9S08
X-Received: by 2002:a0c:cd84:0:b0:679:e920:8cd8 with SMTP id v4-20020a0ccd84000000b00679e9208cd8mr6050408qvm.5.1700756519357;
        Thu, 23 Nov 2023 08:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrj1O1hpDc6NeAxpV2GS1vrZy3hZQzyEhzxehhRvLXaDQdDUWvnEYNo3xTnqa3wcqvAyN9mA==
X-Received: by 2002:a0c:cd84:0:b0:679:e920:8cd8 with SMTP id v4-20020a0ccd84000000b00679e9208cd8mr6050394qvm.5.1700756519163;
        Thu, 23 Nov 2023 08:21:59 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ff18-20020a0562140bd200b00679df43b715sm558828qvb.127.2023.11.23.08.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:21:58 -0800 (PST)
Date:   Thu, 23 Nov 2023 11:21:56 -0500
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
Subject: Re: [PATCH RFC 12/12] mm/gup: Merge hugetlb into generic mm code
Message-ID: <ZV98JDaWkeP4P1ib@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-13-peterx@redhat.com>
 <ZV7/dtKtwPIQsv4q@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV7/dtKtwPIQsv4q@infradead.org>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:29:58PM -0800, Christoph Hellwig wrote:
> Bit, but the subject makes it sound like hugetlbfs is gone to me.
> What about something like:
> 
> mm/gup: handle hugetlb in the generic follow_page_mask code
> 
> ?

Sure thing.

-- 
Peter Xu

