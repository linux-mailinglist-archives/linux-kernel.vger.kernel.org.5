Return-Path: <linux-kernel+bounces-143725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7588A3CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E0B1F21D52
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FAE3FB31;
	Sat, 13 Apr 2024 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UPNMQpXN"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE94F1C2A5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713009048; cv=none; b=D0uQq3V3Y4snNMBjl1sTi69/6IOwbNIiCDVPcotdJkD8zwJ7YxNKlVjU8YG10+WqSfXtA9ZvWrkNDe1EACmKWG6w/oee6fgpRjelFl786LMtYIWK5HPb9OCcJvqxvNc+UJhjgtSXnxVH8IzmCEzTSXYS2AM5rH9eeI0H8yz1Llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713009048; c=relaxed/simple;
	bh=PtC7jHiLyTKBTG9iP7AvPgc+6ZXScdOk3HuslgLZ8wE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YeEFbdFq1r1q/xJbVpYP49ML7zmsLtYmqapQ2NjB2Ov3r9XiWghkeIIIaCw7gH7U8zL9BjYhUj0jwOxEfLfXy2/ad/AlhR/afTHkbsWObDsI8qD8gylOb3ibI6ogaxmFRuPP1L9kKPSiO5R2xbUzS83Y9mbCU5rUJdriIlgt/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UPNMQpXN; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=C/i+R
	Nq5Pzo3i3TYLnj/DsICAobD6rQqS8xqCwClBB8=; b=UPNMQpXNGkCqNPfm/uiqr
	2JLtqx5FZ36szmAX/TW6XXOB3u/8XlO7c1ZjCSGYrO542eBkWiM9MfDktyvIqC9w
	NfF9P5APJbRxV5gLjeh2MHduBSbPEPpeQOolaVPxVYgvglUD9sO0rfvbCpsIBf+9
	NBiH31uQOjv+9dDiQgAofE=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wD3n+hVcRpmDvQVBA--.50814S2;
	Sat, 13 Apr 2024 19:49:45 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: boris.brezillon@collabora.com
Cc: daniel@ffwll.ch,
	airlied@gmail.com,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	steven.price@arm.com,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] drm/panthor: Add defer probe for firmware load
Date: Sat, 13 Apr 2024 19:49:38 +0800
Message-Id: <20240413114938.740631-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n+hVcRpmDvQVBA--.50814S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruryxWryrCr4fKF1rKw1kuFg_yoWDtwc_CF
	4jyr1fXw48Ga4qqF1vka129Fy2kF4rZF1kZanYq34fCrnrGasrt39Fqry3W3y5WF10vasr
	ua4UXr40krW7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU84v3UUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEBu-XmVODWy+XAABsD

From: Andy Yan <andy.yan@rock-chips.com>

The firmware in the rootfs will not be accessible until we
are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
that point.
This let the driver can load firmware when it is builtin.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/gpu/drm/panthor/panthor_fw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 33c87a59834e..25e375f8333c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1336,8 +1336,17 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	}
 
 	ret = panthor_fw_load(ptdev);
-	if (ret)
+	if (ret) {
+		/*
+		 * The firmware in the rootfs will not be accessible until we
+		 * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
+		 * that point.
+		 */
+		if (system_state < SYSTEM_RUNNING)
+			ret = -EPROBE_DEFER;
+
 		goto err_unplug_fw;
+	}
 
 	ret = panthor_vm_active(fw->vm);
 	if (ret)
-- 
2.34.1


