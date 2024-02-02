Return-Path: <linux-kernel+bounces-50462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A4E847942
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A5C2866BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F7E81730;
	Fri,  2 Feb 2024 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geWC4g8l"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395F839E5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900795; cv=none; b=nDUajgRocGN8/xumc5JrxonRkynRICd2M9lvrx3D2QT81vItiTakS2ltwd2YLsgpIQ8GwuwO8TfPYuCOnZqsr7+jsFZcTGS0oDO6k140DS6qgyLQ1dSRwvkxyTN3sssYzuJapHAiBSF0ifUtAesXO6noIl/F44q5dAo3gveF760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900795; c=relaxed/simple;
	bh=rNWqum3/yYvzJfhaZjhWCaFc1cTDx8Mx6rzWVIVoCyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z/dpxp3+FAtTW8O2oIfJv/luEru16U4n18O0sYCpKYO3R66tX5nmHoS3upIYPPFz7atVUrhMsXFgnX+ixngRtCgXxu791TM43tY2/F+eMIOcFv1wVrbDT4r4CqnQQH08Wyws3WSIueJgLifB+nRkQkxvj76AOiVHbc3h5YnNG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geWC4g8l; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d081a0e5feso15508971fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 11:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900792; x=1707505592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EfyIjo6kez38DeVdB3upQeRKk1i+rP6oI+i6zlaUfoo=;
        b=geWC4g8lliMc722fjCcD1BWfvohFaoXqVb9Be3c0PgDO/PPR9eoZhLU01u1/3H8dVD
         ET9ND7Wm7Jdl9UCfYLXrVfXzFqm9QO0o5i/HWY2IvgWRngKMa5vdFMgZ4Ol333oC3ZOw
         6F6BNFz0NCKZoKbmCYTPy6Vl+51jEF9Y61lYab/YWImHfQHzcOr2zXIlcaH1OmGRqWtO
         B0PZddapIxsQjjqrGM678GmZLtAxof5KDbWjnzZaGSyfrLdNEQWo4O5l2GCu0hN51z+M
         ugay55elXL5XuDVjfm7swTj6HuuCEC95cg+g/WDsHt1lH1eZBc+eG02sFyxg5u1LygC9
         QZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900792; x=1707505592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfyIjo6kez38DeVdB3upQeRKk1i+rP6oI+i6zlaUfoo=;
        b=ZFZt0Ol9HH1FA9oa1gmFKO3D9Qt1ED/K+tFsJtaJo6q63RD6dNc+tupmHl3LX591rt
         injweMMH+WFC2a6aZ/BEa5Dd2PfSJ3YoSX3qPEml/HFdZ87xkSlSmArAVmGmbouD44tJ
         w7IhLQRiVGcISBJ57K19hEB79QdzsAVIC4QV6mmo+U4bF58BDrKPOZ4i9nd6arL7EAP4
         paYqpVFnzcVZH8H96GbfAVt5RzlUgo1bUgQSDbpUdz7eG824YypHwj1RtiMbflwDZ0hX
         y+s2pRumIy3jlWENOFF9ABDuw39SjNlSOoPXh4jr5HL4tl66QnOwXf2RVxY71qoNBz6V
         5lQQ==
X-Gm-Message-State: AOJu0YxTal9+1iA+j24pFBjeVddYvBRRvf245p+tXC/0E5I55EidjYjw
	Ueea0JFQcA/jHs+6EpffEMgRMXyQyQKr+mioGaduBrmUompqTpKU
X-Google-Smtp-Source: AGHT+IHtyU5/7ucIPamzM379TcohrpY27WfOJr7P6Tq9bDYiN8E6PqLXwyXaVlVfe6ps2VVxllG9Og==
X-Received: by 2002:a2e:a4b7:0:b0:2d0:7f95:1e3d with SMTP id g23-20020a2ea4b7000000b002d07f951e3dmr2445991ljm.40.1706900791373;
        Fri, 02 Feb 2024 11:06:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWEOqqB5uM/ZmiUeUdHWjO7MY/KcV6nzIPGUJ31nUcBeA2L7eQ9N5NI7fkF8C37YuahFUEd2kOpYu8x6WYfnpb/LDj2OYIBKScbAfzMBHEM480SJzArDdTwjCEFkR41eRK3d7T5D0kzUy9ofYBPgAbNNtq6PCoM/9PHOBczPPmSEANnI8kMIv4O+vM5CUo9O3rw9jgdL+i/lqZh055QYa+xlYlPObGucrdfAdlhrng6hgo4rc2i4rxsKo3uXHCSlrLokST19mc1Hgtl/ZXlHyDocYZdEVHiY0qIng==
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id y9-20020a2e3209000000b002d0522b2550sm353782ljy.32.2024.02.02.11.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:06:30 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/1] mm: vmalloc: Add a scan area of VA only once
Date: Fri,  2 Feb 2024 20:06:28 +0100
Message-Id: <20240202190628.47806-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invoke a kmemleak_scan_area() function only for newly allocated
objects to add a scan area within that object. There is no reason
to add a same scan area(pointer to beginning or inside the object)
several times. If a VA is obtained from the cache its scan area
has already been associated.

Fixes: 7db166b4aa0d ("mm: vmalloc: offload free_vmap_area_lock lock")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 449f45b0e474..25a8df497255 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1882,13 +1882,13 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
 		if (unlikely(!va))
 			return ERR_PTR(-ENOMEM);
-	}
 
-	/*
-	 * Only scan the relevant parts containing pointers to other objects
-	 * to avoid false negatives.
-	 */
-	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
+		/*
+		 * Only scan the relevant parts containing pointers to other objects
+		 * to avoid false negatives.
+		 */
+		kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
+	}
 
 retry:
 	if (addr == vend) {
-- 
2.39.2


