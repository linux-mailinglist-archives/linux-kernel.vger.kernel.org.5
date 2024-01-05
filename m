Return-Path: <linux-kernel+bounces-17832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD6C82535F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7662864C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EF92D614;
	Fri,  5 Jan 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CTf4U0Qp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D72D602
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 12:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE7DC433C7;
	Fri,  5 Jan 2024 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704458016;
	bh=Tyh7Z/guTSNA99TOFNxVkN5Bd/C6PszkdiWF0BBoAEA=;
	h=From:To:Cc:Subject:Date:From;
	b=CTf4U0QpP32A3rDra6b0HkUE0k4EoPr1rDFnEFRVYD5psD31yheYu2gfdHrPsicSu
	 RnDjeBbaUsmWcxMGAd/1CXmW0to/3nF88dk1gzpCY/Y4f/hnY5KrHdLPXUfv3DQDKX
	 gGbQl9L+xm38tIw1TUFA/70OxFA8aCfT2HxklFmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: coresight@lists.linaro.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] coresight: make coresight_bustype const
Date: Fri,  5 Jan 2024 13:33:32 +0100
Message-ID: <2024010531-tinfoil-avert-4a57@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 45
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Tyh7Z/guTSNA99TOFNxVkN5Bd/C6PszkdiWF0BBoAEA=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnTv0vrHt6h7lFywvcia+X1LYL2J1OZI543dq+9IcGin RB3Q+B/RywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzksAbDgn3FYtYusywm7Yhw va6/sMv5p+bnOIYF16NW9tdJK3FlOyWK/09RSJzBZaABAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the coresight_bustype variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 include/linux/coresight.h                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fabe00a40d6..24c49e581737 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1796,7 +1796,7 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 }
 EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
 
-struct bus_type coresight_bustype = {
+const struct bus_type coresight_bustype = {
 	.name	= "coresight",
 };
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a269fffaf991..8fe75a0d7693 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -35,7 +35,7 @@
 
 #define CORESIGHT_UNLOCK	0xc5acce55
 
-extern struct bus_type coresight_bustype;
+extern const struct bus_type coresight_bustype;
 
 enum coresight_dev_type {
 	CORESIGHT_DEV_TYPE_SINK,
-- 
2.43.0


