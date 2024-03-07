Return-Path: <linux-kernel+bounces-94961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C996874747
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE00E1C2214C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771111D555;
	Thu,  7 Mar 2024 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="R/WsBH2W"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EEA1CA9F;
	Thu,  7 Mar 2024 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785188; cv=none; b=QqLsv9FLmd5gWAwzVBTG59I2hrGybGKmpiXbsirHji7mV+FxgHps0rfnWBQOjQ53rJ74oxUY7CKe75HR6zUzc7IYs16exG8dR7HKKJ/dIlu9XvW9hZVGSbNjXr3NWem7WYnqLq4otohJHsmWNymBMTHX+nD2D2gFWOR+PCbcPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785188; c=relaxed/simple;
	bh=614ti+/WDfbXKwDyIMOiRA9yVLWMSCRRp198y+JS7TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLe3G/SID58ejzfjMrrhuBewCOFHpJBqs9d/P6R1CFnOuiveTkwRyk/z1OwbI7gRxQRFLGoWR7il8EGQUsoHEt17UUBWYkOI882kd+ySieR0DhH3duquVTwqJIWI7RWuSVhOuJdG9SThOiOvGYePqVaXuaqG0J9Ot/CZfzdxyEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=R/WsBH2W; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kMKpn
	icj8zQhYvv/bA41f70n6s6QZdvmmvnjBVMou8o=; b=R/WsBH2WgR3Il0FevMu4Q
	RuKym3JZh8T/wpxtA2qKDgICjdf0Zl0xAP1q+3MDyojb6FFHyLTIkck0y7sBxCPH
	f9gCWwbYVhdeGy+xKrpBbjomuiVtpwbCrbpGYllPOQQ6dZMQVPu1Rt+uy692WS6n
	yQ0BpvX4hGo6B+/lNUSxCk=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXrmdmP+llh0IFAA--.11885S12;
	Thu, 07 Mar 2024 12:19:19 +0800 (CST)
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
Subject: [PATCH linux-5.4.y 8/8] loop: loop_set_status_from_info() check before assignment
Date: Thu,  7 Mar 2024 12:14:11 +0800
Message-Id: <20240307041411.3792061-9-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307041411.3792061-1-zhanggenjian@126.com>
References: <20240307041411.3792061-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXrmdmP+llh0IFAA--.11885S12
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4kJFW5CF47ZFy5AF13Jwb_yoW8ZrW8pF
	43Wa4Yk3yFgF48GF4qyry8ZFW5G3ZrGry3WrZrt3WrZr1Ivwna9rZrK34F9rWkJryfWFWF
	gFnxXFy0vF1UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jejgcUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyBqafmWWf4vf8AABsf

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
index c999eef4e345..ff452c02b61f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1296,13 +1296,13 @@ loop_set_status_from_info(struct loop_device *lo,
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


