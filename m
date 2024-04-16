Return-Path: <linux-kernel+bounces-146096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E168A60A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72A51F219FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4ECA7A;
	Tue, 16 Apr 2024 02:03:22 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93DAD31;
	Tue, 16 Apr 2024 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233001; cv=none; b=WjemxerPFk4brKMLja6mWwkM9lNQwdLHeeJl3oJWrr6lmAhechuP0R5DsaiAmR4OLLnUdyRQkw4zr+TE0+F7lEJY5scL34sC+4NyQR9GesLdY9I5BRKyv0p6Mhly0kqaAvEKfUqrAfDgxxBXIehO8O8E8/RWL0E0tycm75MNe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233001; c=relaxed/simple;
	bh=FARwHQbqqfl4C6eGcy0NTVNSv7RaH7jZ8al24DA2dcM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KAx0sK/uWvhaCkALVLabTZ7fOIeRRHaieKvKzvEoaziONPfj+PP+3nG4NF3HJvahim+gFRNPVCgqXDDL58eBcu6AUh+lH/H+3JoKVRidEZKGsZWq83sgbE3rS6A1M+PWiyHo/CHhinweEKeOThsyxCzGJBfXmgkKUFy7zDlALOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VJS1Z08c0z1ypGJ;
	Tue, 16 Apr 2024 10:00:50 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id CF3D91400D5;
	Tue, 16 Apr 2024 10:03:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 10:03:11 +0800
From: Devyn Liu <liudingyuan@huawei.com>
To: <f.fangjian@huawei.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <liudingyuan@huawei.com>,
	<liuyonglong@huawei.com>
Subject: [PATCH] spi: hisi-kunpeng: Delete the dump interface of data registers in debugfs
Date: Tue, 16 Apr 2024 09:58:39 +0800
Message-ID: <20240416015839.3323398-1-liudingyuan@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600002.china.huawei.com (7.193.23.29)

Due to the reading of FIFO during the dump of data registers in
debugfs, if SPI transmission is in progress, it will be affected
and may result in transmission failure. Therefore, the dump
interface of data registers in debugfs is removed.

Fixes: 2b2142f247eb ("spi: hisi-kunpeng: Add debugfs support")
Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 35ef5e8e2ffd..77e9738e42f6 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -151,8 +151,6 @@ static const struct debugfs_reg32 hisi_spi_regs[] = {
 	HISI_SPI_DBGFS_REG("ENR", HISI_SPI_ENR),
 	HISI_SPI_DBGFS_REG("FIFOC", HISI_SPI_FIFOC),
 	HISI_SPI_DBGFS_REG("IMR", HISI_SPI_IMR),
-	HISI_SPI_DBGFS_REG("DIN", HISI_SPI_DIN),
-	HISI_SPI_DBGFS_REG("DOUT", HISI_SPI_DOUT),
 	HISI_SPI_DBGFS_REG("SR", HISI_SPI_SR),
 	HISI_SPI_DBGFS_REG("RISR", HISI_SPI_RISR),
 	HISI_SPI_DBGFS_REG("ISR", HISI_SPI_ISR),
-- 
2.30.0


