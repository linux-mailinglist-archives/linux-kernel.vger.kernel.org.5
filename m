Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C787F6A06
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjKXBHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:07:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EAD1B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1700788038;
        bh=2xxxAalZ73cRwdZRWpl45yBEiTMvShJqt0Ovd9kac2g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aLUR6BoFlBYtiJSS1etIcfjzdaRpP7n06oAX400JbB3OP61oS/wOD/3jq4bPjiHo7
         3wV4SPvTP17Yymwb3AVOw5cxJL3maWt8kTqxiWD0fQM4wcqqDzYWLfxL3K9rkKAnFf
         ojmOBd5/ZElekPwIA7twndtJZFq7XZH8nRc4O9ntZ4Cxpv3JrqzErLQo5ugIGxzrhe
         AnO4HeawO2liLqIkV6zztDc+3tAcLf8juI796b7ZvbBbqqPK25FTyG884GBMkPQKCQ
         LJw3I9E1ued7g3z1a+HLCZCJix/By7U4i3qv7cRtce+cFZDtLBozzgMFENOcehn3bS
         8PA1SWmy4fqQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbxfF0fnlz4wd2;
        Fri, 24 Nov 2023 12:07:17 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
In-Reply-To: <ZV4co7wcI-_wK91F@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org> <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org> <ZV4co7wcI-_wK91F@x1n>
Date:   Fri, 24 Nov 2023 12:06:24 +1100
Message-ID: <87y1eoq7sf.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:
> On Wed, Nov 22, 2023 at 12:00:24AM -0800, Christoph Hellwig wrote:
>> On Tue, Nov 21, 2023 at 10:59:35AM -0500, Peter Xu wrote:
...
>> 
>> If dropping the check is the right thing for now (and I think the ppc
>> maintainers and willy as the large folio guy might have a more useful
>> opinions than I do), leaving a comment in would be very useful.
>
> Willy is in the loop, and I just notice I didn't really copy ppc list, even
> I planned to..  I am adding the list (linuxppc-dev@lists.ozlabs.org) into
> this reply.  I'll remember to do so as long as there's a new version.

Thanks.

> The other reason I feel like hugepd may or may not be further developed for
> new features like large folio is that I saw Power9 started to shift to
> radix pgtables, and afaics hugepd is only supported in hash tables
> (hugepd_ok()).

Because it's powerpc it's not quite that simple :}

Power9 uses the Radix MMU by default, but the hash page table MMU is
still supported.

However although hugepd is used with the hash page table MMU, that's
only when PAGE_SIZE=4K. These days none of the major distros build with
4K pages.

But some of the non-server CPU platforms also use hugepd. 32-bit 8xx
does, which is actively maintained by Christophe.

And I believe Freescale e6500 can use it, but that is basically
orphaned, and although I boot test it I don't run any hugetlb tests.
(I guess I should do that).

cheers
