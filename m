Return-Path: <linux-kernel+bounces-94965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050D874753
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE78284EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042F71C2A1;
	Thu,  7 Mar 2024 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bdXFwwC+"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE331BC56;
	Thu,  7 Mar 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785211; cv=none; b=WSsO9IhlQu4xtvRZHd1Qr5dMtv384ivr03f4prJRFTjzAQiByxWh7Pj4cd0I5D3hFbq8Az73l+2Af58rd7uhtZvc7OoDlt3SmVx8H0Lv8JIcpjhZ7/jtEtm473AOtDZZqgUC/qEDRG+lz2/FJ8bG7xBGHEzUn3MhenzUhtqZCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785211; c=relaxed/simple;
	bh=RVzCBWZL3Fs2lKVuMO+8HdbnbBEx+N+Ja88D9+iMXLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+uveaUxDTgpOPCEIIb5dl9ZWKTBvF+GbQNIVAcX7AEEjGylm6mQWaAsMQYhKuZN6rczkCQ1ccLItUTBqcnmRxPVg8jJo8L7HBD0HSfrnj454jjyw+QT8iWjhFDNSdmLoKbgkfpqYFacjd0pgaWRjdrIiDF1UvSO6K733GeUS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bdXFwwC+; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VJTS0
	wA0DvHHRitPTm1NT41xy31OCjf26nYLakxJP8U=; b=bdXFwwC+lx4GDms/G4slc
	jAf0VBcp4OU0LAv6ytfWLXUNBjv23ZyGXndPK+aOhtCO5sY0bZoWUM9KJRgizZGC
	LExB2L0VK7w5tS8v75AU/nVt6w9ecYDluGqR0TiYFpQ/2quKpF5z02SPlx3RNQ06
	+fGEp2YrFDbjSA5IYraB0Y=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXrmdmP+llh0IFAA--.11885S11;
	Thu, 07 Mar 2024 12:19:18 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Siddh Raman Pant <code@siddh.me>,
	syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH linux-5.4.y 7/8] loop: Check for overflow while configuring loop
Date: Thu,  7 Mar 2024 12:14:10 +0800
Message-Id: <20240307041411.3792061-8-zhanggenjian@126.com>
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
X-CM-TRANSID:_____wBXrmdmP+llh0IFAA--.11885S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1xur4Utw4DAF45AFW5Wrg_yoW8Kw18pF
	43WryUZ3yrKF4UCFsrt34kXry5WanrGFy3G39Fk345u390vrnavry7Cr93urykJry5ZFWS
	gFn3try8Z3WUZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtR67UUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyBqafmWWf4vf8AAAse

From: Siddh Raman Pant <code@siddh.me>

[ Upstream commit c490a0b5a4f36da3918181a8acdc6991d967c5f3 ]

The userspace can configure a loop using an ioctl call, wherein
a configuration of type loop_config is passed (see lo_ioctl()'s
case on line 1550 of drivers/block/loop.c). This proceeds to call
loop_configure() which in turn calls loop_set_status_from_info()
(see line 1050 of loop.c), passing &config->info which is of type
loop_info64*. This function then sets the appropriate values, like
the offset.

loop_device has lo_offset of type loff_t (see line 52 of loop.c),
which is typdef-chained to long long, whereas loop_info64 has
lo_offset of type __u64 (see line 56 of include/uapi/linux/loop.h).

The function directly copies offset from info to the device as
follows (See line 980 of loop.c):
	lo->lo_offset = info->lo_offset;

This results in an overflow, which triggers a warning in iomap_iter()
due to a call to iomap_iter_done() which has:
	WARN_ON_ONCE(iter->iomap.offset > iter->pos);

Thus, check for negative value during loop_set_status_from_info().

Bug report: https://syzkaller.appspot.com/bug?id=c620fe14aac810396d3c3edc9ad73848bf69a29e

Reported-and-tested-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20220823160810.181275-1-code@siddh.me
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index eadb189be0cc..c999eef4e345 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1298,6 +1298,11 @@ loop_set_status_from_info(struct loop_device *lo,
 
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
+
+	/* loff_t vars have been assigned __u64 */
+	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
+		return -EOVERFLOW;
+
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
-- 
2.25.1


