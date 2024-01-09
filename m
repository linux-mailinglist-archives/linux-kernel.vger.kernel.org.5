Return-Path: <linux-kernel+bounces-21218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6944828C31
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80804287B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D723C49E;
	Tue,  9 Jan 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="DLZpnq6h"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B023BB3F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso3954328e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704823876; x=1705428676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/P8n3FbWL68F6TxA0R2WkA/gfn2dX46Rf9mM5caQ3iY=;
        b=DLZpnq6h0S5ot4HaRwNCSG5/wYihZfKLQToZV9DgsbPPpiE6QHHEzNwXkyMRFeoC2U
         G+1mN1P+ZszK0TmDRh3btUJBYPL7qsdFDa6y+wQ1WvcXixhi1nwAC5wk2Bgo7i6n8VML
         vtls4YmkUcahVDGvFA07MjA22wOqVFoPZZNng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823876; x=1705428676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/P8n3FbWL68F6TxA0R2WkA/gfn2dX46Rf9mM5caQ3iY=;
        b=mJQwCeV8lq2cVy7qE2lyDu0siHAT8bXuRtH+VkC83vdegB0dwR/GCR7UonBXb4AF7l
         C65Jdl1hfPPeUTAhP6dFyphQ1RHDL2EEiorpivmf0XoQydWXlaZORqFipEANjK4TWfiR
         JSf9HdzOlYyXfBk9+DD19y94Ka7bJrFivTtlPAead/Slxn95QjGD1ZjjbNSr+gWCRvAI
         6t/qlAdCJF6zSowj6hoo2BEz87LGDxyQtt5vhJ3j58ShM+CQq34LQO8ammsHOvTe4GfF
         6xqlK5Xbr3vdZFrrODrRLVZgVV/LSqZXTr9iCOxO+QCvAPSNE6syZzLnbfazOpDn9aGy
         VBOA==
X-Gm-Message-State: AOJu0YzAojnogaT8e2YDNbsopGCPhBvNfhFWKKKAQ5WXUiglfYasPEq5
	HMXROpzpfl4DWbwkZsKjSODhi4+RufvLUg==
X-Google-Smtp-Source: AGHT+IHhF9LaN3kubE12wa/Q1/CdohNcShPSp8gh5kvPO8qnqS9yArqftswDYKp4dF2WmIezKVMLgw==
X-Received: by 2002:a05:6512:3d0c:b0:50e:a6f8:aacf with SMTP id d12-20020a0565123d0c00b0050ea6f8aacfmr3282849lfv.14.1704823876174;
        Tue, 09 Jan 2024 10:11:16 -0800 (PST)
Received: from andri-workstation.turninn.appdynamic.com ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
        by smtp.gmail.com with ESMTPSA id n25-20020a05600c3b9900b0040e527602c8sm2104579wms.9.2024.01.09.10.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:11:15 -0800 (PST)
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
Subject: [PATCH 0/7] New DRM properties for output color format
Date: Tue,  9 Jan 2024 18:10:57 +0000
Message-ID: <20240109181104.1670304-1-andri@yngvason.is>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a subset of patches, originally submitted by Werner Sembach
titled: New uAPI drm properties for color management [1]

I've rebased against the current master branch, made modifications where
needed, and tested with both HDMI and DP on both Intel and AMD hardware,
using modified sway [2] and wlroots [3].

The original patch set added the following properties:
 - active bpc
 - active color format
 - active color range
 - preferred color format
and consolidated "Broadcast RGB" into a single property.

I've elected to only include active and preferred color format in this
patch set as I've very little interest in the other properties and,
hopefully, this will be easier for others to review.

[1]: https://lore.kernel.org/dri-devel/20210630151018.330354-1-wse@tuxedocomputers.com/
[2]: https://github.com/swaywm/sway/pull/7903
[3]: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/4509

Werner Sembach (7):
  drm/amd/display: Remove unnecessary SIGNAL_TYPE_HDMI_TYPE_A check
  drm/uAPI: Add "active color format" drm property as feedback for
    userspace
  drm/amd/display: Add handling for new "active color format" property
  drm/i915/display: Add handling for new "active color format" property
  drm/uAPI: Add "preferred color format" drm property as setting for
    userspace
  drm/amd/display: Add handling for new "preferred color format"
    property
  drm/i915/display: Add handling for new "preferred color format"
    property

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  75 ++++++++++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   8 ++
 drivers/gpu/drm/drm_atomic_helper.c           |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
 drivers/gpu/drm/drm_connector.c               | 111 ++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_display.c  |  33 ++++++
 drivers/gpu/drm/i915/display/intel_dp.c       |  23 ++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  10 ++
 drivers/gpu/drm/i915/display/intel_hdmi.c     |  16 ++-
 include/drm/drm_connector.h                   |  27 +++++
 10 files changed, 289 insertions(+), 22 deletions(-)


base-commit: 1f874787ed9a2d78ed59cb21d0d90ac0178eceb0
-- 
2.43.0


