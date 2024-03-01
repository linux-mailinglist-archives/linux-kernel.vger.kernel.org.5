Return-Path: <linux-kernel+bounces-87777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF186D8E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20F91F23716
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6A3A26E;
	Fri,  1 Mar 2024 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="H/ka5F9V"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD12E416;
	Fri,  1 Mar 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256794; cv=none; b=AivCyWmVrDaToGGQy9lTGrgheLzcUUB8OBf3puoFRfc1T7Twu5XgD8CnJ8x03fk++PezdNelbefuTzePAPuYgZEEJ5th2kMsBzMcmuLGJhLCmd8kwgywK+mH1NEvhtxKAwOA9HcxwVOE/ycczcfk2DcCSKV9uPltGe8Su5Mfbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256794; c=relaxed/simple;
	bh=lbTVUMhxn1ktqI2lN9lgHcss1yek4QTPVEjRudHaEF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guDCQw/3B6/T2e05xr+RM7Itqto70EMcBbKYRAdREfVK0ucW+a77rCjxp5gTnn29CJWPfbDBIhsTezOaqwbnOtPmlDCv/E9h/vcK53Hga8QPJAixBzE1Q7wA+gV2I/XLzo+aagkPJ2RUiuLdhRfQtp0ommNgwCQCqRNrNCpEjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=H/ka5F9V; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8CY1O
	Dlw6c1e5TwxkQwAen6QJmz56H/WmfOZ5M5TNM0=; b=H/ka5F9VbgyctHVrx1qn9
	bu1MR3Ms18eCq9AjYs+dTnFsm6NzfYDlNWN9mHmreS9iZzqGBayqh8TLNneTZLFQ
	ozUb30wpFAmlOA+t5yKgkPyOfj4f9YjCuK2u+b8l3r87DOBNZIQYD0XzM2Hx2TDQ
	NxOnxF/aaBXn/Rbnn3YQss=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDn7+APMOFlZSfbBA--.18054S6;
	Fri, 01 Mar 2024 09:32:38 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Martijn Coenen <maco@android.com>,
	Christoph Hellwig <hch@lst.de>,
	Bob Liu <bob.liu@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH 4.19.y 2/9] loop: Call loop_config_discard() only after new config is applied
Date: Fri,  1 Mar 2024 09:30:21 +0800
Message-Id: <20240301013028.2293831-3-zhanggenjian@126.com>
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
X-CM-TRANSID:_____wDn7+APMOFlZSfbBA--.18054S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar43AryfuFy7try5Xr4xZwb_yoW8WrWxpF
	nrWFyjyFWvgF48CFWUWrWkZa45Gan7G3y3XFW2k3y5ur43Z3savr9Ika4xXr1DJFW8WFWY
	v3Zakr10qw1UCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UiqXLUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyBqUfmWWf0mcQwAAsi

From: Martijn Coenen <maco@android.com>

[ Upstream commit 7c5014b0987a30e4989c90633c198aced454c0ec ]

loop_set_status() calls loop_config_discard() to configure discard for
the loop device; however, the discard configuration depends on whether
the loop device uses encryption, and when we call it the encryption
configuration has not been updated yet. Move the call down so we apply
the correct discard configuration based on the new configuration.

Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 52481f1f8d01..bd94406b90c9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1286,8 +1286,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		}
 	}
 
-	loop_config_discard(lo);
-
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1311,6 +1309,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	loop_config_discard(lo);
+
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
-- 
2.25.1


