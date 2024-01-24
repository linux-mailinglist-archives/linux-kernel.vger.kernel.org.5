Return-Path: <linux-kernel+bounces-36840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3516383A796
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01B51F2613D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1A1AAD4;
	Wed, 24 Jan 2024 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZqCWq7e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE11AACA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095181; cv=none; b=ZoavDOmjmGlP9Isd0AAmGPbG9xs97zSn0nZLM4HJbBO2F8sDw+qdn/5Tz2fuwrhyhVmSWyQ5Kp0xMQYcdv++D19R7kNplTLLSAGfj7fAWTfogyByU2+QvyN3YxqFnTjSu+9xu7RGJ8tKk4OESnqfeaDyYauxYWvJ49rCjiBxq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095181; c=relaxed/simple;
	bh=exF1qXGKYskZom0x21RTewAyP5aHcW/MBt7fN555E7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdSHqmyhOaPq2MW/7sSxzeHHk7mPfpccHbgPso/HLoN2wD+p0hxWZIvDTFFvcgXn8ZjfgFsNLh7vqLdnAy8H6ND6VGIDg2dYRBvFVwh3CqgHpK80ZZTp1eyWQbgPfQOcBZOvfWD5Q38GPYTAJWOw4VVVe3Xbh8kpwZYfnnMoxiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZqCWq7e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706095178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Tdg6Pxwo5yb88aEPcd5SX3GxtpgWjx+EchJ6YmUkm4=;
	b=IZqCWq7eccGSNjjnjoimtbaaMDVyPofHUIW+F+B5A2RmrTa/E3AiUg/ylz7RIWzTlOgLLC
	5k7dZEruACX9ovrH0PUmaTDpUKVRTT9FkF9NpqnSmvnrCA00JehRprKXfLdb2rVSKbYtYE
	APsQBfcbSqongdN6+p9Dbl7nuF7/P3Y=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-LXFs8guYN2ST3etikcoKRw-1; Wed, 24 Jan 2024 06:19:37 -0500
X-MC-Unique: LXFs8guYN2ST3etikcoKRw-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-469be81ec74so537150137.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095177; x=1706699977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Tdg6Pxwo5yb88aEPcd5SX3GxtpgWjx+EchJ6YmUkm4=;
        b=vZ5a4+/8se8xGLayowS+lHZdRYDnJ4HTHYhY47ndRqheZCLzZPOjkPPDwIaQyk/uUg
         OzNRalxtYKP++rBbjNNpMx/Bf6IHZKvZPmgusQdJXYexuhJ7vC+tbBJMi/BF96u2IS1V
         ZEJNoEegU/VZJX1H/y1UD1xkxXAcUhcn4k4Loe+NQsM+7KrFYSYJXjcA+6lWSNu0S7TX
         pgRTKOv6RLmnTmxXkWY9zos3MiDw1mQzxhuL1uFpzZDmNtmpBimWGb03Vdj4bLXJYa/4
         T3hfVoaI/ROjcBKR5l+1v3hTq4+qQxzQqZP8GiTgAKKBwaiL8KG9FKmQBZ2h0yajcZFK
         ksWQ==
X-Gm-Message-State: AOJu0Yzr4w++8ibyAWmZeEzYBZk6qDOwiC4FOOFGK2xx4M8FIp0z/kJe
	Pktk5uiGsBxHM4uPRdHA3g4+yteIaJkexNQbuGpngXiapMA9gsZBrVMQlcegp/7SS73+kSyUNDl
	a/RqpS8XnLnPDTqaUMlTLy9S/c5sqZUfcJDgL0ce79AmOMGb0Jt/WuCbWUNOFkA==
X-Received: by 2002:a67:cf4d:0:b0:469:aec1:b425 with SMTP id f13-20020a67cf4d000000b00469aec1b425mr1668111vsm.3.1706095176866;
        Wed, 24 Jan 2024 03:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfq/53hwK5W6EYfpAy/CIrTd6ajQQRINtlI/Tva0zppHFqHuvfSChD8fb6zOGYnC6pXS//nA==
X-Received: by 2002:a67:cf4d:0:b0:469:aec1:b425 with SMTP id f13-20020a67cf4d000000b00469aec1b425mr1668087vsm.3.1706095176567;
        Wed, 24 Jan 2024 03:19:36 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ql3-20020a056214540300b00686aa6dbcbfsm1027016qvb.81.2024.01.24.03.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:19:36 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v4 0/2] drm/imx/dcss: implement region request and devres
Date: Wed, 24 Jan 2024 12:19:03 +0100
Message-ID: <20240124111904.18261-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

@Laurentiu:
Thank you very much for the review. I was indeed on an older branch. As
Linus's master is currently broken for ARM64 [1], unfortunately, I built
it instead against:
60096f0a77600ac2cc92b82fee279d1905576950

Hope that's fine.


Changes in v4:
- Add Laurentiu's Reviewed-by to patch #1
- Remove unnecsseray struct device pointers from all touched files
- Rebase against newer kernel due to changes in dcss_drv_platform_remove()

Changes in v3:
- Fix build errors (missing variable, forgotten remove to call of deleted
  function)

Changes in v2:
- Add the region-request to this patch-series. That was previously a
  separate patch.

dcss currently does not request its memory resource. This series adds
that request with devres. As we're at it, it also ports all the ioremaps
and associated allocations to devres.

I can build this, but I don't have the hardware available to test it. So
you might want to have a closer look.

P.

[1] https://lore.kernel.org/lkml/45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop/


Philipp Stanner (2):
  drm/imx/dcss: request memory region
  drm/imx/dcss: have all init functions use devres

 drivers/gpu/drm/imx/dcss/dcss-blkctl.c | 13 ++-----------
 drivers/gpu/drm/imx/dcss/dcss-ctxld.c  | 14 +++-----------
 drivers/gpu/drm/imx/dcss/dcss-dev.c    | 19 +++++++++----------
 drivers/gpu/drm/imx/dcss/dcss-dev.h    |  1 -
 drivers/gpu/drm/imx/dcss/dcss-dpr.c    | 21 +++------------------
 drivers/gpu/drm/imx/dcss/dcss-drv.c    | 12 +++---------
 drivers/gpu/drm/imx/dcss/dcss-dtg.c    | 26 +++++---------------------
 drivers/gpu/drm/imx/dcss/dcss-scaler.c | 21 +++------------------
 drivers/gpu/drm/imx/dcss/dcss-ss.c     | 12 +++---------
 9 files changed, 31 insertions(+), 108 deletions(-)

-- 
2.43.0


