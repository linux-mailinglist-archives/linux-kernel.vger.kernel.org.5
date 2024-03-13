Return-Path: <linux-kernel+bounces-102457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5287B260
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8221C21AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310154C630;
	Wed, 13 Mar 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="tUta5kxe"
Received: from relay.smtp-ext1.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C54C60C;
	Wed, 13 Mar 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359806; cv=none; b=X1P9VhLca9MbnG9FFY/ORwEZCjDo45lfPtWWvShbq830FqmSIlo/BwTI2acqMZShzYjpOzeCV32Io14Blveg7NYhR554/e4vt4EShRAJWFVn71YDt2HST78szUFJdGtEF2MRThUvk4MtEiP116bLW5LVEKvtcxL5hLxpqYBiOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359806; c=relaxed/simple;
	bh=3BD4gGhAqghzw6gpQVHVO4yadhEZRKKYCsiViAsbDhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3vKyZuAjoEgrbf5okDH+g5Cr9ACQwBNbctJ4tL1D12K2Xw9CdsjE4dFQNDKpzIpFdvQnNzU4vvWaK4oSQEhMqnb3Haua+/5EY78b5EYGXnGaH7EOGHCUUQ0c7zzEhK1I12MB/GRMwNT1jXQdDjWoDqgSXW1M/okrb8fyQUKY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=tUta5kxe; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext1.broadcom.com (Postfix) with ESMTP id C325CC0029DF;
	Wed, 13 Mar 2024 12:46:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext1.broadcom.com C325CC0029DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1710359211;
	bh=3BD4gGhAqghzw6gpQVHVO4yadhEZRKKYCsiViAsbDhM=;
	h=From:To:Cc:Subject:Date:From;
	b=tUta5kxe1gtE33JzJgGyTd5oeSmmxvUFDJwjpG12tNxx+xEM433oOsW88mKXz/bGq
	 s8Ehaqk8Ijf3J4guH05GXDrZgV2bCWgDDTqU0P87YRyI16jJoKEoPVwGQdm7w9IVSz
	 PMvjprG9LlKjJX7IbSjVInpl2qmeeRsfkGfzDZXQ=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2521C18041CAC4;
	Wed, 13 Mar 2024 12:46:50 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-spi@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Michael Walle <mwalle@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Michael Walle <michael@walle.cc>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] spi: Fix error code checking in spi_mem_exec_op()
Date: Wed, 13 Mar 2024 12:45:30 -0700
Message-Id: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with
-EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
visible in the kernel log:

[    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
[    2.210295] spi-nor: probe of spi1.0 failed with error -95

It turns out that the check in spi_mem_exec_op() was changed to check
for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), but this
means that for drivers that were converted, the second condition is now
true, and we stop falling through like we used to. Fix the error to
check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.

Fixes: cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP")
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- collected R-by tags from Michael and Pratyush
- rebased against spi/for-next

 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c9d6d42a88f5..17b8baf749e6 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -382,7 +382,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
+		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP)) {
 			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
 			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
 
-- 
2.34.1


