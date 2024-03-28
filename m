Return-Path: <linux-kernel+bounces-122984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103248900AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A351C28ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D78172E;
	Thu, 28 Mar 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASfoX7nY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2667651AE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633492; cv=none; b=X60e5cmzPTjo9wKcahstKg13wbwnQoqwEneHeQ64KurhynIbVz/u226B0ntj1k7bXmkkdMBicZ4cF2EywxJhgv3cHH4F4I4HDEG42B7XKFCLCnKdYyBMM5oqU+s8fTINxy7mBlrSVQWqlsM4qiGxSCe3IeA5JlDQb1hlaW/qSXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633492; c=relaxed/simple;
	bh=1b0kDwcvNj5vH5K0pAK4HupQheat89mZSwQWjzdBGDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQ597jsuSHDOx3cUrXfZvdKdZt5l7bQR9SKfzD4DN5zRpmRzrzfs0usvXYJwRAEQ2bd/gTREgi7C85wo+tkcJ0nWM81bbZghJqlzsWzXhwLSfNknMd/uOjx3PPODNkqN5kKIGjOpdDfzzdWmowVbd1H0BmUwBpMM60DDxjt0cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASfoX7nY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e25afabaso979276e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711633489; x=1712238289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0ld9ottGtMP3PSLHeDCuhhunV2RKSWGGUbt6pNFLTE=;
        b=ASfoX7nYjpQbJfFxFU/oJWW8pxd61ieqf8IUmgk7aFcdkycZg4nspm7XOWgoOy1nQw
         LAkAwkg+SaJv/IC9uvo3WEEC/p2W52+y37fRQF+qK2keUNdvPflQ+PxI7pzixmBp6bxG
         vs6txCKb+oLPfq/AKeiJ40dtn7kvOft2vfUP+QUmqE7N071sOyvZjQixvFKqDPZaePtA
         wdlKdB9+BJVTK5G4kCkNcWzaSnpWwG5k9CVaQjczRgImiaapkhoxxlVQ1u1qI5+oIylv
         Q5+m21Ls5DMdoSrelILEHrVPXCIlhKteOhQDoS04IaNzmKx7E5R1DrxRC/4zcyQ1uXHb
         BKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633489; x=1712238289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0ld9ottGtMP3PSLHeDCuhhunV2RKSWGGUbt6pNFLTE=;
        b=SX7vOsRaAb1NWZ0BROkbtc2/FFNkJW0EtUMHjxNwDuNRyMYvz3xIswKxKuU+bY+KWb
         bDsXqwWLWB6EHUEvTDB6c7HpH4UbqxKpvKs+hKWv9d+1m2oGuLCgdzAHAfRKWptMgRjf
         wVSPHWbOEba/yUjBdlOHidO1noMjakXD4ko7phd8I/qw8Qhie0MwH4RQGEDCkC+T/73S
         /o32e+q9WgLKXAEMo7gy1A9nZynWXLzA4yQvNU0qtA1Hp6JcZiYSK0wmqzCva+99h4kk
         fBRNR1eJsCjB2iHo6Woiy9FxlhiWY2bKYDfcG96HEK9OvxPmXtPvLKgd0s2Vb7T+gNXC
         pqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXDJLS6gSXlt7vgmprpfmwsajk2U6utGJkqEiI5neUwIuuigG/wYL/0gzTtd9vhplIX0Qd/x+se4RTHqZ+RJRjz8/gpZOTe7KTSA/k
X-Gm-Message-State: AOJu0YxCLdbLam+hY4njtuY/qX7MTXISqreXLnkBX+FNcMBoM+882OA4
	RihnECXF8q7iscu8UrWGyk05chxVPQgdrEdzoGarsaxAODVxQHI4
X-Google-Smtp-Source: AGHT+IGgUYdZXvk1Jxa+qm2IRi+ZxbQKQ2cbC6z+k22XLHpAg517MrIY7J9tdrqnczVNq3X2Isc3Jw==
X-Received: by 2002:ac2:4642:0:b0:513:bf6e:bf05 with SMTP id s2-20020ac24642000000b00513bf6ebf05mr1858320lfo.14.1711633487520;
        Thu, 28 Mar 2024 06:44:47 -0700 (PDT)
Received: from localhost.localdomain ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id b26-20020ac247fa000000b005159b7007aesm212501lfp.153.2024.03.28.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:44:47 -0700 (PDT)
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
To: David Airlie <airlied@redhat.com>
Cc: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Emil Velikov <emil.velikov@collabora.com>,
	Ivan Kapranov <i.kapranov@securitycode.ru>,
	lvc-project@linuxtesting.org,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: add driver_priv validation in virtio_gpu_create_context
Date: Thu, 28 Mar 2024 16:43:51 +0300
Message-Id: <20240328134351.298050-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer file->driver_priv was dereferenced without checking
against NULL, but in the "virtio_gpu_transfer_to_host_ioctl" function
it was checked against NULL after calling virtio_gpu_create_context
function.

Found by Security Code and Linux Verification Center(linuxtesting.org)
Fixes: 72b48ae800da ("drm/virtio: enqueue virtio_gpu_create_context after the first 3D ioctl")
Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e4f76f315550..98fe9ad4ed15 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -64,6 +64,9 @@ void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *file)
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 
+	if (!vfpriv)
+		return;
+
 	mutex_lock(&vfpriv->context_lock);
 	if (vfpriv->context_created)
 		goto out_unlock;
-- 
2.34.1


