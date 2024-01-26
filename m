Return-Path: <linux-kernel+bounces-39910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8E283D74F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F171C2D261
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479E1C29D;
	Fri, 26 Jan 2024 09:22:15 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32C1BF3E;
	Fri, 26 Jan 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260935; cv=none; b=A35zR7prgneunyZqrYFLPZIt/Ryiscj+1mdakc/pArb/PzFgCpNxSUS7ABCiLif/a9rIIlXdfxd72b+M/gUZ784PRaNeCRthEYYZWgmSvv6N8jYXhedtcK/qhuo2Af4WQfq2/iYRCe9mmeYXTY6iFnFF64GV2S9ZBxyVUrJJzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260935; c=relaxed/simple;
	bh=Lf3encN/F8/HuCIppMQ0kCZkOPYn0JSFA0SPxEOdeLA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PULD+ZE8PQjoymMkI2a2quNFekwprutzk/d6rppROzvvOBmqHQnOZeJEK2QTcjHPW9Ik94Lq4cEzf+PwFGX+ZEPUoIGhA3uKfJiYSn6ciTSXSW7xMp5hXDP3LItlXUmWZBoXMmx9YqSuOKqY/w6G1jfu3fYNnyyz3X+bPPKy0nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TLsc86slsz29kgF;
	Fri, 26 Jan 2024 17:20:24 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id ED1A8140416;
	Fri, 26 Jan 2024 17:22:10 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:22:10 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 0/4] some updates and cleanups for hisilicon/sec2.
Date: Fri, 26 Jan 2024 17:21:20 +0800
Message-ID: <20240126092124.14055-1-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500001.china.huawei.com (7.185.36.227)

This seires patch mainly add some RAS registers to enhance the 
DFX positioning function and fix some cleanup issues.

[PATCH v1 3/4] -> [PATCH v2 3/4]
	sec_sqe3->c_len_ivin |= cpu_to_le32(c_req->c_len);
-	sec_sqe3->tag = cpu_to_le64((unsigned long)(uintptr_t)req);
+	sec_sqe3->tag = cpu_to_le64((unsigned long)req);

Other patches are not modified.

Qi Tao (3):
  crypto: hisilicon/sec2 - updates the sec DFX function register
  crypto: hisilicon/sec2 - modify nested macro call
  crypto: hisilicon/sec2 - fix some cleanup issues

Wenkai Lin (1):
  crypto: hisilicon/sec - remove unused parameter

  drivers/crypto/hisilicon/sec2/sec_crypto.c | 33 ++++++++--------------
  drivers/crypto/hisilicon/sec2/sec_main.c   |  5 ++++
  2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.33.0


