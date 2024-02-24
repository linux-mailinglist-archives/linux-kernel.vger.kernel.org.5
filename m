Return-Path: <linux-kernel+bounces-79629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5878624E3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05691F2344B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033E16429;
	Sat, 24 Feb 2024 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMYusG9z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276D3B79E;
	Sat, 24 Feb 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776706; cv=none; b=g6mp9N6YA9LyJ0eLeBnfB68huIqTHCRp9x0rHD9MQzp6Ez6iUKGVB3JumZ1E2jWPR7wUaWNpM6R3+ESpAzSd+6dfLMDOYLNJOx+mYQZHGE7eEUySXXo5Fzq7dQ4gHI4qHlobnL28fKRvytvB9obZCoFajIuY+uKx+YOa+r/oqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776706; c=relaxed/simple;
	bh=rpYOVLIlw2+edCfnGPgTidNvVsmfYwWsDaMoVPZVr8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IF+Dzp9vRoFu0re0AfrHOjd9SgktBxy6UKRWtAWexklJCjPQeEtxKpNiH3xEif5GMkBRWa1s+fo3/lWz2T9Q7g4LnhFzn00PldxDa4KHyOiVX2MsYI19ikHO1IUiHxymHWSQYps8gPviuT9PXP2Lm0S66Bgb59C0SW895ZjGABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMYusG9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4786FC433F1;
	Sat, 24 Feb 2024 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708776705;
	bh=rpYOVLIlw2+edCfnGPgTidNvVsmfYwWsDaMoVPZVr8E=;
	h=From:To:Cc:Subject:Date:From;
	b=jMYusG9zU120ZBb9vkTnb0qG6A/UiiTaSGVoqNWGurOliBSjvBWVryKy64I+HsV5g
	 ec3yKfFqRpoRkYCyzp4fmpQBvd82X98XRoJZkGt7l80ESU6NovDz6G3SC6R/pxcjUc
	 WWjMesOnL+QL2nUL7rjaJWRaULmaM1/SpDkMNvRO+40HJwmmBWjpOeG/icgHV4kxiJ
	 hfFiCLEyaufNjEirGF2iX50SNMN9EOKoqhZlQC8Waqcb+QJMWMVctgvZMtdkSsdkPY
	 ELCFD8sW8eK/DziA6ATVbxz5xLI/fod5LI0n/s1SzCx+mTXh1wxBX5fFb6ehxdx/9b
	 lZc8XbGFs7ang==
From: Arnd Bergmann <arnd@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] iio: avoid fortify-string overflow error
Date: Sat, 24 Feb 2024 13:11:34 +0100
Message-Id: <20240224121140.1883201-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The memcpy() call in dlhl60d.c triggers a check with clang-19:

In file included from drivers/iio/pressure/dlhl60d.c:11:
In file included from include/linux/module.h:17:
include/linux/fortify-string.h:553:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
  553 |                         __write_overflow_field(p_size_field, size);
      |                         ^

It writes into a two member array from a loop over a linked list
that likely has some indication of having more than two entries.

Add a conditional check there to avoid the overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/pressure/dlhl60d.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 28c8269ba65d..a43ecda849db 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -262,6 +262,8 @@ static irqreturn_t dlh_trigger_handler(int irq, void *private)
 			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
 			DLH_NUM_DATA_BYTES);
 		i++;
+		if (i >= ARRAY_SIZE(tmp_buf))
+			break;
 	}
 
 	iio_push_to_buffers(indio_dev, tmp_buf);
-- 
2.39.2


