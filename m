Return-Path: <linux-kernel+bounces-156793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC178B083B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F31C21FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012715A48E;
	Wed, 24 Apr 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fKkGcGcs"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F115A484
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957745; cv=none; b=NLUj8wx72CswQGMmRi+evwLH5ibLl5cvTk+v8wzWysSR9elT18W+NbfmvjQBfNAE/lz5E4xpXj143dTljRQtRiEvn7hzQyydF+qLVVT+JuswZ5MUnPSSR4BrWejpsBInWmGB6ZFwdTxoGBtsRToPaqfuZUXkVGdPeEUjapkILHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957745; c=relaxed/simple;
	bh=GTlPQ21gMbP7CEmXQRTbN/+j7q/yOGy0x+8lbAMsAWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Ni2tTovbkE1jvkVYAGCJ7NJ4cOi40d0TFvYGt6zYoxQyPC2L6SM7ftC7ATDCNSaWSY+mIB0dFa2+r+VAQ9qZ8zCVNoweQ0EzlBS3hu2o+X2icxf5mlaCdER06kH88CP6EblzT95bma9IO+/ZDvYDlScUdogC2bgUrxmQluvkaVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fKkGcGcs; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240424112215epoutp0450a4831b995ff801eb590eaa0bf3ac66~JM3quyCIV0446504465epoutp04N
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:22:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240424112215epoutp0450a4831b995ff801eb590eaa0bf3ac66~JM3quyCIV0446504465epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713957735;
	bh=GaACKX7Cd1B6n1VlcyLHwH1C8jd7NZ302MpXyTOqUpU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fKkGcGcsLOe3Hg5/SCTNP0TT/xMEEPDLf9JxP/xghfyEXAf2p7dZZKoKaAUz57f9a
	 6cewF6Y0AxJkPgwq+i33r1QfOOamcFKcM3ssKJBhI0Si5DG2uuk8t1WqILWufTdGVT
	 aHqeRbsV5cCFSLQEXPY1A6qdGdbw6h3aKAZlKIeE=
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.42.80]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240424112214epcas5p3f1db9648a7fcf66ac4aff4c6b7c008a5~JM3p_5amO1011410114epcas5p3X;
	Wed, 24 Apr 2024 11:22:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.73.19431.66BE8266; Wed, 24 Apr 2024 20:22:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240424112123epcas5p46e76f51b8913661a6b740dcbbec83621~JM26bEkm41754917549epcas5p49;
	Wed, 24 Apr 2024 11:21:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240424112123epsmtrp2c065bd304ba61e38c25a7ced22359806~JM26aR2Pb0141301413epsmtrp2k;
	Wed, 24 Apr 2024 11:21:23 +0000 (GMT)
X-AuditID: b6c32a50-ccbff70000004be7-3b-6628eb669c84
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.29.08924.33BE8266; Wed, 24 Apr 2024 20:21:23 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240424112121epsmtip205e42635ac4666ad8055611a646f167b~JM24fgL4j2230922309epsmtip2p;
	Wed, 24 Apr 2024 11:21:21 +0000 (GMT)
From: Hariom Panthi <hariom1.p@samsung.com>
To: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, vbabka@suse.cz, osalvador@suse.de
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	r.thapliyal@samsung.com, Maninder Singh <maninder1.s@samsung.com>, Hariom
	Panthi <hariom1.p@samsung.com>
Subject: [PATCH 1/2] mm: page_owner: fixing wrong information in
 dump_page_owner
Date: Wed, 24 Apr 2024 16:48:37 +0530
Message-Id: <20240424111838.3782931-1-hariom1.p@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7bCmpm7aa400g6PzRCzmrF/DZvGk7RCL
	xekJi5gsLu+aw2Zxb81/Vos73+axWxye38ZicWZakcXGe9kWqy+yWMxu7GN04PbYOesuu8fm
	FVoemz5NYvc4MeM3i0ffllWMHmcWHAGKn672+LxJLoAjissmJTUnsyy1SN8ugSvj8LSDzAVL
	uStmPJNrYNzB2cXIwSEhYCLRfSSsi5GLQ0hgD6PEyjuTWLsYOYGcT4wSn57KQCS+MUos3z6P
	BSQB0jDzXw8bRGIvo8SRvldMEM4XRon7S+6ygIxlE9CWOP7JCqRBRKBa4tT+12DNzAKLGCW+
	f9cBsYUFgiRmvFzCDGKzCKhK7Lk2jx3E5hWwkXi94xk7xDJ5iZmXvkPFBSVOznwCNUdeonnr
	bGaImr/sEpMOGkLYLhLNh9ZBHSos8er4Fqg5UhKf3+1lg7DLJboXdLNC2A2MEnOX+0DY9hJP
	Li5kBTmfWUBTYv0ufYiwrMTUU+uYINbySfT+fsIEEeeV2DEPxlaWmHtkE9RaSYkd8zugbA+J
	5fuWMkICNFaid9oO9gmM8rOQfDMLyTezEDYvYGRexSiVWlCcm56abFpgqJuXWq5XnJhbXJqX
	rpecn7uJEZyOtAJ2MK7e8FfvECMTB+MhRgkOZiUR3l9/VNKEeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ875unZsiJJCeWJKanZpakFoEk2Xi4JRqYJpWc9Hq7F376WzZG4Lfz+W/9u1x+u7OE4Vi
	1jczr7Yk+H+TkD1g/Glu32KdNI46sT+n2KoWm6mf1nk/9ZnVnW8fjq130D5fNKk+vHaL+Ufh
	+FlTHv1k4eLcEvdjnUbFotTQdQ6BvhzaweXTsjwk3dZbFPqqXG49Vr+dP2C5zJ311XfmmIm9
	E5/2+tnpwn8vI235WtsNPrWEHr5/56h9/bKbcifmnJh7aaYVmwBn4IYPoR03HGuSD4qxFeuI
	m5gVXg4K/Sutt8dmVbnc5f+Zr/W/T1pncIlhj85CrzOsEx5dszxU3OJ3f4Zf8ry9byVLvwdy
	/Vm7h3X63MuT83oO+98qfGceedDH5Afbqylt3b5KLMUZiYZazEXFiQA6evAKtgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvK7xa400g5k7+SzmrF/DZvGk7RCL
	xekJi5gsLu+aw2Zxb81/Vos73+axWxye38ZicWZakcXGe9kWqy+yWMxu7GN04PbYOesuu8fm
	FVoemz5NYvc4MeM3i0ffllWMHmcWHAGKn672+LxJLoAjissmJTUnsyy1SN8ugSvj8LSDzAVL
	uStmPJNrYNzB2cXIySEhYCIx818PWxcjF4eQwG5GiUUn17NAJCQl1s3/wgxhC0us/PecHaLo
	E6PEnketrF2MHBxsAtoSxz9ZgcRFBJoZJbbO3sMI4jALLGOUuLHrOBNIt7BAgMTWt82sIDaL
	gKrEnmvz2EFsXgEbidc7nrFDbJCXmHnpO1RcUOLkzCdgVzADxZu3zmaewMg3C0lqFpLUAkam
	VYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwSGupbmDcfuqD3qHGJk4GA8xSnAwK4nw
	/vqjkibEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qB6Zyv
	JI+tsUT524jZ2qemfDHhdrj8P6Lww6++4mlyt+PLUj/c2OA89WTPzvIG04tFLas2XLdP67tq
	LSm1bUX/tPbL2hM59zrztFQ8Cvy+IY8x/c5GXzOmGPmZExs+xX6JKHwsWDK58MiiygV3tP+q
	7F3MnfFg3QSb8qLvZa/ET4lzmKbEyt/2meLrtMkpfMv2pyuO/2k9t1FO++mOvSwxU1+mOmp8
	2XEq5vzJsI/1teoS03ac56263BkUFyAz8XXFBMZj9Y2/rLZHfJ1Zff3JgoN6xqefGJaz/713
	12FfdYT7sl05ugIbFm11XveCRSQj+4vFZMOckJK7cy3mbevQeKHkOZOrscSyZ8paR36bC0os
	xRmJhlrMRcWJAEpCcqTgAgAA
X-CMS-MailID: 20240424112123epcas5p46e76f51b8913661a6b740dcbbec83621
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240424112123epcas5p46e76f51b8913661a6b740dcbbec83621
References: <CGME20240424112123epcas5p46e76f51b8913661a6b740dcbbec83621@epcas5p4.samsung.com>

From: Maninder Singh <maninder1.s@samsung.com>

with commit ea4b5b33bf8a ("mm,page_owner: update metadata for tail pages"),
new API __update_page_owner_handle was introduced and arguemnt was passed
in wrong order from __set_page_owner and thus page_owner is giving
wrong data.

[   15.982420] page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 80, tgid -1210279584 (insmod), ts 80, free_ts 0

Fixing the same.
Correct output:
[   14.556482] page last allocated via order 0, migratetype Unmovable, gfp_mask 0xcc0(GFP_KERNEL), pid 80, tgid 80 (insmod), ts 14552004992, free_ts 0

Fixes: ea4b5b33bf8a ("mm,page_owner: update metadata for tail pages")
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Hariom Panthi <hariom1.p@samsung.com>
---
 mm/page_owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 742f432e5bf0..6669c7eadfb3 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -328,7 +328,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	if (unlikely(!page_ext))
 		return;
 	__update_page_owner_handle(page_ext, handle, order, gfp_mask, -1,
-				   current->pid, current->tgid, ts_nsec,
+				   ts_nsec, current->pid, current->tgid,
 				   current->comm);
 	page_ext_put(page_ext);
 	inc_stack_record_count(handle, gfp_mask, 1 << order);
-- 
2.25.1


