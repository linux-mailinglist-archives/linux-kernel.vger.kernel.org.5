Return-Path: <linux-kernel+bounces-159291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B958B2CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208BE2866EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A17168AE6;
	Thu, 25 Apr 2024 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RpPGXvQL"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94015623A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082396; cv=none; b=iPU7aTjIXdOHxQ/1MiWgGDKc4HPED9LTgp+FpB2OOA5IAvniitV9H39+fVrMpUfBLQXkThukXArMvc/G/WDz30m/2XjW2mflwbXL2GGlP9lZlhgbDCG7JWYXcIFP/8kDpsOrCkPPqNlAhGmPwes7JBOtgduJcbeFmvg42jNCqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082396; c=relaxed/simple;
	bh=NNgi4h1D/vIB8B9WWNK8rKrvsAEbOXnhHyZ/SEcHCmI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LMrCoxNQRXNBCFlOjRW2ysWXRz16ug8uwFPVXdTgqCqbTEj8mwuelUAzmpht3IcvWAjrWjnCCI3xTNwf27WTbgiClA+Kx0Jym6nsa5Q5HMobrytMW/0GPg9b22nfFd96tdq0MnPDDAFmb7DWH/3RuTNeN+P2xVhThV6LZEACP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RpPGXvQL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so2689542276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714082394; x=1714687194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l7hgyv8FDM1wHsZylAaox/6RJL9rO8NR1hm+CUZNluQ=;
        b=RpPGXvQLN5T72+EZ89vA5DmogVgx+oXqVHRhOhPbTq5v2RshNEkJwQoaKR9Gwayf4M
         szDAs2juRpSrI0wuMLUje923oRPRLU8cvhFmiG+wUBbj5NQV3Z1Yvb7pBLBCPQcGIBxA
         wSFC96C+nr0oY0pTpswnEmVLql+ZzsBrwfakdJWAjTjGiHp8//TB4gU0ZZySz2t8sjl+
         tXK+rPVFu42yTSrrYzr3TnHfWJjnWAjF8QaIQolshNYuuHRMYSwB/9FuXNVtUVj01A+D
         I/p7el/OPi4x1No3XNP7M7YCDj5mUTlExpuqJeeTUh9l/ZwLfSs68aycDvcw8bVjq16x
         0K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082394; x=1714687194;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7hgyv8FDM1wHsZylAaox/6RJL9rO8NR1hm+CUZNluQ=;
        b=bt3tv5zTV7yw/ig0koN9NqLAImmg7Bpr8z1H5oOImA0BGVApWCDEgYliQVKXvKw3UR
         0CuYU3S/oqsY/NVKrDIGXu/v7l3uwmYGIe/fax+MOwCu8hePtLBOokOKelu6PHhC1Wwy
         RsiHGKsp45AfDEO+d+neBXcMqIwbIGVuQ186Ztjh/Nd930uwePL2N0xGSW8mmjnvlsgM
         3antBxFsVzX6bVB75mYxLYf4oF0SCo+diTvxDPxKZU71JUg57t4XoDxHb8qENBQyh9kW
         Ov8tYDKhT82YNVjQt+Zj/HIM5nfczKJlCM7KmcrcqM0rJ8XhZpvvE+7DCvoMrHtsWWCE
         6D6A==
X-Forwarded-Encrypted: i=1; AJvYcCWcbdCUH04M7dOstSdMPjdzrf/B6yS/OOIgqcoHf3IXf6CuVov1xgxhsn/Wu6mv8xMRRSmbvU8BmjhX9/5l/F6tQD+2AB0JPvqA4bQg
X-Gm-Message-State: AOJu0Yz9mrUn6kqVv4UAIE6tUqXaHgGzCelgj8Xt/BVQqtd6mQQ6IaOn
	mGarMJMTFm2ehzOu4WUpyB8UZh9V747sQglgSYXgIFU3bE+/Qd5Lsl5ABJKFtAPtTU9js7N2ZPe
	kNTSYs0jhjW+kuyEaBg==
X-Google-Smtp-Source: AGHT+IFRO3Uz01eedNagD4MaFbj1TCHrH2OYWaLnefGokv8XltZrBBnf3FkfF5XHqG41ekpe3LfbjjoxDN9hT4L2
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:154b:b0:de4:7a4b:903 with SMTP
 id r11-20020a056902154b00b00de47a4b0903mr112080ybu.3.1714082393698; Thu, 25
 Apr 2024 14:59:53 -0700 (PDT)
Date: Thu, 25 Apr 2024 21:59:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425215951.2310105-1-yosryahmed@google.com>
Subject: [PATCH] x86/mm: remove unused CR3_HW_ASID_BITS
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 6fd166aae78c ("x86/mm: Use/Fix PCID to optimize user/kernel
switches") removed the last usage of CR3_HW_ASID_BITS and opted to use
X86_CR3_PCID_BITS instead. Remove CR3_HW_ASID_BITS.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/mm/tlb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047c..a2ba5bb201705 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -85,9 +85,6 @@
  *
  */
 
-/* There are 12 bits of space for ASIDS in CR3 */
-#define CR3_HW_ASID_BITS		12
-
 /*
  * When enabled, MITIGATION_PAGE_TABLE_ISOLATION consumes a single bit for
  * user/kernel switches
-- 
2.44.0.769.g3c40516874-goog


