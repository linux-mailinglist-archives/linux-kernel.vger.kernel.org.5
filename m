Return-Path: <linux-kernel+bounces-144103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F788A41D1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85C81C209D5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B849D2C1B6;
	Sun, 14 Apr 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7D708FK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628E286BD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713090302; cv=none; b=K32PwOgZ6pgFrrewA6h5Vs97Pa1Zaz9fYy6H0pxoTrtQd0haAoxYB9irUEn1P7o/hrx4zfs2HcTrIowRyFbPHV2AgNSgKsoKmpQ0ZQMqJSnCQU9DLX/INQEA515POh4KP48tJcQUKeVm5ShdbfMoREGr/8sen57fkxWBQr/ce4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713090302; c=relaxed/simple;
	bh=JJZlIn2mvmHgMJDDfAZ1JdDcw/dwxd99aCw9whf/RG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pmi7x+d2xu59HTHDh/tvfN6Sb0vVYyE75bJiOWY5cZwEtdQ7hCrHlqZBpMOITnauRTHhPClYnSipAQWwG0KaMiwulQtY5w+zjw+QNK7Z10JEe5BHBQCZiy4GtErdZS8SFfzBIUF4AKqZCN3KediLImkJJNfryNGkVDX0rdr5XCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7D708FK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ee12766586so1474586b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 03:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713090299; x=1713695099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DADHOWnUNYP/9/v99Q0bIFc3ha7reMyzoz3vmz/f54w=;
        b=c7D708FKLjINv5ZHjrsm/Oh3ovvic6LWDBIxRcwg/MRwH4PtpeMK0DiHpgE+DkqRn7
         A0aAvQBxhDUmUJxhcsidt1J2J+RtNucdwjpy07Sb6iF/4UkIu3TgfRsTV0UN4bJ5Y5vA
         IGorkrdSuFpij5OG6Yz+YSa0h83+3Dbl/Sl/CddW2KNUNYpEEsMWv3wOMgEZR+vvsY3J
         O+YTGBGZ8RkSf/YhBaJA1djYAYPXNll/hYK/Q/FkjWphh8y1Ccen82aC7KO6++5oDvvc
         /P6yNneh+0uYxZ3YkP67U7jDomgZJebI9xolURFTxMB1JBZyS99xRW5Ql8d/16RJA3Hd
         KTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713090299; x=1713695099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DADHOWnUNYP/9/v99Q0bIFc3ha7reMyzoz3vmz/f54w=;
        b=FHdDPPvKz6abF8ygxlu/hr9EevEqkgMhshZNgbJlRPsm101igPfZyiX02wlgWx51zE
         eVBEyHCY3eWsR/8mZ/csPpYr7Hb2+b1b9eH52yVtKQjMUNU5+KhV7e81JMXIX/OQ710/
         JVbWoOuz4yyy/zs8oPnucVB0Vvj3zi3i5TTezDsyDHGhWzNSLPaVJaDL4nh1DuZzVx9Y
         ZXTfSZUpYbYrZXQ5qTS7UZjgTrDu9MzjkBamJ28X7b37xEJDkpIgHRuFBc0aoX1RX387
         oOoy7kpIIQCCd3N6DXhFLnQrJBrBHD2uEk1YDO6PK/MPq3+naAXUkYjZQWdu4K5tbS0u
         VHFA==
X-Forwarded-Encrypted: i=1; AJvYcCWPqLeod0moOmsS1NW/goPxFym0yPXGBYXPY/Z0+n8T+hq22Oj3lyZ4aCQ+DCILIFVo0XokfPjU4TMMa3SC01A+OTcxoHMm/T/TNxSe
X-Gm-Message-State: AOJu0YynJfXaCvUvIKgNsqBKYzulzgqKWzWRqliRS0cgt+vn5mHZ2YdV
	WuwzhO5941+FhXjM56V0DRsZcXqR8MTyoLaEgpku2YUL3twT9TQi
X-Google-Smtp-Source: AGHT+IFo+3A88+eErsb0hrFDYgsGA859sSv6X9J0eSGBHL9qSAzFushHa4YDibASL+DuNgxlqQFy3g==
X-Received: by 2002:a05:6a20:3241:b0:1a9:9839:f209 with SMTP id hm1-20020a056a20324100b001a99839f209mr8824592pzc.0.1713090298867;
        Sun, 14 Apr 2024 03:24:58 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cb8:5ab4:8eca:a8e7:b24c:7514])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm5233452pgc.21.2024.04.14.03.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 03:24:58 -0700 (PDT)
From: sumadhura kalyan <opensourcecond@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sumadhura kalyan <opensourcecond@gmail.com>
Subject: [PATCH] Replace function alignment of camel case by snake case.
Date: Sun, 14 Apr 2024 15:54:42 +0530
Message-Id: <20240414102443.98927-1-opensourcecond@gmail.com>
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


