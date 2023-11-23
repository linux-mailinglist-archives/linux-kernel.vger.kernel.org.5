Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE117F63AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjKWQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKWQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:11:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F30BA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700755912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8IbO4KgPnWaEztnpzO0r+lahYtNssXdnrhCz8eHLLKU=;
        b=QCTR32dpTm/6oH2BZAogKT6EO2WRNodRehfSiu9sNx9V5bShDusMmC08M+fWTNbAUR3H/K
        S6fPfeCfSoCufunnnvXni2bBRHcF4gCBuLf8CEgtwlpmeGdVZOlZdDPt0eE9KFbELSRz9G
        hbomZfqOWgeNnkTxtITYgoohFPcIz9E=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-DQcKuahAN1m91_-KOreXNA-1; Thu, 23 Nov 2023 11:11:50 -0500
X-MC-Unique: DQcKuahAN1m91_-KOreXNA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d664911ccfso134730a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755910; x=1701360710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IbO4KgPnWaEztnpzO0r+lahYtNssXdnrhCz8eHLLKU=;
        b=BhqPebWYnarJ7ZG6s4o8KmN+KbGto1oUY0VdaRPyhcVtY/3xYE6eZ0hGqacDOXnU//
         pT84aoxM9xinrLCiPApXDuIAEB3uPQQygRYppvlKIMv99YXHJ40zaO5Ht/3oagFx9NdX
         yv25XLZgVHMkOAXqGR5rh3olra5yXx0iz+slTEiOvrvuiJ8T4qc5khX+DsMJT5o6l5zk
         K6u1ccPbBhHLYKY+gnR0o1aFRcbB0/LJg00/JiX5ci7ZkqUsM19LRhPfmlYiBhZAd5sS
         pX4MIjSNnvi2Ngzv9zBdkN8AQREL+Oobn5FUX29qKbwxG/v/xVw14rbXUnQfmo7YSxkm
         CjlQ==
X-Gm-Message-State: AOJu0YzCAbsFx1DqxKszGQqfdhna0qy8X1Lwu9AE2OZvVD6xsnJhpVY8
        N5qa5ZnGtddqyGkRoEF5Vw0YFbOCRZMyvseJ/bjtWL1pe7vaQblbjhEr2jXe2K6DHlUVIL+U8FT
        o/X0/pEOkzluXxPQ/A5EZUTMo
X-Received: by 2002:a05:6820:2713:b0:589:dc7a:75e5 with SMTP id db19-20020a056820271300b00589dc7a75e5mr108258oob.1.1700755910168;
        Thu, 23 Nov 2023 08:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+2tFm6H3EiyYM7ARmM6DOGQygEKl6IoRRftHyYzKnTLw1QqSRG9maQ5eEZB/yHGvcwTzszg==
X-Received: by 2002:a05:6820:2713:b0:589:dc7a:75e5 with SMTP id db19-20020a056820271300b00589dc7a75e5mr108234oob.1.1700755909967;
        Thu, 23 Nov 2023 08:11:49 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dw14-20020a0562140a0e00b0067a0d46bc4esm293494qvb.58.2023.11.23.08.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:11:49 -0800 (PST)
Date:   Thu, 23 Nov 2023 11:11:47 -0500
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
Subject: Re: [PATCH RFC 04/12] mm: Introduce vma_pgtable_walk_{begin|end}()
Message-ID: <ZV95w730I45Y-XcK@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-5-peterx@redhat.com>
 <ZV7+KqGP9iG6+QaH@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV7+KqGP9iG6+QaH@infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:24:26PM -0800, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

One thing I'd prefer double check is this email in the R-b is different
from From:.  Should I always use lst.de for either tags and CCs for my
future versions?  Let me know if that matters.

Thanks,

-- 
Peter Xu

