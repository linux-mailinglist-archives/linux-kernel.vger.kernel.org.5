Return-Path: <linux-kernel+bounces-98873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4CC878086
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2EE1C2093A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1B43AAC;
	Mon, 11 Mar 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="h1H8y1/g"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17453FE4F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163407; cv=none; b=pLqaWkeMho53HBmIVBVt1FSv/01fly7T/lr5z6+jn5+eV3d0g0F0T14olJy+sKdXDS1Gsx0u1f95uE8k6HHCppBpFBmPriqYDySX5bBxs3PZhbvDVlpmk4ysOva+4AzErVcAQKTnNF3X7shABiCVPxDF2q3EKt6yYcb82kFBgvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163407; c=relaxed/simple;
	bh=veo+1KYcd84Vkkyq1AUfsbLRFWwaOKVUBG3RxoLqPoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iwmZtXCBl6mqrAa+1Hgp2lEVK1pu4hOlRAqI0my+KueDJkbfeUO80VxsQC15pANbMtS3xIxE4XnL0IFNOU1gILUYJVft1OOeoDY71j83pRwQ7qb15R5LwF11aLtuE3VNGW3wu8hLI0uA6o5GBU3qGKdthJp/687h26FtFXhSv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=h1H8y1/g; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5685d46b199so1357720a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710163404; x=1710768204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mEOen0PdEKYkfvmGwbZYSoDNtgExorL8k9mwAI4fX4=;
        b=h1H8y1/gvyJLH4F2wjwY/LOGKnlHq2UguVCRjz4InJWpWTxbP2/ggREy64hvwWe6ta
         yZ6HLkSilZh5emG6jNhQk0E9ez+sP5r4dQndZ68Suj4MZ6IwVLyzmSJcTSzGNj461k/1
         fjGKcIq62lz/f8sYJ1SzeWw6U5B+pRsjISgRa0DpSw6couPBzpu58EZqYSK/GbQHMIdu
         oS4KkjxneV5a740LezkS3lzkNUEH+WIpUYmKqFGSyKRTDHI+CLP6gHENZpolOXqNs+LG
         +au3rVbsfWTA6ol8Xjy30Cq6faEGApsRRReRjwR0rb6KXq1OhluFKgoCWM+hMy/i2glh
         009w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163404; x=1710768204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mEOen0PdEKYkfvmGwbZYSoDNtgExorL8k9mwAI4fX4=;
        b=q4ERoJ9cRc4cgxMWL1FXYWNHuTYFph3MWjHn6hnokpxuJeXJEq5FhQKatmtwd3vy6j
         WbmKeznlBCJ5u93Dr4EQURCTUwx3Jz/0684RmyWmMcjwLtcRlWaIfo169QKL7yeSKK83
         l6iVw8dTlXVp/sBgXntavQyMrjdPnn/AkHn4gjwGlK/v7rII26JqvZiJe+nTxFRRjsbs
         AU81diAsgknO9Hm/0qo7hlxlZs/HtJMD1dJvevPvTpuHSyz1lTTgP3R7x+QrCMMI998/
         0XbjgjIoCUn5FQ0FtmRfIbz9HXZUG0cMZpuA0VLwfDqQq3zwBi3hCUXhWhFCRxZuSYD2
         TC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwyx649RwkOoZr4Xkl5NfYoKMw3bsDl7GdchHJPqeF48nQFE4osU841bq5yTNzss7AW63e7G+QMGJr0sEsM37YYNtm+a8mFX7QLB5X
X-Gm-Message-State: AOJu0YxwzxOK40DwumyQFYnYovHa15TPvTcqvmfpkQpMb0p3lvhSEli7
	jm/0x0SmV0LGNkfW1piQCU0E4vP6yn8T1uXtJGqx1liSAfn3I93fGYukeCnYEOc=
X-Google-Smtp-Source: AGHT+IHy1pfzsVAAO8uOlh4i/oemtUAuHPNn6q344i9I8thnD3AGZ55KvJvrZ9C5m4VtldgJ3qaT4w==
X-Received: by 2002:a17:906:e219:b0:a45:f74d:343a with SMTP id gf25-20020a170906e21900b00a45f74d343amr301393ejb.22.1710163404544;
        Mon, 11 Mar 2024 06:23:24 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a44cb0bf11bsm2861075ejb.79.2024.03.11.06.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:23:23 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 09/11] arch/alpha/fpreg: add missing includes to fix -Wmissing-prototypes
Date: Mon, 11 Mar 2024 14:23:04 +0100
Message-Id: <20240311132306.3420135-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311132306.3420135-1-max.kellermann@ionos.com>
References: <20240311132306.3420135-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes:

 arch/alpha/lib/fpreg.c:20:1: error: no previous prototype for 'alpha_read_fp_reg' [-Werror=missing-prototypes]
    20 | alpha_read_fp_reg (unsigned long reg)
       | ^~~~~~~~~~~~~~~~~
 [...]

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/lib/fpreg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/lib/fpreg.c b/arch/alpha/lib/fpreg.c
index 7c08b225261c..88e912689140 100644
--- a/arch/alpha/lib/fpreg.c
+++ b/arch/alpha/lib/fpreg.c
@@ -5,9 +5,12 @@
  * (C) Copyright 1998 Linus Torvalds
  */
 
+#include "../kernel/proto.h"
+
 #include <linux/compiler.h>
 #include <linux/export.h>
 #include <linux/preempt.h>
+#include <asm/fpu.h>
 #include <asm/thread_info.h>
 
 #if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
-- 
2.39.2


