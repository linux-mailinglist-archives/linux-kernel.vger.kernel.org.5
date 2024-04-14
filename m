Return-Path: <linux-kernel+bounces-144129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B77F8A4226
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A091C2113C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168C13BB32;
	Sun, 14 Apr 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URRBWdTK"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10417381B9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713095477; cv=none; b=SAW8XvGRAMjvNvqpJwlVRKcthFQuNoMj1evyissw5yMYpmun6zmb2M9c6KEK+nYNmhTgSIjNu7fN2kEG3D/2WHZwXrIPF9zkQasmP7saPmEDZkewbjgGXT9x21r0HpSfAI01rIqlmPdDh7jFUKAXjurhKcPjxeqK1DyaXolzsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713095477; c=relaxed/simple;
	bh=rXTOdsaRIzRbNgVlIBMIj0vO3iGBtzcD6lZjA2B5V1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AySYjGfRG6apZWXhOmMpBCP6YAsBExVPbJ14eywo323tmA0orj6zbDAYMcMNUj/ItF2Ph3KwQvnxAKiDjKbo/8/qjjfuqE3UHtYAg/xB57g97hQKtmGqSJiQgNdHOnywsIynrAAnriYmUfD8EZHA+LBkz7veyxKoqVgcYiRLi9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URRBWdTK; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so8861a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713095475; x=1713700275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qs2idsBX3ZZ5E4aZueQ/SYBDJyQHjsxqMHTtPG/8MaQ=;
        b=URRBWdTKudu2666dXGzYojG2uSjZZ7mCOhPQQ1QttxHRuogTzELT27L+Hyq8IRXd16
         ESsBo+sEfm68WyY3JqkzK4P4BXXXVSCsZ08Njsu/33MSay/euOH34Vb2RVwafx67cb+8
         cd/pqtvza5Li0kXcaVRWZf3oPQHGKLGuVe/pyGwObQMK9IHdsngmlt+D9tmljG8aFQQl
         OLG9PpqiSHWrRx6aN0w3fZbiv/Ojol/g6VBDPnyHfq8IGWIEDR3bvfAE5B4x2b6rTMS9
         3X1IktG6PIms+abSg4NL315RMKyMbq1N5TmBaTdKdpt9Dt3Rm09f1/AHucmMaDrAAX/X
         6/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713095475; x=1713700275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qs2idsBX3ZZ5E4aZueQ/SYBDJyQHjsxqMHTtPG/8MaQ=;
        b=bS/fZIAqpVf8YV9htxx5fzJToSHndC834O1FM2G9dX4DAncGG4SQP/Pwygkqr8YGSu
         Neayq+86HA5cBfTB1HlEqbnziv/6mC6lH3DiYcT6SnDJPliei7osKpHzK5rxJeAiug+k
         2DQUvRCzqwmYYqlfxCsGkDhU4QAF4vlkpEmWKwWnB3iwAQEz28Kj2btaz9oF0uSREDIc
         Ud8UPw+cJv65fbTgZHdnFvYAgZDD14HmqNujGVVxGOg2pDUzt0aDoAybbLbSDMQzhT/2
         29E5i5qBl/qEXGeSU3s0s7vEqAaUoUMbPGbtVOIxq5e6LECSe/v2FoNrY5OBdp7g4ibf
         l1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWU0WLhGdCSjnJvkxcB9gjE5b/tmbLDXPHzCEqSw5OjLOnqpePoryyME7RsQ7S4BByFlLLbnAWGaeoHR2/0qtXBlS5+eGWBg/iJhvd3
X-Gm-Message-State: AOJu0YyqDDRYJzbuevo8Zm7uIJ7nY9pZMFdNN6hQ08UKi/5G+evuFkHq
	j2XqbUuKfSvARGmWl/CsOzZSRjvbJnsdcCoNgrDmYR+mYyFV4W4J
X-Google-Smtp-Source: AGHT+IGRTsogyptL6qX2/64x1lRw3gvt/9KI3ggg0T6r4jcoCUp2JbHXPZtGdmBTqD7gB6JwUFGuKA==
X-Received: by 2002:a17:902:e809:b0:1e5:9da5:a799 with SMTP id u9-20020a170902e80900b001e59da5a799mr5635241plg.6.1713095475264;
        Sun, 14 Apr 2024 04:51:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cb8:5ab4:8eca:a8e7:b24c:7514])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001db66f3748fsm5913165plq.182.2024.04.14.04.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 04:51:14 -0700 (PDT)
From: sumadhura kalyan <opensourcecond@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sumadhura kalyan <opensourcecond@gmail.com>
Subject: [PATCH v2] staging: vc04_services: Reformatted code according to Kernel Documents.
Date: Sun, 14 Apr 2024 17:21:06 +0530
Message-Id: <20240414115106.105946-1-opensourcecond@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue found by checkpatch

Signed-off-by: sumadhura kalyan <opensourcecond@gmail.com>
---
v1 -> v2: Updated subject line as per standards

 .../vc04_services/vchiq-mmal/mmal-vchiq.h     | 29 +++++++------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
index 09f030919d4e..98909fde978e 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h
@@ -42,8 +42,7 @@ struct vchiq_mmal_port_buffer {
 
 struct vchiq_mmal_port;
 
-typedef void (*vchiq_mmal_buffer_cb)(
-		struct vchiq_mmal_instance  *instance,
+typedef void (*vchiq_mmal_buffer_cb)(struct vchiq_mmal_instance  *instance,
 		struct vchiq_mmal_port *port,
 		int status, struct mmal_buffer *buffer);
 
@@ -101,31 +100,25 @@ int vchiq_mmal_finalise(struct vchiq_mmal_instance *instance);
 /* Initialise a mmal component and its ports
  *
  */
-int vchiq_mmal_component_init(
-		struct vchiq_mmal_instance *instance,
-		const char *name,
-		struct vchiq_mmal_component **component_out);
+int vchiq_mmal_component_init(struct vchiq_mmal_instance *instance,
+			      const char *name, struct vchiq_mmal_component **component_out);
 
-int vchiq_mmal_component_finalise(
-		struct vchiq_mmal_instance *instance,
-		struct vchiq_mmal_component *component);
+int vchiq_mmal_component_finalise(struct vchiq_mmal_instance *instance,
+				  struct vchiq_mmal_component *component);
 
-int vchiq_mmal_component_enable(
-		struct vchiq_mmal_instance *instance,
-		struct vchiq_mmal_component *component);
+int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
+				struct vchiq_mmal_component *component);
 
-int vchiq_mmal_component_disable(
-		struct vchiq_mmal_instance *instance,
-		struct vchiq_mmal_component *component);
+int vchiq_mmal_component_disable(struct vchiq_mmal_instance *instance,
+				 struct vchiq_mmal_component *component);
 
 /* enable a mmal port
  *
  * enables a port and if a buffer callback provided enque buffer
  * headers as appropriate for the port.
  */
-int vchiq_mmal_port_enable(
-		struct vchiq_mmal_instance *instance,
-		struct vchiq_mmal_port *port,
+int vchiq_mmal_port_enable(struct vchiq_mmal_instance *instance,
+			   struct vchiq_mmal_port *port,
 		vchiq_mmal_buffer_cb buffer_cb);
 
 /* disable a port
-- 
2.25.1


