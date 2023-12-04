Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57820803AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjLDQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjLDQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1153AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701708537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DlFD7GhwLjb9S13yNsgkI3KXvw6iVqGQQvaiU30gBvU=;
        b=Il0kLUyM12rNafdXjZQvm82s/fpgXndxk/nOX7x4wEx9en6Yy9cXcYPsbZcAgj2GJmfJfm
        UeZFM+x1qbaVjLdye1j5QLqj/uHfmHJyhPi702sod4aWKdDrI8jNK/fp9uFFH+ys2zj1Sy
        IkjWYy7Gldug/+OOuGYG5CNDhinBAa0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-yFlc80ULO6GoJA8YRmdZJw-1; Mon, 04 Dec 2023 11:48:56 -0500
X-MC-Unique: yFlc80ULO6GoJA8YRmdZJw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b395875bd0so114632839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708535; x=1702313335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlFD7GhwLjb9S13yNsgkI3KXvw6iVqGQQvaiU30gBvU=;
        b=XerfXk07deeAwk4eSlc8dKirzrPXUUqV1KydC7omfCMBDuA/yo/yiCvWJ9vDtVJRuC
         wc1D8kVe+hVtgozWDm+n1HAHNEquNYU9tgOBicKDr51GoIyg786tBPOOgsLZIviT0gLr
         ota38/0xe4ItAvktra83kH1YuNUftE9wGKykz2RWW1Q1tcmanuPb6C7nvFtVLr1zNPfW
         k5e0P3dNgyPHRIvLBKILl8F3v43WjeMqH7gsnTdrAD3xgHnGrJut1gGxOp3bRfKtoguz
         aJWy6glBmwjd5h58wU7kweTj2dEgEOe/XYfgWTS7EQimkzj1tZU8Zjy7RX1dafLMDqlx
         a0nA==
X-Gm-Message-State: AOJu0Yxo8DaOmbARQ+ypd0E3x4MtH0+8XZGsFlbECK9YLJOV5brt8Jjy
        yyB4VKbu6VjZQlN4R0TdjfAauNI/FvJzn6mU8ntr5cdZ4QQNpFw/+mEM1N5MWOw2ad5o0PwdcNW
        W7iBS4K/8IxKO6Rd3cQ77LpHw
X-Received: by 2002:a05:6602:2245:b0:7b3:5be5:fa55 with SMTP id o5-20020a056602224500b007b35be5fa55mr32630809ioo.2.1701708535613;
        Mon, 04 Dec 2023 08:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMbZTTWxY8DAhdNOUcz7fb265lA/l2cJEQ3I487U8F0Nm42ahY5dHXJJc8+VpefYo3r7ArvA==
X-Received: by 2002:a05:6602:2245:b0:7b3:5be5:fa55 with SMTP id o5-20020a056602224500b007b35be5fa55mr32630779ioo.2.1701708535343;
        Mon, 04 Dec 2023 08:48:55 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id b10-20020a02a58a000000b00463fb5dd52dsm2637378jam.57.2023.12.04.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:48:55 -0800 (PST)
Date:   Mon, 4 Dec 2023 11:48:52 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
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
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZW4C9I2LHmZY-COM@x1n>
References: <ZV21GCbG48nTLDzn@infradead.org>
 <ZV90JcnQ1RGud/0R@casper.infradead.org>
 <ZV-KQ0e0y9BTsHGv@x1n>
 <d2313c1d-1e50-49b7-bed7-840431af799a@arm.com>
 <ZV-sJsdFfXiCkylv@x1n>
 <510adc26-9aed-4745-8807-dba071fadbbe@arm.com>
 <ZWDKV0XNjplc_vUP@x1n>
 <ZWj_EgljG3NwS5r1@x1n>
 <283da12c-14f1-4255-b3c4-ab933f3373c4@csgroup.eu>
 <01aad92f-b1e0-4f31-b905-8b1c2012ebab@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01aad92f-b1e0-4f31-b905-8b1c2012ebab@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:11:26AM +0000, Ryan Roberts wrote:
> To be honest, while I understand pte_cont() and friends, I don't understand
> their relevance (or at least potential future relevance) to GUP?

GUP in general can be smarter to recognize if a pte/pmd is a cont_pte and
fetch the whole pte/pmd range if the caller specified.  Now it loops over
each pte/pmd.

Fast-gup is better as it at least doesn't take pgtable lock, for cont_pte
it looks inside gup_pte_range() which is good enough, but it'll still do
folio checks for each sub-pte, even though the 2nd+ folio checks should be
mostly the same (if to ignore races when the folio changed within the time
of processing the cont_pte chunk).

Slow-gup (as of what this series is about so far) doesn't do that either,
for each cont_pte whole entry it'll loop N times, frequently taking and
releasing the pgtable lock.  A smarter slow-gup can fundamentallly setup
follow_page_context.page_mask if it sees a cont_pte.  There might be a
challenge on whether holding the head page's refcount would stablize the
whole folio, but that may be another question to ask.

I think I also overlooked that PPC_8XX also has cont_pte support, so we
actually have three users indeed, if not counting potential future archs
adding support to also get that same tlb benefit.

Thanks,

-- 
Peter Xu

