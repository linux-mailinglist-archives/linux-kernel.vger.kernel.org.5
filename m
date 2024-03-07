Return-Path: <linux-kernel+bounces-94964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A757E874750
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435DA1F2277E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E42B208B8;
	Thu,  7 Mar 2024 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nNVNFLgd"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6E2134A;
	Thu,  7 Mar 2024 04:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785196; cv=none; b=beruyTKQhOo6oAocVyxExelUlMwYIsUOoZxalHtwab/Gjud+TQm8YaYpeNnsAyMvsjqXWHctNsd6ChABrfSfrvHHt2oNLQznPPeLp1YTaPuVQ8oGlf+3Ih4ge38HxAYxA6k0ylGN8vfj3LBqBa2m/azR0geyc2zgt+yPVftqaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785196; c=relaxed/simple;
	bh=zCUCs9CUkcZ2INKZXClzeber7vQNZVCgFvKkZ7r+t7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IVNqbq3T4+KT/cSGuus3LnBpMzCxGjOmGTOwvcmx183gX5pxZo8pTOB4cw2+okSn5iUQQMw+wj7GUsZmowYDew0KQLPbx1VuLdYPt826WFKP3jleWJK+XVPa1K+YcQvhx7StR18XuoTm+YYCUohPaAk0kDKlc82/WDTsHi22UsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nNVNFLgd; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/2+K2
	+TLNLt8Zt/Ms6VCHD4O/MJXQaq4q4Xpocy6olg=; b=nNVNFLgdzm/OQkKu06198
	yobWGYVh9ZCaUfgelogti4u8zv+Fyu7ZekJlpPQR7wvejqihQnoHcP8ctI2YeWSm
	XeZs05a9b9aBUx41mi06cb5VWxpObnMN/Uqf1DYBnYI+aNPxKsFyyV7vtf+es7mD
	4de7E24QroHDgKj1oeDduw=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXrmdmP+llh0IFAA--.11885S6;
	Thu, 07 Mar 2024 12:19:15 +0800 (CST)
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
Subject: [PATCH linux-5.4.y 2/8] loop: Call loop_config_discard() only after new config is applied
Date: Thu,  7 Mar 2024 12:14:05 +0800
Message-Id: <20240307041411.3792061-3-zhanggenjian@126.com>
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
X-CM-TRANSID:_____wBXrmdmP+llh0IFAA--.11885S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar43AryfuFy7try5Xr4xZwb_yoW8WrWxpF
	nrXFyUtFWvgF48CFWUGrWkua45Gan7G3y3XFW7C3yY9r43Z3savr9Ika4xXr1ktFW8XFWY
	vanakr10v3WUCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjFAJUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbi5h2afmVLY5SfTAABsU

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
index fced67ab1068..eb7b9629f6dd 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1332,8 +1332,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		}
 	}
 
-	loop_config_discard(lo);
-
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1357,6 +1355,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	loop_config_discard(lo);
+
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
-- 
2.25.1


