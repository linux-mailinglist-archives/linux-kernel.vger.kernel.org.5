Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94357E208A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFLzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjKFLzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:55:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE51F3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699271692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gI3xCMXfcB+src4UwQsehw1949W0KFbwKLmzbP4s340=;
        b=QzZeypk72slLq9AAn7968YzqdEFMimys8jt2lAeLnNHkizQsRhX8P3hYCeeRJOyDiZ9Q4o
        eEDbeBxTkF/EowMAAg3WIjh+ssNrxmw6L/qjgqPHzaxjYRSUeqouZsPW2zFWSYc5I9HXmx
        V+dMaZrQJzzRSnJpVrHDzIe770ttIlY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-0TncSstmNjedbITciSgJZw-1; Mon,
 06 Nov 2023 06:54:44 -0500
X-MC-Unique: 0TncSstmNjedbITciSgJZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67E122823810;
        Mon,  6 Nov 2023 11:54:43 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0D440C6EB9;
        Mon,  6 Nov 2023 11:54:34 +0000 (UTC)
Date:   Mon, 6 Nov 2023 19:54:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ed Tsai =?utf-8?B?KOiUoeWul+i7kik=?= <Ed.Tsai@mediatek.com>
Cc:     Will Shiu =?utf-8?B?KOioseaBreeRnCk=?= <Will.Shiu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Wang =?utf-8?B?KOeOi+S/oeWPiyk=?= 
        <peter.wang@mediatek.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Alice Chao =?utf-8?B?KOi2meePruWdhyk=?= 
        <Alice.Chao@mediatek.com>,
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
Message-ID: <ZUjT11xUNM7u/UjV@fedora>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
 <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
 <ZUUd48QF/TEGFzPy@fedora>
 <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
 <ZUW96Ha5GoJePD8Y@fedora>
 <2bc847a83849973b7658145f2efdda86cc47e3d5.camel@mediatek.com>
 <5ecedad658bf28abf9bbeeb70dcac09b4b404cf5.camel@mediatek.com>
 <ZUhxS9JMyPK+v6Ec@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUhxS9JMyPK+v6Ec@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 12:53:31PM +0800, Ming Lei wrote:
> On Mon, Nov 06, 2023 at 01:40:12AM +0000, Ed Tsai (蔡宗軒) wrote:
> > On Mon, 2023-11-06 at 09:33 +0800, Ed Tsai wrote:
> > > On Sat, 2023-11-04 at 11:43 +0800, Ming Lei wrote:
> 
> ...
> 
> > Sorry for missing out on my dd command. Here it is:
> > dd if=/data/test_file of=/dev/null bs=64m count=1 iflag=direct
> 
> OK, thanks for the sharing.
> 
> I understand the issue now, but not sure if it is one good idea to check
> queue limit in __bio_iov_iter_get_pages():
> 
> 1) bio->bi_bdev may not be set
> 
> 2) what matters is actually bio's alignment, and bio size still can
> be big enough
> 
> So I cooked one patch, and it should address your issue:

The following one fixes several bugs, and is verified to be capable of
making big & aligned bios, feel free to run your test against this one:

 block/bio.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..80b36ce57510 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1211,6 +1211,7 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
 }
 
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
+#define BIO_CHUNK_SIZE	(256U << 10)
 
 /**
  * __bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
@@ -1266,6 +1267,31 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		size -= trim;
 	}
 
+	/*
+	 * Try to make bio aligned with 128KB if it isn't the last one, so
+	 * we can avoid small bio in case of big chunk sequential IO because
+	 * of bio split and multipage bvec.
+	 *
+	 * If nothing is added to this bio, simply allow unaligned since we
+	 * have chance to add more bytes
+	 */
+	if (iov_iter_count(iter) && bio->bi_iter.bi_size) {
+		unsigned int aligned_size = (bio->bi_iter.bi_size + size) &
+			~(BIO_CHUNK_SIZE - 1);
+
+		if (aligned_size <= bio->bi_iter.bi_size) {
+			/* stop to add page if this bio can't keep aligned */
+			if (!(bio->bi_iter.bi_size & (BIO_CHUNK_SIZE - 1))) {
+				ret = left = size;
+				goto revert;
+			}
+		} else {
+			aligned_size -= bio->bi_iter.bi_size;
+			iov_iter_revert(iter, size - aligned_size);
+			size = aligned_size;
+		}
+	}
+
 	if (unlikely(!size)) {
 		ret = -EFAULT;
 		goto out;
@@ -1285,7 +1311,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 		offset = 0;
 	}
-
+revert:
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
-- 
2.41.0



Thanks, 
Ming

