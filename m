Return-Path: <linux-kernel+bounces-27834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216682F68A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F8C1C237F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65153FE50;
	Tue, 16 Jan 2024 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR26B9A/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C243FB35;
	Tue, 16 Jan 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434323; cv=none; b=jzfNyQ1R+UxgQwZW2IFcJGP96uBH1ggHtbs4gjcH5b5E4ZjQ9mUl6YjlddVVbIIro7cOobr9qyhoveCpD7zEBQgCBAl4S1g8JxjuITKyCUQ1Yrg/9Kp+ofR/Cr+24Rgjnp/h6bZ9q+4y3mroPJxpqOXF3w+9ChyL49QZP1FlDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434323; c=relaxed/simple;
	bh=4vf9MSNWAubfBAh0ArsuBB9cwHDCLIIqku+4MwBPn1k=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=UjiWR4evignqlp/SGH5phPuIb6h/tkwJYRJtWJJ3AKDnStowC8gwynH9HOrjXsIK/FjXiTYR3XUC9z6Sl7wL4JtVvXC/ykfnIwaDTJmGIbONqCtFaPuRSrMKm1kzt3UZMecX53FM++DfrVw4G8zQWacfBtNb8mMWF8EULbYTMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR26B9A/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD56C433F1;
	Tue, 16 Jan 2024 19:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434322;
	bh=4vf9MSNWAubfBAh0ArsuBB9cwHDCLIIqku+4MwBPn1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mR26B9A/6/4UmBKgrWOJgSs+iNmTOLEtUSghFcwasb6wKhzOoC74pSoGrkntm8fTc
	 3lCDO1LCz5BXWrhyh28ssJyV+8FpCbc5JbtOdaZZHo57SKKV+hkccYfQdmzVaoW8ss
	 ld2BWH3QeD4C0v/co/W9WemNJT/qKvdE9U00RrdfoIiFnJafUFaacBgvJdKk5nrGHQ
	 cxBOIBUo6g5lChmn9LJU0Vg/0bS2hoaZD8mEnx0AKhCsAX4DrKDrf1CdPeQDoWbNyc
	 TB+e3BHTfUcvcLCfTPhLUy4mjOW5Rm2P+I8tePCvymJh5BjnVzny/cTRM1s/mAzjig
	 SqaHV6jfdnGqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.7 063/108] block/rnbd-srv: Check for unlikely string overflow
Date: Tue, 16 Jan 2024 14:39:29 -0500
Message-ID: <20240116194225.250921-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 9e4bf6a08d1e127bcc4bd72557f2dfafc6bc7f41 ]

Since "dev_search_path" can technically be as large as PATH_MAX,
there was a risk of truncation when copying it and a second string
into "full_path" since it was also PATH_MAX sized. The W=1 builds were
reporting this warning:

drivers/block/rnbd/rnbd-srv.c: In function 'process_msg_open.isra':
drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output may be truncated writing up to 254 bytes into a region of size between 0 and 4095 [-Wformat-truncation=]
  616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
      |                                                   ^~
In function 'rnbd_srv_get_full_path',
    inlined from 'process_msg_open.isra' at drivers/block/rnbd/rnbd-srv.c:721:14: drivers/block/rnbd/rnbd-srv.c:616:17: note: 'snprintf' output between 2 and 4351 bytes into a destination of size 4096
  616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  617 |                          dev_search_path, dev_name);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~

To fix this, unconditionally check for truncation (as was already done
for the case where "%SESSNAME%" was present).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312100355.lHoJPgKy-lkp@intel.com/
Cc: Md. Haris Iqbal <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc:  <linux-block@vger.kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Link: https://lore.kernel.org/r/20231212214738.work.169-kees@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rnbd/rnbd-srv.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 65de51f3dfd9..ab78eab97d98 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -585,6 +585,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 {
 	char *full_path;
 	char *a, *b;
+	int len;
 
 	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!full_path)
@@ -596,19 +597,19 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	 */
 	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
 	if (a) {
-		int len = a - dev_search_path;
+		len = a - dev_search_path;
 
 		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
 			       dev_search_path, srv_sess->sessname, dev_name);
-		if (len >= PATH_MAX) {
-			pr_err("Too long path: %s, %s, %s\n",
-			       dev_search_path, srv_sess->sessname, dev_name);
-			kfree(full_path);
-			return ERR_PTR(-EINVAL);
-		}
 	} else {
-		snprintf(full_path, PATH_MAX, "%s/%s",
-			 dev_search_path, dev_name);
+		len = snprintf(full_path, PATH_MAX, "%s/%s",
+			       dev_search_path, dev_name);
+	}
+	if (len >= PATH_MAX) {
+		pr_err("Too long path: %s, %s, %s\n",
+		       dev_search_path, srv_sess->sessname, dev_name);
+		kfree(full_path);
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* eliminitate duplicated slashes */
-- 
2.43.0


