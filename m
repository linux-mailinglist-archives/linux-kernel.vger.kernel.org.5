Return-Path: <linux-kernel+bounces-77348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9786042D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A88E28CF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9EE73F22;
	Thu, 22 Feb 2024 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcofIHS8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA771758
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635485; cv=none; b=MzJY25cf9l8Aqk1rwDZSNFfR0CQzj96rVnfoVUFY98f08m5GCc7fPS1XEC8y+o39grruIWaFc+4eHylF3d+aTaaTvt5t/rZSQzQ2c5xYkviBWFs9Rbs5ZgkLmfS3IWLYo/P/ZEDrEMrDH0rRizSA4/d7nQZz7nZzZO/77fZONIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635485; c=relaxed/simple;
	bh=RYF/zx8lxVWlX0R60jvZqrw1QrH/wfXhiW3cenHTKEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7VHlnkg4lto4voWgxy4g3Sm94amGaMyTo8s8GmZw26eOz4o11YBmkcjZqyij8fmkaBm0jsS+iK4ZeYiHU/Ia5DYWYj9o/Zd5YHcwhs/SDmHrLHp3d0d4KvoosBvQdl8wezZ0Vb/Ku9SxRGpKQJrJvwZsnm3xCQZxogt8f/gSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcofIHS8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708635482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnuwxZrLi92WYaoyoAhB2T7aK4APtF+lWO0JDf5B6mU=;
	b=DcofIHS8GlItP4dmmXWttfVVk1SZVDbTiHSqfnyvhQ2p36v1+UHEX5UGHJaVdtpAjPffRY
	5S+LMIo7tc6jTp4cfRjVzfmSiJnU3oiGjexmxfFYDP6nfRTehIcxqc20YZvB87X4whHlO6
	8HqaS8A0U/bjTeY+L0VboYI0qRNt4jY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-fF_JvuC2OfKQu_nuUtCNjw-1; Thu, 22 Feb 2024 15:57:59 -0500
X-MC-Unique: fF_JvuC2OfKQu_nuUtCNjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 179AA1065221;
	Thu, 22 Feb 2024 20:57:59 +0000 (UTC)
Received: from ibm-p8-16-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com (unknown [10.22.8.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B66D10800;
	Thu, 22 Feb 2024 20:57:58 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: ilpo.jarvinen@linux.intel.com,
	shravankr@nvidia.com
Cc: davthompson@nvidia.com,
	ndalvi@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH 1/2] platform/mellanox: mlxbf-pmc: mlxbf_pmc_event_list(): make size ptr optional
Date: Thu, 22 Feb 2024 15:57:29 -0500
Message-ID: <182de8ec6b9c33152f2ba6b248c35b0311abf5e4.1708635408.git.luizcap@redhat.com>
In-Reply-To: <cover.1708635408.git.luizcap@redhat.com>
References: <cover.1708635408.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The mlxbf_pmc_event_list() function returns a pointer to an array of
supported events and the array size. The array size is returned via
a pointer passed as an argument, which is mandatory.

However, we want to be able to use mlxbf_pmc_event_list() just to check
if a block name is implemented/supported. For this usage passing the size
argument is not necessary so let's make it optional.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 40 +++++++++++++++------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 250405bb59a7..b71636eb3db1 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -966,32 +966,33 @@ static bool mlxbf_pmc_valid_range(unsigned int blk_num, u32 offset)
 }
 
 /* Get the event list corresponding to a certain block */
-static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size_t *size)
+static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size_t *psize)
 {
 	const struct mlxbf_pmc_events *events;
+	size_t size;
 
 	if (strstr(blk, "tilenet")) {
 		events = mlxbf_pmc_hnfnet_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_hnfnet_events);
+		size = ARRAY_SIZE(mlxbf_pmc_hnfnet_events);
 	} else if (strstr(blk, "tile")) {
 		events = mlxbf_pmc_hnf_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_hnf_events);
+		size = ARRAY_SIZE(mlxbf_pmc_hnf_events);
 	} else if (strstr(blk, "triogen")) {
 		events = mlxbf_pmc_smgen_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
+		size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
 	} else if (strstr(blk, "trio")) {
 		switch (pmc->event_set) {
 		case MLXBF_PMC_EVENT_SET_BF1:
 			events = mlxbf_pmc_trio_events_1;
-			*size = ARRAY_SIZE(mlxbf_pmc_trio_events_1);
+			size = ARRAY_SIZE(mlxbf_pmc_trio_events_1);
 			break;
 		case MLXBF_PMC_EVENT_SET_BF2:
 			events = mlxbf_pmc_trio_events_2;
-			*size = ARRAY_SIZE(mlxbf_pmc_trio_events_2);
+			size = ARRAY_SIZE(mlxbf_pmc_trio_events_2);
 			break;
 		default:
 			events = NULL;
-			*size = 0;
+			size = 0;
 			break;
 		}
 	} else if (strstr(blk, "mss")) {
@@ -999,43 +1000,46 @@ static const struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk, size
 		case MLXBF_PMC_EVENT_SET_BF1:
 		case MLXBF_PMC_EVENT_SET_BF2:
 			events = mlxbf_pmc_mss_events_1;
-			*size = ARRAY_SIZE(mlxbf_pmc_mss_events_1);
+			size = ARRAY_SIZE(mlxbf_pmc_mss_events_1);
 			break;
 		case MLXBF_PMC_EVENT_SET_BF3:
 			events = mlxbf_pmc_mss_events_3;
-			*size = ARRAY_SIZE(mlxbf_pmc_mss_events_3);
+			size = ARRAY_SIZE(mlxbf_pmc_mss_events_3);
 			break;
 		default:
 			events = NULL;
-			*size = 0;
+			size = 0;
 			break;
 		}
 	} else if (strstr(blk, "ecc")) {
 		events = mlxbf_pmc_ecc_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_ecc_events);
+		size = ARRAY_SIZE(mlxbf_pmc_ecc_events);
 	} else if (strstr(blk, "pcie")) {
 		events = mlxbf_pmc_pcie_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_pcie_events);
+		size = ARRAY_SIZE(mlxbf_pmc_pcie_events);
 	} else if (strstr(blk, "l3cache")) {
 		events = mlxbf_pmc_l3c_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_l3c_events);
+		size = ARRAY_SIZE(mlxbf_pmc_l3c_events);
 	} else if (strstr(blk, "gic")) {
 		events = mlxbf_pmc_smgen_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
+		size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
 	} else if (strstr(blk, "smmu")) {
 		events = mlxbf_pmc_smgen_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
+		size = ARRAY_SIZE(mlxbf_pmc_smgen_events);
 	} else if (strstr(blk, "llt_miss")) {
 		events = mlxbf_pmc_llt_miss_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_llt_miss_events);
+		size = ARRAY_SIZE(mlxbf_pmc_llt_miss_events);
 	} else if (strstr(blk, "llt")) {
 		events = mlxbf_pmc_llt_events;
-		*size = ARRAY_SIZE(mlxbf_pmc_llt_events);
+		size = ARRAY_SIZE(mlxbf_pmc_llt_events);
 	} else {
 		events = NULL;
-		*size = 0;
+		size = 0;
 	}
 
+	if (psize)
+		*psize = size;
+
 	return events;
 }
 
-- 
2.43.1


