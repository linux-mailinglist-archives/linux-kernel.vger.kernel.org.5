Return-Path: <linux-kernel+bounces-110548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365BC886065
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CD51C2209E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B792133404;
	Thu, 21 Mar 2024 18:14:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E4131E3C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.204.156.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044861; cv=none; b=bJDn4YnKHBSuqMlUSh0cz7/gCBwY1aWDMa13KRmYM8ARJER3fGkPf6d+PpmOAFLN/jQBe+gtd4akrsMNTbunDjcanZ2WGo2MqSu3iTzmevvOuWNCGXD/nSWkVqp1UwjTJO2R6oXiJUBWHYLxs/D6HobaWPGSwAAkbDbjf0OaII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044861; c=relaxed/simple;
	bh=InEqR0TlXCon75rDatUuS82amrpsj2Ydaomc8MJOdTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+KdWxrnOT/Dx3g6pL3tILal4Imq5uI0jTAdOtFbHv3PqBY08QgowDVpqb+KCwqa4UqiKDlo2FpOyaQ+/HgGDLYYvNMPzz7a1h8uri0qoEaa0G1bsCeSmusawbJMHVEqy8httJE70C6ocNYexUNL9gexhCULRB3ttbrqYaaUp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com; arc=none smtp.client-ip=165.204.156.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rtg-sunil-navi33.amd.com
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 42LIE6vg1365980;
	Thu, 21 Mar 2024 23:44:06 +0530
Received: (from sunil@localhost)
	by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 42LIE6cd1365979;
	Thu, 21 Mar 2024 23:44:06 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: fix function implicit declaration error
Date: Thu, 21 Mar 2024 23:44:03 +0530
Message-Id: <20240321181403.1365947-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when CONFIG_DEV_COREDUMP is not defined in that case
when amdgpu_coredump() is called it does not find it's
definition and the build fails.

This happens as the header is defined without the
CONFIG_DEV_COREDUMP ifdef and due to which header isn't
enabled.

Pulling the header out of such ifdef so in both the
cases the build does not fail.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 95028f57cb56..f771b2042a43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -74,10 +74,7 @@
 #include "amdgpu_fru_eeprom.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
-
-#ifdef CONFIG_DEV_COREDUMP
 #include "amdgpu_dev_coredump.h"
-#endif
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
-- 
2.34.1


