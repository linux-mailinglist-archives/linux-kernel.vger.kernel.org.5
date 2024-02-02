Return-Path: <linux-kernel+bounces-49303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67FA846871
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602BD1F231B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC648781;
	Fri,  2 Feb 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JDQge6j0"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0178481B4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856228; cv=none; b=INNlsXaCiBfepO0avJgRNA9l9rhNrzFRcjPSxejcpStP25b1Id/9oERNnjXJIl9+zZogJsCYgi2qidbl318TkZub86J1THDVOLfjntq7IwvgTfDhFv4KhPSHpGg7UqluX3uCx7Mz20Yz0jU/4fiCv0szbfvbpMswY5q+hxDR+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856228; c=relaxed/simple;
	bh=AT0D06dEnCX3xAFZpn1FFCz1gETYrTU97dZV26IIREo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G5pbIkPWpi0a7jQMBl+f4vi4GPU73cYuZLs4sj8FZbAZCIMrxTISbIP3X0xlxDKZD+evvCDTiuBEw3ifrgAIyyRHAwWI9z9TRj1seHV6o3vFIA3Sv+m4ioIBNYbdBNZRDuAGMiNpMooUJyQAP048GEwdwccs9Jqn43u24h7ef70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JDQge6j0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 4597320B2000; Thu,  1 Feb 2024 22:43:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4597320B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706856227;
	bh=yJ2N3/HVGxJA0MGmEiSpJS8Lev4/X5f6v9PbC3nQxsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDQge6j0N748zAX3m40uBjCAofdEIZ3yaeynY2aCazTw07uwLOJStak9RvU57N2nB
	 xoyU8AZgWNF+KwYqVPJcCO3VOiAA3OGEzS2cgwoBZQ+GTMxR6EHoPlkGqkcOsWfgsQ
	 DN0ZpUT6L7+m8E6ocHeGZSEiIkaw6wQKXDKzYCEo=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.dev>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v4, 2/2] drm: Check polling initialized before enabling in drm_helper_probe_single_connector_modes
Date: Thu,  1 Feb 2024 22:43:44 -0800
Message-Id: <1706856224-9725-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1706856176-9483-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1706856176-9483-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In function drm_helper_probe_single_connector_modes() when we enable
polling again, if it is already uninitialized, a warning is reported.
This patch fixes the warning message by checking if poll is initialized
before enabling it.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401191128.db8423f1-oliver.sang@intel.com
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v4
 * Clubbed this patch with similar patches and added a cover letter
---
 drivers/gpu/drm/drm_probe_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index bd76603dc387..30e6063535cd 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -622,8 +622,12 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 					 0);
 	}
 
-	/* Re-enable polling in case the global poll config changed. */
-	drm_kms_helper_poll_enable(dev);
+	/*
+	 * Re-enable polling in case the global poll config changed but polling
+	 * is still initialized.
+	 */
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_enable(dev);
 
 	if (connector->status == connector_status_disconnected) {
 		DRM_DEBUG_KMS("[CONNECTOR:%d:%s] disconnected\n",
-- 
2.34.1


