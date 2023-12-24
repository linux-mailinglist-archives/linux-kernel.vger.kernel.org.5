Return-Path: <linux-kernel+bounces-10656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AB381D84D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68E01C20D4F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EE415CF;
	Sun, 24 Dec 2023 08:23:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0666139A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [122.235.137.177])
	by mail-app3 (Coremail) with SMTP id cC_KCgAHAhl46odlgshjAQ--.38024S2;
	Sun, 24 Dec 2023 16:23:21 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Evan Quan <evan.quan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Ran Sun <sunran001@208suo.com>,
	Deepak R Varma <drv@mailo.com>,
	Ken Wang <Qingqing.Wang@amd.com>,
	Rex Zhu <Rex.Zhu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm/smu7: fix a memleak in smu7_hwmgr_backend_init
Date: Sun, 24 Dec 2023 16:22:47 +0800
Message-Id: <20231224082249.3539167-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgAHAhl46odlgshjAQ--.38024S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18Gr4DWw1xuw4UAF1DZFb_yoW8WFy7pa
	s3JrWvv34UAanrt3ZrAF1IgF1rC397JFyv9w1UK39Iv345Kr18uryDGa9IyF4qkFyxWw4S
	qr12q3yUWr1j9wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbasjUUUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

The hwmgr->backend, (i.e. data) allocated by kzalloc is not freed in
the error-handling paths of smu7_get_evv_voltages and
smu7_update_edc_leakage_table. However, it did be freed in the
error-handling of phm_initializa_dynamic_state_adjustment_rule_settings,
by smu7_hwmgr_backend_fini. So the lack of free in smu7_get_evv_voltages
and smu7_update_edc_leakage_table is considered a memleak in this patch.

Fixes: 599a7e9fe1b6 ("drm/amd/powerplay: implement smu7 hwmgr to manager asics with smu ip version 7.")
Fixes: 8f0804c6b7d0 ("drm/amd/pm: add edc leakage controller setting")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 11372fcc59c8..b1a8799e2dee 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2974,6 +2974,8 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 		result = smu7_get_evv_voltages(hwmgr);
 		if (result) {
 			pr_info("Get EVV Voltage Failed.  Abort Driver loading!\n");
+			kfree(hwmgr->backend);
+			hwmgr->backend = NULL;
 			return -EINVAL;
 		}
 	} else {
@@ -3019,8 +3021,10 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 	}
 
 	result = smu7_update_edc_leakage_table(hwmgr);
-	if (result)
+	if (result) {
+		smu7_hwmgr_backend_fini(hwmgr);
 		return result;
+	}
 
 	return 0;
 }
-- 
2.34.1


