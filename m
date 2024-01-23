Return-Path: <linux-kernel+bounces-35073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B704A838B84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17EFBB210DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC45A780;
	Tue, 23 Jan 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INQkBDVk"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1F5A110
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005002; cv=none; b=JtqNc+j0WIP29YtUT9BWL121+Cv4uKAjNawdKa+i9rGFBLF+XXz0L4J+gOjHtjpzsWaC81pXH8pPRwtBtbn8JJBcYTKO1p+9Az5wj/2PLCFGCKmIc5I/GZcyjsyMN3rBv66aGPbSR9WuOuZN1qLNcRQ67xNtznnJd3a3nZR6npE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005002; c=relaxed/simple;
	bh=lIRmt8mPE9r83SAhg8C8ZQT8Qke7OTanSFB0FbO1ZOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+Yz8Is0jgADgJvYJU6QcrXeG0LakrpcISbtZf1jEkZuDvjqHetdeW6zgznGOPxfR5HgFBUyQvdQkwMHlwDAsU9tJoaDH36Xqpwv9gDQ+rYzVcgyYkOMUYLKPcq70tqhJaTkPW7qnBjbBaVym4t2rts2ApLbnJmE40jtieHvsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INQkBDVk; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706005000; x=1737541000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lIRmt8mPE9r83SAhg8C8ZQT8Qke7OTanSFB0FbO1ZOM=;
  b=INQkBDVkDbaNR9lpDGxlvbQLAP2DPUCnIObU+BqJWTcwB8oe5/UH1oQt
   HhToVzQOKEl3JlDd7g5FOe9+D1lu00uwvYu7EjlHio+f80wR7gSJYdLA6
   V4aW+sQe95GKCl3jzw1NTBRjN5nYZm2XuIgV8L8TPHyWCt7oeeR7cj0uP
   vHjmrNHOyo1IlSTMclFzTQQ/c+jlP/vt4K1E28WfLhrp2eRRdTLg6AgjF
   kP/nXJae+UFIrcT1T4ID1QMPT3qvuFerW50hml0GCddVqmlQsTGoStgeb
   EJSzk1U+alMUI3ZgMyjAxeILMHeZ2cKjLStwXysB9vXn8GpzamOPhT94x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="391900155"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="391900155"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1549598"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:16:37 -0800
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Vitaly Lubart <vitaly.lubart@intel.com>,
	linux-kernel@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/5] mei: gsc: add support for auxiliary device created by Xe driver
Date: Tue, 23 Jan 2024 12:16:21 +0200
Message-ID: <20240123101625.220365-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lubart <vitaly.lubart@intel.com>

Add support for gsc mei auxiliary device created by Xe driver

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/gsc-me.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index 6be8f1cc052c13be3607432f..9e558ec2ea1d5cef1aee7fb3 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -292,6 +292,10 @@ static const struct auxiliary_device_id mei_gsc_id_table[] = {
 		.name = "i915.mei-gscfi",
 		.driver_data = MEI_ME_GSCFI_CFG,
 	},
+	{
+		.name = "xe.mei-gscfi",
+		.driver_data = MEI_ME_GSCFI_CFG,
+	},
 	{
 		/* sentinel */
 	}
@@ -312,5 +316,6 @@ module_auxiliary_driver(mei_gsc_driver);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_ALIAS("auxiliary:i915.mei-gsc");
 MODULE_ALIAS("auxiliary:i915.mei-gscfi");
+MODULE_ALIAS("auxiliary:xe.mei-gscfi");
 MODULE_DESCRIPTION("Intel(R) Graphics System Controller");
 MODULE_LICENSE("GPL");
-- 
2.43.0


