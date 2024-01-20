Return-Path: <linux-kernel+bounces-31690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29696833285
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4482834BA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40069DF78;
	Sat, 20 Jan 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLvbyuHt"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FAFD2FA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719068; cv=none; b=Wj4WJDhtv719NOfPfwkr2epZujBkf9XUOIyKa79QihzSLJ7zducK8Etx4gxxKCEUNMOYiUpLB/T+qryX8+tsPAIGg1DkJFZJwSCY3urU+8d/Ds7yIK6i3b4V3P07RZB0yuZo8mv0/6t9ZIErzVVLqRlnbMsfJNcbaiGHPAhMOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719068; c=relaxed/simple;
	bh=bfKkfZdK+j5iNHBICR9hXv9ldRAf+PdIDkkPbpbg0as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D45D+dGltoU82AFHGLFZ1HOuv+fDhfGQSFgON0Ri0X8bnjL2Aujvu8CJX0c8YOX2FdcZ9wJp9HgnODTPpDq3eHw1+hq14fs5l+T/JVVsGBjgVaO9AO2zitnsZvSPL67u+3ey8UJ62qfI766IDuackI+aW6lB7H5u1qRR1Ll2B4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLvbyuHt; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed0710c74so1360375276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719066; x=1706323866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khrCIVPglrVXE8B6IKw0gUJXYk/zQUc0AIxevIyXOcA=;
        b=gLvbyuHtYu5VEXLdBUGGHjGXAIvDDfz4RTzy9tu+03I6BVnr2q+DMrpgF3xPKlV+BH
         +lWvWqoA4K3hbc6FHANmTqqWjEP97WwcFKsoHAuzNKUy1PjPeWACVSPOIPDKK6tU2Sk7
         Nh/1Hxa2wAzt1Vxkd7IU+xEQCxwOGhmyoaYgTktYgT6ADo6anzGD/XH++vSsPKVYi8J1
         EVoxhiOEk3Vet/ynJzkPsKrMHgsC8r7vXilIpxtEWKFcNl/a57z9QTqe573m0J2vk5EC
         juprm3LqIShVtboKF7ErW5uskqp0em6550CpzFeeIz9nALqmAtCCc9rTsRFz5SLuRvDW
         l2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719066; x=1706323866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khrCIVPglrVXE8B6IKw0gUJXYk/zQUc0AIxevIyXOcA=;
        b=PdpYdhxwydVelCMGV0qS0tRKB0NEOjyvYN+6xYNHdh+PCb2LXpJFXLFJK64KC3Lcv1
         JwdpK25R6WCpmYu/KZvGTZlSLtYqqRvn7Tj7FSuf9WxGWXiu9UE8hchHku2Lkpi4olaZ
         ntgeIeXhkfvWULy88fU0tRcRxQq0WtRwgD6Pu1CtIHdBHBtgamrevlKKklbdvt7UdpB4
         ve9xSAvkbx6nIhIY2JYtnOIRzVdre9X3Gpc9fGR91RlpwjlFtcB4L3nKxblKFlvLJar0
         ieqxCVPuxBWj0q/JxQReEos7LAP8acSRjKov/qmB7nvEu7sHKOweTB70uurRdqhgBPFL
         /u4w==
X-Gm-Message-State: AOJu0Yxbh9HwxfX8rqpoGZwm9FTSPpzPxlMOOXL3kHjQ/VpeGPV26m69
	XoMf8uSjYryLAqABraTSXEN9QyIEct9lFzQ1yM7FMOMMw7mdB+y2
X-Google-Smtp-Source: AGHT+IGJAk2hlN5+5Sn7hGHowuv9qXVJkR2kSnp4V7X6LefuFI94JPINworViKWnbNzJ1lazqHyT7g==
X-Received: by 2002:a25:9243:0:b0:dc2:2327:fcff with SMTP id e3-20020a259243000000b00dc22327fcffmr806679ybo.29.1705719066184;
        Fri, 19 Jan 2024 18:51:06 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id k129-20020a256f87000000b00dc24ed83a6csm174854ybc.62.2024.01.19.18.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:51:05 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 7/9] cpumask: define cleanup function for cpumasks
Date: Fri, 19 Jan 2024 18:50:51 -0800
Message-Id: <20240120025053.684838-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120025053.684838-1-yury.norov@gmail.com>
References: <20240120025053.684838-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we can simplify a code that allocates cpumasks for local needs.

Automatic variables have to be initialized at declaration, or at least
before any possibility for the logic to return, so that compiler
wouldn't try to call an associate destructor function on a random stack
number.

Because cpumask_var_t, depending on the CPUMASK_OFFSTACK config, is
either a pointer or an array, we have to have a macro for initialization.

So define a CPUMASK_NULL macro, which allows to init struct cpumask
pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectively
a no-op when CPUMASK_OFFSTACK is disabled.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 73ff2e0ef090..0dd8e810200f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -7,6 +7,7 @@
  * set of CPUs in a system, one bit position per CPU number.  In general,
  * only nr_cpu_ids (<= NR_CPUS) bits are valid.
  */
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
@@ -898,6 +899,7 @@ typedef struct cpumask *cpumask_var_t;
 
 #define this_cpu_cpumask_var_ptr(x)	this_cpu_read(x)
 #define __cpumask_var_read_mostly	__read_mostly
+#define CPUMASK_NULL			NULL
 
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
 
@@ -945,6 +947,7 @@ typedef struct cpumask cpumask_var_t[1];
 
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
+#define CPUMASK_NULL {}
 
 static inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
@@ -988,6 +991,8 @@ static inline bool cpumask_available(cpumask_var_t mask)
 }
 #endif /* CONFIG_CPUMASK_OFFSTACK */
 
+DEFINE_FREE(free_cpumask_var, struct cpumask *, if (_T) free_cpumask_var(_T));
+
 /* It's common to want to use cpu_all_mask in struct member initializers,
  * so it has to refer to an address rather than a pointer. */
 extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
-- 
2.40.1


