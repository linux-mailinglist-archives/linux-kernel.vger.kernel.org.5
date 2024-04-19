Return-Path: <linux-kernel+bounces-151146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 541008AA9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E011DB22046
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ADC4D59F;
	Fri, 19 Apr 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jxHJaZzW"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C8321D;
	Fri, 19 Apr 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513972; cv=none; b=lOXJUlBp7EbuuPCHa3F4Er0SjgLoORYQ2XK7+ygCDUURSvob6VN003ElrybOSJNVu1Tm5GN7a71cBiNu1qUyzkL+5DcVirG1tfYvA2b7dB0thbzlLDR5o3MmFwGtnAtjOyuJyEdwel+cMORTkodIfqWGm5WT9OyrqZRa7KSr6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513972; c=relaxed/simple;
	bh=VRorQ8SHhWit+mZr7S2o3kkAkzG3qTTdyzmayMCRpZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VhZsjvH/T6GJ1ohYBGPc+Tq2gqS9KflI3/cyjB5CZsCA3QW/6vbnPqiXqog9ihwjSr1PvK9ubz50D92dQiB+L6ja+KOzGGmsgngxXgajGzLAAIu+effjdwLftoA0SDsPZiqpamoRBpPPNBAbDXLjeN0LlA1uJsZCk+pnywca81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jxHJaZzW; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43J85q4U061750;
	Fri, 19 Apr 2024 03:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713513952;
	bh=wywIflZZILgds45tSLlMBSxHlOVP+lLAO8bVR1MGrzw=;
	h=From:To:CC:Subject:Date;
	b=jxHJaZzWqDbn4u4dyNkSDtPScNKU/HiEe56NDPzGB65+OKPOpCQQHYuB4wmUiyY9S
	 0OXEncyjGJ2GuM/fgTwlWDKwsvQY0IN67Bp5vB4EiYwarVMz6xjZ58JIRaqxY+U8j6
	 Ta5GkbeEiVIAzmwpda3NFNcmbmOwSp4glILmvk/E=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43J85qIi107255
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 03:05:52 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 03:05:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 03:05:51 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43J85lCd123132;
	Fri, 19 Apr 2024 03:05:48 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <s-vadapalli@ti.com>, <rogerq@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>, <jreeder@ti.com>,
        <r-gunasekaran@ti.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>
Subject: [PATCH net] net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets
Date: Fri, 19 Apr 2024 13:35:47 +0530
Message-ID: <20240419080547.10682-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Jason Reeder <jreeder@ti.com>

The CPTS, by design, captures the messageType (Sync, Delay_Req, etc.)
field from the second nibble of the PTP header which is defined in the
PTPv2 (1588-2008) specification. In the PTPv1 (1588-2002) specification
the first two bytes of the PTP header are defined as the versionType
which is always 0x0001. This means that any PTPv1 packets that are
tagged for TX timestamping by the CPTS will have their messageType set
to 0x0 which corresponds to a Sync message type. This causes issues
when a PTPv1 stack is expecting a Delay_Req (messageType: 0x1)
timestamp that never appears.

Fix this by checking if the ptp_class of the timestamped TX packet is
PTP_CLASS_V1 and then matching the PTP sequence ID to the stored
sequence ID in the skb->cb data structure. If the sequence IDs match
and the packet is of type PTPv1 then there is a chance that the
messageType has been incorrectly stored by the CPTS so overwrite the
messageType stored by the CPTS with the messageType from the skb->cb
data structure. This allows the PTPv1 stack to receive TX timestamps
for Delay_Req packets which are necessary to lock onto a PTP Leader.

Signed-off-by: Jason Reeder <jreeder@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 drivers/net/ethernet/ti/am65-cpts.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index c66618d91c28..f89716b1cfb6 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -784,6 +784,11 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 		struct am65_cpts_skb_cb_data *skb_cb =
 					(struct am65_cpts_skb_cb_data *)skb->cb;
 
+		if ((ptp_classify_raw(skb) & PTP_CLASS_V1) &&
+		    ((mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK) ==
+		     (skb_cb->skb_mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK)))
+			mtype_seqid = skb_cb->skb_mtype_seqid;
+
 		if (mtype_seqid == skb_cb->skb_mtype_seqid) {
 			u64 ns = event->timestamp;
 

base-commit: a35e92ef04c07bd473404b9b73d489aea19a60a8
-- 
2.17.1


