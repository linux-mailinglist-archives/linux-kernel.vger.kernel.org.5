Return-Path: <linux-kernel+bounces-154387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E68ADB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B505C1F21D74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E564D134D1;
	Tue, 23 Apr 2024 01:24:04 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF412B93;
	Tue, 23 Apr 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835444; cv=none; b=doZoIv86kUrvWtGmbl4FTuXY57yyjtAndbSgjPWfsc5aRDWtVMEC5SDFsi3wPc2vQ4ahVo16AcIIRyhdXEnaukA0yaLGMvs8Fk1cM6fHgjs/eyZKj4jeS6aRuFXwTe/W5ucFX+C1wGra3CzWkSl+2l0ejIo5u/vBAoGb2fE3rpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835444; c=relaxed/simple;
	bh=EuaU35KfwN9Z7OMbZwNvGMdvR4+I5EILignv0Y/hgtY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SGMOXCNnItbTkZ4rJ5NK9HGnUs8ph/qUFzWfkD7HZmGWt2sMJ5BYQb1I5yFK8gi/oWeaA/IIoPeLhZjy1aejiyzljYraReECxNwviSvrBNao2MXzpnIUbxKLNi3qEn6IPzNNaEQ+kov3nls0Bitz/1zAZh/A7+tz+yNiJDIO2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VNkpw0xP5zNt10;
	Tue, 23 Apr 2024 09:21:28 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 0223218007D;
	Tue, 23 Apr 2024 09:23:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 09:23:57 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 0/2] crypto: hisilicon - fix reg offset issue and cleanup dump information
Date: Tue, 23 Apr 2024 09:19:20 +0800
Message-ID: <20240423011922.770693-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500025.china.huawei.com (7.221.188.170)

Fix for register offset and cleanup dump information of debugfs.

Chenghai Huang (1):
  crypto: hisilicon/debugfs - mask the unnecessary info from the dump

Wenkai Lin (1):
  crypto: hisilicon/sec2 - fix for register offset

 drivers/crypto/hisilicon/debugfs.c        | 29 +++++++++++++++--------
 drivers/crypto/hisilicon/hpre/hpre_main.c |  2 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  |  6 ++---
 3 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.30.0


