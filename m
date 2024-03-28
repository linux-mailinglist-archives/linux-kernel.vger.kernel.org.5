Return-Path: <linux-kernel+bounces-123026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47B890130
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79F61C25DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338212F38D;
	Thu, 28 Mar 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIwgWdpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201612F38B;
	Thu, 28 Mar 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634832; cv=none; b=Lvue5R+ldHCSjYyou+BsRWQittE5dP1oBhmbiif7UrumYJlFxWGIp0odKKilzlBYcarDfUHHCU1K19sC6tNF6EuZJLYTgSe62HsXc5XVk00gXvvQet8cdQ/7jQTltX+AIU/3ABiCAN7jOkjZvDUABb6QCkBWrej9Nhc8RO5Kunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634832; c=relaxed/simple;
	bh=jCpFq1/rgN+7LjvFqEP/87Ucf4QQthKAvwD+RuobdII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kaIvdv8BScpK72+0B0VDB6GHIbTPttmqmO1bXiv0C4DhlCnyvpP+uQb0Xu685xLhkve3gbTlJTxfbM3SdFQy2L9qa+P0GpMVpVYux+pSIVykbwtj4d/OXeq7o+5gjN+hbzNWTftlwY3+VVr5Wg7mkWTy0HjmiK86/r5j5xl+EmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIwgWdpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6929CC433C7;
	Thu, 28 Mar 2024 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634831;
	bh=jCpFq1/rgN+7LjvFqEP/87Ucf4QQthKAvwD+RuobdII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIwgWdplCpwDNWYw4e1shf3eU4qoI/uvcSnjDOLeb+kQweNsamyY7YOT+JBBCmRzw
	 HezFO0Fb4Y5P33syW0JRJSrC5h9C5oTkH5rBI1MZ+P561FPcxmEayw1Bi9tveYzytC
	 pRKupfZbCAkQqUPaLBSSlJg6gVN1Fm4xeRNXMsgcNi9/x9CeOaHUG81Y4rCvtSwelR
	 asCNEsRlXnLfHoC3uwy5v9/I5NwerDic/0Q15M2P1Idowq4iZaa4rw4QpgdLTpmQ/0
	 LRp05PnaEx41QBFzVv1Zw+bK9LK24zwEz5PV77deYh3nlSY03oT0Z/yE0v+NQV0HVu
	 E3qh9p9plPG5A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: [PATCH 10/11] staging: greybus: change strncpy() to strscpy()
Date: Thu, 28 Mar 2024 15:04:54 +0100
Message-Id: <20240328140512.4148825-11-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-10 warns about a strncpy() that does not enforce zero-termination:

In file included from include/linux/string.h:369,
                 from drivers/staging/greybus/fw-management.c:9:
In function 'strncpy',
    inlined from 'fw_mgmt_backend_fw_update_operation' at drivers/staging/greybus/fw-management.c:306:2:
include/linux/fortify-string.h:108:30: error: '__builtin_strncpy' specified bound 10 equals destination size [-Werror=stringop-truncation]
  108 | #define __underlying_strncpy __builtin_strncpy
      |                              ^
include/linux/fortify-string.h:187:9: note: in expansion of macro '__underlying_strncpy'
  187 |  return __underlying_strncpy(p, q, size);
      |         ^~~~~~~~~~~~~~~~~~~~

For some reason, I cannot reproduce this with gcc-9 or gcc-11, so I'm not
sure what's going on. Changing it to strspy() avoids the warning. In this
case the existing check for zero-termination would fail but can be replaced
with an error check.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is from randconfig testing with random gcc versions, a .config to
reproduce is at https://pastebin.com/r13yezkU
---
 drivers/staging/greybus/fw-management.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
index 3054f084d777..35bfdd5f32d2 100644
--- a/drivers/staging/greybus/fw-management.c
+++ b/drivers/staging/greybus/fw-management.c
@@ -303,13 +303,13 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
 	struct gb_fw_mgmt_backend_fw_update_request request;
 	int ret;
 
-	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
+	ret = strscpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
 
 	/*
 	 * The firmware-tag should be NULL terminated, otherwise throw error and
 	 * fail.
 	 */
-	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
+	if (ret == -E2BIG) {
 		dev_err(fw_mgmt->parent, "backend-update: firmware-tag is not NULL terminated\n");
 		return -EINVAL;
 	}
-- 
2.39.2


