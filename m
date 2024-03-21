Return-Path: <linux-kernel+bounces-109534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C847F881A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748011F21EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603A91851;
	Thu, 21 Mar 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NPsYVdv5"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B50A23
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984302; cv=none; b=OdZxmq7aL5XDbZjKwjXFum2SVaxKFB5Dpb1AOVGT8O7R91VJ7Fv4atZ6/qYp6v0TptuBzsLdB2WMH2gA67YpjnUiTDIwlRA8kVmWKey/cf9eKMazptegfyTYC2JFDAjWDKhf6bUJKmSfPOpGt1Zb2MqoaRDXh+62/4zvXNK+zuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984302; c=relaxed/simple;
	bh=9qViWAiTCFIgFNI104sEmf2/03Isba6KDxtepjBz+As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+58foXntgmMzdQgevxkQxwVa+pOt6S/WkZPo/CrlMuy21BKwaInmO7KDLw9Qu2TzMcQGe0SuPQAE7J1hR7ox0DXX28pwWlsphPaQmVgWTiX+U/7qSyGWBWDok2KdOYVOqWwVsBdw6jxfhyaqHhriuXjXrNuqkaHfXNpCzgZtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NPsYVdv5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29c71c6e20cso397714a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710984300; x=1711589100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKMmiCHffcx2ZBQ5QrgfnTfmU8fHpt/uWul6SXcgwsw=;
        b=NPsYVdv5ewrNjIeTuHT/9oE5j9Vr8nNZ8FDWIJNoXRaDE13ceyha6MJ/NwA1evtWgr
         +6aX+zgDXftSSrnjC4AMAQwl0dWx/vUxGlAFcvFQENvIS2Slkk0KPkMPAIDSknXr2wnm
         4WbayPlxxcmIzSX27TVtrOCGkjeuC6YsDf6cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710984300; x=1711589100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKMmiCHffcx2ZBQ5QrgfnTfmU8fHpt/uWul6SXcgwsw=;
        b=E2NDvx0RLWmtxRIWOyLbRBRFgb4kwV+m+ZXuj079MCqvHFhrMG/xwry/QP9H0tPpgx
         WetRkVvJosASJTyHu2WfZ5G+nnZ7cS76qVjan/NxzCBtdnPif3vgzb4Ar+IYkSljdoLv
         Dk5qvuSwWvSVCdH8fIIcyLUZ1Z1qm3LQhU7PYnJdLk8MQ1Z9B4DACq1QDRQD3YnpePw3
         xpghuqxADy474aUo6rDWQ+P4kBnPsWl/y0G+8Ei1siW9M6TOJyo8dvN24QHajLTgWJ16
         ErUDoQdNwbgijl5cKrVzuW9w+KC53hGjWx8l59Y7Ln23P2BT2DvebP+iR68hPCI9DmgK
         trOw==
X-Forwarded-Encrypted: i=1; AJvYcCXCL0YWyKFjDygWwwvRoewOk9aSfa7v6LhXX5uGtKdk9gIla2FtW9/Nj/cFjmBMsizmHJvHk+zO8ryEEFF9AKfKtwSqQUJ4hG5WrYjr
X-Gm-Message-State: AOJu0YyR00pmBIc5vGJBD84hX5LTlm+eTQ1cH2Yhoiy8fM8D2TTRnqjm
	arlnC9izEErQDo7xNucZIOfdFLMx+zP05tHS8218i6oGaczcUTYa/olDwlbdIA==
X-Google-Smtp-Source: AGHT+IFblfDsuIjIHTVJCb0dAYrbnIzAn8PgVyToCqQbTiekWIhtFt694PRGUKrwdZCzQZU0XxixSQ==
X-Received: by 2002:a17:90b:4cc3:b0:29c:7620:6fde with SMTP id nd3-20020a17090b4cc300b0029c76206fdemr746531pjb.36.1710984300365;
        Wed, 20 Mar 2024 18:25:00 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d837:1d3e:d3cd:7674])
        by smtp.gmail.com with UTF8SMTPSA id sw15-20020a17090b2c8f00b0029bc2b845c4sm2309353pjb.11.2024.03.20.18.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 18:25:00 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 1/2] virtio_balloon: Give the balloon its own wakeup source
Date: Thu, 21 Mar 2024 10:24:44 +0900
Message-ID: <20240321012445.1593685-2-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240321012445.1593685-1-stevensd@google.com>
References: <20240321012445.1593685-1-stevensd@google.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..89bc8da80519 100644
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
@@ -1029,6 +1029,15 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	spin_lock_init(&vb->adjustment_lock);
 
+	/*
+	 * The virtio balloon itself can't wake up the device, but it is
+	 * responsible for processing wakeup events passed up from the transport
+	 * layer. Wakeup sources don't support nesting/chaining calls, so we use
+	 * our own wakeup source to ensure wakeup events are properly handled
+	 * without trampling on the transport layer's wakeup source.
+	 */
+	device_set_wakeup_capable(&vb->vdev->dev, true);
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
-- 
2.44.0.291.gc1ea87d7ee-goog


