Return-Path: <linux-kernel+bounces-143757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926B8A3D10
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45908B215BA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89E45038;
	Sat, 13 Apr 2024 15:02:04 +0000 (UTC)
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3ECA31
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713020523; cv=none; b=EbbiKN+SK+/oCJ3/XzRV5iD2tOWg/kx601F7SaT69ElLC5aToubECz1oNx6oiII1yGe7/8ZMyUZYok6TaxPfc6Jh/u0/SgL20j6QQG0Vor21y3+mHFVsW+YQAt30erS7a9H1cjMQw2pjjMWzvov/7dtyCh7VKP0W52G13Gx1ljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713020523; c=relaxed/simple;
	bh=cQqmGUNTIUsPOuG5qLAkm6+OZUoK++6w76rZGWCTmMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDYN+oweM7MG9GMUsaNg7m3oReIeOavROBDpTgA7uyopiOiCOsdVzkV4T50b5O47uuGmzkV5e5Hfk2ZuIxIyvaISyLng544ndlSIaMfUUtMchJ53EIXxL0fvcvYQQ0e9jcuEbLfmieGthf7JY2VTdy1Bm5zQEaOZg1PS/mbSX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=provod.works; spf=pass smtp.mailfrom=provod.works; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=provod.works
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=provod.works
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <me@provod.works>)
	id 1rvet5-007DtT-CD; Sat, 13 Apr 2024 17:01:51 +0200
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <me@provod.works>)
	id 1rvet4-00016U-Th; Sat, 13 Apr 2024 17:01:51 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (959450)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1rvest-000z1D-7H; Sat, 13 Apr 2024 17:01:39 +0200
From: Ivan Avdeev <me@provod.works>
To: laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: uvc: use correct buffer size when parsing configfs lists
Date: Sat, 13 Apr 2024 11:01:24 -0400
Message-ID: <20240413150124.1062026-1-me@provod.works>
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

Cc: stable@vger.kernel.org
Fixes: 0df28607c5cb ("usb: gadget: uvc: Generalise helper functions for reuse")
Signed-off-by: Ivan Avdeev <me@provod.works>
---
v2:
- add Cc: stable
- v1: https://lore.kernel.org/linux-usb/20240411164616.4130163-1-me@provod.works/
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


