Return-Path: <linux-kernel+bounces-38467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C3D83C07F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC75B2A6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5058202;
	Thu, 25 Jan 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P5diZh7v"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C61CA83;
	Thu, 25 Jan 2024 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180296; cv=none; b=GGQXEDJwXZ2HP3GP2pA1wo8btDR5Uh7Lw1SnoWX0lH0izg4g2vC4QXHQ3jta1hM6TL8t0aMv8RcUHC03AqxTeXtRWkRzKl8m4iPBeuB+bUm3s0QwVebFQDA/uko9jffP6azQ10JeWRvxZra/DY6FacSucKWTZKWIEnmf4Y/Tn8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180296; c=relaxed/simple;
	bh=03KT88bs5CPFUzGWiSf0JoK4aabPHEcPRG/J8ct3YMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URJ8BD8tTwwK84ZqiegRninQNh8pLfHbGJ9SHKUatIOEpuUeUwxUy7EK6TE97a5BcdRssc+boXAD9CUk1Uk1uv6uob/f4KXucFHkOH6elpCHT96EVDinPIiAw1g0txbQV0nKfIyalH2BsUFg8qBPammJmt6g1ZEhiDVh5e0rtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P5diZh7v; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hyAxN
	nJEjaEeWu++V1hIX4/hQ1ibrMzym3D/Hwm9ZGQ=; b=P5diZh7vy2qXQbww/HXV/
	w3rzLHnWp8Y7oK0bEnV5UBzYj95y9gN7BTUa/I26WThTm+uUpD7HhufvfC/hclrt
	Zkdc+CZAxBHPw9q+d8blwk9mFeceMaXZML5RXQufn3AVUAAaeVdNERTNfH0X4ecD
	BUoblUi9Ww5flj9XSb6ZLc=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3X06yPrJlPkoiAw--.19557S2;
	Thu, 25 Jan 2024 18:57:56 +0800 (CST)
From: clancy_shang@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: mgmt: Fix wrong param be used
Date: Thu, 25 Jan 2024 18:57:52 +0800
Message-Id: <20240125105752.3144840-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X06yPrJlPkoiAw--.19557S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW7WF4rWw1UWF1rXFWUArb_yoWDZFXEgF
	409ay7uF4UXryvyF4Y93WrWr1Sya4a9Fs7Xr9xKrWxAr98Gr1UuFn7AF9xJFn3uanxZrn7
	Zr4DXF4F9w409jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8RpB3UUUUU==
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/xtbBzRRwuGVOBrWrwwAAsh

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


