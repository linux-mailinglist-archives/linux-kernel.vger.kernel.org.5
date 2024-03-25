Return-Path: <linux-kernel+bounces-117527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3B88B2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E489BE528F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3113AD23;
	Mon, 25 Mar 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pc+Zz6Nu"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83CF1BF3B;
	Mon, 25 Mar 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385895; cv=none; b=Gspm6XT7vW/WfAsaAnL+uliR1Jq5SkurU+xlZoljmKlZ2BP+LlmWA31m+h7v31HgCLKycFUPBSo9PWjv5vxWXIV3UHY2j8e456kNguQYzRIXQwythW1+U4mJfyf0X9tlEXU8+qdDdbDLaQC0UtTwZFWvWnYmGQgeXxaymUHaRhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385895; c=relaxed/simple;
	bh=s+1XxCgD/bIw+EVjquCNoElOO+KgUsBhWbtYu72Cc7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=td3Ka9EvjWoXL5EYZJAeMQR5u3qC6fZDSJFtDdQz4aF45ufrHNAF4a+uRFR8FwB9FBPkk8h1c9rNtCC17YNG0FznYmuFAq9E4FlZjnvLCC+Dvx41c2EuqRdQDyzmFpbvVnA3SWkQSp279AEB7kAl3LkwqSvua/Ie3uLVVo+CUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Pc+Zz6Nu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PGwAqo056603;
	Mon, 25 Mar 2024 11:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711385890;
	bh=GPiMIB+Jdz5Fonm+uVYUxOBrjgYl4eFPyll8eytBOg8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Pc+Zz6NuyRvUkU6vVtP3kjd9dycVyrX3/mRnCzDFrdNBoK0pB3vy386vArHGk50yf
	 xn/SE6j+2b3HhgEkzKrq5D7rmU+RePfyFcnSgMIvGFcvOEZLHgZmBb2Y9SRqQeAu5n
	 I6GcKZRNWvoPiXs7LU70lDzqocZQJX1F4+JCvSRQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PGwASK079561
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 11:58:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 11:58:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 11:58:09 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PGw83k029739;
	Mon, 25 Mar 2024 11:58:09 -0500
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 3/3] remoteproc: omap: Remove unused header omap-mailbox.h
Date: Mon, 25 Mar 2024 11:58:08 -0500
Message-ID: <20240325165808.31885-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325165808.31885-1-afd@ti.com>
References: <20240325165808.31885-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This header no longer used, remove this include.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/omap_remoteproc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 8f50ab80e56f4..bde04e3e6d966 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -29,7 +29,6 @@
 #include <linux/remoteproc.h>
 #include <linux/mailbox_client.h>
 #include <linux/omap-iommu.h>
-#include <linux/omap-mailbox.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/reset.h>
-- 
2.39.2


