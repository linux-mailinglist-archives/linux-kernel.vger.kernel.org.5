Return-Path: <linux-kernel+bounces-127834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29CB89518D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A341F25B32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB85626A0;
	Tue,  2 Apr 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTatd7zE"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BD65BD1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056471; cv=none; b=IkUUdCwKaGugtK5Iw0dc2ClIGevbEwo/LRdGFiJFLNoKBQoVgXCs1n2lw5waIXld0MZKN21q2TlwCIv2AJ1ADd9KD7MgogX4pw2jCxMVVa4qldtLRcJHjiSSeFdZYhHzIAUqZ7kP/wI0nzhthKkdumMtOWqVp7xrQsd53npeAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056471; c=relaxed/simple;
	bh=jK+AFaPuB4QJkOlQSpapYzjziTfiCfCCfo7UWLC+ajY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2YJLm12QC1LePG0kJn2za6UhCj5zBkDWBsrIO91rMcgYrUvPfLb3U50UBFSqa3nVWvoivbg+rakyc635pdXh/1lxPo056sQB3yG0A+JCcQBWPYKSRJ4jLPVYEU+mhFwaqvmjE5Kp2CpAFitQXfIeYxJtsJ5bofYvsl4OpMxiM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTatd7zE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6962e6fbf60so44097786d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712056469; x=1712661269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF9nmGQgrbBBKoEODSqmsdf3m34vi7We9f5KYGrq5eQ=;
        b=XTatd7zExMDOaI0CoJwn8flni40honijO/2m59N6mMmHyiAnC8HZK5wfXbao3WaUiF
         ddikk650/vphdp6UdS8O0ORrpaWs15dn1Q+kZ4AWENLNLaY2vNN4EUNIBLnOxqmaRYPZ
         n00eBZN1JuKBwIvBOPrl7ehL/qDVQW6MTpkUQyW7yaY4JNNc3GYwCww7MQ9rbN+Ojm8K
         aG2XC0JVaebM03kIZq1SaWD8DqLHmzNBZC9ZAyOxD/u3rss8HI18nw319O2k8TJeXhmw
         viHQ3ZSWNlUMxyIQfWd+sVorJnsEGxVzih1OjYv9vnNhVBqem+YfxrN7XH4jAGyq1OKl
         epDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712056469; x=1712661269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF9nmGQgrbBBKoEODSqmsdf3m34vi7We9f5KYGrq5eQ=;
        b=RfIm3bZMOu54oW4kMIv4LORxDK9eP2Sw29vEbASC+ER1WWyk16JTovNYpgZPcV2y5E
         mmSd6G0Whk9g3F2BhTUcvVQnPmbEO7Dvt4UNMkUyn5mfAT9tYNx68xQVPlpuG1nvqCSF
         8LKXLLo1UIa8qQoPBV57z18RCRdZFQlw90Zvy+URA+NxZm6zgpYYjiOzK7axDDuNSuha
         4l/eAydjtOPSh7a7GqzDqEidE53tZHjLjZ0oQr0jki+bxSA6yQL6ppl/MpegbxRtEF2a
         B2LwJF2ss/plGOVSjf173RY9FQhdgAj/oSJP/FpnZSTEI99jAEsV3MP/NRjzwv9DhVZ/
         qSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8HZNEtnICa77KPOgFnqSMzYtv3L2uLJA7jHqFG3xLQ1FuRvWj64YD+R7tjYoCUTILd89fIoG6hMOHrzj2XbIly1QHNVhboS5zrhhM
X-Gm-Message-State: AOJu0YxYDtaD60BMpoQ0YIfqQiid/dFF7drSGKiNuwhBY6h47fH0G58k
	cePeO5ViukHyyglQeT+MaxmTcbC9DxvWU0wjMm7ags9/tbJb1yHE
X-Google-Smtp-Source: AGHT+IGS0uqiCKJa4dv9VNSkOwxSSex+kQ8m3oeOu7lY86dHg2spNQmL+dupDA7mrw1XNDRQdV8eTw==
X-Received: by 2002:a0c:fecc:0:b0:699:af7:1fa6 with SMTP id z12-20020a0cfecc000000b006990af71fa6mr5206180qvs.47.1712056469197;
        Tue, 02 Apr 2024 04:14:29 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:2c6f:6cdc:f641:6ecf])
        by smtp.gmail.com with ESMTPSA id 11-20020a05621420cb00b006968a6fb010sm5428855qve.91.2024.04.02.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:14:28 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] staging: pi433: Replace pi433_receive param void type to struct pi433_device.
Date: Tue,  2 Apr 2024 14:14:11 +0300
Message-Id: <20240402111414.871089-4-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402111414.871089-1-ikobh7@gmail.com>
References: <20240402111414.871089-1-ikobh7@gmail.com>
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


