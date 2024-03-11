Return-Path: <linux-kernel+bounces-99675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF1E878BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C342812DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6AF59163;
	Mon, 11 Mar 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qioKqVQu"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2D57890
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201134; cv=none; b=DAQALNVi2EV6uJslKo02biTHtdGJbCxjSNYqFaVEzaeOtQppLnTKVi6YW1Gyobr1ePT6Zn5lbiE+T961jLrJSjUVt+nKv0J3miQlV5690vMpw4CUEfx1Z5NaGzsMUBQVOO1v6qW6/pUjkSi/rS5R+nviCMuZ0muTsb9XZdFCWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201134; c=relaxed/simple;
	bh=pBZqTh7G7jp+IUnkic52oQI13i+dNvvK3OLg5P87lgg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tCQaPZSRGxItjKgVJAQjZrAXbwypsMoZDNr1PlbxJlybtOsXSUURCQsupwjHv6EfDSEBYWycQZWahn/RK8mgOkGo4mCAgpQR1gUbu3tYIS5cEJKFHvboQQ4IxYojvPaAN/5UvOsZDZOoUza8nXrKBlZ/nIJbqNvUzC+tT0UyTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qioKqVQu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso9594679276.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710201132; x=1710805932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HoDCqku35T7YbxqPd3TAz1OoTvE4SVOE0AIV0UpVVT0=;
        b=qioKqVQumAqmNc6HjmxXFCDYhK8XtXX2+iNuUtrmcRngP5XKX0UfrSMZDEkbkpFQDo
         4jCfsfR3vwfbveEqcY3UfdA933FfftexWIZzi9948vhOzn6wecmU51DIfMqUzIHqg8yP
         MmqLk0TlW+0PiINV09qrnctak22/clAe4/tT+mvNlKbzUEt7DpKs5U0vKnZXe6LtT8gp
         6uRz8crMEIPQxubEEFhJ5etdhk/469RLOWGgdXVAhc79vXncXLPKcB++EBKSAs8m3MGQ
         utfVeHwKOsy2SN5XG9bKTvG1VYNSUU6wszA3l7Ps9hrROHQ2zkTUH+xS1PZroVh6Rxs8
         KovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201132; x=1710805932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoDCqku35T7YbxqPd3TAz1OoTvE4SVOE0AIV0UpVVT0=;
        b=LHbxAxwlbimdnjV5cjXwj29GZG7/hdRNAxWfhyKi5mQcc3V3JqVHWDqL8xFOcxYm/G
         sYWqdtoYbWY47Ox9K59LakB9g4ZQ1qKacl0DrMSbUbj0+lQDqGBqSCDdbdFH+x3+MJ9R
         tl+LFK8Z7i6MoxgyjhQCO6c423Y9wYaleyfOmoxoGDmmVmOGwke0LI6zPEhZkiedkuyF
         f0HKjCfAgXptthCodG4PVOZAnjfH+ZSgWpuUxqY5iGwYfuCr8xNDlGKev7OmBWI7tbXm
         pFvkJEJXg2lesykxM+Jrcxtc/RwM2Dd3BFefB5OdDM+/327Fhw2xofWkM2RY3mig1e6K
         s36A==
X-Forwarded-Encrypted: i=1; AJvYcCXCn39RgLaWVxnxn6ZB8pd/cR/nWwB9drRG7za3dtv5vxVnFwj97LRsLBbpSJnOoobqmXF2zdk2Qf4BY+98a3wF1QEBMCCS6Ntki19v
X-Gm-Message-State: AOJu0YzMoJm9ijIWdzGTcq/hfp5DyJieBF4ELCiPA9mQitEqzljxP/mf
	pA/AExMZPMtsUuLLmQFlejkNGJSXYwyzqf7lrDZhTDZjyP8EdaamjRY3GCAwTstwVPjFZlnt4At
	oeaN4dq66PSgWnCqE5Q==
X-Google-Smtp-Source: AGHT+IGvoB6x0HUGO9cKrUhakaBjnzL5PQuqIrdPSs5csd6UtFI4bJM31GyU0eku4GbNJXOK7s5b21fIZKPIOmYT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:dbc2:0:b0:dc6:d233:ffdd with SMTP
 id g185-20020a25dbc2000000b00dc6d233ffddmr2219113ybf.0.1710201132663; Mon, 11
 Mar 2024 16:52:12 -0700 (PDT)
Date: Mon, 11 Mar 2024 23:52:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311235210.2937484-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: remove unnecessary check in zswap_find_zpool()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

zswap_find_zpool() checks if ZSWAP_NR_ZPOOLS > 1, which is always true.
This is a remnant from a patch version that had ZSWAP_NR_ZPOOLS as a
config option and never made it upstream. Remove the unnecessary check.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 9a32377520827..c6267b5e0999a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -884,12 +884,7 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 
 static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
 {
-	int i = 0;
-
-	if (ZSWAP_NR_ZPOOLS > 1)
-		i = hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS));
-
-	return entry->pool->zpools[i];
+	return entry->pool->zpools[hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS))];
 }
 
 /*
-- 
2.44.0.278.ge034bb2e1d-goog


