Return-Path: <linux-kernel+bounces-98571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBC877C27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C992282317
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E8B13FFA;
	Mon, 11 Mar 2024 09:00:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047121115;
	Mon, 11 Mar 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147612; cv=none; b=X2H/1isEs/TuUf87jxINBjQEeEjbWZBwTA6blPT4GyQr8rJ3a3NcXwRAhEE1O6YxgLIWElb6D0ptXHIkC+rpXSJAaba1XIJynk3R0JbA/9gLMz4h8MjVluDQ4oqOVvjtbYUyYj4yGU/GKInmfBdG+BemDeiHuh+RJlZ4ukEufyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147612; c=relaxed/simple;
	bh=4T3LYMO4O+4sggHhLctCPj7vVLuqjXwtjA0tn25Lb6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VRBYLfVDt9jYhNa9eYCjELSAzCuvcw3tZvzI2zVA78TjDakKxmTR7Mq3ZGgyJZa/iw58J36LbICg+WjBbDjfrh1pAmSir9DN25h0Uf5sDPIxmKSx1WfW6PngzacjgcCSZ1mZt7a6cWsUAMbs5eqbIiHK31DFXDQ1s5yZbkcUloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c58ebdbc4ee4beeb079192331949678-20240311
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:64f28ce8-837a-4ed9-a4b9-142e4af9a9bf,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.37,REQID:64f28ce8-837a-4ed9-a4b9-142e4af9a9bf,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:19a7db84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240311165439VOSJMZSU,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5c58ebdbc4ee4beeb079192331949678-20240311
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
	with ESMTP id 1931794865; Mon, 11 Mar 2024 16:54:36 +0800
From: mengfanhui <mengfanhui@kylinos.cn>
To: kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com,
	shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mengfanhui@kylinos.cn
Subject: [PATCH] scsi: megaraid_sas: disabled shared host tagset feature by default
Date: Mon, 11 Mar 2024 16:54:12 +0800
Message-Id: <20240311085412.2391632-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By default, the host_tagset_enable feature is disabled，Fio performance
has improved significantly

fio test command:
sudo fio -filename=/fio_test -direct=1 -iodepth 32 -thread -rw=write -ioengine=libaio
-bs=4K -size=5120M -runtime=600 -numjobs=$CPUN -group_reporting -name=**.result >> **.result

The test data results bw  are as follows：
              v6.8_kernel       v6.8_kernel_disable_host_tagset
4k randwrite     375                     642
4k randread      210                     784
4k  write        306                     387
4k  read         435                     2457
128k write       355                     380
128k read        976                     3665
1M   read        415                     3122

Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..da19c4c07f2f 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -123,9 +123,9 @@ MODULE_PARM_DESC(poll_queues, "Number of queues to be use for io_uring poll mode
 		"High iops queues are not allocated &\n\t\t"
 		);
 
-int host_tagset_enable = 1;
+int host_tagset_enable;
 module_param(host_tagset_enable, int, 0444);
-MODULE_PARM_DESC(host_tagset_enable, "Shared host tagset enable/disable Default: enable(1)");
+MODULE_PARM_DESC(host_tagset_enable, "Shared host tagset enable/disable Default: disable(0)");
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION(MEGASAS_VERSION);
-- 
2.25.1


