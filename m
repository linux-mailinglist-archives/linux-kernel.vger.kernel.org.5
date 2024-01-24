Return-Path: <linux-kernel+bounces-36841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F415283A799
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6911C2592C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894E81B592;
	Wed, 24 Jan 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRlvjSSp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4D21AAD8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095183; cv=none; b=d4pT3HJYqzeBVzqiAk+JNN7dMTUcFxojAcKGuoy1/nT8UpF0XD9AsjPK8Ul7GzeArzvPNDaAKlxbYtJEpyTNqwXNZX34I6NHou8ecd4PfideMmBFgWTUAHo7V5dkzoEfnKrnWOUGT5fNQsfAKLhGc/kjAUKii+mmt/4IUoXaifY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095183; c=relaxed/simple;
	bh=ZlHGhgWv/S/iK0qXLDDd+AjHFKwwp6EfyvIOkaVhQWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT5sm3ls5EF2L6CEYAM48FJgd070XXVBu1gqxedjIsJhqDWKsZqpnOpoY0sSzy6oM3vchsIfTmXdXd5767TSI5YcDDYgOO2aMsmDscxCIXuaQi+5hrwtdOHcR71vd4HANdbTyr9833MNOGJxy7/O8Z3KCEciZn3ASKfO157kYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRlvjSSp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706095181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaA2C5PYtumt01jPaH2L+2eGuFjEsntK8inT+e3/Q88=;
	b=BRlvjSSpUGe0W674rHgQHvwHH5lHul/+DRxtnB/BtQLqaJe3ANusMpKSAGzpNJRqmHrkTa
	BI/k4UdGTrIkAAY1AvY0rthbu52g+M46t6UQ5K1He06zfl+eocnp1ycVxe05cyUMwtX7MH
	W68P1wi6UoRFbwW+ocsk5Cm2XOSHPkY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-CVTuqjVuPkee69zOqPbDfQ-1; Wed, 24 Jan 2024 06:19:39 -0500
X-MC-Unique: CVTuqjVuPkee69zOqPbDfQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68517c60b0eso2771246d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095179; x=1706699979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaA2C5PYtumt01jPaH2L+2eGuFjEsntK8inT+e3/Q88=;
        b=NHhogPOSfrTfhGUCwBP4yeh0BXB6a07O8A5K8sjoZGJTLkiqU08QEvAIGj2Bx7/WZz
         u4eFshnmvbo51ERQt7fSQ5+QM1z4RtpVETnkYl735jfHjG3nIFcNgOOODwDVMM9zDBsz
         UINAL67CBWGjiLEl2m9DG5fhkbIx3QoaWCXAF6Fi018MdkUT+ForTFyn5wUstAsdY5DW
         msKkWZoHm3yCEAmYKIrZlx+Tp8yG2U+6USPCpnpa10Lu+UoHZ/6ZsjH8XK/ASOPvbegJ
         h+pZWSgOgpV76n6jbv5azLNidBxg0tmikZaySmJgbslagvtOhCkkhPJQ/ZftiWOcA88H
         yf3A==
X-Gm-Message-State: AOJu0YyG66wOrmtyYntK+PCUwxEC0DT0ALRlwbM10P6+EqoD3kIyq6EB
	n7/dx8ka0shHOWvQWBrHmXBWGsftyo0ePX+6Sy91kdi5Ouxko1H15SSKdnS3KKiJhblOiBojuxi
	FOvRXimZ37913p8aW7T+X5G9m5eEh4tJmsj4nGVea6Ubly2OS/KfQZu67TPoO7Q==
X-Received: by 2002:a05:6214:1d26:b0:685:2465:5b49 with SMTP id f6-20020a0562141d2600b0068524655b49mr1899682qvd.5.1706095179185;
        Wed, 24 Jan 2024 03:19:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYS88+M28R+fEZ5DmWrk/clm4AHy6UZ3aTWylHEKV7eS6226fnp4mYXCUPSsT8AHARYsBrlw==
X-Received: by 2002:a05:6214:1d26:b0:685:2465:5b49 with SMTP id f6-20020a0562141d2600b0068524655b49mr1899657qvd.5.1706095178867;
        Wed, 24 Jan 2024 03:19:38 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ql3-20020a056214540300b00686aa6dbcbfsm1027016qvb.81.2024.01.24.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 03:19:38 -0800 (PST)
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
Subject: [PATCH v4 1/2] drm/imx/dcss: request memory region
Date: Wed, 24 Jan 2024 12:19:04 +0100
Message-ID: <20240124111904.18261-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124111904.18261-2-pstanner@redhat.com>
References: <20240124111904.18261-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver's memory regions are currently just ioremap()ed, but not
reserved through a request. That's not a bug, but having the request is
a little more robust.

Implement the region-request through the corresponding managed
devres-function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/imx/dcss/dcss-dev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
index 4f3af0dfb344..d448bf1c205e 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
@@ -170,6 +170,7 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 	struct resource *res;
 	struct dcss_dev *dcss;
 	const struct dcss_type_data *devtype;
+	resource_size_t res_len;
 
 	devtype = of_device_get_match_data(dev);
 	if (!devtype) {
@@ -183,6 +184,12 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
 		return ERR_PTR(-EINVAL);
 	}
 
+	res_len = res->end - res->start;
+	if (!devm_request_mem_region(dev, res->start, res_len, "dcss")) {
+		dev_err(dev, "cannot request memory region\n");
+		return ERR_PTR(-EBUSY);
+	}
+
 	dcss = kzalloc(sizeof(*dcss), GFP_KERNEL);
 	if (!dcss)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


