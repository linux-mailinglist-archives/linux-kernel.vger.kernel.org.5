Return-Path: <linux-kernel+bounces-17693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE282513E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A90286F95
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839024A1E;
	Fri,  5 Jan 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZBD/fCin"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B42249F7;
	Fri,  5 Jan 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hyAxN
	nJEjaEeWu++V1hIX4/hQ1ibrMzym3D/Hwm9ZGQ=; b=ZBD/fCinCHAJjZF7ZeP4M
	VAe+2e6HZwmwNQq+lGva3ullAybf4zS6c0cUDG0c9bOnQaadB+GfvAjZthMynmf6
	lzKtBWN2MwF4qGsFVCmnvSpwTH73peENv+5ieYAkPS48ZypF9qw7DaHAx40WxrVD
	EvM1eNt/RiBfR+w9VOjXA8=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by zwqz-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3v95e0ZdlvtBYAQ--.43318S2;
	Fri, 05 Jan 2024 17:52:32 +0800 (CST)
From: clancy_shang@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: mgmt: Fix wrong param be used
Date: Fri,  5 Jan 2024 17:52:28 +0800
Message-Id: <20240105095228.279247-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v95e0ZdlvtBYAQ--.43318S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW7WF4rWw1UWF1rXFWUArb_yoWDZFXEgF
	409ay7uF4UXryvyF4Y93WrWr1Sya4a9Fs7Xr9xKrWxAr98Gr1UuFn7AF9xJFn3uanxZrn7
	Zr4DXF4F9w409jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeiXo3UUUUU==
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbisQlcuGVOA46VxwABsp

From: Clancy Shang <clancy.shang@quectel.com>

if the BlueZ library calls the API interface "adapter_set_device_flags",
which sends the "MGMT_OP_SET_DEVICE_FLAGS" opcode to the kernel, but
does not receive the callback message "MGMT_EV_DEVICE_FLAGS_CHANGED"
from the kernel. it fixs this bug.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9dd815b6603f..c74abdf3618f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5177,7 +5177,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 
 done:
 	if (status == MGMT_STATUS_SUCCESS)
-		device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+		device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
 				     supported_flags, current_flags);
 
 	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_FLAGS, status,
-- 
2.25.1


