Return-Path: <linux-kernel+bounces-67788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC348570BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0D228495B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7D1419B5;
	Thu, 15 Feb 2024 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWDPUI76"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036313DBA4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037593; cv=none; b=NgoydLpNssak3ck9i1ktyVF7e2Q3m6Z/+gbYJntXVGaXNnZX7Czd3Ad8ie4lwFOoCjwCG/u/GHXc9GTPCWm9rsoB+QMaORHVfaG+coWatJ2ROaAffEnV5nzYXUCX58OFrt8FFfD3SvknDC0F8X3OrLPkxq28J1Ezn2yflHgIIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037593; c=relaxed/simple;
	bh=2FVu6yXE7U52ivGAjAAmrkoj6QOniMtDTmis6EZTPqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WDLRDDuLRaTi6gx3B1QxC/6NDqkK7Yjqxc0go8RQpJoxYi5U1b9x+TmxnpywwfQkGa4sRdxEoMjlQylL7oCMWmbU6Y/JtiwXGFx59Zdj+ch9nRYxLynVdto8Qb7jdreUIrJc3Jo3nlM7yJmUdSI317w3eOsScAjMabA6CYv4epQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWDPUI76; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563b49a0f44so1819946a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708037590; x=1708642390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dM/iULill3Uj1lqLW3ClBj2hmpKY1OGRqTHuq9SM0pI=;
        b=BWDPUI761uEVi/IbW1IVGWVCU8g7Go4vM06p9/RqZvQ7FtrceMYVbvu1gFglsQSyLX
         HiQGfAT+sOlgTaUU6yGW1bjjHR9ZnScsyKTKJ70bwaW6+W5ttgGWGNgXjovhig+hrR89
         pu1airmC/WKTUPRbGJzkVERB4w1/TRLQ6PtSPK9cwSAAmAw2Q5JkTGs2g4+s2++h2Xbv
         226EAZReGPz0N1zoEdGqpzJl0ih8iFBHtktSxruvJfHnKAkoDGhWt48mY/jAauQ2LF/c
         TMW4DAHNSMBXhhkNwPz2yJVv2vzb+gLWdf/oXDTXmTfB/YsgOGYYrfA3V9yzec7n9YPD
         QoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708037590; x=1708642390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dM/iULill3Uj1lqLW3ClBj2hmpKY1OGRqTHuq9SM0pI=;
        b=XWUwqIxGR8ItFQ1HSlYW4lVOkBme4fDE4VdhmjAu8HhTJCtdDRasUlV5zfSeB46IAk
         6U6kptw4DSlq3RCe0mYVfAHyUQ57afuKeRotiLP5W0YBaQRKQbbzlTwhRC9XC6QXW2z3
         W1xel8oP8A39OOfwArCoZK1CopLIm0jW+dKcx950M9jwvIWxQcSeQq3idncTkqSV1GXb
         zsJCZSGg82ph0LJYo6/t6995z/cDWpy4aWAF+ssonp1fOjRIb45nKLPLGhPqC68gu5yJ
         jzRIoKVqPMuryB/ssfE1ZNY/v4VIt5SR4gxjcnVQMoR/9vyBL6qNLQLZ9A1XkzcJGIkJ
         o3UA==
X-Forwarded-Encrypted: i=1; AJvYcCW6bx1AA5tdwKMJ0E0z6/9NcdqoxKZFaIs8CJBQPYNiUPQjilt4ysdpk6BjCdodPyyMzRIT5ID5REzqxa8ZPoH0FU4rrjMae0/ujfqU
X-Gm-Message-State: AOJu0YynGXrIVSazF0pkcWKswId8l89ehtZMRYSqztv/iUlEjzihwEcO
	njjLBvSO7CBNfsbRCRfeN7biUYfM5p/DJdyzy4NYmd9uBM/kUvGE
X-Google-Smtp-Source: AGHT+IHhX9TEWUB84SFRhuZNXr7KhVPFBUH31IMkj66V/NmQ7Seh5e4nlfDjHV17LK9b77QMCKR7cQ==
X-Received: by 2002:a17:907:86a4:b0:a3b:ad02:98b1 with SMTP id qa36-20020a17090786a400b00a3bad0298b1mr6506310ejc.10.1708037590040;
        Thu, 15 Feb 2024 14:53:10 -0800 (PST)
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090699c600b00a3d88bdf5aasm966467ejn.103.2024.02.15.14.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:53:09 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: florian.fainelli@broadcom.com
Cc: linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH 2/3] Staging: vc04_services: bcm2835-camera: fixed several brace coding style checks
Date: Thu, 15 Feb 2024 23:52:49 +0100
Message-Id: <20240215225249.11010-1-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed coding style checks raised by checkpatch

Signed-off-by: Moritz C. Weber <mo.c.weber@gmail.com>
---
 .../vc04_services/bcm2835-camera/controls.c        | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index 6bce45925..e670226f1 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -533,17 +533,15 @@ static int ctrl_set_image_effect(struct bcm2835_mmal_dev *dev,
 
 		control = &dev->component[COMP_CAMERA]->control;
 
-		ret = vchiq_mmal_port_parameter_set(
-				dev->instance, control,
-				MMAL_PARAMETER_IMAGE_EFFECT_PARAMETERS,
-				&imagefx, sizeof(imagefx));
+		ret = vchiq_mmal_port_parameter_set(dev->instance, control,
+						    MMAL_PARAMETER_IMAGE_EFFECT_PARAMETERS,
+						    &imagefx, sizeof(imagefx));
 		if (ret)
 			goto exit;
 
-		ret = vchiq_mmal_port_parameter_set(
-				dev->instance, control,
-				MMAL_PARAMETER_COLOUR_EFFECT,
-				&dev->colourfx, sizeof(dev->colourfx));
+		ret = vchiq_mmal_port_parameter_set(dev->instance, control,
+						    MMAL_PARAMETER_COLOUR_EFFECT,
+						    &dev->colourfx, sizeof(dev->colourfx));
 	}
 
 exit:
-- 
2.30.2


