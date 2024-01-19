Return-Path: <linux-kernel+bounces-30685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348B832306
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8B61F2177C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A215A4;
	Fri, 19 Jan 2024 01:36:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA66EC7;
	Fri, 19 Jan 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628180; cv=none; b=pMmxCD3VupRCAkMNrdXYq/suZuyIP4nbfRRLtxmzYZB0gyXsqVUu+/2A0h/k2p6jJJPpLMOe0tkP7E7UEHz2gH0cLPLDBCVkSAAn36+x6y4faOCF806Vm6PUNY+8Kfqz775NSMv4dI8ckSVZEVHnByZsnYejWr3wfjlxovtI3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628180; c=relaxed/simple;
	bh=FuC0kEmZfBf7U/MDt0gJdriiIyRBZ51V3J/u2QRfekI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n46JAHCFAF33CnSdqXUC2HLJs395QS/c2kpzZWvGEbzTr+BHI+0YGt4RRCyzoNzQ8mBdWPZQWs1m3m50aqPQEph161Q1SXyO/+bQhVjp0XqOR8ngF++3HTEM5azSGsjqtzgyXVqlGZFrlwd8suJ2qJEwKtcBSaRI6kZz43NQtOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TGMdQ2DZ5zGpnJ;
	Fri, 19 Jan 2024 09:35:54 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id DDBDD18005B;
	Fri, 19 Jan 2024 09:36:14 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 09:36:14 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH 0/3] support '%pd' and '%pD' for print file name
Date: Fri, 19 Jan 2024 09:38:45 +0800
Message-ID: <20240119013848.3111364-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)

During fault locating, the file name needs to be printed based on the
dentry/file address. The offset needs to be calculated each time, which
is troublesome. Similar to printk, kprobe supports printing file names
for dentry/file addresses.

Ye Bin (3):
  tracing/probes: support '%pd' type for print struct dentry's name
  tracing/probes: support '%pD' type for print struct file's name
  Documentation: tracing: add new type 'pd' and 'pD' for kprobe

 Documentation/trace/kprobetrace.rst |  3 +-
 kernel/trace/trace_probe.c          | 50 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.31.1


