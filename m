Return-Path: <linux-kernel+bounces-134234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8EA89AF59
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FBA1F21D95
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429712B7D;
	Sun,  7 Apr 2024 08:04:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC31748F;
	Sun,  7 Apr 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477074; cv=none; b=tGnBtNP4uMA3TTrea/Pq9DvOTBWUSqikkabQx2hmbmkm6Ra0x2PDJNoGO+WKPEpwILmdjJHP2kpQlqB+RWjs4LEbGnfu4HoEWdmbwByS01icTVggU+1z15tw67WUUHTC8yNWUQuzqXbR+OcJ+C0XUiBFD6hXoJScM+HSq6p2+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477074; c=relaxed/simple;
	bh=WuVmlcXEI6ienjeI1ef3w79EoIsbGXDctKG2kz3xZZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/7lUGIH6R7WzcOUwS7RtIchw3VTI326/aAPiOMP1+ywoHtBU5rQoICd5BhGu7E3w6Dj5WB8sXYzo//3gxRkWPIuIxnwQAHOL2Ql0BsFu8vL7Gq8Jx95t0HW61d25FzVRCUw+l2/73MdGh5mCv5Tw2gEnTfO3QpB7trVPc8x4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VC4SF35Blz1QCVb;
	Sun,  7 Apr 2024 16:01:49 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id A25E21402C7;
	Sun,  7 Apr 2024 16:04:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 16:04:27 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH v2 0/9] crypto: hisilicon - Optimize and fix some driver processes
Date: Sun, 7 Apr 2024 15:59:51 +0800
Message-ID: <20240407080000.673435-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500025.china.huawei.com (7.221.188.170)

This patch series is mainly used to fix and optimize some
problems of hisilicon.

v1 -> v2
- fixed codecheck warnings about unused variable
  | Reported-by: kernel test robot <lkp@intel.com>
  | Closes: https://lore.kernel.org/oe-kbuild-all/202404040616.cF0Pvb9M-lkp@intel.com/

Chenghai Huang (9):
  crypto: hisilicon/sec - Add the condition for configuring the sriov
    function
  crypto: hisilicon/debugfs - Fix debugfs uninit process issue
  crypto: hisilicon/sgl - Delete redundant parameter verification
  crypto: hisilicon/debugfs - Fix the processing logic issue in the
    debugfs creation
  crypto: hisilicon/qm - Add the default processing branch
  crypto: hisilicon - Adjust debugfs creation and release order
  crypto: hisilicon/sec - Fix memory leak for sec resource release
  crypto: hisilicon/debugfs - Resolve the problem of applying for
    redundant space in sq dump
  crypto: hisilicon/qm - Add the err memory release process to qm uninit

 drivers/crypto/hisilicon/debugfs.c         | 38 +++++++++++++++-------
 drivers/crypto/hisilicon/hpre/hpre_main.c  | 21 ++++++------
 drivers/crypto/hisilicon/qm.c              |  8 ++---
 drivers/crypto/hisilicon/sec2/sec_crypto.c |  4 ++-
 drivers/crypto/hisilicon/sec2/sec_main.c   | 26 +++++++--------
 drivers/crypto/hisilicon/sgl.c             |  5 +--
 drivers/crypto/hisilicon/zip/zip_main.c    | 24 +++++++-------
 7 files changed, 68 insertions(+), 58 deletions(-)

-- 
2.30.0


