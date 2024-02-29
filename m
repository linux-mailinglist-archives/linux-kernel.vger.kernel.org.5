Return-Path: <linux-kernel+bounces-86323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4D86C3EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F71C22329
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546085337B;
	Thu, 29 Feb 2024 08:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gQXMnted"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA7D50A63;
	Thu, 29 Feb 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196083; cv=none; b=ijjhR7wqG4ke6DmZbRm2hWTL3WtC6SJyf9jaTimldipDJa2NNIPcBRrYLU4DUbQ6SszXQHLi6WtLOW0o6u0/atO3ztdHiAoiY73rdC0k7JzqEKBoDdVD/IqTol7Z4kmxwpNQat0+EDRpQQ7OI0joNaH3qAuhrkEN6P3AysDwg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196083; c=relaxed/simple;
	bh=03KT88bs5CPFUzGWiSf0JoK4aabPHEcPRG/J8ct3YMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UoSXKS7WiStDvQreBKx7yXhbaUIjvyU0L+AT6svNTzb2/NCaAmm2eGLIaphbvCfViauj9YXJziS2xynvQ7rpfffhGcgThcEwvova5VFFvVyR2KaZvOkgNP7NM5KlpkLzQorFvUtOIWuSBwG8apBPbDkQ77PIZAu8PMWt4GIvDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gQXMnted; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hyAxN
	nJEjaEeWu++V1hIX4/hQ1ibrMzym3D/Hwm9ZGQ=; b=gQXMntedUhlzrlxQ4uEv6
	zKmC6QNXfalg9kKuLxySTnTzIws33S1WybuoCtsfhXs348FFRWVuoVzqZKNsMYd0
	qiRt7N23hA4nB/Qprz6wF1C0HHgwGh5/DsMJFhZ6UlhZMocoNO4j5+W1YUxlSpSL
	vOWw3irxW37MRHfIg31r1I=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD33oYhQ+BloLRsGg--.37440S2;
	Thu, 29 Feb 2024 16:41:07 +0800 (CST)
From: clancy_shang@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: mgmt: Fix wrong param be used
Date: Thu, 29 Feb 2024 16:40:59 +0800
Message-Id: <20240229084059.895730-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33oYhQ+BloLRsGg--.37440S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW7WF4rWw1UWF1rXFWUArb_yoWDZFXEgF
	409ay7uF4UXryvyF4Y93WrWr1Sya4a9Fs7Xr9xKrWxAr98Gr1UuFn7AF9xJFn3uanxZrn7
	Zr4DXF4F9w409jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU01q2tUUUUU==
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbisAiLuGV4H-ePSAABs4

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


