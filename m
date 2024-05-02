Return-Path: <linux-kernel+bounces-166216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970EE8B97A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80201C22EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B358AC8;
	Thu,  2 May 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1prhNpc"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647715578A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641894; cv=none; b=Z4uWjLEwQmpdJU8B4J5eCTILK6QpYxDzgAaYFyBEwStBpmXMUGDyVr6lGgQ91nCvJhW4tccyL6yDzhIiP+J+oG7bYsg/LLIaDuO1d0xTQmii4OgopsisJ+C9iIIfAomESmvMLAzJkvEbK0ui6NFRvbbqY8+dWj22K9m1W9XRHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641894; c=relaxed/simple;
	bh=Q0j+FEUbSyqV92vLdWL4Yq6IfpsYB1S99FEiQf2pX5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5Ti71krSQbD24O3sdQRahggCl3WCyabSojV/HtENV2jX2jGM3AGzzR7dN6ZEDc1SHZFOlkHM563IkE79GBaCXKLbmFhrYkSHzcEseAJoP9SdV2zYqkO2M42kujdaO6lMW4htbmFyOIZGdJE+ZVHZQXRpAarO/G8j2lK2faWwjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1prhNpc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b27e960016so682644a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714641893; x=1715246693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E663sjFFt5eNpPHpt2DGNzWmy8ubvWUrprjgv845FQ8=;
        b=S1prhNpcI+ue74bckJMp2BKCU5pzNxLyHsJ+atjUwUhqlu28tctyOnehJ9lTjt9OJc
         nxM0JCVltwL//Pbfv3bRFD5wo8ZTkB/Wq5gYyZqsBGpmMIXdFmLVTFN5hkpxVvKtmO6p
         3eoyh4OjKJfTWL2ZvhrOjQ/VOds4t+oQNp+SnmV47fO2aSM5JD95pMXH6hOiNo94NTHd
         aoj37VHf9rhcoQ4lFjmKvGDC/02QB8xSZlDwCFa49cVWsAYAScst0XoM8LLr40ej20pS
         PjjVUFlBLvUY7vwQ5Z0Ci3PkYArVhzAHHuSafQk1Dtp7CqtT7mTAjVf2crbzgyjT13tk
         wGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714641893; x=1715246693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E663sjFFt5eNpPHpt2DGNzWmy8ubvWUrprjgv845FQ8=;
        b=HHE7AezrdGyPMzpOK6QUeaFhKUJrIyiLLW2lC4m3w/N2kXcHqJHGbm4ViRvnlko+fo
         LskOT0+rx3b0x6zdk3HrG8k/+VpfDWpn36lk+bU2hRyrifP2HysME2NHtnVrBPpXxHfT
         sbHj661ZqxdPuev/Ls0A3HNK1rXmeBLDk7ZGT1iOoFombdEnR00tIy3hg5hybKJBvkbo
         qbQ3TRbVA+zjsRvsXFsyrprzN+RIm1squ+suSbZt7a+59oXthqCy8ImLtpniUpwNZkev
         mtppcy0cFyCV/wKu8S1HqlfxH3OuR/DWHNPrLjPUQXrVKFzGwlx0xhgwVpT/7JYTkp95
         VkjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNtuFdxIJx0sd7gX6Z+kp0ff2svReOHp52j3hV5Pi4nDxlnqpCiG/+cLsEfmXNzAWoVf38WvhoJxbyRS9kJWfnndqgwb8X1JsP8wbd
X-Gm-Message-State: AOJu0YxhwBas/WEqSfpMkueMMI7TJl6IObOOtvfPVoXfyvPUVd21FbTY
	XUXjQjzbIWOYyW0Q5qEZGqdwrByu9dwLGvqKn0KkTmf4A9M5j/NI
X-Google-Smtp-Source: AGHT+IGaEf5cJEO9SrJsD1B2VyQprhEHez2s8f5FrIZUTssd9+4+d3mLIfOSH8E9syhiac4i5BEk/Q==
X-Received: by 2002:a17:90b:f90:b0:2af:d64:4887 with SMTP id ft16-20020a17090b0f9000b002af0d644887mr4938013pjb.4.1714641892595;
        Thu, 02 May 2024 02:24:52 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id bk15-20020a17090b080f00b002a51dcecc49sm746836pjb.38.2024.05.02.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:24:52 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
Date: Thu,  2 May 2024 17:24:42 +0800
Message-Id: <20240502092443.6845-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502092443.6845-1-visitorckw@gmail.com>
References: <20240502092443.6845-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a benchmark test for the fns(). It measures the total time
taken by fns() to process 10,000 test data generated using
get_random_bytes() for each n in the range [0, BITS_PER_LONG).

example:
test_bitops: fns:             7637268 ns

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
---

Changes in v5:
- Reduce testing iterations from 1000000 to 10000 to decrease testing
  time.
- Move 'buf' inside the function.
- Mark 'buf' as __initdata.
- Assign the results of fns() to a volatile variable to prevent
  compiler optimization.
- Remove the iteration count from the benchmark result.

 lib/test_bitops.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index 3b7bcbee84db..5c627b525a48 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -50,6 +50,26 @@ static unsigned long order_comb_long[][2] = {
 };
 #endif
 
+static int __init test_fns(void)
+{
+	static unsigned long buf[10000] __initdata;
+	static volatile __used unsigned long tmp __initdata;
+	unsigned int i, n;
+	ktime_t time;
+
+	get_random_bytes(buf, sizeof(buf));
+	time = ktime_get();
+
+	for (n = 0; n < BITS_PER_LONG; n++)
+		for (i = 0; i < 10000; i++)
+			tmp = fns(buf[i], n);
+
+	time = ktime_get() - time;
+	pr_err("fns:  %18llu ns\n", time);
+
+	return 0;
+}
+
 static int __init test_bitops_startup(void)
 {
 	int i, bit_set;
@@ -94,6 +114,8 @@ static int __init test_bitops_startup(void)
 	if (bit_set != BITOPS_LAST)
 		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
 
+	test_fns();
+
 	pr_info("Completed bitops test\n");
 
 	return 0;
-- 
2.34.1


