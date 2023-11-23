Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC17F65DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjKWR73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF718B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700762373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNOjqsptwz7c8grD/7MGGSeMypaQKvMpNZ+dH7MhfuE=;
        b=Xvv+B1JgzU1XF1EPYT8ImkYM7mZR5U+aGTYAKfqv5+8tfEIRz9CAJojvhsXZxZJzanhpav
        vQ11f+kr6a9M4dpM/nIi4hp5guaDL0eYGybJX82yC8s1ae88xWwKeyM1lj4imxLp3SXlyk
        0F/UQq1/DxHhNEKdXWK8IZ+Icx2LGwM=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-4BvZCTRMNleMXEHCXVB_NA-1; Thu, 23 Nov 2023 12:59:31 -0500
X-MC-Unique: 4BvZCTRMNleMXEHCXVB_NA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1f9847123e4so460833fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762371; x=1701367171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNOjqsptwz7c8grD/7MGGSeMypaQKvMpNZ+dH7MhfuE=;
        b=kVS7d2MBeZ/7I6pEPxOagt3gIxAcan/BRfdhqhGg+eMqgzwawCvY8bL7Dj7I4cmets
         8GIGv0CSyrQkHk5V7zqUiJGb+/d6DIwo7dLsfdZpR/EVtT8disYNcmV0mk5NA09B32Z7
         SBsaFx6gq/yjZkA1pnAF7eJ9MQ0lxp8dVExMx3Orcnp48Noj1dNjM5Yj1MRqMmYjwQEg
         TiehY/acv91UnOFYemgLxlR9zmlExwLbkRJGEHOQK+8eDCPZm8s0I7PbQcFWY9n4iMSZ
         z5CDWmdifS7+43ghn535EEQwd46Y1TSOWQQXEJkNK96/bCLvS2YYZ45dP54hotF7+WUK
         DQHQ==
X-Gm-Message-State: AOJu0YxKd9G3D9mC+/Ag9gS8SutqVgozGSxJaGOY2qt06o3Z6cE4khAl
        iJPtoc/KocSZ2FMps+oJpudrMDiHNEGT0ChbbjKR2DYMFuJE6kkivD2mer7OGj9rbXxuIIG7ATl
        tkD+qOQpSh7jAj1X/+V6g1DAnA2K/KBE/
X-Received: by 2002:a05:6358:5e14:b0:16e:b5d:43ce with SMTP id q20-20020a0563585e1400b0016e0b5d43cemr58993rwn.0.1700762370896;
        Thu, 23 Nov 2023 09:59:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOZ/NEKMBkQZYMvSkFjegl/MxRtWj9qDrEghOHEFAnl5us597gee6C44GeROrLuqIc03jbWg==
X-Received: by 2002:a05:6358:5e14:b0:16e:b5d:43ce with SMTP id q20-20020a0563585e1400b0016e0b5d43cemr58982rwn.0.1700762370511;
        Thu, 23 Nov 2023 09:59:30 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d16-20020a0cfe90000000b00677f3081deesm126346qvs.60.2023.11.23.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:59:30 -0800 (PST)
Date:   Thu, 23 Nov 2023 12:59:27 -0500
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
Subject: Re: [PATCH RFC 05/12] mm/gup: Fix follow_devmap_p[mu]d() to return
 even if NULL
Message-ID: <ZV-S_8XWSL9I9aw4@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-6-peterx@redhat.com>
 <ZV7+aP8x0aFE4D57@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV7+aP8x0aFE4D57@infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:25:28PM -0800, Christoph Hellwig wrote:
> On Wed, Nov 15, 2023 at 08:29:01PM -0500, Peter Xu wrote:
> > This seems to be a bug not by any report but by code observations.
> > 
> > When GUP sees a devpmd or devpud, it should return whatever value returned
> > from follow_devmap_p[mu]d().  If page==NULL returned, it means a fault is
> > probably required.  Skipping return the NULL should allow the code to fall
> > through, which can cause unexpected behavior.
> > 
> > It was there at least before the follow page rework (080dbb618b) in 2017,
> > so 6 years.  Not yet digging for a Fixes, assuming it can hardly trigger
> > even if the logical bug does exist.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> I'd still add a fixes tag and send if off to Linux for 6.7-rc instead
> of letting it linger.

Will do.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

When rethinking, "return page" is correct for devmap, but it should be
better to always use no_page_table() instead for page==NULL when trying to
return NULL for follow_page(), even if no_page_table() should constantly
return NULL for devmap, afaict, so it should be the same.

So I'll make it slightly different when reposting separately, please feel
free to have another look.

Thanks,

-- 
Peter Xu

