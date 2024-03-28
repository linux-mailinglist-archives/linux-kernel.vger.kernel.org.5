Return-Path: <linux-kernel+bounces-122874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E501488FEC2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227751C25FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E2A7F7F4;
	Thu, 28 Mar 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz+YbND6"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFB7F495
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627979; cv=none; b=aDOeA0+IrxHq9G3ITfYOpwxMGelfOkGHAVcYy11gLchd7L6LPhFXuy/JqKfD9HJDipihqW8Dg6f0yb3XZf6Pm+lvSBGigfet4a2WO3k/b5RsL/dSqmRGCIt7FDLGiclAehSN8QOuof3HEyMaCYWqTs2nTuyezo1D1aXksjx2oPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627979; c=relaxed/simple;
	bh=jK+AFaPuB4QJkOlQSpapYzjziTfiCfCCfo7UWLC+ajY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kL6YwDmBDlz5Atsabmd81gIJKl0i/mOgwr0N3h+HJjxXrC4QupnyZY1BSwsjKXvQw+FKz5qCqQFeLID1aA+pR0+FaVjk9av6QW/4V+gVTOqQkKhzEH9E2oatITU2WAqnWALVTkr88XkTtUn8vhLxPLo+CUCEvmICC6G5A/tzeuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz+YbND6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so10808581fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711627975; x=1712232775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF9nmGQgrbBBKoEODSqmsdf3m34vi7We9f5KYGrq5eQ=;
        b=Gz+YbND69YqqMoLEigTS7BrjjCllE5EuT16yrNXgK1S0dD2/E50gMpWdC4evByMic6
         2US9qPco5qWIqHEfxixF9hekkinWi5YOTc6FesyyE6leiqziqOIdcChr4yeJPA2aVKhf
         J+LjzQq3gOWg/te7U6LYaytb9oYClvGpgIqZOyXXA1wxlcM9qMS5mGxJAjioV3WeYwnr
         NBbCZXC/TiUaIGsPpB9NH4nZAe4qQNw8KG504Lbvu4oeskG+Ri2HkOKot/EepISo1o9J
         YMCa5tAhQKD19dLiu9Dx8p3LZNQ6TCl1B6vjA55N2PkrgLOGVurF6bUyz/U+2R80wkp6
         v2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711627975; x=1712232775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bF9nmGQgrbBBKoEODSqmsdf3m34vi7We9f5KYGrq5eQ=;
        b=nyXRa8lsWZ4wmgl1uR0XNXVVI6b0J5b//zA4jaJt6H4tqZxm7Y2by+v8fP28kVzW1D
         Nq44FV1GgEP6q7c3EhzVGFDlJYqPjmoh7ZIkOWwNjFfUcIvT4/5HgqoC1E1TESrrkzTx
         g7tgTCk5bbPUiLy9VpYakTFpXlZnP3G9Q4RldiEtvY69EqfeCuL9YMWcsGefXt5uPLXJ
         VsbyGmVt090NsWCquimJADpfcHFK81H2EzR9p0P3SSTowzicb2fneIGlrCB9G4MiLgFR
         kfkLiQAgPMBZgkcxLZh3vuFMM5YttQGgG9sYTOcVkF5IDz4IOiLegV3vef4un8otaGb3
         Q8yw==
X-Forwarded-Encrypted: i=1; AJvYcCWc7E3IU5ooMpEbHV4K+6CzNItrpzmQdutGelOmffFl7wWxBPaR4ZGuPCAzAL1+FFcLmCpZ72MeJEptm1Of/mtbaGfl9sZRY7+NJtnR
X-Gm-Message-State: AOJu0YxTdhf+pKcAgVxEXL7iUhlF3/armlej0FRY59jHh0/rUqNQ/TPv
	rbAJt1CMRmPQdRb/5hAzXSNN3qrQBSZuUsfCNkeES57kn9UGGzdz
X-Google-Smtp-Source: AGHT+IEWK9ENE10zwgU54CiNitUhI3g7jx9ewL2i3/B3VRdYM5jCJ7XFGT5qust3NTz5llpWiivhzQ==
X-Received: by 2002:a2e:8019:0:b0:2d3:f3fe:48ac with SMTP id j25-20020a2e8019000000b002d3f3fe48acmr2108960ljg.27.1711627975554;
        Thu, 28 Mar 2024 05:12:55 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:125e:963c:4e4b:b7c5])
        by smtp.gmail.com with ESMTPSA id bd11-20020a05600c1f0b00b00415460a63ebsm1416456wmb.29.2024.03.28.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:12:55 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: pi433: Replace pi433_receive param void type to struct pi433_device.
Date: Thu, 28 Mar 2024 14:12:42 +0200
Message-Id: <20240328121244.1244719-5-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328121244.1244719-1-ikobh7@gmail.com>
References: <20240328121244.1244719-1-ikobh7@gmail.com>
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


