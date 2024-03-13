Return-Path: <linux-kernel+bounces-102348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0887B10C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DFA1F245A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595D660DFC;
	Wed, 13 Mar 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eJQ4wG9F"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCE60DEC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353993; cv=none; b=LWMLl1ldE0FkV7N/lb6D4pnFoi7ifMXPoEuqBZi79sZAK3jlVsSav4AWaSClRqtO5l1+8cZGwm8LsHptpGLznmD+I82lkIxtz+ZNCS0C7jPjG31+hfVr3I2IxTcJx5pW0+RqFm9VsAraen0orZuDFWOXtMBW9lhn0Zw9lShtX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353993; c=relaxed/simple;
	bh=KCFc7PDUBA25mdcJlQ6DeNsE8GXrWSpFQMSgo+06cRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=AETkikd7SwcJXhPd6PGr6tkW3SencthFaihPq2EUgoxHt+Rz13nEToesktZeWDD/L1O6tRJLKGTM/kdzQ3VxRPtNPR4R9ibgiv9ieb0fQk75dmzXmg9foHHlm6Lhlfa0+I/FR9eSFJPvb8z2b3Al47w8MBi8pXAJXX/zh2c8+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eJQ4wG9F; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710353981;
	bh=KCFc7PDUBA25mdcJlQ6DeNsE8GXrWSpFQMSgo+06cRY=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=eJQ4wG9FQAFO6D1MQG0303ZbPcTX4fcJL+NfI8N8fUaxkVAMFBShC4nfXfWy2nHiT
	 QGXJ4+eXdSVUtCzAT7PeK79AZvvWUpCStS8cIi5FIwV0fCdyC4v0Go8+Xvy5k5XjBC
	 +htt077M+2cGaUmslhVxxD7ycMUJipvf2D3fyOeg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 13 Mar 2024 19:19:30 +0100
Subject: [PATCH 1/2] misc/pvpanic: use bit macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240313-pvpanic-shutdown-header-v1-1-7f1970d66366@weissschuh.net>
References: <20240313-pvpanic-shutdown-header-v1-0-7f1970d66366@weissschuh.net>
In-Reply-To: <20240313-pvpanic-shutdown-header-v1-0-7f1970d66366@weissschuh.net>
To: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710353980; l=811;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KCFc7PDUBA25mdcJlQ6DeNsE8GXrWSpFQMSgo+06cRY=;
 b=duUiqTbuq/rfxkKHUsvdoNJfjH5RaaDlXZN4w7gL9ddd+7g1LWuBq2xUVJ2/R7umzZimZhy7P
 8OxPKw47nuNA3nIYB76zmoy4sU7qdm45KqlYbKxTmnD5UdyHlz/F2rD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The macros are easier to read.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/lkml/2023110407-unselect-uptight-b96d@gregkh/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/uapi/misc/pvpanic.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
index 54b7485390d3..9ea6a965ca7a 100644
--- a/include/uapi/misc/pvpanic.h
+++ b/include/uapi/misc/pvpanic.h
@@ -3,7 +3,9 @@
 #ifndef __PVPANIC_H__
 #define __PVPANIC_H__
 
-#define PVPANIC_PANICKED	(1 << 0)
-#define PVPANIC_CRASH_LOADED	(1 << 1)
+#include <linux/const.h>
+
+#define PVPANIC_PANICKED	_BITUL(0)
+#define PVPANIC_CRASH_LOADED	_BITUL(1)
 
 #endif /* __PVPANIC_H__ */

-- 
2.44.0


