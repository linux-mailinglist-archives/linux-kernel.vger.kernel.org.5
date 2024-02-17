Return-Path: <linux-kernel+bounces-69924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E2A85905B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D3283186
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592127CF1A;
	Sat, 17 Feb 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsxF0O0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63F7C09F;
	Sat, 17 Feb 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182183; cv=none; b=GIwflB0TdwKhk8yOoNo2SLNTT10b67AwxUaaL+NJFDWzvMuGu7ZdY8mTpWFRhxmnUlN4sZsAg3LIkbv2GzoE/2zVl2BfVDRDJ1ifWBTp4nAXkqlpycZJ8dyzwq8lZf9TkOVpmqxIKNJnqHn6EfvUIO0XU7WCKG6w9LNpD+p6Szg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182183; c=relaxed/simple;
	bh=7qfwQMTk/6XmuQTgWrrAU6QDNKvMnI+7NUmGueoQmuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DirQYFZe/HgTvG1zN55Dn0aNfUArbFbZN5FNSaedW3BzdD8n+KwgeDxURF23KsFJSs+KcLje4+Lr9eoUxYF0Hx1I05jRtlNsBsI3AZ9trD/5DzXbAT4XF1tCNK5cMoygTIOYq5z7DlVqsyKWPspmZCFZIFLFSD/AsKn30QQ05rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsxF0O0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02076C433C7;
	Sat, 17 Feb 2024 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708182183;
	bh=7qfwQMTk/6XmuQTgWrrAU6QDNKvMnI+7NUmGueoQmuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsxF0O0zWvPp505t1lswvS1c07/vMyEj6NoWQGyVmOanlWHTgZy+BXheaA1LpqFsK
	 0EOGVlB6+Di9XgzmDKXGhgICuKHjiyS6StSQM/iKM/sGiYqjrPqy58nroPER5ekRMJ
	 ukkP8NVixapjyuC4ugenR6sCoqfLLmhTDNOMMn9M1VDKUa4mcZi8ihmX+5Y1opV6Ik
	 cAlY6KX71aBxy8Juy5Al0MNjz9km7CAkvJjYa8BHjMsEVAAPe66JRSkhhApIMwI48C
	 RfvbdwgLwUXJfb++tbEMIfG0AHo6XVwD7DgIkjQTI9ERYmkSr4oXtVy7IP2V8shnfc
	 yxVs5lHpLMx5Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rbMDW-000000001Vs-35SB;
	Sat, 17 Feb 2024 16:03:02 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
Date: Sat, 17 Feb 2024 16:02:25 +0100
Message-ID: <20240217150228.5788-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217150228.5788-1-johan+linaro@kernel.org>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent DRM series purporting to simplify support for "transparent
bridges" and handling of probe deferrals ironically exposed a
use-after-free issue on pmic_glink_altmode probe deferral.

This has manifested itself as the display subsystem occasionally failing
to initialise and NULL-pointer dereferences during boot of machines like
the Lenovo ThinkPad X13s.

Specifically, the dp-hpd bridge is currently registered before all
resources have been acquired which means that it can also be
deregistered on probe deferrals.

In the meantime there is a race window where the new aux bridge driver
(or PHY driver previously) may have looked up the dp-hpd bridge and
stored a (non-reference-counted) pointer to the bridge which is about to
be deallocated.

When the display controller is later initialised, this triggers a
use-after-free when attaching the bridges:

	dp -> aux -> dp-hpd (freed)

which may, for example, result in the freed bridge failing to attach:

	[drm:drm_bridge_attach [drm]] *ERROR* failed to attach bridge /soc@0/phy@88eb000 to encoder TMDS-31: -16

or a NULL-pointer dereference:

	Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
	...
	Call trace:
	  drm_bridge_attach+0x70/0x1a8 [drm]
	  drm_aux_bridge_attach+0x24/0x38 [aux_bridge]
	  drm_bridge_attach+0x80/0x1a8 [drm]
	  dp_bridge_init+0xa8/0x15c [msm]
	  msm_dp_modeset_init+0x28/0xc4 [msm]

The DRM bridge implementation is clearly fragile and implicitly built on
the assumption that bridges may never go away. In this case, the fix is
to move the bridge registration in the pmic_glink_altmode driver to
after all resources have been looked up.

Incidentally, with the new dp-hpd bridge implementation, which registers
child devices, this is also a requirement due to a long-standing issue
in driver core that can otherwise lead to a probe deferral loop (see
fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Fixes: 2bcca96abfbf ("soc: qcom: pmic-glink: switch to DRM_AUX_HPD_BRIDGE")
Cc: stable@vger.kernel.org      # 6.3
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 5fcd0fdd2faa..b3808fc24c69 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -76,7 +76,7 @@ struct pmic_glink_altmode_port {
 
 	struct work_struct work;
 
-	struct device *bridge;
+	struct auxiliary_device *bridge;
 
 	enum typec_orientation orientation;
 	u16 svid;
@@ -230,7 +230,7 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 	else
 		pmic_glink_altmode_enable_usb(altmode, alt_port);
 
-	drm_aux_hpd_bridge_notify(alt_port->bridge,
+	drm_aux_hpd_bridge_notify(&alt_port->bridge->dev,
 				  alt_port->hpd_state ?
 				  connector_status_connected :
 				  connector_status_disconnected);
@@ -454,7 +454,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		alt_port->index = port;
 		INIT_WORK(&alt_port->work, pmic_glink_altmode_worker);
 
-		alt_port->bridge = drm_dp_hpd_bridge_register(dev, to_of_node(fwnode));
+		alt_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
 		if (IS_ERR(alt_port->bridge)) {
 			fwnode_handle_put(fwnode);
 			return PTR_ERR(alt_port->bridge);
@@ -510,6 +510,16 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
 		}
 	}
 
+	for (port = 0; port < ARRAY_SIZE(altmode->ports); port++) {
+		alt_port = &altmode->ports[port];
+		if (!alt_port->bridge)
+			continue;
+
+		ret = devm_drm_dp_hpd_bridge_add(dev, alt_port->bridge);
+		if (ret)
+			return ret;
+	}
+
 	altmode->client = devm_pmic_glink_register_client(dev,
 							  altmode->owner_id,
 							  pmic_glink_altmode_callback,
-- 
2.43.0


