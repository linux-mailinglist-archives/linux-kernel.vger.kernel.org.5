Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3C76A0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGaSw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGaSwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3731BF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690829492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LC0V9/+I+dQtKIWD+joyys4KFMU5FdyntHwr9WKxQxc=;
        b=JfkdPeDtINpJANRKsQ0me2FKCE9ltAvEgxmoruVewZegKAm+GfoPFEgQEzV5Na5BSofGg3
        YADLWffmoQBBqYwmcSGxbgxaLvCGh9d32skELpqD00Y0wUwrLOGyFL3Y6HLyJFUTVWmJDM
        Ty4G3xkwMSgDDx12+xrPudxlScCBvuM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-ObcA1mFJO2SfDrunWJa_nw-1; Mon, 31 Jul 2023 14:51:30 -0400
X-MC-Unique: ObcA1mFJO2SfDrunWJa_nw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76cb292df12so27842485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690829490; x=1691434290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC0V9/+I+dQtKIWD+joyys4KFMU5FdyntHwr9WKxQxc=;
        b=armyjPjpkDpcNhcl9ntIGKNdcaAPaWiLWQEc3LT2qY6IIMhc0FTfg4GFOG5JDHziwe
         N2BVdvVUkmxDJvxAdOGNpmA5E2iWVz/EyYOEGkaJ/Hy4ZjTDGGTW4+/h6UUAESON9eTe
         eW/TOZqtIZ916jb+MMyj2+rzs7ZZjHv8PsoK5Qzk9olo0iVu+9PQ9CPwlJcpDy6OzGde
         JPES6grOIFqgPIYFsREBYRZN3bo/+NLdElJWf5HAUzjyHODw62VANjay741rtnOTKKQy
         Jft0asxv9Id+GfXBGyUH4rSVhunWptxRLTNOFGinkTFQUEuAwA3gr2sEog1zYmNMgV/V
         fbOQ==
X-Gm-Message-State: ABy/qLYwOQb0qljDJ1g1Is6b/8V6ofiEKFOm8gJ2oKMIhVxWWasjgRUy
        DFrRfythb1/F23LR9wkmWofnReaO2kyBhAaT2QEGHYi2QerpTS8nRNbyokfPXL9rKQLzMqeOoCm
        PVbW6cClEGmW5en9DZ2T2lE1E
X-Received: by 2002:a05:620a:4620:b0:765:7783:a0ec with SMTP id br32-20020a05620a462000b007657783a0ecmr10445727qkb.4.1690829490222;
        Mon, 31 Jul 2023 11:51:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEg5YxLF59WmVvWOZ3yqWHlLOSK+aX3Y8j9q9S8wpsyhiYv7b9KXyA/YO/AvBdJ4oXFKIWEAw==
X-Received: by 2002:a05:620a:4620:b0:765:7783:a0ec with SMTP id br32-20020a05620a462000b007657783a0ecmr10445711qkb.4.1690829489916;
        Mon, 31 Jul 2023 11:51:29 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a16-20020a05620a125000b00767502e8601sm3513396qkl.35.2023.07.31.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 11:51:29 -0700 (PDT)
Date:   Mon, 31 Jul 2023 14:51:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMgCr4TxgNQZhhQK@x1n>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
 <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com>
 <ZMfc9+/44kViqjeN@x1n>
 <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
 <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:23:59AM -0700, Linus Torvalds wrote:
> So GUP-fast can only look at the page table data, and as such *has* to
> fail if the page table is inaccessible.
> 
> But GUP in general? Why would it want to honor numa faulting?
> Particularly by default, and _particularly_ for things like
> FOLL_REMOTE.

True.

> 
> In fact, I feel like this is what the real rule should be: we simply
> define that get_user_pages_fast() is about looking up the page in the
> page tables.
> 
> So if you want something that acts like a page table lookup, you use
> that "fast" thing.  It's literally how it is designed. The whole - and
> pretty much only - point of it is that it can be used with no locking
> at all, because it basically acts like the hardware lookup does.

Unfortunately I think at least kvm (besides the rest..) relies not only on
numa balancing but also fast-gup.. :-( Please refer to hva_to_pfn() where
it even supports fast-gup-only HVA translation when atomic==true set.

Thanks,

-- 
Peter Xu

