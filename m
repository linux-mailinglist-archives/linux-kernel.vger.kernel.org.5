Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAC7E344E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjKGDuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGDuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:50:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0414811A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699328958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9FCMlk2IkrIEzQB8L9xTTGDJXhqSvTWTL0IDXr95cA=;
        b=K6DWsPZCgjJMl9xANvwbCrDwKE3nFftwLwooCy263w4j2gReEgbyUylTZrrL7Sb9GNwrm1
        ZGY9YvDMKygy47z7IFTFK1dcvr29pL4Lg4Dg6LxAtjHTO87WAG+Radd/QB0dLm6Gf5/poz
        uec5GCkIN5/QWcPsxpRUx04p2Gw7jLI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-H3pkEELXNwqDhxmZ4mCm1w-1; Mon, 06 Nov 2023 22:48:58 -0500
X-MC-Unique: H3pkEELXNwqDhxmZ4mCm1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7C1F185A781;
        Tue,  7 Nov 2023 03:48:57 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18CD240C6EB9;
        Tue,  7 Nov 2023 03:48:48 +0000 (UTC)
Date:   Tue, 7 Nov 2023 11:48:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>
Cc:     Will Shiu =?utf-8?B?KOioseaBreeRnCk=?= <Will.Shiu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Peter Wang =?utf-8?B?KOeOi+S/oeWPiyk=?= 
        <peter.wang@mediatek.com>,
        Alice Chao =?utf-8?B?KOi2meePruWdhyk=?= 
        <Alice.Chao@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
Message-ID: <ZUmznGeKhJKnE7wx@fedora>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
 <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
 <ZUUd48QF/TEGFzPy@fedora>
 <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
 <ZUW96Ha5GoJePD8Y@fedora>
 <2bc847a83849973b7658145f2efdda86cc47e3d5.camel@mediatek.com>
 <5ecedad658bf28abf9bbeeb70dcac09b4b404cf5.camel@mediatek.com>
 <ZUhxS9JMyPK+v6Ec@fedora>
 <ZUjT11xUNM7u/UjV@fedora>
 <fb568e7a1020ef6d2d22f3f0771034b1dc699fb9.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb568e7a1020ef6d2d22f3f0771034b1dc699fb9.camel@mediatek.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 02:53:20AM +0000, Ed Tsai (蔡宗軒) wrote:
> On Mon, 2023-11-06 at 19:54 +0800, Ming Lei wrote:
> >  On Mon, Nov 06, 2023 at 12:53:31PM +0800, Ming Lei wrote:
> > > On Mon, Nov 06, 2023 at 01:40:12AM +0000, Ed Tsai (蔡宗軒) wrote:
> > > > On Mon, 2023-11-06 at 09:33 +0800, Ed Tsai wrote:
> > > > > On Sat, 2023-11-04 at 11:43 +0800, Ming Lei wrote:
> > > 
> > > ...
> > > 
> > > > Sorry for missing out on my dd command. Here it is:
> > > > dd if=/data/test_file of=/dev/null bs=64m count=1 iflag=direct
> > > 
> > > OK, thanks for the sharing.
> > > 
> > > I understand the issue now, but not sure if it is one good idea to
> > check
> > > queue limit in __bio_iov_iter_get_pages():
> > > 
> > > 1) bio->bi_bdev may not be set
> > > 
> > > 2) what matters is actually bio's alignment, and bio size still can
> > > be big enough
> > > 
> > > So I cooked one patch, and it should address your issue:
> > 
> > The following one fixes several bugs, and is verified to be capable
> > of
> > making big & aligned bios, feel free to run your test against this
> > one:
> > 
> >  block/bio.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 816d412c06e9..80b36ce57510 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1211,6 +1211,7 @@ static int bio_iov_add_zone_append_page(struct
> > bio *bio, struct page *page,
> >  }
> >  
> >  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) /
> > sizeof(struct page *))
> > +#define BIO_CHUNK_SIZE(256U << 10)
> >  
> >  /**
> >   * __bio_iov_iter_get_pages - pin user or kernel pages and add them
> > to a bio
> > @@ -1266,6 +1267,31 @@ static int __bio_iov_iter_get_pages(struct bio
> > *bio, struct iov_iter *iter)
> >  size -= trim;
> >  }
> >  
> > +/*
> > + * Try to make bio aligned with 128KB if it isn't the last one, so
> > + * we can avoid small bio in case of big chunk sequential IO because
> > + * of bio split and multipage bvec.
> > + *
> > + * If nothing is added to this bio, simply allow unaligned since we
> > + * have chance to add more bytes
> > + */
> > +if (iov_iter_count(iter) && bio->bi_iter.bi_size) {
> > +unsigned int aligned_size = (bio->bi_iter.bi_size + size) &
> > +~(BIO_CHUNK_SIZE - 1);
> > +
> > +if (aligned_size <= bio->bi_iter.bi_size) {
> > +/* stop to add page if this bio can't keep aligned */
> > +if (!(bio->bi_iter.bi_size & (BIO_CHUNK_SIZE - 1))) {
> > +ret = left = size;
> > +goto revert;
> > +}
> > +} else {
> > +aligned_size -= bio->bi_iter.bi_size;
> > +iov_iter_revert(iter, size - aligned_size);
> > +size = aligned_size;
> > +}
> > +}
> > +
> >  if (unlikely(!size)) {
> >  ret = -EFAULT;
> >  goto out;
> > @@ -1285,7 +1311,7 @@ static int __bio_iov_iter_get_pages(struct bio
> > *bio, struct iov_iter *iter)
> >  
> >  offset = 0;
> >  }
> > -
> > +revert:
> >  iov_iter_revert(iter, left);
> >  out:
> >  while (i < nr_pages)
> > -- 
> > 2.41.0
> > 
> > 
> > 
> > Thanks, 
> > Ming
> > 
> 
> The latest patch you provided with 256 alignment does help alleviate
> the severity of fragmentation. However, the actual aligned size may
> vary depending on the device. Using a fixed and universal size of 128
> or 256KB only provides partial relief from fragmentation.
> 
> I performed a dd direct I/O read of 64MB with your patch, and although
> most of the bios were aligned, there were still cases of missalignment
> to the device limit (e.g., 512MB for my device), as shown below:

512MB is really big, and actually you have reached 3520MB in READ by
limiting max bio size to 1MB in your original patch.

Just be curious what is the data if you change to align with max sectors
against my last patch? which can try to maximize & align bio.

> 
> dd [000] ..... 392.976830: block_bio_queue: 254,52 R 2997760 + 3584
> dd [000] ..... 392.979940: block_bio_queue: 254,52 R 3001344 + 3584
> dd [000] ..... 392.983235: block_bio_queue: 254,52 R 3004928 + 3584
> dd [000] ..... 392.986468: block_bio_queue: 254,52 R 3008512 + 3584

Yeah, I thought that 128KB should be fine for usual hardware, but
looks not good enough.

> 
> Comparing the results of the Antutu Sequential test to the previous
> data, it is indeed an improvement, but still a slight difference with
> limiting the bio size to max_sectors:
> 
> Sequential Read (average of 5 rounds):
> Original: 3033.7 MB/sec
> Limited to max_sectors: 3520.9 MB/sec
> Aligned 256KB: 3471.5 MB/sec
> 
> Sequential Write (average of 5 rounds):
> Original: 2225.4 MB/sec
> Limited to max_sectors: 2800.3 MB/sec
> Aligned 256KB: 2618.1 MB/sec

Thanks for sharing the data.

> 
> What if we limit the bio size only for those who have set the
> max_sectors?

I think it may be doable, but need more smart approach for avoiding
extra cost of iov_iter_revert(), and one way is to add bio_shrink()
(or bio_revert()) to run the alignment just once.

I will think further and write a new patch if it is doable.



Thanks,
Ming

