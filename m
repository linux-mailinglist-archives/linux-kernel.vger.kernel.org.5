Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D167E1977
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjKFEyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 23:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKFEyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:54:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27806DB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 20:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699246429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0xxS0GcTpI1/DgZckR1OrAQOwxzwiXZ07noMlU8lfM=;
        b=AEFJ7tT+HqXL6aYtCxTT6GUZC6eSpd9bEZLxn/7lUo7YmQKg7NQph9ZFHQAEAlfzwhiup5
        RpkOFuuR0K0vYoharAdfuGv7xjsyrT0ckQZs9D8pF5+b/zjZiSQlVlpzByVWHPgbtMUcfg
        LO9xYuCreKnMuGBNIFqAPjO6TceUmZo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-u2guWhx7NOmnhhSHkQuB-w-1; Sun,
 05 Nov 2023 23:53:45 -0500
X-MC-Unique: u2guWhx7NOmnhhSHkQuB-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBCEB380628F;
        Mon,  6 Nov 2023 04:53:44 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F11372166B26;
        Mon,  6 Nov 2023 04:53:35 +0000 (UTC)
Date:   Mon, 6 Nov 2023 12:53:31 +0800
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
Message-ID: <ZUhxS9JMyPK+v6Ec@fedora>
References: <20231025092255.27930-1-ed.tsai@mediatek.com>
 <64db8f5406571c2f89b70f852eb411320201abe6.camel@mediatek.com>
 <ZUUd48QF/TEGFzPy@fedora>
 <cf09a768d0e116bfaf01a1592a7ae95a10b4c2cf.camel@mediatek.com>
 <ZUW96Ha5GoJePD8Y@fedora>
 <2bc847a83849973b7658145f2efdda86cc47e3d5.camel@mediatek.com>
 <5ecedad658bf28abf9bbeeb70dcac09b4b404cf5.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ecedad658bf28abf9bbeeb70dcac09b4b404cf5.camel@mediatek.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 01:40:12AM +0000, Ed Tsai (蔡宗軒) wrote:
> On Mon, 2023-11-06 at 09:33 +0800, Ed Tsai wrote:
> > On Sat, 2023-11-04 at 11:43 +0800, Ming Lei wrote:

...

> Sorry for missing out on my dd command. Here it is:
> dd if=/data/test_file of=/dev/null bs=64m count=1 iflag=direct

OK, thanks for the sharing.

I understand the issue now, but not sure if it is one good idea to check
queue limit in __bio_iov_iter_get_pages():

1) bio->bi_bdev may not be set

2) what matters is actually bio's alignment, and bio size still can
be big enough

So I cooked one patch, and it should address your issue:


diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..7d982e74c65d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1266,6 +1266,24 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		size -= trim;
 	}
 
+	/*
+	 * Try to make bio aligned with 128KB if there are pages left so we
+	 * can avoid small bio in case of big chunk sequential IO
+	 */
+	if (iov_iter_count(iter)) {
+		unsigned curr_size = (bio->bi_iter.bi_size + size) &
+			~((128U << 10) - 1);
+		if (curr_size <= bio->bi_iter.bi_size) {
+			ret = left = size;
+			goto revert;
+		} else {
+			curr_size -= bio->bi_iter.bi_size;
+			ret = size - curr_size;
+			iov_iter_revert(iter, ret);
+			size = curr_size;
+		}
+	}
+
 	if (unlikely(!size)) {
 		ret = -EFAULT;
 		goto out;
@@ -1285,7 +1303,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 		offset = 0;
 	}
-
+revert:
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)




Thanks,
Ming

