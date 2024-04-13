Return-Path: <linux-kernel+bounces-143554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1782E8A3ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162481C22CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD921CA8B;
	Sat, 13 Apr 2024 03:46:15 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B642E1CAA0;
	Sat, 13 Apr 2024 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979975; cv=none; b=eDH4fOBmAeq9lcqUXxPpxVPmg61IS3gvWAWArT3DqICMbzPnSvSXpFqblRGyky58m15GvJeYlL+2IujrysPo6ywqd4RFIuH/PBG0/xdY3mkdATal8TqJRNx+yK+9358OCMX8NH+ZX1NujoGFsLl4Ig8wIZeH8vg9Pp054aLNCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979975; c=relaxed/simple;
	bh=xoFEJeINMB3hgkcTFrxUt2+/GuZKa7IK48ckiRG6yPs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=d65PAG1vm5Zr2chN/bkpoT0cRIQjKDCoM7HhI10dJDm9HV6DaJB3l2g4iwLCfvXXVBGP+WXFh1Ovd7HaNWv+xvJXAvjQhumyB8Tqm2k1IqXf82/BrEQ+r2ott6AX+XqTsq2m1Htdw7egkzdc+lzmHljDsHfkU7sy3r0UOA+iPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=volanscomputer.com; spf=none smtp.mailfrom=volanscomputer.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=volanscomputer.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=volanscomputer.com
X-QQ-mid: bizesmtpsz1t1712979935tbvmq61
X-QQ-Originating-IP: tGsLe40sNdl2DN6EVTVroMK6OPPzABgR888y3uBtGKs=
Received: from fbox.volanscomputer.com ( [121.225.57.225])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 13 Apr 2024 11:45:29 +0800 (CST)
X-QQ-SSF: 01100000000000E0Z000000A0001000
X-QQ-FEAT: St3bwald4oqa7733neXQZyyx47IfaDj4ARBGGGXfZ8Q5Lfmdr5piyScn1FR1w
	A2S5MOWRHvtZh+Z3J9vNWiQ0kTM5wiJskgJwU2KqxtUlTiK425JrqmkI5wYHUY+0uCE5W9l
	ZXMauo20aKYcRBrjJVt7W3CmCR/iiRIpgS569R+5Rn/ChArh560YRtJsgIvG3x9RmEPEeBP
	iwkXApVx6TWRgvwCEJFjzOaMWk+SDivSoAax40wfEg9ibt31IhmuLCsRF1PCZSbzbBJLpwo
	mjknP/XFhiMYqT5NrOMVALwcbjWmMaXuaeLbzgLfAyZi8HczjJdpX7XKhp4FNRRSH+F3u/H
	w3/xiuV9wqnKnZZMCeRkqyfavZyS7yqI5P1oTCrGW1PSCr8gkSNf/mxVYn9NcPvfQ2ckbln
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6237763326711016679
From: Mingming Gu <mmgu@volanscomputer.com>
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Christian A . Ehrhardt" <lk@c--e.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Mingming Gu <mmgu@volanscomputer.com>
Subject: [PATCH] block: fix bio_copy_user_iov() for SG_DXFER_TO_FROM_DEV case
Date: Sat, 13 Apr 2024 11:45:08 +0800
Message-Id: <1712979908-6132-1-git-send-email-mmgu@volanscomputer.com>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:volanscomputer.com:qybglogicsvrgz:qybglogicsvrgz7a-1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit "block: Fix WARNING in _copy_from_iter" is insufficient to make
SG_IO ioctl with a transfer direction of SG_DXFER_TO_FROM_DEV work;
the passed in iterator should be advanced after bio_copy_from_iter().
Otherwise its caller, blk_rq_map_user_iov(), will return -EINVAL due
to a wrong loop condition.

Instead of using a copy of the passed iterator, save iter->data_source
and restore it after bio_copy_from_iter().

Signed-off-by: Mingming Gu <mmgu@volanscomputer.com>
---
 block/blk-map.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 71210cd..eca02d9 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -211,11 +211,12 @@ static int bio_copy_user_iov(struct request *rq, struct rq_map_data *map_data,
 		if (ret)
 			goto cleanup;
 	} else if (map_data && map_data->from_user) {
-		struct iov_iter iter2 = *iter;
+		bool tmp = iter->data_source;
 
 		/* This is the copy-in part of SG_DXFER_TO_FROM_DEV. */
-		iter2.data_source = ITER_SOURCE;
-		ret = bio_copy_from_iter(bio, &iter2);
+		iter->data_source = ITER_SOURCE;
+		ret = bio_copy_from_iter(bio, iter);
+		iter->data_source = tmp;
 		if (ret)
 			goto cleanup;
 	} else {
-- 
2.7.4


