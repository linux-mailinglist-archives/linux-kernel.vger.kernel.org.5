Return-Path: <linux-kernel+bounces-49299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2874E84685C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA1E1F22084
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198A18658;
	Fri,  2 Feb 2024 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KmCC8OM2"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4887C18639
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856186; cv=none; b=dPojef16b88IgJtRenJ4kRJXvWcrj4wKNQhMskU70dTRt2itmmEAOg4Pj9OeUhiIRlEqzi6maDojbWA/uHPwW07hJTWieHXa60ajvuj/ynrDOrffPbY1zCKtnsB37tX/jjSvLHa3ocOCXH/wVmEXYBpbQJuuowwsPANTJ33FoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856186; c=relaxed/simple;
	bh=IeuTYvT2kSfyJRGh2TcyQfdT8Kl0+V+dExn2BrFG6SU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MsAsiUZas2JJbjE5y4AG49/oF/XleeJABZcSHp86G3093uhXL8e42pPuo6DWXeIA5V4RJceJAj+851A/twIp8rENvTaPeAw4G6SIlrn68TNs76XLJl8v2tLbBPkOG/NvyOWKFG9/oe0yC3MNSsNTrNn23J7OeBjG3BWqxmuUycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KmCC8OM2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C6F3F20B2000; Thu,  1 Feb 2024 22:43:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6F3F20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706856184;
	bh=o0pt0AvQb9QH1NVN0Ep+6Z4WzLV/a6EZfES4iiGUlsM=;
	h=From:To:Cc:Subject:Date:From;
	b=KmCC8OM2S7hF8N3oCUViQyTPIoi55pJb5EwGKN7K4YZ47h0ZEGrNIxp/xvusZqom8
	 1Lqtpe1qoUbzw5Y5PGkgmExh6VcK8kcOgymjVNH0g+/4wpgkI4SNCf/gsuLbK0Xfdq
	 dZXHWtA1OOWy7ZaA4PlqFGbAw/8w8W3jRahWpn6I=
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
Subject: [PATCH v4 0/2] drm: Check polling initialized before
Date: Thu,  1 Feb 2024 22:42:56 -0800
Message-Id: <1706856176-9483-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patchset consists of sanity checks before enabling/disabling
output polling to make sure we do not call polling enable and disable
functions when polling for the device is not initialized or is now
uninitialized(by drm_kms_helper_poll_fini() function)

The first patch consists of these checks in
drm_kms_helper_poll_disable() and drm_kms_helper_poll_enable() calls.
It further flags a warning if a caller violates this. It also adds
these checks in drm_mode_config_helper_resume() and
drm_mode_config_helper_suspend() calls to avoid this warning.

The second patch adds a similar missing check in
drm_helper_probe_single_connector_modes() function that is exposed by
the new warning introduced in the first patch.

Shradha Gupta (2):
  drm: Check output polling initialized before disabling
  drm: Check polling initialized before enabling in
    drm_helper_probe_single_connector_modes

 drivers/gpu/drm/drm_modeset_helper.c | 19 ++++++++++++++++---
 drivers/gpu/drm/drm_probe_helper.c   | 21 +++++++++++++++++----
 2 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.34.1


