Return-Path: <linux-kernel+bounces-123074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 479208901CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4046B21E51
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836F12F38E;
	Thu, 28 Mar 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6nBMvO8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24512F38C;
	Thu, 28 Mar 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636298; cv=none; b=N+ra2drUjO1JFuTUzygwQ6DTrQRi7jP6WELmDXs1gJrhOHy45/S5HFEwXspHbE0t+8sgmADfgEc1+9d9F5skzjVErzm98aFxTG13l4vcnv3uKJnPjL9U5VahiHOBEUOsUsUeoCkaXqvFg2mp/aFTVp13IgI3UxDUlywtHFNOBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636298; c=relaxed/simple;
	bh=R0aUpIukgAH4xjGJj4S14g7ze9BAK3FgVk+vR41wWF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEmC9jXBCJyQ9lI45/Ccv0qcLLjcHuZjlI/QUCjOtFNpYh0/6n1RkT7lBtbfLxuKh25KOQXii7Hxl1U6e7rhzdSaBxmFPI5FeBvMCSAztmFcwfY/ro5wFo3mOicvmCroFmk3lmurJViTLv/y7rBg07wLskxLzrx8IPS99mWdVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6nBMvO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A6AC433C7;
	Thu, 28 Mar 2024 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636298;
	bh=R0aUpIukgAH4xjGJj4S14g7ze9BAK3FgVk+vR41wWF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6nBMvO8FUq7wwMpXlu5eU2X+qG2WwQMDrQQcRCXN13QGA7B+OYdbmM3DdmZbLfpd
	 eJcJTquwgfzRZ2I0/ojf1S84gT5/H3gCLYVPq9jfRlj8k5y1H4wZpkhHcWXziQAml5
	 aJeSJ8DXrTbPoFJB3u+3Cyp9otY+hfgaiuBfkBGclsSwXDoAQXRuAEWvm5pvYnvJhS
	 0E6tdV7+RfopI4ZvIWUMm6IiTcdbMOVi9nncy4ueupamqPVOJxAgfXAN5H4zYM4HDo
	 MuSfDfCP8h8W94vjEQL85zvUuRBzTmg9ZjMYK3/93ZDgIqf+rHpEjVsQ1kDiY5yHgD
	 T6xlVNXKOCFgw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Nathan Chancellor <nathan@kernel.org>,
	Alex Elder <elder@inktank.com>,
	Josh Durgin <josh.durgin@inktank.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alex Elder <elder@linaro.org>,
	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 3/9] rbd: avoid out-of-range warning
Date: Thu, 28 Mar 2024 15:30:41 +0100
Message-Id: <20240328143051.1069575-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-14 points out that the range check is always true on 64-bit
architectures since a u32 is not greater than the allowed size:

drivers/block/rbd.c:6079:17: error: result of comparison of constant 2305843009213693948 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
            ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is harmless, so just change the type of the temporary to size_t
to shut up that warning.

Fixes: bb23e37acb2a ("rbd: refactor rbd_header_from_disk()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 26ff5cd2bf0a..cb25ee513ada 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6062,7 +6062,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
 	void *p;
 	void *end;
 	u64 seq;
-	u32 snap_count;
+	size_t snap_count;
 	struct ceph_snap_context *snapc;
 	u32 i;
 
-- 
2.39.2


