Return-Path: <linux-kernel+bounces-56258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BC84C7FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC891287686
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BABD2C6A3;
	Wed,  7 Feb 2024 09:52:02 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127528DBC;
	Wed,  7 Feb 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299521; cv=none; b=cHjzoOguRCz54II57j804Fg2i0q38FBLAmp7TLsRBDXvP62QtRk5xoHjYjsyuXDtpl8yQsLHrxHGsFNC2ybNSDUlxWpLwEmOX+40y2v7N+qNF0QyhC08Gu1hj7gVc8kp3d7g+NBOggEk8T5ovOZmMUKDbTRqzaHo25uAIS0O3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299521; c=relaxed/simple;
	bh=XqdeSA/6t257zdspDNBGkqLK9I4Kn390CRGdDF1TMJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A0E3RxBn8THJcMODZ9yJYQjOMU9kPOJrzLWKB/e895MuFXlx9mS8yaR26Ss+8VrVhae3Yi66LDQnHR1qeYPasyhyMo0FIY2bRPyVoLGBdTqpk5N6UtM3ePPPIMm1ecIBcyZXXrvS9srRFMNac+aFDgLJrVZG52cu0ai/DSL7ahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TVFhg0wJpz29lTN;
	Wed,  7 Feb 2024 17:49:55 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id ACB021404F7;
	Wed,  7 Feb 2024 17:51:51 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 17:51:51 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH v2 0/3] crypto: hisilicon/qm - add stop function and obtain queue status
Date: Wed, 7 Feb 2024 17:50:58 +0800
Message-ID: <20240207095101.37280-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Patch #1 supports stopping function by sending mailbox to device,
device directly flush out function data.
Patch #2 supports users to obtain the queue stopping result by
querying the debug file.
Patch #3 changes function type.

Changed in v2:
 - Remove redundant check in patch#2.
 - The loop exit condition is modified to
prevent no log output when timeout.

Weili Qian (3):
  crypto: hisilicon/qm - add stop function by hardware
  crypto: hisilicon/qm - obtain stop queue status
  crypto: hisilicon/qm - change function type to void

 Documentation/ABI/testing/debugfs-hisi-hpre |  15 ++
 Documentation/ABI/testing/debugfs-hisi-sec  |  15 ++
 Documentation/ABI/testing/debugfs-hisi-zip  |  15 ++
 drivers/crypto/hisilicon/debugfs.c          |   5 +
 drivers/crypto/hisilicon/qm.c               | 184 +++++++++++++-------
 include/linux/hisi_acc_qm.h                 |  10 +-
 6 files changed, 183 insertions(+), 61 deletions(-)

-- 
2.33.0


