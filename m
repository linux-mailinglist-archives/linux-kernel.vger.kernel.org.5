Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326E17FE1B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjK2VUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjK2VUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:20:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E410DB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=snbaImfv3zlormUNSdyLXEJtHqS0syGmg48S3ZeIobc=; b=Trk/qX+6KUWoedcteU9LE/hnH5
        Hat6hae4Rg2zFyMNluwy2WNp+EZqrL0Ch4RpT6m/04u4PVnbx/q0YkObKt+r2uOq95KQHpMjUuduM
        Ac6lKR+C4O8pLAfEu2sZjZCupkxHzY0TU8LDwSu23fvgo02b0zS9Kiv//i44dIFdrOJ8qNph3vnEx
        SjCLb2Vq6ryo7VXYqkxU8g7Kk+fsdvEExQNuDZ108RqbXdN2ejU0KOFoiMYgaxfzmxyBFf8HinvOw
        NOraHyXRg3RdaR/Q8FCye3m7CbTjL+rDchu0L7d27uB6gxokLkm4es8hr8XqiqKKvefBPgkF0criY
        U3sY2eMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8Rye-00Dm4H-GD; Wed, 29 Nov 2023 21:20:12 +0000
Date:   Wed, 29 Nov 2023 21:20:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Christoph Lameter (Ampere)" <cl@linux.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC v3 0/9] SLUB percpu array caches and maple tree nodes
Message-ID: <ZWerDCdvVkAfsStz@casper.infradead.org>
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
 <b51bfc04-d770-3385-736a-01aa733c4622@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51bfc04-d770-3385-736a-01aa733c4622@linux.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:16:17PM -0800, Christoph Lameter (Ampere) wrote:
> Percpu arrays require the code to handle individual objects. Handling
> freelists in partial SLABS means that numerous objects can be handled at
> once by handling the pointer to the list of objects.

That works great until you hit degenerate cases like having one or two free
objects per slab.  Users have hit these cases and complained about them.
Arrays are much cheaper than lists, around 10x in my testing.

> In order to make the SLUB in page freelists work better you need to have
> larger freelist and that comes with larger page sizes. I.e. boot with
> slub_min_order=5 or so to increase performance.

That comes with its own problems, of course.

> Also this means increasing TLB pressure. The in page freelists of SLUB cause
> objects from the same page be served. The SLAB queueing approach
> results in objects being mixed from any address and thus neighboring objects
> may require more TLB entries.

Is that still a concern for modern CPUs?  We're using 1GB TLB entries
these days, and there are usually thousands of TLB entries.  This feels
like more of a concern for a 90s era CPU.

