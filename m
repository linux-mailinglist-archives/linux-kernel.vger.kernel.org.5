Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FE0767409
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjG1Rz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjG1Rzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD410CB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690566899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5BKzqiVvDxpi79QFmZnEbX/IsAn0VcOVhbxmE8BoKs=;
        b=Mgr42134k7//Fz4TY5OJV5SMK70WnwtrAcSW9xoR97WffnTYaSG+NWSX5n8sqvNKBogowr
        0A07ZaIfoqmutHFCLDsx/dW6U7cwaltlkNSkXGJpTI5OppSUNid94uCIRiCq/fItG5RrZj
        D1xDmvbh7D+GhrxGE+HtI87h5P0kza8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-R7tNtWu2N0Wax3teaPI3rw-1; Fri, 28 Jul 2023 13:54:57 -0400
X-MC-Unique: R7tNtWu2N0Wax3teaPI3rw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso12849185e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566896; x=1691171696;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5BKzqiVvDxpi79QFmZnEbX/IsAn0VcOVhbxmE8BoKs=;
        b=MdfgAvs5MGqj9GNtuaxyeukRXYJJf8TAWpcJ5Y+xy7WmiayfZ8h4qq2Gg+uHG6QO0F
         AKyMLi3DQrcmi9Gd+xc8aV4FjYs97lU3d+yC7djIGopN3cUBZEq+Te/EWnn4jbl5FeHG
         qvuQVN1zZXamu5V39ZvpdCbPg77I6IXtauLhHvvYS9POpS9S2rmN48HB6NPLrbQewIs5
         nYRgYylM2Zz6+pRgh7fg0ul3YDLEWIQcihi5PpoArFe64aDAl3dsftok5NvQMLDoi6CC
         TN837x2XiT9SYcr3ftInftQwybKZ3TwA/6nH+Dq13OFKnqdlH3LiVa75FWhXN7wm4q53
         Ezkg==
X-Gm-Message-State: ABy/qLZC5Pzk1j6LyOvYzsJEZGqyQsfGubF6Z8/ccO9JotkQayOXIErk
        cOuFq4Ah2pbLCB0vfAlAbmMLDzlosby9dzsqwDRS0jnjqficMMjg5lytS4FykwoW1QcCvItBtaf
        4noLHQ7taEfFjMupTrc33APuQ
X-Received: by 2002:a7b:cd8c:0:b0:3fb:fa9f:5292 with SMTP id y12-20020a7bcd8c000000b003fbfa9f5292mr2354778wmj.25.1690566896496;
        Fri, 28 Jul 2023 10:54:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7SOsuepFtym4CnisxHoIJWa6n6aCxJkcZmmuVxr7VgQqWSHOCuv9c22vtqlzHoKGzRhjwVA==
X-Received: by 2002:a7b:cd8c:0:b0:3fb:fa9f:5292 with SMTP id y12-20020a7bcd8c000000b003fbfa9f5292mr2354756wmj.25.1690566896027;
        Fri, 28 Jul 2023 10:54:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c029100b003f9bd9e3226sm4760553wmk.7.2023.07.28.10.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:54:55 -0700 (PDT)
Message-ID: <29a7a660-ea24-abcd-ba7a-beef9c074340@redhat.com>
Date:   Fri, 28 Jul 2023 19:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
Organization: Red Hat
In-Reply-To: <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> 
> There was the case for "FOLL_PIN represents application behavior and
> should trigger NUMA faults", but I guess that can be ignored.
> 
> But it would be much better to just remove all that if we can.
> 
> Let me look into some details.

I just stumbled over the comment from Mel in follow_trans_huge_pmd():

/* Full NUMA hinting faults to serialise migration in fault paths */

It dates back to

commit 2b4847e73004c10ae6666c2e27b5c5430aed8698
Author: Mel Gorman <mgorman@suse.de>
Date:   Wed Dec 18 17:08:32 2013 -0800

     mm: numa: serialise parallel get_user_page against THP migration
     
     Base pages are unmapped and flushed from cache and TLB during normal
     page migration and replaced with a migration entry that causes any
     parallel NUMA hinting fault or gup to block until migration completes.
     
     THP does not unmap pages due to a lack of support for migration entries
     at a PMD level.  This allows races with get_user_pages and
     get_user_pages_fast which commit 3f926ab945b6 ("mm: Close races between
     THP migration and PMD numa clearing") made worse by introducing a
     pmd_clear_flush().
     
     This patch forces get_user_page (fast and normal) on a pmd_numa page to
     go through the slow get_user_page path where it will serialise against
     THP migration and properly account for the NUMA hinting fault.  On the
     migration side the page table lock is taken for each PTE update.


We nowadays do have migration entries at PMD level -- and setting FOLL_FORCE
could similarly trigger such a race.

So I suspect we're good.

-- 
Cheers,

David / dhildenb

