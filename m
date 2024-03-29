Return-Path: <linux-kernel+bounces-125027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52CD891EED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906DC28C014
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352051BC14E;
	Fri, 29 Mar 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5WOCn4c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B301BC13E;
	Fri, 29 Mar 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716663; cv=none; b=eHw5rlj/K1b6U8iR95iWU4ReBGyLWffUFKVk41BovZYCEgNKmywQIgAsV1dlcIzdxXvbO8BNEsZ6+o2dJ6k+md2Bujk4WHc9McZhKF7TDQUjtoo1fUqTus6Xc6lzAuF2OrwMEnTrCJUa4eF5hY0jcYabO9y7sGQnijDta52LPoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716663; c=relaxed/simple;
	bh=eDX8oDgda9OYKH8SbjNNZLEdT2O+EKxz+JxtXv63BIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNaiFsiAPzC+4M6eXeQGGgne5+TzWA4HDkxfjliY5FltP0E7z1STH4amDd+PDgAoeM8mAHcBOcit+Ws+dWFXMQ2/IwdKk28MK494Dei2m3ZEjl35rWAcv42d7x8XuBeoKWdrcG1MjhUfc0NHnEDHMat/vn11KXcfPMHLHD6lS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5WOCn4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129DEC433F1;
	Fri, 29 Mar 2024 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716663;
	bh=eDX8oDgda9OYKH8SbjNNZLEdT2O+EKxz+JxtXv63BIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5WOCn4ciGCEVEOomH0CbNFW3nA1JZa8VAmkHGZ4d3pjihP5CIi+ZdTiEDlQL41De
	 w4i2ULMItVQRuGNp75D3r08t8aNWRE8fe+sZdQGoNAGcncPQHQrUJevNA5hdhn1fIi
	 hiftkF5RxlAO8mLdhnGKbR3/LYJeT82ksaudnLGd8oPmju+ib0ZFmhzckePoVbv+R3
	 YIAkMoGkkMsqV9mjf5TMqlhRWsTfUPopmZbeXrVk27OoeEu7z/m4fq2ArZ57GPAmdc
	 gUjC+g90zyj95uVQ7DGFPxLQwyOK+U1fnTdF0cXisDZZ6rl1isUUv7s1y3XINY7207
	 oF/YU9reEbGhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	bryantan@vmware.com,
	vdasa@vmware.com,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 4.19 02/19] VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()
Date: Fri, 29 Mar 2024 08:50:34 -0400
Message-ID: <20240329125100.3094358-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125100.3094358-1-sashal@kernel.org>
References: <20240329125100.3094358-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 19b070fefd0d024af3daa7329cbc0d00de5302ec ]

Syzkaller hit 'WARNING in dg_dispatch_as_host' bug.

memcpy: detected field-spanning write (size 56) of single field "&dg_info->msg"
at drivers/misc/vmw_vmci/vmci_datagram.c:237 (size 24)

WARNING: CPU: 0 PID: 1555 at drivers/misc/vmw_vmci/vmci_datagram.c:237
dg_dispatch_as_host+0x88e/0xa60 drivers/misc/vmw_vmci/vmci_datagram.c:237

Some code commentry, based on my understanding:

544 #define VMCI_DG_SIZE(_dg) (VMCI_DG_HEADERSIZE + (size_t)(_dg)->payload_size)
/// This is 24 + payload_size

memcpy(&dg_info->msg, dg, dg_size);
	Destination = dg_info->msg ---> this is a 24 byte
					structure(struct vmci_datagram)
	Source = dg --> this is a 24 byte structure (struct vmci_datagram)
	Size = dg_size = 24 + payload_size

{payload_size = 56-24 =32} -- Syzkaller managed to set payload_size to 32.

 35 struct delayed_datagram_info {
 36         struct datagram_entry *entry;
 37         struct work_struct work;
 38         bool in_dg_host_queue;
 39         /* msg and msg_payload must be together. */
 40         struct vmci_datagram msg;
 41         u8 msg_payload[];
 42 };

So those extra bytes of payload are copied into msg_payload[], a run time
warning is seen while fuzzing with Syzkaller.

One possible way to fix the warning is to split the memcpy() into
two parts -- one -- direct assignment of msg and second taking care of payload.

Gustavo quoted:
"Under FORTIFY_SOURCE we should not copy data across multiple members
in a structure."

Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
Suggested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/vmw_vmci/vmci_datagram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index 8a4b6bbe1beed..275542e8b2ad9 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -242,7 +242,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 
 			dg_info->in_dg_host_queue = true;
 			dg_info->entry = dst_entry;
-			memcpy(&dg_info->msg, dg, dg_size);
+			dg_info->msg = *dg;
+			memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 			schedule_work(&dg_info->work);
-- 
2.43.0


