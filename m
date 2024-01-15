Return-Path: <linux-kernel+bounces-26218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110782DCF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C5282B18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940AD18032;
	Mon, 15 Jan 2024 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="MB/UucWH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2CC18027
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7fce1abcso4555685e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1705334797; x=1705939597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nfzXYtohis0OwCD+AmIl/qoZqPN5SyFIj+AeVDGrUY=;
        b=MB/UucWHIgdmBPWYysmxSDp7a694aYDXbyKd/OIIfjY64MRdzyah4eKp706ARhzRSa
         zG9uoiOjn1oTfUs58ZQDjshgTl/Oej2cVIrBYxvCepBNY/y+KnfcOCpCqyUEp14QJzwL
         XjGVt1whaZTVPl85Se2yWyuCiDz9lDtixo96M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334797; x=1705939597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nfzXYtohis0OwCD+AmIl/qoZqPN5SyFIj+AeVDGrUY=;
        b=XGLG9ME1RYHnK/Oev/hy6vbT9j79JRVN9ns/nRJ6B3fpJweLAF5S1yOidrBHQqSlbH
         DLO02U5zNW7vtWNqUA2iwfgyS7r/gb8/J2ZgORs2AhjWzhaRpix/K3DQlZmn21Qn34K0
         GoIoCIPpaUrIZEMd1IfGZKoX0gxHEO/QsUlVfRN/hbrjekqt3oPKn3m2IDZ5ryrsXh1R
         Ekrd3hEu2wM5WzHFkb/rXnnSLSkSd+Dk3KEaU4NtbzdmiQ1pVcPU8jABAzfhxj6MU6Od
         mK7sljHGCdtyr5LXMoSGU3qMxzjqjz51ekiky4Rphfm+PwU0IMmxUjh1trpHjXtH2Pi+
         yruQ==
X-Gm-Message-State: AOJu0YyTz9pPtBJqg1RiH5VwRL/fBKwqk1LmWOLUVDDJ/GAfBc2RM/EB
	zGjCaDw3m8HBwnF4g+ujK1aDFGiPW7gq0A==
X-Google-Smtp-Source: AGHT+IEUUc5iRjuXbMJ2dngkv+RJCZlkEQjqC7ossePXJRfMhg+lS/5kV7bU5iCCs/lMM5nEnzQUkw==
X-Received: by 2002:a7b:cbc7:0:b0:40e:6707:b758 with SMTP id n7-20020a7bcbc7000000b0040e6707b758mr2317948wmi.178.1705334796754;
        Mon, 15 Jan 2024 08:06:36 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b0040d6b91efd9sm20174140wmq.44.2024.01.15.08.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:36 -0800 (PST)
From: Andri Yngvason <andri@yngvason.is>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Simon Ser <contact@emersion.fr>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Andri Yngvason <andri@yngvason.is>
Subject: [PATCH v2 0/4] New DRM properties for output color format
Date: Mon, 15 Jan 2024 16:05:50 +0000
Message-ID: <20240115160554.720247-1-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After some discussion, we decided to drop the "active color format"
property and rename the "preferred color format" property to "force
color format". 

The user can probe available color formats in combination with other
properties using TEST_ONLY commits.

v1: https://lore.kernel.org/dri-devel/20240109181104.1670304-1-andri@yngvason.is/

v2
 - Dropped "active color format"
 - Replaced "preferred color format" with "force color format"


Werner Sembach (4):
  drm/amd/display: Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check
  drm/uAPI: Add "force color format" drm property as setting for
    userspace
  drm/amd/display: Add handling for new "force color format" property
  drm/i915/display: Add handling for new "force color format" property

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 67 ++++++++++++++++---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++
 drivers/gpu/drm/drm_atomic_helper.c           |  4 ++
 drivers/gpu/drm/drm_atomic_uapi.c             |  4 ++
 drivers/gpu/drm/drm_connector.c               | 48 +++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c       | 35 ++++++++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  5 ++
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 29 ++++++--
 include/drm/drm_connector.h                   | 16 +++++
 9 files changed, 190 insertions(+), 22 deletions(-)


base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
-- 
2.43.0


