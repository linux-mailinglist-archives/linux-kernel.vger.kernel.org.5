Return-Path: <linux-kernel+bounces-135092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125AB89BB0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C080428338F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C18A3C08E;
	Mon,  8 Apr 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="EWR6+B0/"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0113C6AC;
	Mon,  8 Apr 2024 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566662; cv=none; b=ZZv9SvqbZ2Ve6QBGNlMECeR7U+tGqfBKqa76gmJ2zG9ixgkNbNYPpCf9ZdyfOzlrz2InKbXSFbpn5FA8q6sRsHAzypNpiMGN7ju1KMqBXa86RS+4Y+xs5qr/BvrxSVDPzxE8CJ+ymdvzftb7jacwjc9l2AOdjx9rjJ8f62XBqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566662; c=relaxed/simple;
	bh=71cgcbD3LCizJbaId/qtf0bxqGyZFhg/a+lnSwLkGbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ddRGAlHgExwKy+6nES71wZSrVHHodKl6pXVVv9r6SP1xZJaaXYkA+Y35i29vkudpKHvW0DqUf5DQ/1uHI/k06eQIP5G7qO0JXsrCR3Zi/dfIeAUjAqX6wpkbTLHDfjHsVVDV53IDdlneTk+buUn39Lf03xYTQpgnd86mF7rSlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=EWR6+B0/; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 0270A100003;
	Mon,  8 Apr 2024 11:57:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712566634; bh=tVaZQ82kV0U3VdjNP3qButkhjLghxD+YcZT09STBU0k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=EWR6+B0/gNf41mL3w6lZmTV9X69uZetXhu7XTDGpVjECqaMntRrs8I03xbrIeGDvb
	 xSR6EPy6HI9obNTSe2zvlXDKzikO5zq+Rm+3ek64f257mnNv4jh+1g9xIvnChEhU+Q
	 fqUyVpBBwyk3NS+flimzDNcWZ0SrLr72HsxJ1n/2zS73uAbed1AzwMnLYY4Wa5Sc6H
	 mkk7MaBQGoZxXYQMDam/uSM1zDLFJdbBAgAtD/eLCQB5Agiv4bgIsWHfclheA+BBO/
	 /y4lKFaOd7T03nohLLQB4f5CCb0vOX7lsbnvIY5Glh3rApTXFplEwFa+ylZy+QSGyV
	 Uxy26W+/Hm4jA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Mon,  8 Apr 2024 11:55:52 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 11:55:32 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Neil Armstrong
	<neil.armstrong@linaro.org>, Stephen Boyd <swboyd@chromium.org>,
	<linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] drm/msm/dpu: Add callback function pointer check before its call
Date: Mon, 8 Apr 2024 11:55:23 +0300
Message-ID: <20240408085523.12231-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184614 [Apr 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/08 07:15:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/08 06:53:00 #24704467
X-KSMG-AntiVirus-Status: Clean, skipped

In dpu_core_irq_callback_handler() callback function pointer is compared to NULL,
but then callback function is unconditionally called by this pointer.
Fix this bug by adding conditional return.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c929ac60b3ed ("drm/msm/dpu: allow just single IRQ callback")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 946dd0135dff..03a16fbd4c99 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -223,9 +223,11 @@ static void dpu_core_irq_callback_handler(struct dpu_kms *dpu_kms, unsigned int
 
 	VERB("IRQ=[%d, %d]\n", DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
 
-	if (!irq_entry->cb)
+	if (!irq_entry->cb) {
 		DRM_ERROR("no registered cb, IRQ=[%d, %d]\n",
 			  DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
+		return;
+	}
 
 	atomic_inc(&irq_entry->count);
 
-- 
2.30.2


