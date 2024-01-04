Return-Path: <linux-kernel+bounces-16662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144B482420A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B70287745
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5102231C;
	Thu,  4 Jan 2024 12:52:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E482137E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T5R7H5ZSHzMpnqr;
	Thu,  4 Jan 2024 12:42:19 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T5R7G6TLWzMpnPs;
	Thu,  4 Jan 2024 13:42:18 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 2/2] drm/panel: ltk050h3146w: use dev_err_probe wherever possible
Date: Thu,  4 Jan 2024 13:41:58 +0100
Message-ID: <20240104-ltk-dev_err_probe-v1-2-8ef3c0b585d8@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104-ltk-dev_err_probe-v1-0-8ef3c0b585d8@theobroma-systems.com>
References: <20240104-ltk-dev_err_probe-v1-0-8ef3c0b585d8@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
This is only a cosmetic change.=0D
=0D
This replaces a hand-crafted EPROBE_DEFER handling for deciding to print=0D
an error message with dev_err_probe.=0D
=0D
A side-effect is that dev_err_probe also adds a debug message when it's=0D
not EPROBE_DEFER, but this is seen as an improvement.=0D
=0D
Cc: Quentin Schulz <foss+kernel@0leil.net>=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 17 +++++------------=
=0D
 1 file changed, 5 insertions(+), 12 deletions(-)=0D
=0D
diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/g=
pu/drm/panel/panel-leadtek-ltk050h3146w.c=0D
index ecfa4181c4fd9..9d87cc1a357e3 100644=0D
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c=0D
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c=0D
@@ -650,20 +650,13 @@ static int ltk050h3146w_probe(struct mipi_dsi_device =
*dsi)=0D
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "cannot get reset gp=
io\n");=0D
 =0D
 	ctx->vci =3D devm_regulator_get(dev, "vci");=0D
-	if (IS_ERR(ctx->vci)) {=0D
-		ret =3D PTR_ERR(ctx->vci);=0D
-		if (ret !=3D -EPROBE_DEFER)=0D
-			dev_err(dev, "Failed to request vci regulator: %d\n", ret);=0D
-		return ret;=0D
-	}=0D
+	if (IS_ERR(ctx->vci))=0D
+		return dev_err_probe(dev, PTR_ERR(ctx->vci), "Failed to request vci regu=
lator\n");=0D
 =0D
 	ctx->iovcc =3D devm_regulator_get(dev, "iovcc");=0D
-	if (IS_ERR(ctx->iovcc)) {=0D
-		ret =3D PTR_ERR(ctx->iovcc);=0D
-		if (ret !=3D -EPROBE_DEFER)=0D
-			dev_err(dev, "Failed to request iovcc regulator: %d\n", ret);=0D
-		return ret;=0D
-	}=0D
+	if (IS_ERR(ctx->iovcc))=0D
+		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),=0D
+				     "Failed to request iovcc regulator\n");=0D
 =0D
 	mipi_dsi_set_drvdata(dsi, ctx);=0D
 =0D
=0D
-- =0D
2.43.0=0D
=0D

