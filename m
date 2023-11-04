Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29367E0DA4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbjKDDos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjKDDoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B012184
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699069436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1LrTjRfjBJLKAZKTPJ3e6IBQx9TBLxXp5gJn/UCemk=;
        b=BmkXAep27o8yWmezOL5z8AUS8FH+EzDwa5Y7kyCGQQ8/CovFZtChW93AwEWI3RHCkTUM0J
        IEjjOsRJx41+8Mfe8av3o/j9MF1oA/mmYArrQ45uqeoLvxnDmulMkMpPx0NxleFl1UKYKR
        pttQnrhhaw4rq22GtFa+4ZfgvuDKhRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-uSNpMGNxPwW7gYHyU4CZ-g-1; Fri, 03 Nov 2023 23:43:51 -0400
X-MC-Unique: uSNpMGNxPwW7gYHyU4CZ-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A8C282401E;
        Sat,  4 Nov 2023 03:43:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59EFD2166B26;
        Sat,  4 Nov 2023 03:43:40 +0000 (UTC)
Date:   Sat, 4 Nov 2023 11:43:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>
Cc:     Will Shiu =?utf-8?B?KOioseaBreeRnCk=?= <Will.Shiu@mediatek.com>,
        Peter Wang =?utf-8?B?KOeOi+S/oeWPiyk=?= 
        <peter.wang@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Chao =?utf-8?B?KOi2meePruWdhyk=?= 
        <Alice.Chao@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        Chun-Hung Wu =?utf-8?B?KOW3q+mnv+Wujyk=?= 
        <Chun-hung.Wu@mediatek.com>,
        Powen Kao =?utf-8?B?KOmrmOS8r+aWhyk=?= <Powen.Kao@mediatek.com>,
        Naomi Chu =?utf-8?B?KOacseipoOeUsCk=?= <Naomi.Chu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Stanley Chu =?utf-8?B?KOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>, ming.lei@redhat.com
Subject: Re: [PATCH 1/1] block: Check the queue limit before bio submitting
Message-ID: <ZUW96Ha5GoJePD8Y@fedora>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
 <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
 <ZUUd48QF/TEGFzPy@fedora>
 <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 01:11:02AM +0000, Ed Tsai (蔡宗軒) wrote:
> On Sat, 2023-11-04 at 00:20 +0800, Ming Lei wrote:
> >  On Wed, Nov 01, 2023 at 02:23:26AM +0000, Ed Tsai (蔡宗軒) wrote:
> > > On Wed, 2023-10-25 at 17:22 +0800, ed.tsai@mediatek.com wrote:
> > > > From: Ed Tsai <ed.tsai@mediatek.com>
> > > > 
> > > > Referring to commit 07173c3ec276 ("block: enable multipage
> > bvecs"),
> > > > each bio_vec now holds more than one page, potentially exceeding
> > > > 1MB in size and causing alignment issues with the queue limit.
> > > > 
> > > > In a sequential read/write scenario, the file system maximizes
> > the
> > > > bio's capacity before submitting. However, misalignment with the
> > > > queue limit can result in the bio being split into smaller I/O
> > > > operations.
> > > > 
> > > > For instance, assuming the maximum I/O size is set to 512KB and
> > the
> > > > memory is highly fragmented, resulting in each bio containing
> > only
> > > > one 2-pages bio_vec (i.e., bi_size = 1028KB). This would cause
> > the
> > > > bio to be split into two 512KB portions and one 4KB portion. As a
> > > > result, the originally expected continuous large I/O operations
> > are
> > > > interspersed with many small I/O operations.
> > > > 
> > > > To address this issue, this patch adds a check for the
> > max_sectors
> > > > before submitting the bio. This allows the upper layers to
> > > > proactively
> > > > detect and handle alignment issues.
> > > > 
> > > > I performed the Antutu V10 Storage Test on a UFS 4.0 device,
> > which
> > > > resulted in a significant improvement in the Sequential test:
> > > > 
> > > > Sequential Read (average of 5 rounds):
> > > > Original: 3033.7 MB/sec
> > > > Patched: 3520.9 MB/sec
> > > > 
> > > > Sequential Write (average of 5 rounds):
> > > > Original: 2225.4 MB/sec
> > > > Patched: 2800.3 MB/sec
> > > > 
> > > > Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> > > > ---
> > > >  block/bio.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/block/bio.c b/block/bio.c
> > > > index 816d412c06e9..a4a1f775b9ea 100644
> > > > --- a/block/bio.c
> > > > +++ b/block/bio.c
> > > > @@ -1227,6 +1227,7 @@ static int __bio_iov_iter_get_pages(struct
> > bio
> > > > *bio, struct iov_iter *iter)
> > > >  iov_iter_extraction_t extraction_flags = 0;
> > > >  unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> > > >  unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> > > > +struct queue_limits *lim = &bdev_get_queue(bio->bi_bdev)-
> > > > >limits;
> > > >  struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> > > >  struct page **pages = (struct page **)bv;
> > > >  ssize_t size, left;
> > > > @@ -1275,6 +1276,11 @@ static int __bio_iov_iter_get_pages(struct
> > bio
> > > > *bio, struct iov_iter *iter)
> > > >  struct page *page = pages[i];
> > > >  
> > > >  len = min_t(size_t, PAGE_SIZE - offset, left);
> > > > +if (bio->bi_iter.bi_size + len >
> > > > +    lim->max_sectors << SECTOR_SHIFT) {
> > > > +ret = left;
> > > > +break;
> > > > +}
> > > >  if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> > > >  ret = bio_iov_add_zone_append_page(bio, page,
> > > > len,
> > > >  offset);
> > > > -- 
> > > > 2.18.0
> > > > 
> > > 
> > > 
> > > Hi Jens,
> > > 
> > > Just to clarify any potential confusion, I would like to provide
> > > further details based on the assumed scenario mentioned above.
> > > 
> > > When the upper layer continuously sends 1028KB full-sized bios for
> > > sequential reads, the Block Layer sees the following sequence:
> > > submit bio: size = 1028KB, start LBA = n
> > > submit bio: size = 1028KB, start LBA = n + 1028KB 
> > > submit bio: size = 1028KB, start LBA = n + 2056KB
> > > ...
> > > 
> > > However, due to the queue limit restricting the I/O size to a
> > maximum
> > > of 512KB, the Block Layer splits into the following sequence:
> > > submit bio: size = 512KB, start LBA = n
> > > submit bio: size = 512KB, start LBA = n +  512KB
> > > submit bio: size =   4KB, start LBA = n + 1024KB
> > > submit bio: size = 512KB, start LBA = n + 1028KB
> > > submit bio: size = 512KB, start LBA = n + 1540KB
> > > submit bio: size =   4KB, start LBA = n + 2052KB
> > > submit bio: size = 512KB, start LBA = n + 2056KB
> > > submit bio: size = 512KB, start LBA = n + 2568KB
> > > submit bio: size =   4KB, start LBA = n + 3080KB
> > > ...
> > > 
> > > The original expectation was for the storage to receive large,
> > > contiguous requests. However, due to non-alignment, many small I/O
> > > requests are generated. This problem is easily visible because the
> > > user pages passed in are often allocated by the buddy system as
> > order 0
> > > pages during page faults, resulting in highly non-contiguous
> > memory.
> > 
> > If order 0 page is added to bio, the multipage bvec becomes nop
> > basically(256bvec holds 256 pages), then how can it make a difference
> > for you?
> 
> 
> 
> > 
> > > 
> > > As observed in the Antutu Sequential Read test below, it is similar
> > to
> > > the description above where the splitting caused by the queue limit
> > > leaves small requests sandwiched in between:
> > > 
> > > block_bio_queue: 8,32 R 86925864 + 2144 [Thread-51]
> > > block_split: 8,32 R 86925864 / 86926888 [Thread-51]
> > > block_split: 8,32 R 86926888 / 86927912 [Thread-51]
> > > block_rq_issue: 8,32 R 524288 () 86925864 + 1024 [Thread-51]
> > > block_rq_issue: 8,32 R 524288 () 86926888 + 1024 [Thread-51]
> > > block_bio_queue: 8,32 R 86928008 + 2144 [Thread-51]
> > > block_split: 8,32 R 86928008 / 86929032 [Thread-51]
> > > block_split: 8,32 R 86929032 / 86930056 [Thread-51]
> > > block_rq_issue: 8,32 R 524288 () 86928008 + 1024 [Thread-51]
> > > block_rq_issue: 8,32 R 49152 () 86927912 + 96 [Thread-51]
> > > block_rq_issue: 8,32 R 524288 () 86929032 + 1024 [Thread-51]
> > > block_bio_queue: 8,32 R 86930152 + 2112 [Thread-51]
> > > block_split: 8,32 R 86930152 / 86931176 [Thread-51]
> > > block_split: 8,32 R 86931176 / 86932200 [Thread-51]
> > > block_rq_issue: 8,32 R 524288 () 86930152 + 1024 [Thread-51]
> > > block_rq_issue: 8,32 R 49152 () 86930056 + 96 [Thread-51]
> > > block_rq_issue: 8,32 R 524288 () 86931176 + 1024 [Thread-51]
> > > block_bio_queue: 8,32 R 86932264 + 2096 [Thread-51]
> > > block_split: 8,32 R 86932264 / 86933288 [Thread-51]
> > > block_split: 8,32 R 86933288 / 86934312 [Thread-51]
> > > block_rq_issue: 8,32 R 524288 () 86932264 + 1024 [Thread-51]
> > > block_rq_issue: 8,32 R 32768 () 86932200 + 64 [Thread-51]
> > > block_rq_issue: 8,32 R 524288 () 86933288 + 1024 [Thread-51]
> > > 
> > > I simply prevents non-aligned situations in bio_iov_iter_get_pages.
> > 
> > But there is still 4KB IO left if you limit max bio size is 512KB,
> > then how does this 4KB IO finally go in case of 1028KB IO?
> > 
> > > Besides making the upper layer application aware of the queue
> > limit, I
> > > would appreciate any other directions or suggestions you may have.
> > 
> > The problem is related with IO size from application.
> > 
> > If you send unaligned IO, you can't avoid the last IO with small
> > size, no
> > matter if block layer bio split is involved or not. Your patch just
> > lets
> > __bio_iov_iter_get_pages split the bio, and you still have 4KB left
> > finally when application submits 1028KB, right?
> > 
> > Then I don't understand why your patch improves sequential IO
> > performance.
> > 
> > Thanks,
> > Ming
> > 
> 
> The application performs I/O with a sufficitenly large I/O size,
> causing it to constantly fill up and submit full bios. However, in the
> iomap direct I/O scenario, pages are added to the bio one by one from
> the user buffer. This typically triggers page faults, resulting in the
> allocation of order 0 pages from the buddy system.
> 
> The remaining amount of each order in the buddy system varies over
> time. If there are not enough pages available in a particular order,
> pages are split from higher orders. When pages are obtained from the
> higher order, the user buffer may contain some small consecutive
> patterns.
> 
> In summary, the physical layout of the user buffer is unpredictable,
> and when it contains some small consecutive patterns, the size of the
> bio becomes randomly unaligned during filling.

Yes, multipage bvec depends on physical layout of user buffer, but it
doesn't affect bio size, which is decided by userspace, and the bvec
page layout doesn't affect IO pattern.

If userspace submits 1028K IO, the IO is split into 512K, 512K and 4K,
no matter if each bvec includes how many pages.

If userspace submits very large IO, such as 512M, which will be split
into 1K bios with 512K size.

You patch doesn't makes any difference actually from block layer
viewpoint, such as:

1) dd if=/dev/ublkb0 of=/dev/null bs=1028k count=1 iflag=direct

2) observe IO pattern by the following bpftrace:

kprobe:blk_mq_start_request
{
	$rq = (struct request *)arg0;

	printf("%lu %16s %d %d: %s %s bio %lx-%lu\n",
		nsecs / 1000,  comm, pid, cpu, ksym(reg("ip")),
		$rq->q->disk->disk_name, $rq->__sector, $rq->__data_len);
}

3) no matter if your patch is applied or not, the following pattern
is always observed:

117828811               dd 1475 0: blk_mq_start_request ublkb0 bio 0-524288
117828823               dd 1475 0: blk_mq_start_request ublkb0 bio 400-524288
117828825               dd 1475 0: blk_mq_start_request ublkb0 bio 800-4096

Similar pattern can be observed when running dd inside FS(xfs).

> 
> This patch limits the bio to be filled up to the max_sectors. The
> submission is an async operation, so once the bio is queued, it will
> immediately return and continue filled and submit the next bio.

bio split doesn't change this behavior too, the difference is just how
many bios the upper layer(iomap) observed.

Your patch just moves the split into upper layer, and iomap can see
3 bios with your patch when `dd bs=1028K`, and in vanilla tree, iomap
just submits single bio with 1028K, block layer splits it into
512k, 512k, and 4k. So finally UFS driver observes same IO pattern.

In short, please root cause why your patch improves performance, or
please share your workloads, so we can observe the IO pattern and
related mm/fs behavior and try to root cause it.


Thanks,
Ming

