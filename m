Return-Path: <linux-kernel+bounces-105849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE9587E56D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948751F2257F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21D12C1A6;
	Mon, 18 Mar 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzKFBaMl"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199828E39
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753051; cv=none; b=jAOaoip6/4sj7WZ6BdFIY7TZOksHjW9tGBnZU2Bbb42ZXrUWCVuKswJ6K1x25pYwK+rQhKqMRhABQQYPKP+qQ1RAF0BCVyyVZWP8NPPMoN4MymhtWxybSPIdh8w/JIckM+9k8PXzdh5CClBYUEjTKPNC2sQN3vwPMVPJOPOcUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753051; c=relaxed/simple;
	bh=AEbkWv6kVBRVdwmlsE4qnTwSVZJF80FknKhy9jehwtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6enYJb4aHmWFdkiH7fGPcd6JH75V0litrOoltyGbkWxMSENnnirILluWgLMmk3XaL6h6fwgnTmetAZZqL8MbhApYiSYlRM4Cbx9d7J75d7n9nPN3+cgSzkJ17QKwvhkAbt2hqaf/JHcIWVO0Tc85DeawC7ke9SR3lawvk0fx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KzKFBaMl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e02f839d66so2311805ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710753049; x=1711357849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4k9PEqyseGl9R4Xjb6sD+hX6x38ZM1eW1FtX5qGx6w=;
        b=KzKFBaMlzKYWVEecTgl6+zS1C1GBaLw8J4SCZkaiep3/3cvwtaeRHoB2VFNOeh7p+S
         QWWNMPfA5zhudh82cqLrvv8U2FpT00C0ZmXXBsTbNSlH98c53yLKthbYRbRKViVYTUsM
         gwmvqG8mYQ7Xo1K8k0GE/954yDHbnQ1pOvPas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753049; x=1711357849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4k9PEqyseGl9R4Xjb6sD+hX6x38ZM1eW1FtX5qGx6w=;
        b=QZkYwrQoUkQF9+QRR7PkOeC+o6ytXFRg/h4Pl8rf7UjkJwNE9OYLGiK8VSpE2WFVNy
         uZPzNk/OQfqqogdB0BHaaATkGgP6g5On5sxR+2JAVf64zPZcuIJ7kl+N9hqF1a2a3u+Z
         ajnA529G58coqWS/wfq/lzpV/xM/L4GfKZasaukia8zqYi2D4+uuggBhB+qyZ3mVbUDM
         2OTbIhroAzm89XqYsJhMlbdRdv7xo7AdhY9qBQM58yFnOC8+cckLJj9vwfi28EzSY7kQ
         YwOuy+YG0qsylbbMZ9wyuD+BUXGdyFkiG2AdSdmApzP93oPTfBDtvWq4+UkB/iFNG7e9
         t0rw==
X-Forwarded-Encrypted: i=1; AJvYcCXIFf8U6kwLY+ZES4G9ohP1q2BNDL6TqJNDPXcguuHzAkE8rDcwuJdPHnPKufUiOfOM5RGT1g43e2Un6ZT2NL95QjC3Mwgt22wV7LOa
X-Gm-Message-State: AOJu0YxaBukyp3DijIBwjS/g3kKv6Y9OWTgKzeDdYJGglPFydjqAHzCy
	tLbTwIs0pjpLm6rbZQsU2lUwQ5a4sn1xnPtCqC4Lf6bXtdrZdLBqB66Dg/62Jw==
X-Google-Smtp-Source: AGHT+IFdSR0Hi+GPovYTovnK7ZCWypCpDqw5SyDfY+jC/DJpAUK2tThpxcCKoa66LOiGKPWGw/bDZg==
X-Received: by 2002:a17:902:a3cf:b0:1de:dcb4:b0b9 with SMTP id q15-20020a170902a3cf00b001dedcb4b0b9mr10201447plb.40.1710753048934;
        Mon, 18 Mar 2024 02:10:48 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:171e:5cf4:dcfa:390f])
        by smtp.gmail.com with UTF8SMTPSA id u4-20020a170902e5c400b001dc01efaec2sm3569171plf.168.2024.03.18.02.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:10:48 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH 1/2] virtio_balloon: Give the balloon its own wakeup source
Date: Mon, 18 Mar 2024 18:10:33 +0900
Message-ID: <20240318091034.535573-2-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240318091034.535573-1-stevensd@google.com>
References: <20240318091034.535573-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

Wakeup sources don't support nesting multiple events, so sharing a
single object between multiple drivers can result in one driver
overriding the wakeup event processing period specified by another
driver. Have the virtio balloon driver use the wakeup source of the
device it is bound to rather than the wakeup source of the parent
device, to avoid conflicts with the transport layer.

Note that although the virtio balloon's virtio_device itself isn't what
actually wakes up the device, it is responsible for processing wakeup
events. In the same way that EPOLLWAKEUP uses a dedicated wakeup_source
to prevent suspend when userspace is processing wakeup events, a
dedicated wakeup_source is necessary when processing wakeup events in a
higher layer in the kernel.

Fixes: b12fbc3f787e ("virtio_balloon: stay awake while adjusting balloon")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/virtio_balloon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..7fe7ef5f1c77 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -450,7 +450,7 @@ static void start_update_balloon_size(struct virtio_balloon *vb)
 	vb->adjustment_signal_pending = true;
 	if (!vb->adjustment_in_progress) {
 		vb->adjustment_in_progress = true;
-		pm_stay_awake(vb->vdev->dev.parent);
+		pm_stay_awake(&vb->vdev->dev);
 	}
 	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
 
@@ -462,7 +462,7 @@ static void end_update_balloon_size(struct virtio_balloon *vb)
 	spin_lock_irq(&vb->adjustment_lock);
 	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
 		vb->adjustment_in_progress = false;
-		pm_relax(vb->vdev->dev.parent);
+		pm_relax(&vb->vdev->dev);
 	}
 	spin_unlock_irq(&vb->adjustment_lock);
 }
@@ -1028,6 +1028,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	}
 
 	spin_lock_init(&vb->adjustment_lock);
+	device_set_wakeup_capable(&vb->vdev->dev, true);
 
 	virtio_device_ready(vdev);
 
-- 
2.44.0.291.gc1ea87d7ee-goog


