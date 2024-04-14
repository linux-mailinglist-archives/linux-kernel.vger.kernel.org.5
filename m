Return-Path: <linux-kernel+bounces-144212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6138A4332
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C463281942
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F0F134433;
	Sun, 14 Apr 2024 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIkXn/kZ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9D2421D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713105992; cv=none; b=IijmG1bfAnka5ejDTF+/wpjXKGVZ53279oO6c3rBzxD/ruUmFFc17+jk/tO8PZ/4E3u1Y+4pJIrx6+IogWdpADSgg38k5kVATne/Fh9wShknQ/f4c7v7l9LTvEsICIMLQwrvQs7kz8hOblTHhD9LjMNdMn6GKlnGq6XKiTpfeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713105992; c=relaxed/simple;
	bh=Pnm5uzyLFqokE6i2gRypdZYPe78cFXqpMW9vYEyg+PI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=br7LeeZToj+UYCFfbFEh1TUFNFYnsEXBkrgTLdyn2EC36041Fu/xgt+yKdO4/zBOXWxEeizz1W1ioLsF1ZbkrH8iIqBeTpqUkLx2n0xPTp2XOi28qjtx55CckuUu1syGJ6C4l1lAmoqHMp/FpDbRGOU5pG5kgm4QyhB7aroPkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIkXn/kZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so1323132a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713105990; x=1713710790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3tViLkTicsEqeEJWOwiTN/e7BHPxS/OI+grJULG3HM=;
        b=YIkXn/kZOlXy9oHExfq7oHDStZmThmqdiqNOSLidoxjgHT5DRmrGZjut2w6U41yP2I
         h3OgSvPE7TYHoX2DAlNu6Ioc8P3Ll7xWBf3bSnwuje/inCCJ1y8ivmyE0Szss22SP7H+
         heKa3QxqJldWGhncPesHeiyLYjywkXQvXiZRSkQdwr+Y9rA4ir4FVMsEEsqIO+kxnG/2
         hIcXS4GDG9Yr2eZ2Z2tMrTRdEx4cyk9wMjKDkcIojPJfGynUEVBbA+TKWAVodkmwj8SW
         QCzOnJXUp1lFuK4EY/uLWVL5q0+8FqdhMnqZTk83SRgLzFHhXTVc30I0dk/napKlEasg
         Beeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713105990; x=1713710790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3tViLkTicsEqeEJWOwiTN/e7BHPxS/OI+grJULG3HM=;
        b=W0uHYLrtsbAx9Ai1pTSWKVsG+7gw8oiYeeU6CUlrSojnhAU2SO88w7Mx3K8RIegacW
         B+6mRXUwykPAQHH5Tt09NPnDoapFIsW001XVM/Ha6Wr94rJbLxzgjj62zSXryegAMqK7
         tRbuc78hHsHqspAYP0HinxtzH0UusZjV+jlzNB9XB7tr6zOrVsVQDFZa1Dl7AYERLWAD
         152iag2Q63+K4wGBHf5SjshALAC463RRwiVpSuRdZEel30qZu5EnRnS88nPm+mKXKEE7
         h6mL/zmMxvNbmz7c13P9nTh+bb1iqsi9RkSATeiDruvg3qolbVsWOSbX7xszIBW3Ixyg
         bQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCUm7IkBUFouEuAxEIRzmxzgwmXa6VrCBnLdb8kkyA7aDftyiiyaVJRwh+ojNnH3FRLu2s1cPRxpae14ZaKWC1Gih9s3p/9iT0o/ZXbK
X-Gm-Message-State: AOJu0YxOrXPcuVARrFvosocWu6n53V8+FKaJ/vpJHF1rxrsYSiaVYjZk
	8zyYALSxtgWjC8p7M2V+xZgV812yw6P4jK2IZIGkn7ee4VV0adzj
X-Google-Smtp-Source: AGHT+IFZq/s/lmveYTlCBXK+H1HNANw04Kjky+33wlLezYN9D6uBCi2pfeFOVwDbLR348xK5M/fbwQ==
X-Received: by 2002:a17:902:eb81:b0:1e4:7cc5:2292 with SMTP id q1-20020a170902eb8100b001e47cc52292mr8096811plg.49.1713105990200;
        Sun, 14 Apr 2024 07:46:30 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cb8:5ab4:8eca:a8e7:b24c:7514])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902654f00b001e41ffb9de7sm6196325pln.28.2024.04.14.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 07:46:29 -0700 (PDT)
From: Sumadhura Kalyan <opensourcecond@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sumadhura kalyan <opensourcecond@gmail.com>
Subject: [PATCH V3] staging: vc04_services: Re-align function parameters
Date: Sun, 14 Apr 2024 20:16:14 +0530
Message-Id: <20240414144614.125672-1-opensourcecond@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sumadhura kalyan <opensourcecond@gmail.com>

Checkpatch complains that:

CHECK: Lines should not end with a '('
+typedef void (*vchiq_mmal_buffer_cb)(

Re-align the function parameters to make checkpatch happy.

Signed-off-by: Sumadhura Kalyan <opensourcecond@gmail.com>
---

v1 -> v2: Repharse the subject line.

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


