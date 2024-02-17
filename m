Return-Path: <linux-kernel+bounces-70083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6A28592E2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC91284676
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CF87FBC2;
	Sat, 17 Feb 2024 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCAdASkJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D2A7CF20
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708204420; cv=none; b=Xx5fkQDFB+DBW9E8jaT5z74GYvY0+8emGn2pJ1o2mbTz6h/Z2amwkJxUnl7xiAlQHF+66lL2X6hhtBpiOKlgiJ6K1PCgZjXQpqScztKfXE6BBEwzIYndsDRTEMGcxOAnGKmKMiFJhh9RnM0PhuXrKEPfhzm12929gKuVBOlasgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708204420; c=relaxed/simple;
	bh=7hspqxJMlbWp9r8wbinNZ4JYMSL1OjbYJQMw3kfsFf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPfRQ6zP0RN6MuX6X7wKkLbJhikwlwYOing/npQKZeMw3thmfBbMQdHVXx+Wck30IizXN2Jh4X25/3O07HmyvHMRjXLx4SOn5TGjSAfQFwEnb2uTbpIdTRKDeOCRE0oCzXsHZd1t4Z1vdOqglfGQLyaLvHTg/t+SWMqZnIBt73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCAdASkJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56399fb02b3so3874463a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708204417; x=1708809217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GS741zrKEdJkYZt2tXkhtOseE/gYHcmQu8uV5DPSIc=;
        b=jCAdASkJrJdQLi6BpGEcX9Jq5SqgbjM+l/zdk5x4D7Q+ATRL7VjsTXQ5GsiUbR/Ipe
         xW6y4Nr3W71ay5uC1AKxxMgXdCJ9f0NpcHkGYbNi6VFTMrFsdb9TmNeIt5YNzilALRHy
         cz9itxWc4E4oofMSy85O9faguvpfQHOvfreEJSdWglUwoNq/X4EJd/c6G/iBqWLdepkb
         GPr9xz/jVUTc5BdDrU7ix30ZzWVi/EPq2n0n2idlDTLhKjUPADGDs3HuGCdQIrElxXoq
         IOqkeKyj+GSvsG6AI1z26CNpUitmtmeX7A3E1AtA6gBJ7NyScwb5tJF4/3AcN47gnVPQ
         AVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708204417; x=1708809217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GS741zrKEdJkYZt2tXkhtOseE/gYHcmQu8uV5DPSIc=;
        b=jcEqH9S3uZroIAAMPnq4huMEC0yQjieyHLKn1NK8+cumZzs6jKOlZHIWPGa0sZK+0d
         LDOfDPI6Ds4AGHX9BjR1KQfn/G85+4imwJS09zlw4cfmcWkgZiTDrEv+BjmYVC6wmMY0
         4wR55NHdqohMKJUdv9NaAzzsDNOUPviQPrbRCu/tjZySCXic9+CTYBzLL4kZeWc6ASEW
         on6pMmf6798etjdXnPeZ6y5KWzSVQXi71DvugwZRKIajVUGCcHpMlPk0PiScoRxsR5gw
         Th7xYfPv/MCxD1TuExw2qiLnzq7jcgr3A206DZZXxmbGJHGWpdvLb5e9+RS3NiGCGQ6U
         yV7g==
X-Forwarded-Encrypted: i=1; AJvYcCVvvJvTJdtk8A7DhAbuu1ZAhKoISc4NTbS/Xnkvh7kmEmUPD7xuuQz9eqmEsf/Z2vhmjAIPDTe4PXeTPFGdjIGnxuy095flibuL5syQ
X-Gm-Message-State: AOJu0YwBxOPgYac1UJvUrvWP+EQep1vTyG9AX2u+j1J5BFEmr6M3L23Q
	JVyRtbrcgxy16qTN7TS2fQk8AIriYA8rRsL7+9Ycw1reRSsGP2p+
X-Google-Smtp-Source: AGHT+IF28IvsfS79LfXSjGJV6c1pr4ruIKI0l2p/J0WvtTC16QExdfTP4rC0adrGEBCQ31HuOq3j4A==
X-Received: by 2002:aa7:cfcd:0:b0:564:41c9:517f with SMTP id r13-20020aa7cfcd000000b0056441c9517fmr695490edy.26.1708204416624;
        Sat, 17 Feb 2024 13:13:36 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640206c300b005644eca3befsm132087edy.85.2024.02.17.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:13:36 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH v2 1/8] Staging: vc04_services: bcm2835-camera: fix brace code style check
Date: Sat, 17 Feb 2024 22:12:39 +0100
Message-Id: <20240217211246.28882-2-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240217211246.28882-1-mo.c.weber@gmail.com>
References: <20240217211246.28882-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat function parameters to fix checkpatch check:
Increase readability and consistency

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c     | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index e6e89784d..05e5e4ab1 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -350,12 +350,11 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
 			if (is_capturing(dev)) {
 				v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 					 "Grab another frame");
-				vchiq_mmal_port_parameter_set(
-					instance,
-					dev->capture.camera_port,
-					MMAL_PARAMETER_CAPTURE,
-					&dev->capture.frame_count,
-					sizeof(dev->capture.frame_count));
+				vchiq_mmal_port_parameter_set(instance,
+							      dev->capture.camera_port,
+							      MMAL_PARAMETER_CAPTURE,
+							      &dev->capture.frame_count,
+							      sizeof(dev->capture.frame_count));
 			}
 			if (vchiq_mmal_submit_buffer(instance, port,
 						     &buf->mmal))
-- 
2.30.2


