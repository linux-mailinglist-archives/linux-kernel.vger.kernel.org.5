Return-Path: <linux-kernel+bounces-79714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4158625B7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03AA1C20C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C364778E;
	Sat, 24 Feb 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="L9I4meje"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0091E894
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708787174; cv=none; b=p1BwMjqmPRVgge2k1OpuvGn6B5BolgAyht6/UqCyfqrgcYgwJ+BbfKMS7Uh5IysipZ079XKUfiDWJ/ZUScOuXYNAorRtvyH6dtsv8/9VPG8bMuuI3YDmV4OdA2NxZK1LEax2qcGlLMtoM2bHYXkjt62JKa/nc6Ac9lk5Nma5+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708787174; c=relaxed/simple;
	bh=Uryo3XdwAekEHSVjuMlMntBb6I1zHeuqUQ7N7xRLv/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qkNCdSsiUgRRf1iW+ydq2WMHtzCZRE7wozxAwtaNaBddtO58Y8/hB0ILOB+mDarYW7DIH0QUJtcs5Fp0pF/ntKodGVbO7mTaQ27BnwF+ufni7iesmSqJ2Ee3UF6ndPPXuN2mzUazo0Cfovopw0tLKspes//84Td7OzRKKbjhNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=L9I4meje; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708787167; bh=Uryo3XdwAekEHSVjuMlMntBb6I1zHeuqUQ7N7xRLv/U=;
	h=From:To:Cc:Subject:Date:From;
	b=L9I4meje818PMKLYF5UA9Z980dPtZPCvuEHAL7MwqojCWJPc7xFfL2iAoX8mXD2fI
	 DeaNRvSzDJnxkEngB9cioOYKej5HrJ/2mEcDFCTHdkyh6ddvPadR/JinhQSd0GZPyh
	 yZe5GBB4MjEO5Qhzgsisj4VGB/McpYIn3o4yjQ+8=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Ondrej Jirman <megi@xff.cz>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/3] Move blender setup from individual planes to crtc commit in sun4i-drm
Date: Sat, 24 Feb 2024 16:05:57 +0100
Message-ID: <20240224150604.3855534-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

This series refactors blender setup from individual planes to a common
place where it can be performed at once and is easier to reason about.

In the process this fixes a few bugs that allowed blender pipes to be
disabled while corresponding DRM planes were requested to be enabled.

Please take a look. :)

v2:
- use regmap_write where possible
- add review tags

Thank you very much,
	Ondřej Jirman

Ondrej Jirman (3):
  drm/sun4i: Unify sun8i_*_layer structs
  drm/sun4i: Add more parameters to sunxi_engine commit callback
  drm/sun4i: Fix layer zpos change/atomic modesetting

 drivers/gpu/drm/sun4i/sun4i_backend.c  |  4 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c     |  2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 70 ++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_mixer.h    | 20 ++++++
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 85 +++----------------------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h | 20 ++----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 86 +++-----------------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 20 ++----
 drivers/gpu/drm/sun4i/sunxi_engine.h   | 13 +++-
 9 files changed, 125 insertions(+), 195 deletions(-)

-- 
2.44.0


