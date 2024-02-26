Return-Path: <linux-kernel+bounces-80631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08638866AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5A71F21430
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E611BF20;
	Mon, 26 Feb 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="id8ndVyY"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6468F1BDCB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932391; cv=none; b=OSNpAFDejCbJHWle6vhyEMfIp/AmbGUXxkZl0tzx5+yIFx+pz+H0DrQHVnqC0lOWcwNdIHP9UNs+1O8WKYnhgGppifIYrNi2BaWPv6ZeLkAM2rCT0p8Wd2yrU3qxt4QhX3Krif6WXv9CWP1/jBsJCjR9Ryq0TRM+XELe1tOgDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932391; c=relaxed/simple;
	bh=qPsFkvdA/kFCDJ8vwXsssv+4A2ZY6yjRRpNtVPWmndY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RfKakdGIaorQ6V1ZYY717KaTD7T/2NH1FyQUr3xP/gw1yMLtfVqMaa0jMwSRfKIanohTU8YGvr0SnFRmRmBGpjmW3DrVt5bWOQrLKcIMdwVJUdtQOiDwmCxuVXsASZeSiA7MuctWI/w3wAWINSMzbYni+AEdxWi4cXntGnqjoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=id8ndVyY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e4f49c5632so301690b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1708932389; x=1709537189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjePcL8BUGrL8noDvW1Os1K5ntKu4PXsZjDkWTtsAqk=;
        b=id8ndVyY7kXyenCTzHI83Upr/rpxOphevcJsuMR8LdIyBEVMTRvlslr2ksktepVNK1
         xVCH8tw2wWtMOBYiYGoW3wjdaYd6ZVBUlgEHPhoy8SaQPgWLRWqpTpS4N0RCrGDDhYqM
         gZCuECmGVtxLVREQXEEtFaQgr+FS2s05Aa4Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708932389; x=1709537189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjePcL8BUGrL8noDvW1Os1K5ntKu4PXsZjDkWTtsAqk=;
        b=q3EwLox12ZRoTQqa5/GxbMhxd98/6D3xh7Vsh1G7TNfmH1qfeFUPV/s3DAdofSd8z1
         IxzY8XWfuQEidnC2ho+fcd8qeNHNRu9TzlO8we5km9SrUtgwF8hVwh/PN+VYLVXrczW/
         vTx4UJlkSQrJlgac4gINe9rQblTm9DJf+g7EVnR0QBT5Z61i4fD6TrTchVBL8N2emWlb
         m1uo5CEJAyMjm908X7oTsb1QzcTzACS0Suedc6GrXCEpGJul/tjotPypwZGQ/DddLcCl
         sOfbWYsHiqrYMVVemvolLJ0RZ+pxCeszm98ybZF6XnAuTy4p5+DUvS2HwS6Z7cOMmoZn
         Sy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU432xOzZOWS3OjK8iCxD7DKolPYfZvm0xh5P9yNvLXmXUKqOEinGa2F5EtL0ZQbMKt536njQ78+1TzG5O0Tmc4FHmwMB2v4m49nZjG
X-Gm-Message-State: AOJu0Yw8FiYKLXsSyxd8+8ybzUhoFJEjHs44NWGee0pXVAEC6QMRxtnO
	J4oEvpTQBj2vmCIqd0Klc4txbazYhjnRJHjtK+13NMwylwqEWvCL9vSZhEOrkBI=
X-Google-Smtp-Source: AGHT+IGfWvb6/iOZtgWsw79koFVef0neb3umqtxYVIT6P/4Hz5Jy10nS56e+tIhvZMi1S4MWrFhB2A==
X-Received: by 2002:a05:6a00:93a6:b0:6e5:35c8:ef06 with SMTP id ka38-20020a056a0093a600b006e535c8ef06mr769332pfb.31.1708932389515;
        Sun, 25 Feb 2024 23:26:29 -0800 (PST)
Received: from nuc.quora.org ([202.83.99.71])
        by smtp.gmail.com with ESMTPSA id ey11-20020a056a0038cb00b006e144ec8eafsm3405624pfb.119.2024.02.25.23.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 23:26:29 -0800 (PST)
From: Daniel J Blueman <daniel@quora.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] x86: Trust initial offset in architectural TSC-adjust MSRs
Date: Mon, 26 Feb 2024 15:25:33 +0800
Message-Id: <20240226072533.341382-1-daniel@quora.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the BIOS configures the architectural TSC-adjust MSRs on secondary
sockets to correct a constant inter-chassis offset, after Linux brings
the cores online, the TSC sync check later resets the core-local MSR to
0, triggering HPET fallback and leading to performance loss.

Fix this by unconditionally using the initial adjust values read from the
MSRs. Trusting the initial offsets in this architectural mechanism is a
better approach than special-casing workarounds for specific platforms.

Signed-off-by: Daniel J Blueman <daniel@quora.org>

---
 arch/x86/kernel/tsc_sync.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 1123ef3ccf90..cd64b25154d7 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -188,17 +188,10 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 		return false;
 
 	rdmsrl(MSR_IA32_TSC_ADJUST, bootval);
-	cur->bootval = bootval;
+	cur->adjusted = cur->bootval = bootval;
 	cur->nextcheck = jiffies + HZ;
 	cur->warned = false;
 
-	/*
-	 * If a non-zero TSC value for socket 0 may be valid then the default
-	 * adjusted value cannot assumed to be zero either.
-	 */
-	if (tsc_async_resets)
-		cur->adjusted = bootval;
-
 	/*
 	 * Check whether this CPU is the first in a package to come up. In
 	 * this case do not check the boot value against another package
-- 
2.40.1


