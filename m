Return-Path: <linux-kernel+bounces-107263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BC087FA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F2EB213F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEB465189;
	Tue, 19 Mar 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="CPOKOj8h"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8957885
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838087; cv=none; b=uXSzKmUBCFB/nQxTUwnDfgMSFwSbx0L+PxAimsFl4OOy7k4UmrwpEKUGQAfiC41T2gN77pJ7IhExVaH44p5Ws2C6gwdvTJS5QiNZ2HAk5mWPVC9NoOD5I00d+pJ/GHhMTMfSINXyxjFc6oZsHEScDTQjoqWRk6pkztlny3WSJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838087; c=relaxed/simple;
	bh=yD5Qhvh8XSbjwz92hE7wPvI5eJN6qwCcS6HBTqclJ1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QqXFHtWIV6vs2VM82SJoy16W0QwLXioWS1f/eGyKtPbl6E9ezxRXnc8FcE1B1+H0vpl4QO53d5IKQ/A1/x7Xv3mGTrNp/D07gvK4k/HL05w/q7GoAIVQJ4a3rz9RQkEclr7eHTx3dLubbOVQwpV6keonULH3ghDuqiBAkUGuOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=CPOKOj8h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dddbeac9f9so35623795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1710838085; x=1711442885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sluFmFapcoraz5s9n3JUaN6HGbEmuC+aZfPxBl7HKdY=;
        b=CPOKOj8hyZb0A9Fc9inrozRYRuO75Xf1NeuvZlLglDIjvOahzub/qDTAHsobxWQNzR
         /1c481fmwW8p3pXsWMu3CrV7jjcUwIXdhzXEtxC6l+CgzoGY8JiRFnQvoeVm0Cyb1OCi
         LG21IJjOCbKxYJbNn0IGkx8SXBvYRz3hA5wUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710838085; x=1711442885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sluFmFapcoraz5s9n3JUaN6HGbEmuC+aZfPxBl7HKdY=;
        b=bekaK7HCrn7FAsxKDpCu2IG9M814rLOBeYBkoVhzc/h6Y0kVY7i0iq9DjDLxcv6p5H
         8KhauEQoIx86jmbwcRwge+DvtmGUhRtzPMlI1KAz37nD+OTm3fpnw3Y8d5X1ZfJgyQNE
         eGIWg2LX+9Gs+twQwRnwSg0f/Ve68O0RspooEwmAOEIf304tikuRcp74O5+z+eNvM1WW
         vnTHPK3oZ4ngagTBq8RF2wvFt6Qc+ulbOs/ZFh6cP8p3poHnJToveSjxtDtvYPW+NnZJ
         Ii+MJRBNRsOHDYduhbQf6pGazmXf3uw21Umm4lfRWjnGSv/kRhkg4QwnRq99rm38l8r3
         xkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCViU/HRPdxFTZArn8uk0pLEHd6Uj3S0Kna21F+C+bTWagoeHcla9S8AomVFaY5wxRA77p6UvuoHEh0jwaydOxpWwNCFZb7BedN+rkN1
X-Gm-Message-State: AOJu0YzbF+/CEA6sq7X+rfZqLAArr55sSjN2dCx/GM2e/+JKq5eaKVjP
	EHRaEtFR9obAnvBmDhx12bR64MqtK786nSpoWd4hkkx+KvIpf91D5AA+CdgOuHw=
X-Google-Smtp-Source: AGHT+IHkBY5yljndloy1mcKEf/zTWo+284CnPj6frqlIb28ri/8OQ3NAzQ3N0LqTEyfX34irQ6sGVQ==
X-Received: by 2002:a17:902:ea03:b0:1df:3a42:2769 with SMTP id s3-20020a170902ea0300b001df3a422769mr11855928plg.6.1710838084690;
        Tue, 19 Mar 2024 01:48:04 -0700 (PDT)
Received: from nuc.quora.org ([202.83.99.71])
        by smtp.gmail.com with ESMTPSA id jw23-20020a170903279700b001e02875930asm3474488plb.25.2024.03.19.01.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:48:04 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>,
	Steffen Persvold <steffen@numascale.com>,
	James Cleverdon <james.cleverdon.external@eviden.com>
Subject: [PATCH RESEND] x86: Trust initial offset in architectural TSC-adjust MSRs
Date: Tue, 19 Mar 2024 16:47:19 +0800
Message-Id: <20240319084719.1182501-1-daniel@quora.org>
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
Reviewed-by: Steffen Persvold <steffen@numascale.com>
Reviewed-by: James Cleverdon <james.cleverdon.external@eviden.com>

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


