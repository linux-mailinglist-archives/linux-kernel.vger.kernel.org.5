Return-Path: <linux-kernel+bounces-135887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9C989CCA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD94B1F22744
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992491465B0;
	Mon,  8 Apr 2024 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuqouAGK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209814600D;
	Mon,  8 Apr 2024 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605725; cv=none; b=gcCp7Vm0OWQa3etvD4cCeHRHzYLP5ntsuPI6BpaWzs8h1CTaIYWrArYPFq6k2VUVklR6CRPIZZ2eQxmmtmXdjQS5PS7w9TDMDrvfTiCqfVezpBj/RDYlIfrwMFgUv6d+Or3aq9pu2qo3J7HTYTe3ZTnmeRjtA8SpF163M79uyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605725; c=relaxed/simple;
	bh=e7FNZkCRwzJc9ynpMaKnxLTKxonZ60uDaRzM13K/KA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6upDAZGp0Xz4UjylFcn/92qyz3r0LJaYyYokreWTRZX7mwoN/gP+LHfyIyG12jTY+aAmK8WJUZg9TIWap5p6fL2BkoTKJrnBVrr648nR0RYSQbt05JexP+LHWrQ7m6gM+qFbcW+GmonVadwARegnER2QRAcGcvy8WxvbXCnYZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuqouAGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B385C433F1;
	Mon,  8 Apr 2024 19:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712605725;
	bh=e7FNZkCRwzJc9ynpMaKnxLTKxonZ60uDaRzM13K/KA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuqouAGKUeGkDyrdxrdsGxBnYNDVPKyNbwFOycplmtj6O/rv1anr9TxPGFxEcMcMC
	 ArIkGnAgahQITvMSgImOBgzugMIx839snRTqMxVoNXijpVxAMagKHwpQ1GFs8Mh8pV
	 NH8ut2aEMSjdU5X5kKNX5Hi5hQZoJmaimt0AL+YUJfKeYSU+jQ1RFc9RNjh5zuzloH
	 VZenf+GTwlURY1qORe0cvX7TLaL+rIPY0q/608jQd2TNesQhmKg3Dob8K7dVsPOB5c
	 PR0WeKhKpGe1NQsSveZuPsoDqGRajNfHdpRo9hbL1iYt8LgrHMTheDcLveF9/cDjqO
	 JUo3UMOu2Ae7g==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [v2] staging: greybus: change strncpy() to strscpy_pad()
Date: Mon,  8 Apr 2024 21:48:11 +0200
Message-Id: <20240408194821.3183462-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408194821.3183462-1-arnd@kernel.org>
References: <20240408194821.3183462-1-arnd@kernel.org>
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

For some reason, I cannot reproduce this with gcc-9 or gcc-11, and I only
get a warning for one of the four related strncpy()s, so I'm not
sure what's going on.

Change all four to strscpy_pad(), which is the safest replacement here,
as it avoids ending up with uninitialized stack data in the tag name.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2
 - use strscpy_pad()
 - use two-argument form
 - change all four instances, not just the one that produced the warning
---
 drivers/staging/greybus/fw-management.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
index 3054f084d777..a47385175582 100644
--- a/drivers/staging/greybus/fw-management.c
+++ b/drivers/staging/greybus/fw-management.c
@@ -123,8 +123,7 @@ static int fw_mgmt_interface_fw_version_operation(struct fw_mgmt *fw_mgmt,
 	fw_info->major = le16_to_cpu(response.major);
 	fw_info->minor = le16_to_cpu(response.minor);
 
-	strncpy(fw_info->firmware_tag, response.firmware_tag,
-		GB_FIRMWARE_TAG_MAX_SIZE);
+	strscpy_pad(fw_info->firmware_tag, response.firmware_tag);
 
 	/*
 	 * The firmware-tag should be NULL terminated, otherwise throw error but
@@ -153,7 +152,7 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
 	}
 
 	request.load_method = load_method;
-	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
+	strscpy_pad(request.firmware_tag, tag);
 
 	/*
 	 * The firmware-tag should be NULL terminated, otherwise throw error and
@@ -249,8 +248,7 @@ static int fw_mgmt_backend_fw_version_operation(struct fw_mgmt *fw_mgmt,
 	struct gb_fw_mgmt_backend_fw_version_response response;
 	int ret;
 
-	strncpy(request.firmware_tag, fw_info->firmware_tag,
-		GB_FIRMWARE_TAG_MAX_SIZE);
+	strscpy_pad(request.firmware_tag, fw_info->firmware_tag);
 
 	/*
 	 * The firmware-tag should be NULL terminated, otherwise throw error and
@@ -303,13 +301,13 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
 	struct gb_fw_mgmt_backend_fw_update_request request;
 	int ret;
 
-	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
+	ret = strscpy_pad(request.firmware_tag, tag);
 
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


