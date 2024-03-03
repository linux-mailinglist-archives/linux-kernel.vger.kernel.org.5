Return-Path: <linux-kernel+bounces-89694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF5B86F445
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E391C20A42
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2DEB662;
	Sun,  3 Mar 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX9tktsv"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6FB642
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460356; cv=none; b=MvZrGSr6rVqthpHXFAg71J1YKv1u32ZMKBddgqVxxM9vO7//75nKnBy1gRyEznvFf+SfkzHeZZb5hQXczqMVRTWk63zH0gaJ8XRE3dwhGcvqffYl4PcjNzH0ETOlm65YTyIrFzu5mQlGaxt7Jg/vgyB6WR/iKDNUilvXy9PnyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460356; c=relaxed/simple;
	bh=tSobmWen73fv9nPU7r7xbyASdzEXsh6NI0D5+8vjLR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yqu8p9IOVgVNZPnN1cncp0dRaXFZz4bCdEKlWNYtcy++CxvfsSilkGDNeBuQsBF/B17bkNPgm4fRfe3Outs1wSIiL7hjd81AcRkmLJt0hWm2BfX8MQKHbREhdzgX9c8IHnEkCva6Vv/yKHBFrhVjw+nR9ry9juJGPsys+MY7m5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX9tktsv; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d228a132acso44072491fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 02:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709460353; x=1710065153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J8iW5FUb6Ai9/iyJ+EPFHL8GpePG+BU8Uo9Ut8WfDZE=;
        b=fX9tktsvhjkjwbIb0EMG4WwZBojWKRrf4gNgANfs6fbgFp7f2n6C8hmK17TnvEa8p3
         iy+4xZIp6ztil+Hz1WnwrkA13TdkqpkrHWJ0iksODK4iiZA+s0vbMXyTxh7tZr2Dg03b
         alBgB3+jjP2qP5IibM2sVVIjAhQ+8y9wqn7IwSD8rLCRWTlmMjj54FGABlFWT4dPA9VN
         JW21OQdD6IRw/k2P3wO2tWEaqXzYM8BctwaNWrJ8pqgiQVZDW3poD/5AdW4SjUV721rR
         1dbvnhz7YrlKtIyCii4tIi/aah8e6OyDpZywrh3B8rJmMSTRxlpyw1pDR+rhJ13xG9/R
         Z/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709460353; x=1710065153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8iW5FUb6Ai9/iyJ+EPFHL8GpePG+BU8Uo9Ut8WfDZE=;
        b=jbJkO5Y+sM/fUeQDtbFJiTEf3q9RKkmQh0ZGyhQnG6nyjfZi7n+e45QG9GNVmsGE7w
         iuZHYD60tgduXSkoZ572o24I9SpUGYIDYUUl5jqc0uoqagz86jFa5DS0XP7fyPBd8n6L
         wHfkQ/i4wyhTgnPLnPcUgxgOj91LjlhLzQfNBfm2zzzkA/ohVbZ0G5QDOWSpWLX3tzCh
         UKqCD22ne4DVhbVJxrt835aG0GxdaUSFjbm45HF2wrVeYIN7GXIfNxQ8wehBd3dYplwS
         Pd23vB70HmJhTaUzeKY9s3NHb18o9w9/BUM5tV73FEe5EedKXK1V4UC2Dx3SNDYfdBab
         xxkA==
X-Gm-Message-State: AOJu0YyH907vPStRT+EA05pSYUhwnECc9qq7Jv6Y9+JzqbSrFXrIvQd0
	nDz8zYtumQ56FNd6siTfONlZp/UwqinDqjfC/v5jejKEw96P30TN
X-Google-Smtp-Source: AGHT+IGdvgKm2MhCmmOaXXHkFFtt/k8NV+hwFxoNtCcO+7XEAbDrKUH+xlmE515EW/FbQOoYfPmRUw==
X-Received: by 2002:a2e:a688:0:b0:2d2:a9d6:c435 with SMTP id q8-20020a2ea688000000b002d2a9d6c435mr3697205lje.34.1709460352548;
        Sun, 03 Mar 2024 02:05:52 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id n5-20020a2e9045000000b002d24306ada3sm1264523ljg.120.2024.03.03.02.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:05:52 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/2] staging: vme_user: Fix misaligned closing comment */
Date: Sun,  3 Mar 2024 11:05:46 +0100
Message-Id: <20240303100547.153636-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following change:
 * Ensures the trailing */ for comments is on the same line as the opening
   /*

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index 4dd224d0b86e..2a92497c5570 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -691,8 +691,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 
 #define TSI148_LCSR_VMCTRL_RMWEN       BIT(20)	/* RMW Enable */
 
-#define TSI148_LCSR_VMCTRL_ATO_M       (7 << 16)	/* Master Access Time-out Mask
-						 */
+#define TSI148_LCSR_VMCTRL_ATO_M       (7 << 16)	/* Master Access Time-out Mask */
 #define TSI148_LCSR_VMCTRL_ATO_32      (0 << 16)	/* 32 us */
 #define TSI148_LCSR_VMCTRL_ATO_128     BIT(16)	/* 128 us */
 #define TSI148_LCSR_VMCTRL_ATO_512     (2 << 16)	/* 512 us */
@@ -753,8 +752,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_VCTRL_DLT_16384    (0xB << 24)	/* 16384 VCLKS */
 #define TSI148_LCSR_VCTRL_DLT_32768    (0xC << 24)	/* 32768 VCLKS */
 
-#define TSI148_LCSR_VCTRL_NERBB        BIT(20)	/* No Early Release of Bus Busy
-						 */
+#define TSI148_LCSR_VCTRL_NERBB        BIT(20)	/* No Early Release of Bus Busy */
 
 #define TSI148_LCSR_VCTRL_SRESET       BIT(17)	/* System Reset */
 #define TSI148_LCSR_VCTRL_LRESET       BIT(16)	/* Local Reset */
-- 
2.40.1


