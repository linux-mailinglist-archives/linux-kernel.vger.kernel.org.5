Return-Path: <linux-kernel+bounces-156564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580CE8B049C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151B228671D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33161586CB;
	Wed, 24 Apr 2024 08:42:43 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09057156F2B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948163; cv=none; b=ZyEC4QvQegZfLA4L4ihVDeVjk4+DtRK1ufdG0IFKXQnaqlXlTjh3opMa5RaVI92Dzzk4T7RxlGkQSDZoP7S/TVwO3FNGKoUDawJ3G8lni4FPeUjlDr7/C+bBnP6JZePqnFrgAKIRYQt1Q0sCBdjVh2VKWO2OdkVMA+f8Lls0+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948163; c=relaxed/simple;
	bh=p3kEmUvP3hb0uHXNwsP/6B7zN9ddbcUBorXk/271Yc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RjuSK/vx6aR9ijql6k9zKwEfZcuuP8/5YRvVh3uw0ulq5pADm8/Enh3fpt/mBuVhT4SgFt2S1j6y0sj7G5/kM7K++bTLYX42SswxUr42WN/DVX7he5n0wYdHV49/7EgUwjl7feeWF/di8HNjlACU6YMw9tqneprurZPSAHLy6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VPXTy0jFYz1j0sv;
	Wed, 24 Apr 2024 16:39:34 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 14EB518005F;
	Wed, 24 Apr 2024 16:42:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 16:42:37 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>, <dhavale@google.com>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next] erofs: modify the error message when prepare_ondemand_read failed
Date: Wed, 24 Apr 2024 16:42:47 +0800
Message-ID: <20240424084247.759432-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

When prepare_ondemand_read failed, wrong error message is printed.
The prepare_read is also implemented in cachefiles, so we amend it.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/fscache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8aff1a724805..62da538d91cb 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -151,7 +151,7 @@ static int erofs_fscache_read_io_async(struct fscache_cookie *cookie,
 		if (WARN_ON(len == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
-			erofs_err(NULL, "prepare_read failed (source %d)", source);
+			erofs_err(NULL, "prepare_ondemand_read failed (source %d)", source);
 			return -EIO;
 		}
 
-- 
2.34.1


