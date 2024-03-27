Return-Path: <linux-kernel+bounces-121760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1569488ED4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B292A5145
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25870152DF5;
	Wed, 27 Mar 2024 17:49:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E784152DE4;
	Wed, 27 Mar 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561768; cv=none; b=EsWZr0oBl4eQbAlf3/riktkYxKaCt6Pm3gfdSzpJ6kps93qa5/fhpNzUXiruR7tXDBBNCmmXmqTf2eWnpEE++s/iLHVfefyF1zyZsmYTpkrLjyWNY0v/qI2isNXw+0Tr1QuyLV4sfl9invvJV0rAFkfdZP1Jp+IL09L3rndnCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561768; c=relaxed/simple;
	bh=ARoI+Hvl2jvervVRsM90CfObpfJ60BuI2SBkqNTIg5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fof7a+YeB4MmPS7hlAMi8EoI43PoQGC21MNqIftPGF/LOPNel90nG+Qermh0kGgdPtwPjfJxS4GzZKETWrQ7Ml5QyFhX0hm+47wlU6yTXMIf5E3ALjIa4FHkLRKqTa4rbma/TRsgHTZL8dk1LHHZf8ulbTxFMwuZaz7NKG007dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CFFC433F1;
	Wed, 27 Mar 2024 17:49:25 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] scsi: csiostor: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:49:20 +0100
Message-Id: <20240327174921.519830-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI core in pci_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/csiostor/csio_init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csio_init.c
index d649b7a2a879..9a3f2ed050bd 100644
--- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -1185,9 +1185,6 @@ static struct pci_error_handlers csio_err_handler = {
 
 static struct pci_driver csio_pci_driver = {
 	.name		= KBUILD_MODNAME,
-	.driver		= {
-		.owner	= THIS_MODULE,
-	},
 	.id_table	= csio_pci_tbl,
 	.probe		= csio_probe_one,
 	.remove		= csio_remove_one,
-- 
2.34.1


