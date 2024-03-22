Return-Path: <linux-kernel+bounces-110996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F968866CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A271C22FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A0C8FF;
	Fri, 22 Mar 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FOZvCIFx"
Received: from mail-m11885.qiye.163.com (mail-m11885.qiye.163.com [115.236.118.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497179D0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089300; cv=none; b=MUIN9qiEzlsbeP2dQHJEfCbCPXpV5BOeo1uswQKDouRLkD8C5BVPX8POjjH3j+J9LKZK5wMGRUhUws99CGpI4Rt+6D+fdnxMsHOC2ub57y9JfREUPa5RpPq9yHvovmENUy0+3mFPHcmjuELbEMPCms0hCJZbRucxYYzSazr5GSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089300; c=relaxed/simple;
	bh=i0+PV72/2dFaK31wvWPoX0d6bxJSY6XBCsINwakqKcM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UxLl80Ne2J0u+S39fYY8q1vPVmlqVvVK5otouM9sSV+mB+3RaUKObrGnoETLCG45T4n2HysfmAHY9nl+XxyCWsqfOoesxrY4Gjax5MC5g/d+2ataTQna2XNRhzPbtNrt6n4ws1GQ/if0SUoddhP8nTs5IJjMfrD4mExKF5cWGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FOZvCIFx; arc=none smtp.client-ip=115.236.118.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=FOZvCIFx+okQon3GjQmyCaG7uOsxXgdd1r8gVHPktpOMMg+n0Q9s7RrYOCXm9eJCcUyw8fWEBF/CEBADcgFPbntFYkLIhY8MHPxUZVTfwEUW3CdAPxKMdXsKZn1dj4CLz9oME+p2PADGgEAOTDO0AeIMwBKjHnMn8r6rUTuNL5k=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ktnsnF64wj/H5bwoeAclYjmtYjAzqxy2pnWppwBZrP8=;
	h=date:mime-version:subject:message-id:from;
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 916477E067C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:45:31 +0800 (CST)
From: Ye Zhang <ye.zhang@rock-chips.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] thermal: devfreq_cooling: Fix perf state when calculate dfc res_util
Date: Fri, 22 Mar 2024 09:45:31 +0800
Message-Id: <20240322014531.1840999-1-ye.zhang@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4fSVZNHUtOGk0fSUpKGRlVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkhNTkJMVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8e63d5acfc09cfkunm916477e067c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6Mxw*SzMOTxRRNjoSNwgQ
	NRMwCRFVSlVKTEpKS0xKQkhJSkhMVTMWGhIXVQIeVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSkNDSzcG

The issue occurs when the devfreq cooling device uses the EM power model
and the get_real_power() callback is provided by the driver.

The EM power table is sorted ascending，can't index the table by cooling
device state，so convert cooling state to performance state by
dfc->max_state - dfc->capped_state.

Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
---
v1 -> v2:
  - Update the commit message.

 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 50dec24e967a..8fd7cf1932cd 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -214,7 +214,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 
 		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
 		if (!res) {
-			state = dfc->capped_state;
+			state = dfc->max_state - dfc->capped_state;
 
 			/* Convert EM power into milli-Watts first */
 			rcu_read_lock();
-- 
2.34.1


