Return-Path: <linux-kernel+bounces-55758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0465984C153
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296CC1C24619
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831C88F5B;
	Wed,  7 Feb 2024 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWC46ny2"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D198BFB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265415; cv=none; b=A4XwAn5+Utr3w4WIfHLmE4nhJyN9xX3WcXnrzJaq2ABpZu/IljwByFMx7i5QxfP8mJbTRzFBwITYk0X60XI/HsdgPXrmdfYeUatuQMqNTjlcw67gLrAKf6Gbzozfh59lavp9XR2OcaivfnomWzGH9lfxSk4n4QGIWhTognQIPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265415; c=relaxed/simple;
	bh=qD1aE1SiPaNwiLjlA8em3xOkoNrHF43l61oImQY0USQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fc/PMtXwKUrMFvXnDJrksYNQD+o50WfL3txXmo3mJWc9Ezwc1sCodDfBa8HHmssDyOPGnqzO8we/7IpYc1/Y4ILohQyH6cm62RRa+3V75qveJjint7iBcIz4RLqM5fjY6yJkeULK70/uy4UnWO85xS4wdIDefzk5qu4g/KCl9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWC46ny2; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783f553fdabso8302785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 16:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707265413; x=1707870213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eJn6nkq8Q6d0DBnWdQTTcqf1BYRrhaP04tM4LL1oFOA=;
        b=iWC46ny21Vi9ituZ4mPxGH7FrE/thOe42ihQ/MVLHlRUa13pIjP+rnLdchI0dkv/l3
         5CVzZd3F3+NQSZESrtmXorR5NALVAQ/nQH8HYbxcMZyHKT1cNE8JGyWafrd5BUmf2zsc
         Ra/it/9xJ4dvGDIidywqUuemVHUQpSZXU5iW6nlWK/JNeTgNCeMEKifzvr/NgH5Fv7xz
         Azdp+/1zxvaOIlyhykkEiip0eoJkebK0kBf6kqwMqqe+ibE4CQQUnZUs9gzb8cAj0rPf
         6p9DrPhMZJzsF1vFv3soOHZEoUBNMr44ngcy7j1VfW7+wfvdiozzKvuqEwfYS2MsBvMp
         FwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707265413; x=1707870213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJn6nkq8Q6d0DBnWdQTTcqf1BYRrhaP04tM4LL1oFOA=;
        b=jOBojRpI20dkLQNaGAHtMwLy5DUlBgmowinqYmxF8cdys4CFI8XhABgX1/AN7kGH1T
         hBFA15kNkInn8EYL04+kbSnX2Ii4iURM4dJe/Jto6DH1a9L5KEuoLBGRRNrxhmcGeKzO
         veDIYwnUvE6Zv2FH6aZr7iOJ4H7kljkYJsTIl3f6xnwBcCvDuKMXRfm/pUhEBSHzVNwA
         SKt1l/QJVReNsu+ntELPTRMYNK7/2LeL5kdSR0dWjSU9XrkRlflVE32v0VFCpDYLjjQE
         ZRVR+4m3kb1cxwclm5ndAKKYHlsLZumTP8lBLsedBMhbVlq5b1VDDyaiZIW/ZofM7Sta
         B8hg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Jh6Riw0VGMVhsmSiNTsjU9CizxaAESRtOiIKCWAd5B2D9hKB1atFAEP+zEwIEOIVCqiu6ugla4Rfjq3cP16KoeDRPELEFxLSISr0
X-Gm-Message-State: AOJu0Yz72+jh5URL9j964V428isusVdGi+lpY9iCvXFINNsxkY9CndUn
	iZxoB5lgYn/4V0P6kfqk7lrOKizgZUw8zZ2FMYVa42s/+M6/Q2iD
X-Google-Smtp-Source: AGHT+IHV6b1vWGsHIG5WoqcXN3fD8F47EWX0hNDQoEfiBK6EZgO4A05HU+eku6RwOHEX+NSQKmNNpA==
X-Received: by 2002:a05:620a:5601:b0:784:2f2c:7b47 with SMTP id vu1-20020a05620a560100b007842f2c7b47mr14647406qkn.17.1707265412990;
        Tue, 06 Feb 2024 16:23:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKqAZHciSBhjDkL93HSNwomj8WPup6WGlhY7hcp1+bBepyowCJcME+5DvSiTwCuo4I9OvgseJ7gAdxnopaPEgkDX8LvizgVLIp2x2/Xs1qLL4FLcCbxnhahVbF8hiWWVkL99ea8y/zdB6M8xSfrwRlh/aAkjyZZmwTaoWMLdmJD6M7ad9d7RRfYcf5B2Ih8lXWb0RsFCOtN+PE6kWS8zYacyOqFWvlbCaeKJWuVJ9SoK0J3UiOka/zQ+kEwLo1HXwEfGA2yywLwxlu5qbkXEYOwW1QIc14kPcx5EZlq09ObakrYL82tqDJfe16I3syDAwo4i8TKCrIC9NvdJrWuwDOqUD5r1TK/PONOfaVU6sYB8NNIpwqBGBtmBpyQEuuH7OTM7a+9gmZP1ycnmj1/uNpK1iOE0Jov4vAizwLDfVvhx85mOeF+VHPx0NBLWFTsJcyaAv6+9dioJ9m6vqA6+AbFjdPmezodvhrt+8Poit681nKmCj6QRsERdN0a5GoL0l0QtebUF75dKHYeIpfFcZL9xFsiF1OQLiRkIvgFy6KK+lBwp5YMq9LqVciGT0czfprTjMKQE9uu/IAfm3IVHO/JlMLXDexfEoUFwvkGnnqrLAQ06JxSbEirKbJVTqre71+uJ2HZOd9h/5BgWCzkR8Um5QhFpSL68WBpP3D8YyGwClGAK/UzDoda4xqCdYXIGuDkz/AWOdE6nFBpbnYIRP/isjJPgczZPjZugWy1Cicc3CW6TG+wpIREtKVYMGlroiBW0ShOSY9p8ht
Received: from aford-System-Version.lan ([2601:447:d002:5be:a4c9:b449:4b2a:fb09])
        by smtp.gmail.com with ESMTPSA id s9-20020ae9f709000000b00784b5fc8f1dsm30107qkg.34.2024.02.06.16.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:23:32 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Adam Ford <aford173@gmail.com>,
	nathan@kernel.org,
	kernel test robot <lkp@intel.com>,
	Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: imx8mp-hdmi-pvi:  Fix build warnings
Date: Tue,  6 Feb 2024 18:23:04 -0600
Message-ID: <20240207002305.618499-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two separate build warnings were reported.  One from an
uninitialized variable, and the other from returning 0
instead of NULL from a pointer.

Fixes: 059c53e877ca ("drm/bridge: imx: add driver for HDMI TX Parallel Video Interface")
Reported-by: nathan@kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402062134.a6CqAt3s-lkp@intel.com/
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
index a76b7669fe8a..f2a09c879e3d 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
@@ -57,7 +57,7 @@ static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
 	const struct drm_display_mode *mode;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector *connector;
-	u32 bus_flags, val;
+	u32 bus_flags = 0, val;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	conn_state = drm_atomic_get_new_connector_state(state, connector);
@@ -110,7 +110,7 @@ imx8mp_hdmi_pvi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
 	struct drm_bridge_state *next_state;
 
 	if (!next_bridge->funcs->atomic_get_input_bus_fmts)
-		return 0;
+		return NULL;
 
 	next_state = drm_atomic_get_new_bridge_state(crtc_state->state,
 						     next_bridge);
-- 
2.43.0


