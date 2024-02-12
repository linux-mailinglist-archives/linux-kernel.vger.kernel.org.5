Return-Path: <linux-kernel+bounces-61095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B023850D32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316351F25B36
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F447747D;
	Mon, 12 Feb 2024 04:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJy+HGm8"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210A6FBF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707712263; cv=none; b=hERSjFwCSUKinVLyTN7b6yqlYSO+lG3UOdUWyibt0FOt4agvPyoHDeQl3Hi1Fimjd/lVIz/gjq6Sy5KERyOp3ysTCOLiiGWvLrkX69KEky/+e6lqm4b28hAmhCQBtaWdR3wH3cCgCNGagKutyJY7Qa61ebiceYu8/T72UUSF9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707712263; c=relaxed/simple;
	bh=sd2AYUUd6itfORRWa6+jwWW8oOGJmLWpUFPc0KF0MF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxky1NeHoTGtK4ALCpRaF5GAlr55SCleQBbSU0H15za1qSyM/VFHOnIF1rYPbzZE9JBVGUBxAhjo2Rle/ALQ+xcpwp5n7QuetffwtIazXA4wDMUH26QB15z/SXbRtqhrbfGx8avbhJHT+tvuTCK6nGDwsYq7jr1J7uKTRnY6nu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HJy+HGm8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=O+ppX+9FxVt0ChoDJ88PQbcPFT09KUvFH7ZhZ4SJ20U=; b=HJy+HGm8HxjsAAoLvpYdAKzJT+
	zfiQF6tDqDlWVWdYNYE6YthGatoa98LzxMFKSkfgzcxXuFNadaMtiMG7Mn9XtpbCx6t4pcIKLGgfP
	7BN5QgGCDj6c0XPqNLklNOi0oo6Keox0B2uvivfj5WeZcCpekHnLT5UVpJVsnRsSkAwYxUwi3R+16
	hHJQjR4saEl92DNWL/DBruC4sMXMzlXvzqXQvdpOlojjMF5wABSSdLoVr8mXT/9n1QPOb+arlrbH9
	axjOFna6oU0KeIJ3AopaG8AB1vg3w7viTlUxFV7i/aWVlBapknY1QdFXLFCsorfmODwqMGQLLSLip
	mfHOh09w==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNy9-00000004J78-2CXS;
	Mon, 12 Feb 2024 04:31:01 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Li Yang <leoyang.li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>,
	Guanhua Gao <guanhua.gao@nxp.com>,
	Roy Pledge <Roy.Pledge@nxp.com>
Subject: [PATCH v2 RESEND] soc: fsl: dpio: fix kernel-doc typos
Date: Sun, 11 Feb 2024 20:31:00 -0800
Message-ID: <20240212043100.28984-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling of 2 words.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Guanhua Gao <guanhua.gao@nxp.com>
Cc: Roy Pledge <Roy.Pledge@nxp.com>
---
v2:  update Cc: list, rebase

 include/soc/fsl/dpaa2-io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
--- a/include/soc/fsl/dpaa2-io.h
+++ b/include/soc/fsl/dpaa2-io.h
@@ -22,7 +22,7 @@ struct device;
  * DOC: DPIO Service
  *
  * The DPIO service provides APIs for users to interact with the datapath
- * by enqueueing and dequeing frame descriptors.
+ * by enqueueing and dequeueing frame descriptors.
  *
  * The following set of APIs can be used to enqueue and dequeue frames
  * as well as producing notification callbacks when data is available
@@ -33,7 +33,7 @@ struct device;
 
 /**
  * struct dpaa2_io_desc - The DPIO descriptor
- * @receives_notifications: Use notificaton mode. Non-zero if the DPIO
+ * @receives_notifications: Use notification mode. Non-zero if the DPIO
  *                  has a channel.
  * @has_8prio:      Set to non-zero for channel with 8 priority WQs.  Ignored
  *                  unless receives_notification is TRUE.

