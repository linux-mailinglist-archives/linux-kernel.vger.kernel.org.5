Return-Path: <linux-kernel+bounces-55144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6F84B865
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD371F26C18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1A132C17;
	Tue,  6 Feb 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErNxu78E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C9132470
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231123; cv=none; b=JhO9WQL4hxBuFFYrTkK2Y5OFTBcCu9I2Qdw1jBVStbsPK0rqalCcvOS7ElSffxlo3bwgMLC3rrBYYnl3HTc+uVwnEvJZLSb9sJsUIzlNbNgXBZnZmCKS/ASjQOtZeMQX2jVrkazL+XMlU0vNNkEvvAYimlXpAVLbUwqOQNOSIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231123; c=relaxed/simple;
	bh=R/o5EP7C+JnoxFgZaYwDA4ls6GyyKFxMVhJAZddFp0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=aS2GzO+zuWBY1jM3f2/cz1PVH54pDda4btbEqp2E/yltdo/xn4Zlso8cvfqD9Rqgf5QSJYM5CJbDeXMMLbTafimNb9vjihTF06cjU7nD4BL+E6BQFjJydOWvWWyT9dK14W1TibDk7uLh1S8Y4Yvm40xCV/aiXMD15Y+QGUMam+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErNxu78E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707231120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQIKoNOJmX8VRVk5/I0n1vx+OMQlaoxl3aigw5zkfn8=;
	b=ErNxu78EpxHSqhM5CYw0jPtNlWw05ftYLVIjAlcCr4GZcQkdFgoF1fQceNOlq95Piwbx2O
	nMHAS3njwJLTy+Bm4IlXBilw/P9+sZmXVbPuCiS6ol/P7YHJ9+qhNwcM/pOpTxCcNHZwoQ
	wsNECiexjIPv1r7tQpW3mzB1yL6AQ+4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-txHBQnjYOTupBFY5jqw8Fg-1; Tue, 06 Feb 2024 09:51:59 -0500
X-MC-Unique: txHBQnjYOTupBFY5jqw8Fg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2195a9a8efaso3588867fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231119; x=1707835919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQIKoNOJmX8VRVk5/I0n1vx+OMQlaoxl3aigw5zkfn8=;
        b=f8KnH67cCA/IcOPQWi6GS52kmNQ0YqQIpfLcaV6MWMz4Ou3ka8itMMCIhleKFsNY4p
         uTKxQ0PCQGMbRQkCmhv4KL4nL7IkfbxgEvEcPazVwk/IqS61KnNNDq2hrS/XiBTjcUoZ
         9zsb8BGVvbDXUwWn2yCD8wk3jXEJBnIf1fo3B0agWvqCbHYMzp2ZRIVNBYBnSiCUgtjp
         GM3ClMtaXRlr0CeHsUa1h1a+5fev2MuhlQIO+eM7u+t6G3Mlx4WQltTbNQaj5WaXQ660
         XEx/2+xSru0aJ6FbnAXnn2IN1nSIT4pKH/xueuzdiK+4bBiRhZsFLacWYZnTNw2zVHjw
         UeAA==
X-Gm-Message-State: AOJu0Yyjs6hUG49PC8nLRanRqAurt6VkI8kDriX/7vn9TqyevVk6FwYQ
	LFdnK8AY2GNNC2bWwkbNvfXyaUL49PNeeQoPzgS0GCMN7ckys+bkCUDQ4FDZd8TD2k5Ampgezyu
	shZJVRigdasXY+XNs6JzVeZfrUn/ZG4c9yedrJMM6cT6meNeTOtnM0jxQFupGeA==
X-Received: by 2002:a05:6870:164d:b0:210:8802:786a with SMTP id c13-20020a056870164d00b002108802786amr3275741oae.53.1707231118960;
        Tue, 06 Feb 2024 06:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLCyho5u5y4dZMOsWQV1AaVbjSFpDdh6YZMYgsdjNzX2ck/ywfHH/5T/kc/2KHsZrayoPM0A==
X-Received: by 2002:a05:6870:164d:b0:210:8802:786a with SMTP id c13-20020a056870164d00b002108802786amr3275728oae.53.1707231118721;
        Tue, 06 Feb 2024 06:51:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6YVTF3BXfxD7oGuNc/5i4fJi9lzUP0v2EuV9vQ2uYj3WVgVJCvsEX8TROSCzAqDs5ebrmUOfU/S/j7kp3jXPim8rxZSbJKSJVXStktmV2oqMTXILCaFK8Q7/Dm4SdzEV1oi2ax7XvIFESMcCV8iCOJSstM1x0ffCK9wzkBPAe4UiZZyES5vihMsa0sRYoqZu0wDySrdl+bWTxhpQjZZsre7Rw5ZHednIiXPP1W399e2EE8jsT8XU9D+7TeQhQE87br0/am75tATSNqLHpbPwm+dZTE8klIcCGRw==
Received: from step1.redhat.com (host-87-12-25-87.business.telecomitalia.it. [87.12.25.87])
        by smtp.gmail.com with ESMTPSA id k19-20020ac84793000000b0042a9b28733fsm930742qtq.89.2024.02.06.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:51:58 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Kevin Wolf <kwolf@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-vdpa: fail enabling virtqueue in certain conditions
Date: Tue,  6 Feb 2024 15:51:54 +0100
Message-ID: <20240206145154.118044-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
the driver to enable virtqueue before setting DRIVER_OK. If the driver
tries anyway, better to fail right away as soon as we get the ioctl.
Let's also update the documentation to make it clearer.

We had a problem in QEMU for not meeting this requirement, see
https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.com/

Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature")
Cc: eperezma@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/vhost_types.h | 3 ++-
 drivers/vhost/vdpa.c             | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index d7656908f730..5df49b6021a7 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -182,7 +182,8 @@ struct vhost_vdpa_iova_range {
 /* Device can be resumed */
 #define VHOST_BACKEND_F_RESUME  0x5
 /* Device supports the driver enabling virtqueues both before and after
- * DRIVER_OK
+ * DRIVER_OK. If this feature is not negotiated, the virtqueues must be
+ * enabled before setting DRIVER_OK.
  */
 #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
 /* Device may expose the virtqueue's descriptor area, driver area and
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bc4a51e4638b..1fba305ba8c1 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -651,6 +651,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
+		if (!vhost_backend_has_feature(vq,
+			VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) &&
+		    (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
+			return -EINVAL;
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
 	case VHOST_VDPA_GET_VRING_GROUP:
-- 
2.43.0


