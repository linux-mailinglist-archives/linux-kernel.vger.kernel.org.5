Return-Path: <linux-kernel+bounces-22004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1256E8297C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806E5289E43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A140C0F;
	Wed, 10 Jan 2024 10:42:00 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52F40C0E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id D6F4F2F2027D; Wed, 10 Jan 2024 10:41:53 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id E1B262F20249;
	Wed, 10 Jan 2024 10:41:31 +0000 (UTC)
From: kovalev@altlinux.org
To: bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: kovalev@altlinux.org,
	nickel@altlinux.org,
	oficerovas@altlinux.org,
	dutyrok@altlinux.org
Subject: [PATCH 1/1] misc/vmw_vmci: fix filling of the msg and msg_payload in dg_info struct
Date: Wed, 10 Jan 2024 13:40:42 +0300
Message-Id: <20240110104042.31865-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240110104042.31865-1-kovalev@altlinux.org>
References: <20240110104042.31865-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

Fix "detected field-spanning write" of memcpy warning that is issued by
the tracking mechanism __fortify_memcpy_chk, added 2021-04-20
(f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time)

Fixes: a110b7ebb9c674 ("VMCI: datagram implementation.")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/misc/vmw_vmci/vmci_datagram.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index f50d22882476f9..27853b31e288b1 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -234,7 +234,10 @@ static int dg_dispatch_as_host(u32 context_id, struct vmci_datagram *dg)
 
 			dg_info->in_dg_host_queue = true;
 			dg_info->entry = dst_entry;
-			memcpy(&dg_info->msg, dg, dg_size);
+			memcpy(&dg_info->msg, dg, VMCI_DG_HEADERSIZE);
+			if (dg->payload_size) {
+				memcpy(dg_info->msg_payload, VMCI_DG_PAYLOAD(dg), dg->payload_size);
+			}
 
 			INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 			schedule_work(&dg_info->work);
@@ -377,7 +380,10 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
 
 		dg_info->in_dg_host_queue = false;
 		dg_info->entry = dst_entry;
-		memcpy(&dg_info->msg, dg, VMCI_DG_SIZE(dg));
+		memcpy(&dg_info->msg, dg, VMCI_DG_HEADERSIZE);
+		if (dg->payload_size) {
+			memcpy(dg_info->msg_payload, VMCI_DG_PAYLOAD(dg), dg->payload_size);
+		}
 
 		INIT_WORK(&dg_info->work, dg_delayed_dispatch);
 		schedule_work(&dg_info->work);
-- 
2.33.8


