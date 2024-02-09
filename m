Return-Path: <linux-kernel+bounces-59151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C189384F22A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE32861D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D3C679ED;
	Fri,  9 Feb 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oTF1xsyb"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B1664DE;
	Fri,  9 Feb 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470331; cv=none; b=VaUHkkQlERRUNl+f1SBN4sXviitbrlhUw4d2lIqpz9LOyVCmqYUdsjEpxA1FhXSxvEifcVY33PsBIPpMQe4C9KhGMHF4tPJ/cnpOyBElqujSp5Ce4q5g0eRD5uonN5Nq2ix0m+gCvP9Ftt/puRSuTFjeV2vCeq/CtbZlZVUPqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470331; c=relaxed/simple;
	bh=o8WTKGtgzdcRV2Jd2WquBihArE4w4ZkF4hZvS73clBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pSgPQeCVR0Y90JHhjxGpX9vMv3JD6j0tJ52NfkqmdGVu/EUSijcCxl6fb7qje0lNgbr+RaVGJosUM5K1SEnSfNbEvDs66DX4iN8CjrQ7RZlR7T6fS0tMZsQ7egTCG457ksZ2+g/eMZUjKIgSpKuZ9gk0z2up6cRtSZZ8c8qpYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oTF1xsyb; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1fYYR
	FcHkrovkS6o/dnOwQFLyvfstYRX8I/lzb+zlVQ=; b=oTF1xsybC5+tdrzRoBY0+
	1qlXLhC8BNPKXWyAWOAxohnj/fiNAlHsRSiruYh6/N05+it2h83eas3jZz/G5J6z
	3O6T7Zk+5hyYpxdRmheTxIqGXnAvY8CIJOzoNp12L6WogR9KUV3iURtzW6gHIB/e
	0ckRpCtMrtYk8vrUi+PEbQ=
Received: from localhost.localdomain (unknown [111.202.47.2])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wCnTPCv7cVlH43VDA--.32656S2;
	Fri, 09 Feb 2024 17:17:36 +0800 (CST)
From: Keqi Wang <wangkeqi_chris@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Keqi Wang <wangkeqi_chris@163.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] connector/cn_proc: revert "connector: Fix proc_event_num_listeners count not cleared"
Date: Fri,  9 Feb 2024 17:16:59 +0800
Message-Id: <20240209091659.68723-1-wangkeqi_chris@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnTPCv7cVlH43VDA--.32656S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur13Ar15Ar4UKry8CryDWrg_yoW8Gw4DpF
	ZrZFy5AFW8t3WfXws8A3ZrZFy5Xas5Xr1UuFWIkw1kZF45WrWkJa1rtFZIgF9xAr1kKr1j
	qa17JFZxZFWDZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEv38UUUUUU=
X-CM-SenderInfo: 5zdqwy5htlsupkul2qqrwthudrp/1tbiQBJ-3GVOBbgGJAAAsF

This reverts commit c46bfba1337d ("connector: Fix proc_event_num_listeners
count not cleared").

It is not accurate to reset proc_event_num_listeners according to
cn_netlink_send_mult() return value -ESRCH.

In the case of stress-ng netlink-proc, -ESRCH will always be returned,
because netlink_broadcast_filtered will return -ESRCH,
which may cause stress-ng netlink-proc performance degradation.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401112259.b23a1567-oliver.sang@intel.com
Fixes: c46bfba1337d ("connector: Fix proc_event_num_listeners count not cleared")
Signed-off-by: Keqi Wang <wangkeqi_chris@163.com>
---
 drivers/connector/cn_proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 3d5e6d705fc6..44b19e696176 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -108,9 +108,8 @@ static inline void send_msg(struct cn_msg *msg)
 		filter_data[1] = 0;
 	}
 
-	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, (void *)filter_data) == -ESRCH)
-		atomic_set(&proc_event_num_listeners, 0);
+	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+			     cn_filter, (void *)filter_data);
 
 	local_unlock(&local_event.lock);
 }
-- 
2.27.0


