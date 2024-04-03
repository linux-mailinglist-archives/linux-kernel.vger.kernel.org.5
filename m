Return-Path: <linux-kernel+bounces-129494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61CB896BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFFAB26E36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABAA13C699;
	Wed,  3 Apr 2024 10:05:34 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B53813667E;
	Wed,  3 Apr 2024 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138734; cv=none; b=mIOvgpJ7TliKHPI5CNS2uNiFy2hIHU+0/P6L8cs1aQdmxnSw2mqAdB4NQoZ3JbWfjyt+DK29cFr3cUeXZh89HX6x253zK5Q7Kqf+wxV/T3iA/q5IcCXqu8XJ7MJu5VpX6hCPy9vmqAI4/yYpIv1w+eJCnxiVMu+/R9mum7wQZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138734; c=relaxed/simple;
	bh=HZo0thGmj6mJMS1JWhLGkXZQKJN+evPNoOi+wj58PKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SiKYP7zbItwQZlcrsdF64pJ/LrAA9UjEzp2RvdXerlaaxjk9cNDD7r8XSL+Zg40NAWNNvgDCltuC9uzZMGCi7iANmECu4c/BlPWpzwYWM9v7ChpeTFvFE3rFgO6tEITq3ffuW84AH1L/lqC0NZFXHfk1Fjwi90cohHeP88rzFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V8gKY4mxTz29lcD;
	Wed,  3 Apr 2024 18:02:41 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 6175D140158;
	Wed,  3 Apr 2024 18:05:27 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 18:05:27 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 0/9] crypto: hisilicon - Optimize and fix some driver processes
Date: Wed, 3 Apr 2024 18:00:53 +0800
Message-ID: <20240403100102.2735306-1-huangchenghai2@huawei.com>
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
 dggpemd200003.china.huawei.com (7.185.36.122)

This patch series is mainly used to fix and optimize some
problems of hisilicon.

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
  crypto: hisilicon/debugfs - Add the err memory release process to qm
    uninit

 drivers/crypto/hisilicon/debugfs.c         | 36 +++++++++++++++-------
 drivers/crypto/hisilicon/hpre/hpre_main.c  | 21 ++++++-------
 drivers/crypto/hisilicon/qm.c              |  8 ++---
 drivers/crypto/hisilicon/sec2/sec_crypto.c |  4 ++-
 drivers/crypto/hisilicon/sec2/sec_main.c   | 26 ++++++++--------
 drivers/crypto/hisilicon/sgl.c             |  5 +--
 drivers/crypto/hisilicon/zip/zip_main.c    | 24 +++++++--------
 7 files changed, 67 insertions(+), 57 deletions(-)

-- 
2.30.0


