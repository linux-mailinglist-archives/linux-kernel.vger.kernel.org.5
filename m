Return-Path: <linux-kernel+bounces-39122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3183CB19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB6E1F21003
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4A1386D2;
	Thu, 25 Jan 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO9UXfzr"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED1313473D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207324; cv=none; b=WJLA8Ka7C4Riix9VBcYOUnKD7irqjuQ5ZgcyR2Gh6snpWcxuHPmB6VjJKXsLLjflTE2M9ZjNQ/6AMOXGvyvCY/BIihNq8vaxLmH6s/GKW/QtZ0RxLlhJXBzCkqAlWy4XhcwsbnqQdXGvrAHm2qzEzL1XNfLyqTffbP2AlCON3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207324; c=relaxed/simple;
	bh=756udnWKPUnYu+tviVP/6MzNK65B+hc7fr7/t17LzaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntnzcAwJ+c8q/Jkh6Bj2GnUBmnLd1qp/75UcxDAUFVUHuGaqA0RIACgqCpyrK33qcZ6kCiFNdrONBoTisac3hcYAu5A5CCLwdn0T00MI4dJdx/c//2eReyJfnGMR0D4cJ9R6uhcC2L66hJzA9uBlucNZOpVXipkEwkWNNbLHT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO9UXfzr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78333ad3a17so562264485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706207320; x=1706812120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLhCwnRRIZ1E72pj3tBhSpsWi74rqeA6ru7YY86vWc8=;
        b=mO9UXfzr7iiYQ0LltAqd+UVA5xLXhbhgv5Racbh+U7Y2WbE6myGOdYLM0pxDznQhbq
         sNfl5C5A+EgT3vNGE8vXXyVcPNvP240ERHJW/ieU6o8Gh8eQgq/GoTWXGCvMZ6x016/C
         xV4PfB6r1w3p1T2ml75ITKn6kFgcvayy0TMclD8HBpaTq+U7LCgDvTZwznupuUVMYfwl
         1yvQHLkuZ1fcHfOWaEzbpqzdMFYQC2Vt3PFSbBiF/T4/9OzdovZvgs9AntddZ8IvGZ+9
         Ag/v1iqVDb3YrBhm/R19qui3PT2NHKgEuhI/9XAhOKGb6B29Mz1rBhAPCoQNo+UEFEa+
         L/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207320; x=1706812120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLhCwnRRIZ1E72pj3tBhSpsWi74rqeA6ru7YY86vWc8=;
        b=CTdJ+VrrvOIJwToYVaaWdmtJMUU2SyjKRkhfj0oylBWqV4EOLAmicy9gDU9jAGEprF
         M5jzf9PQizwNrq8JP2Y2ANEBo2CkFUTrrVKmAIdAUKTB1qfGjZLPxlUrd/Oih0xOsDsA
         goRcYBzIh86b4yBALM06ok4EXoc5kKFkMXIr36vfrP8WjsJI9ObGoowD+TpmD9w1tWRv
         7mUuHpPwxt1qe3NaNu2szziq96gBkwBGWEO7BFHGAQQQH4HyGgHN8ToqXv38OQVdMVtJ
         3gWh20f4vAG/KqaZWzKalURNDHthM0WWFNCEIThV+z1D+uKyLj1uDUI/c4bfdEYBPmyv
         x2wQ==
X-Gm-Message-State: AOJu0YyUKYsDGqG6EKJBRgpBu0WyM6vVLMS4sqUSeRU2Znlqbana/t+y
	X49IfS/9T9mHZw3tdZWSyf69ti+dZdnCnbUFv9Na69XOmT9ILL9dbflPTMZi
X-Google-Smtp-Source: AGHT+IENIfq2UC3Og9qo2vh57IZoVlyR7hwFppNQFJocCbIrcZLJZCfEHxBEHlZFM1RVSvBhlQNCNQ==
X-Received: by 2002:a05:620a:8529:b0:781:2dfe:787 with SMTP id pe41-20020a05620a852900b007812dfe0787mr101689qkn.111.1706207320207;
        Thu, 25 Jan 2024 10:28:40 -0800 (PST)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id c21-20020a05620a201500b007831ffa4234sm5285373qka.42.2024.01.25.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:28:39 -0800 (PST)
From: Jason Andryuk <jandryuk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Andryuk <jandryuk@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm/cpa-test: Ensure pfn isn't already in use
Date: Thu, 25 Jan 2024 13:28:35 -0500
Message-ID: <20240125182837.52467-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure pfn isn't already in use before assigning to addr[i].  Retry if
in use.  The subsequent pfns were checked against the bitmap, but not
the initial selection.

This prevents some false positives on a machine with a small amount of
RAM where pfn collisions are more likely to be seen.

A Xen HVM first showed:
[ 3640.227939] CPA ffff88800869c000: bad pte 800000000869c163
[ 3640.227982] CPA ffff88800104e000: bad pte 800000000104e161

Testing this patch with a Xen PV guest with one 192MB of RAM showed
varying numbers of addresses like:
[ 2768.082971] CPA test 5 pfn 930d in use

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
This could infinite loop on a machine with a small amount of RAM - is
that worth handling?  Just skip an in-use pfn instead?
---
 arch/x86/mm/pat/cpa-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/cpa-test.c b/arch/x86/mm/pat/cpa-test.c
index ad3c1feec990..bbf337e3e246 100644
--- a/arch/x86/mm/pat/cpa-test.c
+++ b/arch/x86/mm/pat/cpa-test.c
@@ -136,7 +136,14 @@ static int pageattr_test(void)
 	failed += print_split(&sa);
 
 	for (i = 0; i < NTEST; i++) {
-		unsigned long pfn = get_random_u32_below(max_pfn_mapped);
+		unsigned long pfn;
+
+ retry:
+		pfn = get_random_u32_below(max_pfn_mapped);
+		if (test_bit(pfn, bm)) {
+			pr_debug("CPA test %d pfn %lx in use\n", i, pfn);
+			goto retry;
+		}
 
 		addr[i] = (unsigned long)__va(pfn << PAGE_SHIFT);
 		len[i] = get_random_u32_below(NPAGES);
-- 
2.43.0


