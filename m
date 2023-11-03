Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89637E064C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344763AbjKCQWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjKCQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2BF111
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699028474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNgudPCc13D4/tjUOv7XPhTpnXTcLS65Xsn8KNXaBsc=;
        b=a7upcP+ohYVYsfBMtCj/eAxMfif3PMlF3ivb5hYVIanFwtWlB/iOIlSTKgacqG207fpYDL
        ZSPN4NOG16dt51w6VhKYXYYDjuC/j+AF9KLaI3yJZvXf34EKJMvfsHgkr4scsg03Y66AeI
        56EdyXfGWHj3gTt6Qw+2Q9+bErWHwUI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-qTo86_hcP5C2SOhjH-WgDg-1; Fri,
 03 Nov 2023 12:21:07 -0400
X-MC-Unique: qTo86_hcP5C2SOhjH-WgDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77B522932483;
        Fri,  3 Nov 2023 16:21:05 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A91BC2026D4C;
        Fri,  3 Nov 2023 16:20:56 +0000 (UTC)
Date:   Sat, 4 Nov 2023 00:20:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Will Shiu =?utf-8?B?KOioseaBreeRnCk=?= <Will.Shiu@mediatek.com>,
        Peter Wang =?utf-8?B?KOeOi+S/oeWPiyk=?= 
        <peter.wang@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Chao =?utf-8?B?KOi2meePruWdhyk=?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= 
        <Chun-hung.Wu@mediatek.com>,
        Powen Kao =?utf-8?B?KOmrmOS8r+aWhyk=?= <Powen.Kao@mediatek.com>,
        Naomi Chu =?utf-8?B?KOacseipoOeUsCk=?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Stanley Chu =?utf-8?B?KOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>, ming.lei@redhat.com
Subject: Re: [PATCH 1/1] block: Check the queue limit before bio submitting
Message-ID: <ZUUd48QF/TEGFzPy@fedora>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
 <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:23:26AM +0000, Ed Tsai (蔡宗軒) wrote:
> On Wed, 2023-10-25 at 17:22 +0800, ed.tsai@mediatek.com wrote:
> > From: Ed Tsai <ed.tsai@mediatek.com>
> > 
> > Referring to commit 07173c3ec276 ("block: enable multipage bvecs"),
> > each bio_vec now holds more than one page, potentially exceeding
> > 1MB in size and causing alignment issues with the queue limit.
> > 
> > In a sequential read/write scenario, the file system maximizes the
> > bio's capacity before submitting. However, misalignment with the
> > queue limit can result in the bio being split into smaller I/O
> > operations.
> > 
> > For instance, assuming the maximum I/O size is set to 512KB and the
> > memory is highly fragmented, resulting in each bio containing only
> > one 2-pages bio_vec (i.e., bi_size = 1028KB). This would cause the
> > bio to be split into two 512KB portions and one 4KB portion. As a
> > result, the originally expected continuous large I/O operations are
> > interspersed with many small I/O operations.
> > 
> > To address this issue, this patch adds a check for the max_sectors
> > before submitting the bio. This allows the upper layers to
> > proactively
> > detect and handle alignment issues.
> > 
> > I performed the Antutu V10 Storage Test on a UFS 4.0 device, which
> > resulted in a significant improvement in the Sequential test:
> > 
> > Sequential Read (average of 5 rounds):
> > Original: 3033.7 MB/sec
> > Patched: 3520.9 MB/sec
> > 
> > Sequential Write (average of 5 rounds):
> > Original: 2225.4 MB/sec
> > Patched: 2800.3 MB/sec
> > 
> > Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> > ---
> >  block/bio.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 816d412c06e9..a4a1f775b9ea 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1227,6 +1227,7 @@ static int __bio_iov_iter_get_pages(struct bio
> > *bio, struct iov_iter *iter)
> >  	iov_iter_extraction_t extraction_flags = 0;
> >  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> >  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> > +	struct queue_limits *lim = &bdev_get_queue(bio->bi_bdev)-
> > >limits;
> >  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> >  	struct page **pages = (struct page **)bv;
> >  	ssize_t size, left;
> > @@ -1275,6 +1276,11 @@ static int __bio_iov_iter_get_pages(struct bio
> > *bio, struct iov_iter *iter)
> >  		struct page *page = pages[i];
> >  
> >  		len = min_t(size_t, PAGE_SIZE - offset, left);
> > +		if (bio->bi_iter.bi_size + len >
> > +		    lim->max_sectors << SECTOR_SHIFT) {
> > +			ret = left;
> > +			break;
> > +		}
> >  		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> >  			ret = bio_iov_add_zone_append_page(bio, page,
> > len,
> >  					offset);
> > -- 
> > 2.18.0
> > 
> 
> 
> Hi Jens,
> 
> Just to clarify any potential confusion, I would like to provide
> further details based on the assumed scenario mentioned above.
> 
> When the upper layer continuously sends 1028KB full-sized bios for
> sequential reads, the Block Layer sees the following sequence:
> 	submit bio: size = 1028KB, start LBA = n
> 	submit bio: size = 1028KB, start LBA = n + 1028KB 
> 	submit bio: size = 1028KB, start LBA = n + 2056KB
> 	...
> 
> However, due to the queue limit restricting the I/O size to a maximum
> of 512KB, the Block Layer splits into the following sequence:
> 	submit bio: size = 512KB, start LBA = n
> 	submit bio: size = 512KB, start LBA = n +  512KB
> 	submit bio: size =   4KB, start LBA = n + 1024KB	
> 	submit bio: size = 512KB, start LBA = n + 1028KB
> 	submit bio: size = 512KB, start LBA = n + 1540KB
> 	submit bio: size =   4KB, start LBA = n + 2052KB
> 	submit bio: size = 512KB, start LBA = n + 2056KB
> 	submit bio: size = 512KB, start LBA = n + 2568KB
> 	submit bio: size =   4KB, start LBA = n + 3080KB
> 	...
> 	
> The original expectation was for the storage to receive large,
> contiguous requests. However, due to non-alignment, many small I/O
> requests are generated. This problem is easily visible because the
> user pages passed in are often allocated by the buddy system as order 0
> pages during page faults, resulting in highly non-contiguous memory.

If order 0 page is added to bio, the multipage bvec becomes nop
basically(256bvec holds 256 pages), then how can it make a difference
for you?

> 
> As observed in the Antutu Sequential Read test below, it is similar to
> the description above where the splitting caused by the queue limit
> leaves small requests sandwiched in between:
> 
> block_bio_queue: 8,32 R 86925864 + 2144 [Thread-51]
> block_split: 8,32 R 86925864 / 86926888 [Thread-51]
> block_split: 8,32 R 86926888 / 86927912 [Thread-51]
> block_rq_issue: 8,32 R 524288 () 86925864 + 1024 [Thread-51]
> block_rq_issue: 8,32 R 524288 () 86926888 + 1024 [Thread-51]
> block_bio_queue: 8,32 R 86928008 + 2144 [Thread-51]
> block_split: 8,32 R 86928008 / 86929032 [Thread-51]
> block_split: 8,32 R 86929032 / 86930056 [Thread-51]
> block_rq_issue: 8,32 R 524288 () 86928008 + 1024 [Thread-51]
> block_rq_issue: 8,32 R 49152 () 86927912 + 96 [Thread-51]
> block_rq_issue: 8,32 R 524288 () 86929032 + 1024 [Thread-51]
> block_bio_queue: 8,32 R 86930152 + 2112 [Thread-51]
> block_split: 8,32 R 86930152 / 86931176 [Thread-51]
> block_split: 8,32 R 86931176 / 86932200 [Thread-51]
> block_rq_issue: 8,32 R 524288 () 86930152 + 1024 [Thread-51]
> block_rq_issue: 8,32 R 49152 () 86930056 + 96 [Thread-51]
> block_rq_issue: 8,32 R 524288 () 86931176 + 1024 [Thread-51]
> block_bio_queue: 8,32 R 86932264 + 2096 [Thread-51]
> block_split: 8,32 R 86932264 / 86933288 [Thread-51]
> block_split: 8,32 R 86933288 / 86934312 [Thread-51]
> block_rq_issue: 8,32 R 524288 () 86932264 + 1024 [Thread-51]
> block_rq_issue: 8,32 R 32768 () 86932200 + 64 [Thread-51]
> block_rq_issue: 8,32 R 524288 () 86933288 + 1024 [Thread-51]
> 
> I simply prevents non-aligned situations in bio_iov_iter_get_pages.

But there is still 4KB IO left if you limit max bio size is 512KB,
then how does this 4KB IO finally go in case of 1028KB IO?

> Besides making the upper layer application aware of the queue limit, I
> would appreciate any other directions or suggestions you may have.

The problem is related with IO size from application.

If you send unaligned IO, you can't avoid the last IO with small size, no
matter if block layer bio split is involved or not. Your patch just lets
__bio_iov_iter_get_pages split the bio, and you still have 4KB left
finally when application submits 1028KB, right?

Then I don't understand why your patch improves sequential IO
performance.

Thanks,
Ming

