Return-Path: <linux-kernel+bounces-87778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB1B86D8E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15FDB224D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C673A8D2;
	Fri,  1 Mar 2024 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DveyyKxQ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BC039FCC;
	Fri,  1 Mar 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256794; cv=none; b=Jc64tdtdqU//MKXvYPaoaoFrSKbRJ6T8oURh7uvrhuNwhR9eY+BeJhteZUQonEirMCqEpxa6VHqrnNSDdD7kABXRM5zksvARpK7zq/P/Ramqro85Q9jM+11h1E2ayNAKZbUBXJmebN+YL6ag+UO2iY2ntfhKWstg8iBGBAl8xrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256794; c=relaxed/simple;
	bh=OOhyA6h0GG15G23rni5UZ56kO59KsuBRYJDSMPMsu2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CK6Wswehe29Xau70ypqSHKrfPxy0BjQe0u+IttMqCcocPg2Ez/xqPfFG67enVwQDSz+ClWgs00Bn4kr0GJMsNnxQGq1SCgnISHgxQrXSv73KIE2v+aorrEDGiOrQs61Se8OwED669xUAjZSbZINdHx/uKB0YEKTlrQr4uWfeAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DveyyKxQ; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rEEns
	V7ccavcL1+sORm7vSmbrANTnktlQKRoj9s2el8=; b=DveyyKxQz1UnrBk+8VFfa
	h1TSkCXtBFV8EXDvf9jDb7bZEK11xdOMFFhyv8cbbYqlIXfijWGsyXi6zbCPDGeb
	N5jVDOZQcCrVQ5noWsu3RQ3UVf3BfvPtMWB0h2NEqkNoP8pME1395EaKHnU1SgoC
	ccVal+DZLuXEMHegrFqPrk=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDn7+APMOFlZSfbBA--.18054S13;
	Fri, 01 Mar 2024 09:32:45 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Zhong Jinghua <zhongjinghua@huawei.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH 4.19.y 9/9] loop: loop_set_status_from_info() check before assignment
Date: Fri,  1 Mar 2024 09:30:28 +0800
Message-Id: <20240301013028.2293831-10-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301013028.2293831-1-zhanggenjian@126.com>
References: <20240301013028.2293831-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7+APMOFlZSfbBA--.18054S13
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4kJFW5CF47ZFy5AF13Jwb_yoW8ZrW8pa
	13Way5C3yFgF48GFsFyry8ZFW5G3ZrGry3WrZrt3WrZr1Ivwna9r9rK34F9rWkJrW3WFWF
	gFnxXF1vvF1UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHCJQUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyBqUfmWWf0mcQwACsg

From: Zhong Jinghua <zhongjinghua@huawei.com>

[ Upstream commit 9f6ad5d533d1c71e51bdd06a5712c4fbc8768dfa ]

In loop_set_status_from_info(), lo->lo_offset and lo->lo_sizelimit should
be checked before reassignment, because if an overflow error occurs, the
original correct value will be changed to the wrong value, and it will not
be changed back.

More, the original patch did not solve the problem, the value was set and
ioctl returned an error, but the subsequent io used the value in the loop
driver, which still caused an alarm:

loop_handle_cmd
 do_req_filebacked
  loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
  lo_rw_aio
   cmd->iocb.ki_pos = pos

Fixes: c490a0b5a4f3 ("loop: Check for overflow while configuring loop")
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://lore.kernel.org/r/20230221095027.3656193-1-zhongjinghua@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c1caa3e2355f..6050b039e4d2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1269,13 +1269,13 @@ loop_set_status_from_info(struct loop_device *lo,
 	if (err)
 		return err;
 
+	/* Avoid assigning overflow values */
+	if (info->lo_offset > LLONG_MAX || info->lo_sizelimit > LLONG_MAX)
+		return -EOVERFLOW;
+
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
 
-	/* loff_t vars have been assigned __u64 */
-	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
-		return -EOVERFLOW;
-
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
-- 
2.25.1


