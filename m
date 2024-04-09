Return-Path: <linux-kernel+bounces-136427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BA189D3F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512561F25817
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF327F7FE;
	Tue,  9 Apr 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zs0vQ4G4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE17F498
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650482; cv=none; b=tgzCmJNYOMYuZfFHh2xFxIHLFYQRzKB/TN0FG0gQueoZcC2rT9b2LA1YpuH0nyq8/wq+B0UcaZfY509cfzq0xuO5EhrFofOqe+uJ/v1es0sVjXzP75lViqH/rsOm+76oCrkQz0F8yMAZe30onmLFKC9qWqRc7vkjTAhcuRkO5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650482; c=relaxed/simple;
	bh=j3Fq9MRz+jphMARU643d4Ieg05IzjOi2gL8iIE3YmvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZrTNRg7UQ2J6ULgYvXBCX98g+NZUmaX94+2bEty2xVxU5I7rzuAVFlTjmETHye0O03MRR1y3vELxKRqBI69GJc6vImUQLebUIwoduUHCF4mqQ+eCP85qnAiv6frRJ1HbTA5olQp9CBmrx77HmXY7H+mUO1asQRJYwcpJxk408Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zs0vQ4G4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712650479;
	bh=j3Fq9MRz+jphMARU643d4Ieg05IzjOi2gL8iIE3YmvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zs0vQ4G4UKegKiGfjNZyZDA5qTFXRsOHZ9K9448wO5mzMzwwPVdqoFqyfo4OuXPsp
	 rZis5/wj5CVS4S6EKu1nEqPMeumvAArLU6qcvLK0J8YlP+SZUr7KXqRn4lLTTuvuwA
	 B5wiI4CSD+Gx7l67vd/wGynSupG/v1ReGSL5bqkQW+6Jd9SCAhXcVskphzag+4aUjz
	 ACq0yyVQ6saTSM0nrOiwfP2fQLXV3ZuQo3VmGyTpyrFGJLIZ5LtSjzMOSHiPiOGQiL
	 Rwdua/1aWRUCE5j4l/yxSBv1xqtH5rK9DxIpOz2IKM+bm6W1cPlcqGEaBQq8tUp1s/
	 M5rUjVQQbNDZg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 680E537820E2;
	Tue,  9 Apr 2024 08:14:35 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	emma@anholt.net,
	robdclark@gmail.com,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	hamohammed.sa@gmail.com,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	mairacanal@riseup.net,
	mcanal@igalia.com,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] drm/ci: mediatek: add tests for powervr gpu driver
Date: Tue,  9 Apr 2024 13:43:26 +0530
Message-Id: <20240409081329.472463-6-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409081329.472463-1-vignesh.raman@collabora.com>
References: <20240409081329.472463-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For mediatek mt8173, the display driver is mediatek, while the
gpu driver is powervr. Currently, in drm-ci for mt8173, only the
display driver is tested. Add support in drm-ci to test powervr
driver for mt8173. Powervr driver was merged in linux kernel,
but there's no mediatek support yet. So disable the powervr:mt8173
job which uses powervr driver.

Also update the MAINTAINERS file to include xfails for powervr driver.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v6:
  - New patch in the series. Split powervr changes into a new commit. 

---
 MAINTAINERS                      |  1 +
 drivers/gpu/drm/ci/gitlab-ci.yml |  1 +
 drivers/gpu/drm/ci/test.yml      | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 333704ceefb6..92afa7b4f3dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10479,6 +10479,7 @@ S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/gpu/img,powervr.yaml
 F:	Documentation/gpu/imagination/
+F:	drivers/gpu/drm/ci/xfails/powervr*
 F:	drivers/gpu/drm/imagination/
 F:	include/uapi/drm/pvr_drm.h
 
diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 9df55dc45173..5345a970f0b5 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -112,6 +112,7 @@ stages:
   - msm
   - rockchip
   - panfrost
+  - powervr
   - virtio-gpu
 
 # YAML anchors for rule conditions
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 959157449e4e..27930e29aabc 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -292,6 +292,11 @@ amdgpu:stoney:
   variables:
     DRIVER_NAME: mediatek
 
+.powervr-gpu:
+  stage: powervr
+  variables:
+    DRIVER_NAME: powervr
+
 .panfrost-gpu:
   stage: panfrost
   variables:
@@ -320,6 +325,15 @@ mediatek:mt8173:
     - .mt8173
     - .mediatek-display
 
+powervr:mt8173:
+  extends:
+    - .mt8173
+    - .powervr-gpu
+  rules:
+    # TODO: powervr driver was merged in linux kernel, but there's no mediatek support yet
+    # Remove the rule once mediatek support is added for powervr
+    - when: never
+
 mediatek:mt8183:
   extends:
     - .mt8183
-- 
2.40.1


