Return-Path: <linux-kernel+bounces-18068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA982584D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A2E1F22231
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6132189;
	Fri,  5 Jan 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="psSPelBj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461F3174D;
	Fri,  5 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4T68Hj1sK7zDr6k;
	Fri,  5 Jan 2024 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704472625; bh=dto22OSKCDdtMynGtCMenjBTuSfI06aVdQbcRVthelc=;
	h=From:Subject:Date:To:Cc:From;
	b=psSPelBjBMvGJYNGNSmL/KD7UV13PoO7Lq3uIpofR4ukuTS+3TkeHwq1/zW2In25I
	 OqP/ktsGN7QJjLrxjtZ5K+Zk+BKrdwaBAflMuvEcJw0rhW3QcJVgC7Bq4cWmLx7qv9
	 w87piCkbRFJxP4oG6bBSYsM5G7Sb8oRdswRQkrdU=
X-Riseup-User-ID: B89E1D0CDEC478BF436778FAF2FE9B7504FC53DF26383DAC85D557215E91741D
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4T68HP0DTBzJp9w;
	Fri,  5 Jan 2024 16:36:48 +0000 (UTC)
From: Arthur Grillo <arthurgrillo@riseup.net>
Subject: [PATCH 0/7] Add YUV formats to VKMS
Date: Fri, 05 Jan 2024 13:35:01 -0300
Message-Id: <20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUvmGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyMz3bLs3GLdytIyXbM0cwtTyzRjo5Q0CyWg8oKi1LTMCrBR0bG1tQC
 eBc6gWgAAAA==
To: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Arthur Grillo <arthurgrillo@riseup.net>

This patchset aims to add support for additional buffer YUV formats.
More specifically, it adds support to:

Semi-planar formats:

- NV12
- NV16
- NV24
- NV21
- NV61
- NV42

Planar formats:

- YUV440
- YUV422
- YUV444
- YVU440
- YVU422
- YVU444

These formats have more than one plane, and most have chroma
subsampling. These properties don't have support on VKMS, so I had to
work on this before.

To ensure that the conversions from YUV to RGB are working, I wrote a
KUnit test. As the work from Harry on creating KUnit tests on VKMS[1] is
not yet merged, I took the setup part (Kconfig entry and .kunitfile)
from it.

Furthermore, I couldn't find any sources with the conversion matrices,
so I had to work out the values myself based on the ITU papers[2][3][4].
So, I'm not 100% sure if the values are accurate. I'd appreciate some
input if anyone has more knowledge in this area.

Also, I used two IGT tests to check if the formats were having a correct
conversion (all with the --extended flag):

- kms_plane@pixel_format
- kms_plane@pixel_format_source_clamping.

The nonsubsampled formats don't have support on IGT, so I sent a patch
fixing this[5].

Currently, this patchset does not add those formats to the writeback, as
it would require a rewrite of how the conversions are done (similar to
what was done on a previous patch[6]). So, I would like to review this
patchset before I start the work on this other part.

[1]: https://lore.kernel.org/all/20231108163647.106853-5-harry.wentland@amd.com/
[2]: https://www.itu.int/rec/R-REC-BT.601-7-201103-I/en
[3]: https://www.itu.int/rec/R-REC-BT.709-6-201506-I/en
[4]: https://www.itu.int/rec/R-REC-BT.2020-2-201510-I/en
[5]: https://lists.freedesktop.org/archives/igt-dev/2024-January/066937.html
[6]: https://lore.kernel.org/dri-devel/20230414135151.75975-2-mcanal@igalia.com/

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
Arthur Grillo (7):
      drm/vkms: Use drm_frame directly
      drm/vkms: Add support for multy-planar framebuffers
      drm/vkms: Add range and encoding properties to pixel_read function
      drm/vkms: Add chroma subsampling
      drm/vkms: Add YUV support
      drm/vkms: Drop YUV formats TODO
      drm/vkms: Create KUnit tests for YUV conversions

 Documentation/gpu/vkms.rst                    |   3 +-
 drivers/gpu/drm/vkms/Kconfig                  |  15 ++
 drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 151 ++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.h               |   6 +-
 drivers/gpu/drm/vkms/vkms_formats.c           | 250 ++++++++++++++++++++++----
 drivers/gpu/drm/vkms/vkms_plane.c             |  26 ++-
 drivers/gpu/drm/vkms/vkms_writeback.c         |   5 -
 8 files changed, 411 insertions(+), 49 deletions(-)
---
base-commit: 0c75d52190b8bfa22cdb66e07148aea599c4535d
change-id: 20231226-vkms-yuv-6f7859f32df8

Best regards,
-- 
Arthur Grillo <arthurgrillo@riseup.net>


