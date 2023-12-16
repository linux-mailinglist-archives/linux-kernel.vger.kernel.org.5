Return-Path: <linux-kernel+bounces-2112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D6815800
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936671C24101
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A7413FF1;
	Sat, 16 Dec 2023 06:22:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A241134AD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b3d54a346dso165322839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702707725; x=1703312525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo6+/3Ef7WxZMmUJkpFZ/CrkxsWdSlhcx4UNBGwrgeA=;
        b=WL5n5J3pw5c1OrU6dV6uasdzblHE619DR8g3iXv+wEn4wtVt+8R7m0MLI/KG3oGbY/
         ZUWwi2zBlo7yswB6em50FNAJaX8DpxiVXIsU91+a1Nz4uDwmubi/8ThUQFxZqqnfM+Zb
         r4wqjxDB9OEPLJa5tB6ezwrLYujJ7zue6g+0cQ0WQu5PUPzBBnJ1FP8n7xV1yzXl2OU9
         zvbe+sjF5I5D+Xt+B/YE4Mrp5Hg6ojoQcZwn+rVrHYkyeV4le1Gh2bbqNdbFzWXPqLo6
         qdEE6CufAyAdzGYU7Yg/PHC8LFHI4aytfZSJutrN2MejzGGF7bHTYsJ6sRapsKvHXaT0
         uxGg==
X-Gm-Message-State: AOJu0YwWu02N0+YN0g0BiCjujJ+YeUrcQ5+3t9sdREfEWdjC+iMLaCUf
	weiAVgVAwolL5vHpNa3j6AniVhGC5mxtE27ld2knm3UmfT2Q9LM=
X-Google-Smtp-Source: AGHT+IH+2PNn+K7LQu6pJT428vsdPpizigfpZqBwgkrMP7d1VkijA0jNgZglNEaab0ufMjK3tJk2ZYDvKjvlINGkNBaMHwJG6Mwo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3801:b0:466:7019:1a24 with SMTP id
 i1-20020a056638380100b0046670191a24mr539760jav.3.1702707725267; Fri, 15 Dec
 2023 22:22:05 -0800 (PST)
Date: Fri, 15 Dec 2023 22:22:05 -0800
In-Reply-To: <0000000000006c14cd060c99ac12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001efb50060c9a8914@google.com>
Subject: Re: [syzbot] Re: [syzbot] [block?] general protection fault in bio_first_folio
From: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
Author: eadavis@qq.com

please test general protection fault in bio_first_folio

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git abb240f7a2bd

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ec4db73e5f4e..20ccf5796ea0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -286,6 +286,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
 {
 	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
 
+	WARN_ON_ONCE(!bio->bi_vcnt);
 	fi->folio = page_folio(bvec->bv_page);
 	fi->offset = bvec->bv_offset +
 			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
diff --git a/block/blk-map.c b/block/blk-map.c
index 8584babf3ea0..e2169d67be4b 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -275,6 +275,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (!iov_iter_count(iter))
 		return -EINVAL;
 
+	printk("i: %p, nr: %d, cn: %lld, %s\n", iter, nr_vecs, iov_iter_count(iter), __func__);
 	bio = blk_rq_map_bio_alloc(rq, nr_vecs, gfp_mask);
 	if (bio == NULL)
 		return -ENOMEM;
@@ -298,6 +299,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 					       nr_vecs, extraction_flags, &offs);
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
+			printk("r: %d, b: %lld, icn: %d, %s\n", ret, bytes, iov_iter_count(iter), __func__);
 			goto out_unmap;
 		}
 
@@ -339,6 +341,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	}
 
 	ret = blk_rq_append_bio(rq, bio);
+	printk("b: %p, r: %d, %s\n", bio, ret, __func__);
 	if (ret)
 		goto out_unmap;
 	return 0;


