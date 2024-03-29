Return-Path: <linux-kernel+bounces-124818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D749B891CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B861F25F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB01A0AFD;
	Fri, 29 Mar 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAnVkSBK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687891A0AEB;
	Fri, 29 Mar 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716227; cv=none; b=Od35483Ol4vY3CxI2VPZGWFmZkG6G7+zLoOXXY0yAChx4Kf62zd7xMEb6TVsHSvQNB3IlYTykZur2Va4o14BLjn6W5hPlQXXAPVp5bhJvJHaHw8SHhdBJIn7AGgJgBjkGQaSDOuVYa6c27REeR/bUEn+WyXXAjLj24r1JP75pvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716227; c=relaxed/simple;
	bh=AZ0mB1d3R+H64t4ZWNRanPwr3ab/60b2LiI4buc8VcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlES44RwgycO/iLIi2R4dw07mZ/vG3YBo+I7vQ4wkUqFzoBslPnRW3AehLIKYftXz/roWRi+gynmHRKLVSycwIm1vhPKAhqv13/OLCli14HsP5zR6Xv9ngnu8h7RmIHGJOiTUH3pP/MUGzSLaKQPU8pXwKX7p+Tdy+meLbRBbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAnVkSBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCE2C43390;
	Fri, 29 Mar 2024 12:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716227;
	bh=AZ0mB1d3R+H64t4ZWNRanPwr3ab/60b2LiI4buc8VcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAnVkSBKR+DAyxLh2dbbX4mQKk3SCREKXtr7vFOy+dx9zDMHmKN5nSUJ0IzxjUux4
	 jBbHnVqzJvML/xNpAJykX+Q63Z9MxzNVhzUTq6mD7LXhS+2NT9wzdi9gAR/IXKqSLT
	 cfnRasiYZ7D9MRoFt4McEonEir7i7L2Ss5RfALG9Ic9sdawzX+CuCkhrqh6QljHD5F
	 byeSIRyFjbitQCuaUV4uY+24bufZfsyIc7Hjq3XzOltd73xGAgpKgeMHeacL5eyxCI
	 nEp2rhCV5rKcBOsBwsjAHylPRz2kkUs7pj50861trGmidGYKKitnuxXYt+VPQ83sOA
	 mq77d5EL1sj8g==
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
Subject: [PATCH AUTOSEL 6.6 09/75] VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()
Date: Fri, 29 Mar 2024 08:41:50 -0400
Message-ID: <20240329124330.3089520-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index f50d22882476f..d1d8224c8800c 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -234,7 +234,8 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 
 			dg_info->in_dg_host_queue = true;
 			dg_info->entry = dst_entry;
-			memcpy(&dg_info->msg, dg, dg_size);
+			dg_info->msg = *dg;
+			memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
 
 			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 			schedule_work(&dg_info->work);
-- 
2.43.0


