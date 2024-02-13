Return-Path: <linux-kernel+bounces-63003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B158528C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726BF28658E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4915EA2;
	Tue, 13 Feb 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I9rIdyy2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE814275
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805056; cv=none; b=MkvQbWahs4l2xbGAHCB6CdHA1UwRAwUoYGVqsOqltQGPbmwilSPnVPqVhPP91VlLW9wE92rSjR34Zdwbmxgg70g35KLsH7aJUXrl+oh6bTKfPWxqSiM1e/3nVh7U1Ff+VHw6r3gaGWQ2vxSU3hIv6gGJV0ab60K3VHs95VI8EVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805056; c=relaxed/simple;
	bh=E1+S2tKKibkJs1uKrWmlUzanbBrO2nn5tWNZyaj1Pk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSYqfI0r5AiJVcNYGfa+UQEXf2LvtyD2kDJ3qU/wpd73ulzzkpMCEvAj7DYfIaGcfbqIgUjh9V+60jUpB78QIE4+KQSPgbygyVgVMgiWSkhVRfRfjbv6PyImpX2MlPnI6w5QPtjNo6eQbVplam+RV6QUp0tr1rz74FUsTEoQrGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I9rIdyy2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lmdufnX+T5nbFIZ3R27CSUmXLak9xsi6nzCl+pa5IdY=; b=I9rIdyy28QphTvIkWUG5aw1E9o
	Ty5bODu4ezasLaMp7SNJZb/JCl07HEs89l2U01C+HWp+LPqv2a+Ug8gwiY57/r37pVQ63jUDadlLS
	qRzfFWH/Z6ulCqEehEl7p2rYpH5meqarFRjRVAlsOQtCi4eHbXTynWVn+xQ55tsDe5VsZO9WKz1JR
	x2MfbIExRFldrMpkA2byVBTpBrV1Vc8uBSdMXtaK0mZVoczmRY9hKXyqAJ/sHBjFtgebcWJcxX3d7
	yHSOvwmhrLjfNM62IressxC6l+OcZrLJ+8ZZoMSWKDtDpqn0f5DqW/3XFB7h3vxiSQHWiDXInm3Sf
	IQvc+Nig==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZm6o-000000086WR-0Qm8;
	Tue, 13 Feb 2024 06:17:34 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3] drm: drm_crtc: correct some comments
Date: Mon, 12 Feb 2024 22:17:33 -0800
Message-ID: <20240213061733.8068-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some typos and punctuation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alex Deucher <alexdeucher@gmail.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
v2: s/instances/instance/ (Alex)
v3: rebase and resend;
    add more Cc:s

 drivers/gpu/drm/drm_crtc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -61,13 +61,13 @@
  * to one or more &drm_encoder, which are then each connected to one
  * &drm_connector.
  *
- * To create a CRTC, a KMS drivers allocates and zeroes an instances of
+ * To create a CRTC, a KMS driver allocates and zeroes an instance of
  * &struct drm_crtc (possibly as part of a larger structure) and registers it
  * with a call to drm_crtc_init_with_planes().
  *
- * The CRTC is also the entry point for legacy modeset operations, see
- * &drm_crtc_funcs.set_config, legacy plane operations, see
- * &drm_crtc_funcs.page_flip and &drm_crtc_funcs.cursor_set2, and other legacy
+ * The CRTC is also the entry point for legacy modeset operations (see
+ * &drm_crtc_funcs.set_config), legacy plane operations (see
+ * &drm_crtc_funcs.page_flip and &drm_crtc_funcs.cursor_set2), and other legacy
  * operations like &drm_crtc_funcs.gamma_set. For atomic drivers all these
  * features are controlled through &drm_property and
  * &drm_mode_config_funcs.atomic_check.

