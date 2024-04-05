Return-Path: <linux-kernel+bounces-132570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02308996BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A58B283552
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD113C81E;
	Fri,  5 Apr 2024 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5pb8Frt"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC213C818
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302816; cv=none; b=NKKcc8iIfX32GQF1jPyhXrbKrbX5tgr1Iki2WZp2p6hje4US3Gcl1rDTb0OMx2V96jtwjSIEJIM0z5anxLxeqpyORsZNJGJ2RQIydLB/GLAQmWohCaCzL16DNpM1e4cWw+xu1FyXPbM8HtyWiImWbzkTQeZ4CqdEH/XxVqaqJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302816; c=relaxed/simple;
	bh=jK+AFaPuB4QJkOlQSpapYzjziTfiCfCCfo7UWLC+ajY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=se7XvGCY854zT/fXf/tomr7bFNfcfsxtnfC6zOcYcLK9Fp/Yb8hPVITrIKaS8vnqoXzU177OrywTVY1qIUqvl4rsU8Lk4f5WekHyPE6NBMND5tsrYRfM79cLGsjJv0q+IylkkAvY5ZMd0uPP8fKZSBpWLpHZs9rgLO9Mpo3V/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5pb8Frt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4163181a7ceso914505e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712302813; x=1712907613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF9nmGQgrbBBKoEODSqmsdf3m34vi7We9f5KYGrq5eQ=;
        b=f5pb8FrtNq5bN9vUR5SN3MWUBJSn6tuFJxtsiI0hvH0FmZKlScDZZsWytgRFdcKGKn
         b9EF2xbvcwsrkfT0CrVcFSmEZRvwWk2d5bhTVoz3nIyk6TLBznlfI0RHPK8crqx09dEZ
         l37LZJhqYNt4GyNeU7eWiK64FLuwDksuLHXjO7imhgfYmUfpDFFht2XwEoOX1c8Og4My
         nacBNPuW6Nhn1RU8un0YbMC9gUnDm7bEAqYWHC8uWpLj5lcYLsuGXE2DtqhS6ZqjemKR
         WDqQqaQVGrD8LsVeoV03AqlR8hovMDnc0KzDmK2zweanSBaXOY0sKSJJY8cJ77fknLrt
         1S2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302813; x=1712907613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF9nmGQgrbBBKoEODSqmsdf3m34vi7We9f5KYGrq5eQ=;
        b=sYZGsPjL0d+LWsfm9S11O1w9j6Ci+pWl+9slksNJ/uX+nEHVPSn0X3yXccIE6RZeKH
         9TORmEoE5t1LJHNyixiKnXW16Gmk8sHU58BUrKiznQNMTs7IJp5rc09/NATNnPAzg+Mg
         7p8mGCntQ/eMUuIZcfR1FrpaIF0awYi/v7M6PIUC3d7Yk1PwuZemSdNt/O6J1k+nx6ht
         4uVKsH1EcMhq5VwIqpGSWyflyYG7DwWaz7XDoQ5yIOuUIjzw9CMtF/A5kTXzRUOzRhK4
         toKS/o/3lbAMAgxCMMpotZt/Y4OfqNp9Kz8Vzptx+n6ERx/Jki/DngBzDGOefdlemwo8
         TYhg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7D4aOcXCVfxEGHwO4tBrR/JcqsKM+hWROEUrkAQwZLQ+rzr4Xj62Q2tEva29qew/wtg4vMwyudC4w0P+bWJNgnT7xVoWxphCJzA3
X-Gm-Message-State: AOJu0YyyyRHkH2EYxfSBIvKAWWoO0FB2W9xttdj8lr0mjGUNmbaQnJYK
	rrC+AlBnoork55WvUb9B0mDW3aN3/sKR3ECPOVSVG4l3ZmOQYLND
X-Google-Smtp-Source: AGHT+IGA6WB5h1Vgmp1Wazyi22zgCR/Dq8OWifgDgcuzQPoRI0/Ng2ajPekvSxYAfohaQEbeAsQE9w==
X-Received: by 2002:a5d:4684:0:b0:343:b252:2222 with SMTP id u4-20020a5d4684000000b00343b2522222mr472681wrq.6.1712302813154;
        Fri, 05 Apr 2024 00:40:13 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b003434f526cb5sm1311643wrm.95.2024.04.05.00.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:40:12 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] staging: pi433: Replace pi433_receive param void type to struct pi433_device.
Date: Fri,  5 Apr 2024 10:39:56 +0300
Message-Id: <20240405074000.3481217-4-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405074000.3481217-1-ikobh7@gmail.com>
References: <20240405074000.3481217-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pi433_receive is only called once.
It immediately assigns the data param to a struct pi433_device.
Rename param name to pi433.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 7efe6b8501e3..208c0c6d3649 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -409,9 +409,8 @@ static int pi433_start_rx(struct pi433_device *pi433)
 
 /*-------------------------------------------------------------------------*/
 
-static int pi433_receive(void *data)
+static int pi433_receive(struct pi433_device *pi433)
 {
-	struct pi433_device *pi433 = data;
 	struct spi_device *spi = pi433->spi;
 	int bytes_to_read, bytes_total;
 	int retval;
-- 
2.34.1


