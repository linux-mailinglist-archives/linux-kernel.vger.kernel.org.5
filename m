Return-Path: <linux-kernel+bounces-139523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5318A03F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849611F21A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1683D961;
	Wed, 10 Apr 2024 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nor0uCVt"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9928370
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791336; cv=none; b=V69yvDLYFYCZ3M/YpVW06fqW0R9gJ8Fh8JbtTUOEwcq4gTwVj2Jsn+RvAVifbNYD7mJxUImTa+1GqsOIXfqlBMtOJ4eiM0yaLc3kQy40IgywWRfFyysMykpaxJV0X0e6kaBFlG0qEahlFmHx6g3Fr7UJUi0szf4mG4ojMDLz5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791336; c=relaxed/simple;
	bh=bZojjozRdT7pd8nKdcCQ1cu9hUTv+swmCS9zB9sLjbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzGM5zpS6JA3nZXWmduNB5rxar6G6tlF17hVvT/ROuODvV0apuecIj0IzS1Wg6k1vOLftFF3xkYhmmgU0th1OWlh72BBYvFjNK32vSodBhte5coJ3BltFTsEOQgm2jnx0Ek0Ll9l3BlW7icJMQK6/VksdG7obe60BG8hgBSVlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nor0uCVt; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed267f2936so3154504b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712791334; x=1713396134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGK4SWuPfM0vV+la96MhcpZ8ztiKT+W2nuURhMgNDV8=;
        b=nor0uCVt5WbwJPt5f5XGRn60Fy/ctUAy+b9lkUidglQoH5isqz7c3U7C9OMMc+nuqc
         9On5KDT3xNcBcCVKzR0Y8+7C1mTeYNdJTJkdX7suWlCD4Z7Ee9CDRVpCUM8zyMq5RwvC
         6Dlheg8LktV8yoNmjKXy1uWoqVAegMNKY1K3KOhVPvP4O27Cgtb+w70SYNXuDwXBnbZj
         tC/LFY1vC3WXB5Zceb1YQvrCRthKbdKXQqtA/0uAYC9IAwgZfawlkIOY1l8dkDlrsgu7
         lePvI90dnExYPxnVM5+JPsyDHhRIZfprOR+sCofsokLsH/SmzMT9Dm3AXVEV3BSOVzCm
         ZWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791334; x=1713396134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGK4SWuPfM0vV+la96MhcpZ8ztiKT+W2nuURhMgNDV8=;
        b=Z/NfcgCOuwVwY2jnY/53j6YgoSkieVOMtG+P8w7tkk/U506Xel74B04RRzdnY4btFf
         VJZBMk76F5aSb/ZjQIMv/1lYQzSSUXx9D0xHMNYR98D1p6oaL/QK3cXCH/AWGXdxWNc/
         0545V8kvib3wR1NBsUSCPZPOKLS4uXFUHAfcrkAxGEbZpuuTDZuki10CVfOxOjzj3wHc
         ODKdxPJ+kY0LBA4Qt5GnWevH4tAewh1zdX1HVscP+KBX9NWTrNYRd3+6HqBhMidu9Dt6
         z3wdQiPQzPDr6isWhhqL194N11es42WawnZjqOZk1wbDGp7LsQCRN4OnkPIvwfb23665
         AQYw==
X-Forwarded-Encrypted: i=1; AJvYcCVdNB9wwwUNX86Glg7erZ5qHfJRSi1TrQwl+Jvfo2xIp4UOPBrjCv/xHvSoWs2pFThJgJcnRsqwX3wC+cczVjhDH8MsBzoasFcbth12
X-Gm-Message-State: AOJu0Yz/h6Pu1swva+6pQ3CB57jElEBt5+MvoypDMcxXjG52W5kOYsSb
	wAqQX4IjMkpKRC3BUosR6q+TKnz2tFP3mgS9VM8tIu1p/ibgEwkqdSlP73kydoJJYApk3rjvlYS
	t
X-Google-Smtp-Source: AGHT+IGTfMmH9J6bgqBOBzgLbzpJrhS/cLoXAl3L6QF3WCUCaGsZwjRjRVxiKnm08Pxdo9H0G41t7Q==
X-Received: by 2002:a05:6a20:3943:b0:1a8:672a:3fb2 with SMTP id r3-20020a056a20394300b001a8672a3fb2mr4887983pzg.43.1712791334017;
        Wed, 10 Apr 2024 16:22:14 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm161865pjq.40.2024.04.10.16.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:22:13 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	kernel test robot <lkp@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] cache: sifive_ccache: Silence unused variable warning
Date: Wed, 10 Apr 2024 16:22:03 -0700
Message-ID: <20240410232211.438277-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410232211.438277-1-samuel.holland@sifive.com>
References: <20240410232211.438277-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With W=1 and CONFIG_RISCV_NONSTANDARD_CACHE_OPS=n, GCC warns:

drivers/cache/sifive_ccache.c: In function 'sifive_ccache_init':
drivers/cache/sifive_ccache.c:293:23: warning: variable 'quirks' set but not used [-Wunused-but-set-variable]
  293 |         unsigned long quirks;
      |                       ^~~~~~

This is expected, since QUIRK_NONSTANDARD_CACHE_OPS is the only quirk
still handled in this function.

Fixes: c90847bcbfb6 ("cache: sifive_ccache: Partially convert to a platform driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403311253.Z4NvIBxI-lkp@intel.com/
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/cache/sifive_ccache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index e9cc8b4786fb..6874b72ec59d 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -290,7 +290,7 @@ static int __init sifive_ccache_init(void)
 	struct device_node *np;
 	struct resource res;
 	const struct of_device_id *match;
-	unsigned long quirks;
+	unsigned long quirks __maybe_unused;
 	int rc;
 
 	np = of_find_matching_node_and_match(NULL, sifive_ccache_ids, &match);
-- 
2.44.0


