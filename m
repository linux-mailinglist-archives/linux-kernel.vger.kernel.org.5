Return-Path: <linux-kernel+bounces-141350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D848A1D12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69C91C239B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE61C8FC7;
	Thu, 11 Apr 2024 16:47:13 +0000 (UTC)
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C417742;
	Thu, 11 Apr 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854032; cv=none; b=eCe7w8t7E7AIorwlqRDKSk9qAQXfzdMdStyDBsrZRrUoS12ofyeSCSIBlHlLzNN0ewE+AucVhVOZ65E/U+U0I+IjrY6UQlRsFC9XwTfgGKhm8DvjEjgjV9HQGxLrUkOHh2u+TCbeaQlCCv0o0kWi/kMVQF6iNBjUtTI92zFA4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854032; c=relaxed/simple;
	bh=RyVOe6pCtx0/g7zEV7rXDdHduJWvub6mOy5PsGRPM7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F19ALh1GPErHZEv2/sM1gzjxiGaJwgidBP760MyPmwd11340edpTzWwOqKntP6vhuujpvOfia4IaL2150ArNqPVsegYUTOqy+/U7sZZ6NUm6WgfkXzCdaZMhqNZNTkTvfthzXPEIF3RdIel66IK1v3Z3HfM60kzJ0wQvuFy3CfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=provod.works; spf=pass smtp.mailfrom=provod.works; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=provod.works
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=provod.works
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <me@provod.works>)
	id 1ruxZs-002Jw4-5h; Thu, 11 Apr 2024 18:47:08 +0200
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <me@provod.works>)
	id 1ruxZm-0004Du-KJ; Thu, 11 Apr 2024 18:47:02 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (959450)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1ruxZl-00BPCo-2M; Thu, 11 Apr 2024 18:47:01 +0200
From: Ivan Avdeev <me@provod.works>
To: laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivan Avdeev <me@provod.works>
Subject: [PATCH] usb: gadget: uvc: use correct buffer size when parsing configfs lists
Date: Thu, 11 Apr 2024 12:46:16 -0400
Message-ID: <20240411164616.4130163-1-me@provod.works>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes uvc gadget support on 32-bit platforms.

Commit 0df28607c5cb ("usb: gadget: uvc: Generalise helper functions for
reuse") introduced a helper function __uvcg_iter_item_entries() to aid
with parsing lists of items on configfs attributes stores. This function
is a generalization of another very similar function, which used a
stack-allocated temporary buffer of fixed size for each item in the list
and used the sizeof() operator to check for potential buffer overruns.
The new function was changed to allocate the now variably sized temp
buffer on heap, but wasn't properly updated to also check for max buffer
size using the computed size instead of sizeof() operator.

As a result, the maximum item size was 7 (plus null terminator) on
64-bit platforms, and 3 on 32-bit ones. While 7 is accidentally just
barely enough, 3 is definitely too small for some of UVC configfs
attributes. For example, dwFrameInteval, specified in 100ns units,
usually has 6-digit item values, e.g. 166666 for 60fps.

Fixes: 0df28607c5cb ("usb: gadget: uvc: Generalise helper functions for reuse")
Signed-off-by: Ivan Avdeev <me@provod.works>
---
 drivers/usb/gadget/function/uvc_configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 7e704b2bcfd1..a4377df612f5 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -92,10 +92,10 @@ static int __uvcg_iter_item_entries(const char *page, size_t len,
 
 	while (pg - page < len) {
 		i = 0;
-		while (i < sizeof(buf) && (pg - page < len) &&
+		while (i < bufsize && (pg - page < len) &&
 		       *pg != '\0' && *pg != '\n')
 			buf[i++] = *pg++;
-		if (i == sizeof(buf)) {
+		if (i == bufsize) {
 			ret = -EINVAL;
 			goto out_free_buf;
 		}

base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
-- 
2.43.2


