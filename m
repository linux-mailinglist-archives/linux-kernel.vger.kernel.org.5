Return-Path: <linux-kernel+bounces-29782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6564B831358
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CBA28528D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7BAC14F;
	Thu, 18 Jan 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U68I34XZ"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC797125A1;
	Thu, 18 Jan 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564201; cv=none; b=TBsHH3PZq0OTrsAisvZZfp6wnuqwFx2cWS8Nerfp/3zoIIasDzPFQBN7BvSulRpPwauFZVvCs85zqTCkb31FCK6BVL7zSrlTIAvG3tu+nyiOcLTXb+9FmYUWjTZBRjoMlHb8sNekakGlBPlhG4ff3plv5GhGg57CXQ0Fz2SW740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564201; c=relaxed/simple;
	bh=03KT88bs5CPFUzGWiSf0JoK4aabPHEcPRG/J8ct3YMs=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo; b=gGrqo0X8mCXSBSbHkWe4I7ezgEosuuTRB+QKBT3vpheOklI2knIoFOqaU2ZNnNd6Tqz2Sm4q/a+wtNdd27XiMBOaFoBX8rrIB9q3lMJmd4yoJYtqcmKK+470CriQzbpt/WSIDjQKhYiW8J9NgKnNw/4wXRSN/vdpZ07Htq92UPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U68I34XZ; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hyAxN
	nJEjaEeWu++V1hIX4/hQ1ibrMzym3D/Hwm9ZGQ=; b=U68I34XZ+ML95Uy9HetT1
	B4XnR7610kIkPZFvizHOUIM15nM6LTlgkqC7VguBumGrGf7aDh+CuOB9mHkKeBhp
	feR6dxIqIdSE5PMFhxoEHid49pfSCXXBttPtsI7NQ/Lh1NeXoZJ9aF0N1eJITStY
	pjTBd4RFL2ckZLVU5fC/20=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDX37AJ2KhlVjx5Aw--.26S2;
	Thu, 18 Jan 2024 15:49:33 +0800 (CST)
From: clancy_shang@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: mgmt: Fix wrong param be used
Date: Thu, 18 Jan 2024 15:49:27 +0800
Message-Id: <20240118074927.2051489-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX37AJ2KhlVjx5Aw--.26S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW7WF4rWw1UWF1rXFWUArb_yoWDZFXEgF
	409ay7uF4UXryvyF4Y93WrWr1Sya4a9Fs7Xr9xKrWxAr98Gr1UuFn7AF9xJFn3uanxZrn7
	Zr4DXF4F9w409jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeiNVPUUUUU==
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/xtbBzRJpuGVOBiY5sAAAsM

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


