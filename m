Return-Path: <linux-kernel+bounces-102236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC9487AFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C69C1F26142
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EF178B7E;
	Wed, 13 Mar 2024 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iSCb07LG"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA7612FA;
	Wed, 13 Mar 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349860; cv=none; b=dOZOljDTjBYkqWI263X9aLXd9z7pHkAEJz4d0a0MxEOcswnarE9bXCFphmxbTy7SX0P0Pg/F8SEGytd+6KnG9lvW/ys9uuWdck096K41AkGO8SVgmEC1LxD1NEZfeYo+VvxVO716jvEeNu+8fgivYeuJGl+JrjBYQM52gK6dEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349860; c=relaxed/simple;
	bh=v9J5M0W2tLkV8syDeypzxodY6J+nLAS8w+wUGy2Y7Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DL1AOwZFbI5gfbeYmmfvyeeXGRbuChSraVtbLI7EXV7DPERQwpR3tJNNcGHvQcPslY13gTRVtD6WbU4GpXIO0rI1Z4Gn1stf+wSUsHjisIrOcWFb+x7t5/R1E7l+zEJLe51RwYcIkBgH5GlQU61aA7kbSqh6aVg62TdhjUTG+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iSCb07LG; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7297EC0000ED;
	Wed, 13 Mar 2024 10:10:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7297EC0000ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1710349851;
	bh=v9J5M0W2tLkV8syDeypzxodY6J+nLAS8w+wUGy2Y7Ck=;
	h=From:To:Cc:Subject:Date:From;
	b=iSCb07LGlbqLfOXevc7iv/vZ8zWS+2ab+I8clJgGymo0rlTeoyVMQ03SxeK0APSMA
	 c/S/Cs3pVAZaf+WOFP+02N8qweXEu/F9Cle7KKNK0zAPmLPZhdtp3UV8tG4XDxfzFq
	 J5r+161pmpESN2LTcye5kW6b4FyubIZoy6zvoMww=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 9C13218041CAC4;
	Wed, 13 Mar 2024 10:10:49 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-spi@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Michael Walle <michael@walle.cc>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: Fix error code checking in spi_mem_exec_op()
Date: Wed, 13 Mar 2024 10:10:49 -0700
Message-Id: <20240313171050.3505620-1-florian.fainelli@broadcom.com>
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
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Change-Id: I4159811f6c582c4de2143382473d2000b8755872
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 2dc8ceb85374..10b5fa003693 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -339,7 +339,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
+		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP))
 			return ret;
 	}
 
-- 
2.34.1


