Return-Path: <linux-kernel+bounces-9877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EF781CCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86A41C225AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770524B4F;
	Fri, 22 Dec 2023 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+tN0BI7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941624B36
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703261963; x=1734797963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RGG6bCRy/lSswaUP7JRMA/o42Z9/bGzeEqAlWsjQ+Tc=;
  b=J+tN0BI7St/jIzD71fVW2vA9BlLQFDBOv4Y/70MZyLsqbn860KUy2k/d
   c4mWu9X58A/Jcvyy/WbeY8wrWXldb3CZsZTigXcdwK2JD95beFB0CLGbd
   lUHpUDLF/vRRxbo39WwMUFqR028zBLIE3XEwthNmzJzodF5CTsWGpXNU7
   TpFqPvk05yDseu6Yew2EsX77FOwbRCt38aJbaZxIy5i2DHUN1vwX7uVaT
   36z1wPpZ70K0+2bfYdEgF1zCVmZiV02UKdTmDq4dtqL+MwKLqyx6GAOpo
   6AShVufiXKbuH81fCA8U9n+7+OFBviJSUnqFA4/dwxOA1iaPjdElZlYsC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="399955053"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="399955053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 08:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="842978654"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="842978654"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Dec 2023 08:18:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8267D291; Fri, 22 Dec 2023 18:18:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 1/1] extcon: intel-mrfld: Don't shadow error from devm_extcon_dev_allocate()
Date: Fri, 22 Dec 2023 18:18:54 +0200
Message-ID: <20231222161854.2955859-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't shadow error from devm_extcon_dev_allocate() and return it as is.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-mrfld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
index 59cc3391bac7..2ee738f844ab 100644
--- a/drivers/extcon/extcon-intel-mrfld.c
+++ b/drivers/extcon/extcon-intel-mrfld.c
@@ -247,7 +247,7 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
 
 	data->edev = devm_extcon_dev_allocate(dev, mrfld_extcon_cable);
 	if (IS_ERR(data->edev))
-		return -ENOMEM;
+		return PTR_ERR(data->edev);
 
 	ret = devm_extcon_dev_register(dev, data->edev);
 	if (ret < 0) {
-- 
2.43.0.rc1.1.gbec44491f096


