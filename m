Return-Path: <linux-kernel+bounces-36369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 949AE839FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F121C211AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA55251;
	Wed, 24 Jan 2024 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSot2sfZ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32B5244
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065212; cv=none; b=SWftObUa7ZRiQy16wyaRfLnWFI2bVoSr20K0bKD9fmHQNIU9cWNC0lduq2YgYttqs3y+0V4E1NqVEIeohkDdUz+uw3FoMiJ3sh6pVSHsMdqX85Ok3xDqa0XAIQTGHk3noDIv4XT6RtLVXk9UThufeowzDKaxAVoumkrV7CsSvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065212; c=relaxed/simple;
	bh=0DGzwexjLclMIj2G+51Iqdi2yzqVqG67+wo+Tos3BnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzvq5oAwrmkXbyR9xc9qS5oRIoQm8MMkqlk/cU7UBCAGWei29tALC4xp1kCgCg3Ar2QW/DyfNCI0guYj3iZXOh/gpxIGn+ESmZnMVoUPpb/54lhewSbyrHRH4AjwBcyWIPr8UjDyjxM3sAKSw6/nDAiMr6Npt9mUM9Q9i7A/+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSot2sfZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337d90030bfso4362984f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065208; x=1706670008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1360rsVcUfkyEFKvnwoRZUEjTgSXHZgyaxAgVpcjy0=;
        b=ZSot2sfZpY5GhcEETJzg9zh3WDBofy3CPBnFgLV0lKYea+DsNtja5SRiAOJtL5+FwQ
         BerBo+TDuh8Svi3vQfLR4D7DeAHeHheyBz9DyJozPEuGku926a8JL1UvZyHyRV103aHC
         GYU3zh/vhbrxYNx9UWhcitiAIzRqNln1sXqntUN2ioxd0FcUZ7J6nlH3G31NobufcOtl
         fGWmWOtptlnJFurBaxRU2FeqFE2uP/X/TRJ7XckVBH7lOOW0Fl/8Hq+E4lZPI51g3Nqo
         WnQtql2qd6197UP0FV3UIQ0Zx5eTOygcxU7fBs61Hj1r++V7qsBgn/GA5s0hE+f5Dlm+
         KHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065208; x=1706670008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1360rsVcUfkyEFKvnwoRZUEjTgSXHZgyaxAgVpcjy0=;
        b=TGW1I6x0PDf5Y48iz2/n1YogdVjnKqutlz2ZGNU+IyZwNY18W8mBE/u3VN/LqaXbvv
         unvwvB+tEdQEhXKbaYT2w6nFoOhe5gt8dJVBr2T3aVkhxhO7Bk+UaAQyo7dkzDinNJ7i
         Z9jXs9vCwE7IDfSHfsfjSjvBlWycvFw5aK13UZCafr5podsn2+zyeEjCN77orOuF+7YJ
         xroakIm6DHnqKyyqXbPNUo/fgYAk2pCFfg+/lLq2XWK6Nzvn2cOg64kdT89auot7zKCn
         STQI5cvkweyOxU0f4zbKl25X5mAk8QqiRuN1Knhv4EXhr3oAlWpz4FhQvuEpHvPoJRvP
         8Oxg==
X-Gm-Message-State: AOJu0Yytxjo3kziOVhEyRTQaJVRx0k+8uJRfdlH69Vv7wkHMmdjOokE4
	k2sJNzLu2aiBf7Ib+yRW+zNgCkGD+ZgD/EUWVUA7znZLkLYqNKVP
X-Google-Smtp-Source: AGHT+IFNvK8jVLAW43M53dxq/xZnF+II50JMUfdmJD7TTTDRnFU0EbdDhlFtmzEGVNhr51i6+nNWzg==
X-Received: by 2002:a7b:c350:0:b0:40e:88b1:95be with SMTP id l16-20020a7bc350000000b0040e88b195bemr603402wmj.304.1706065208438;
        Tue, 23 Jan 2024 19:00:08 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:07 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v2 0/8] drm/lima: fixes and improvements to error recovery
Date: Wed, 24 Jan 2024 03:59:39 +0100
Message-ID: <20240124025947.2110659-1-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v1 reference:
https://patchwork.kernel.org/project/dri-devel/cover/20240117031212.1104034-1-nunes.erico@gmail.com/

Changes v1 -> v2:
- Dropped patch 1 which aimed to fix
https://gitlab.freedesktop.org/mesa/mesa/-/issues/8415 .
That will require more testing and an actual fix to the irq/timeout
handler race. It can be solved separately so I am deferring it to a
followup patch and keeping that issue open.

- Added patches 2 and 4 to cover "reset time out" and bus stop bit to
hard reset in gp as well.

- Added handling of all processors in synchronize_irq in patch 5 to
cover multiple pp. Dropped unnecessary duplicate fence in patch 5.

- Added patch 7 in v2. After some discussion in patch 4 (v1), it seems
to be reasonable to bump our timeout value so that we further decrease
the chance of users actually hitting any of these timeouts by default.

- Reworked patch 8 in v2. Since I broadened the work to not only focus
in pp anymore, I also included the change to the other blocks as well.

- Collected some reviews and acks in unmodified patches.


Erico Nunes (8):
  drm/lima: reset async_reset on pp hard reset
  drm/lima: reset async_reset on gp hard reset
  drm/lima: set pp bus_stop bit before hard reset
  drm/lima: set gp bus_stop bit before hard reset
  drm/lima: handle spurious timeouts due to high irq latency
  drm/lima: remove guilty drm_sched context handling
  drm/lima: increase default job timeout to 10s
  drm/lima: standardize debug messages by ip name

 drivers/gpu/drm/lima/lima_ctx.c      |  2 +-
 drivers/gpu/drm/lima/lima_ctx.h      |  1 -
 drivers/gpu/drm/lima/lima_gp.c       | 39 +++++++++++++++++++++-------
 drivers/gpu/drm/lima/lima_l2_cache.c |  6 +++--
 drivers/gpu/drm/lima/lima_mmu.c      | 18 ++++++-------
 drivers/gpu/drm/lima/lima_pmu.c      |  3 ++-
 drivers/gpu/drm/lima/lima_pp.c       | 37 ++++++++++++++++++++------
 drivers/gpu/drm/lima/lima_sched.c    | 38 ++++++++++++++++++++++-----
 drivers/gpu/drm/lima/lima_sched.h    |  3 +--
 9 files changed, 107 insertions(+), 40 deletions(-)

-- 
2.43.0


