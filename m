Return-Path: <linux-kernel+bounces-103592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD0D87C18B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF981C21CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CAF74415;
	Thu, 14 Mar 2024 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NK/YwC0X"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4220F6F524
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434991; cv=none; b=AwUxUUzMKXvebtOYj4x08e/iUpX6oG5a18RDMMhHQiV+4UDCQYsrBlEs/kSAeKWWxaWdqoWlon6bfS/Q7MeZaZ8l9yTz3/tgWeqmuFbdo+s5Ok2/SlT5GOl52/W13AJTioY8THcL+5gjPXoE1inS4NYNBdGqSSkgmxWhIbq28F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434991; c=relaxed/simple;
	bh=HMdKN5sM1IyCSfxutBGFyEKQkzLdZNwLXUJ0eJnyRCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdj9AZIadeLqS2ykM/8y7AJGCAFbpybpQatYRwOo+bK3dX7j9M1kFsMcDdNTUCE4uFGkh5uXeVAJO5ssuWVklZUK8jLKNlo0RTjdLUpZe/xiMULEUJCvfYXStzllrtwgStwCML5VmJXEUOyxyN2Z3aueJqf3gmeR4GBlr9Fe9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NK/YwC0X; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47657316341so143514137.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710434987; x=1711039787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErQ7GCVBpqdfPQB8lRuYnFXp3OiN8dCWDu5sVH1/RbQ=;
        b=NK/YwC0XQT3V8AQ3Bfk68kKI+WfjrGJ4GL6sPxYhgwA0jDDAcW07+ZFhBA+h3e2gWc
         jcTuUN/vg2fcfUbqTf1Ekq5R/ACZ31210uAm+neP3MTS9u0XRVRZFX8BnwX64BoS2yYk
         4r00Q/xUX/HlVPe5xiltPlutge/Y1EZ+yeRgLziZPidvNBRfFtpSsQ4DsFJrn9kyKzdL
         oUE6OM/mioNCxDm1+0+5PR7/eGWR/KOXYXo0SZVsW/abS/DFRLrec/ntSHl3oUOMoHCp
         vbcmSGoc/vYPa7EYdBnGYf/INWn6vm4h7mR6TfjNcH2vwMILKreAg3CrCPPXN17PbNam
         r2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710434987; x=1711039787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErQ7GCVBpqdfPQB8lRuYnFXp3OiN8dCWDu5sVH1/RbQ=;
        b=gYBgHKyAKh9xxbNZJXVuic9V1dl2nPxtAhtFtHV8yj5CEq233qsrP7NfedOaTMOl9F
         2zPkVw9oOSXieiG1rSPjMWEP0mQ7MnStq+jOPFVdPm6aUCMUl9iJg4I3wrEmaUv5LtTh
         SrmveQPMaMJAKN/jAC4fKaM8u8Pant58hkLtzFU8PSyfCMsIRQXdqyYCUQNSaoTdbnx+
         k9kCiyZFjnfBXiAhao9xR9qtEcX7oA+41p0Hn2yKN20Hqz+ED6Li39LBEiwsgUMAFOTD
         ir3fLXj/ccY1q3D1O9TfQ4w+OG8K5EpjzPN1H4d7mwpTX0VpjdU1tEPTQZlHuzV0pGXo
         6C4w==
X-Forwarded-Encrypted: i=1; AJvYcCUzU7voMzEglUSWhSs1Zg42mBJ/qGwa6jeBg9cIgf4EQTAfadsiqucGUcfpAqggryL+KZnRNJ4VuMFf5fxWmcJpsMkL7i8JlFH09rO2
X-Gm-Message-State: AOJu0YwHzv0ic6VqGbN/Zmhfb8a7uHg8hvjC0I1rF9t/P8A/uqrZtuDe
	te7qFKHaIQz1T1oUpEkgHv6ngX5+GlxYCYX05CTBRoOX0JFWs9kyQOfMFM9XItV2X4fH55OClR/
	u
X-Google-Smtp-Source: AGHT+IGZcO5lkPzd5uloNC5+PMvKOX5RvPE+9LVF86FNI33jb/OI+AIjo11gwz8uBVAabmzwXSrNaw==
X-Received: by 2002:a67:f78f:0:b0:474:c306:9062 with SMTP id j15-20020a67f78f000000b00474c3069062mr2578203vso.12.1710434986979;
        Thu, 14 Mar 2024 09:49:46 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 5-20020a0562140d6500b0068f65b22b0fsm659336qvs.82.2024.03.14.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:49:46 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH] mm: cachestat: avoid bogus workingset test during swapping & invalidation races
Date: Thu, 14 Mar 2024 12:49:41 -0400
Message-ID: <20240314164941.580454-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cachestat against shmem races with swapping and invalidation, the
shadow entry might not exist: swapout IO is still in progress and
we're before __remove_mapping; or swapin/invalidation/swapoff has
removed the shadow from swapcache after we saw a shmem swap entry.

This will send a NULL to workingset_test_recent(). The latter purely
operates on pointer bits, so it won't crash - node 0, memcg ID 0,
eviction timestamp 0, etc. are all valid inputs - but it's a bogus
test. In theory that could result in a false "recently evicted" count.

Such a false positive wouldn't be the end of the world. But for code
clarity and (future) robustness, be explicit about this case.

Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/filemap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 222adac7c9c5..a07c27df7eab 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4199,6 +4199,9 @@ static void filemap_cachestat(struct address_space *mapping,
 				swp_entry_t swp = radix_to_swp_entry(folio);
 
 				shadow = get_shadow_from_swap_cache(swp);
+				/* can race with swapping & invalidation */
+				if (!shadow)
+					goto resched;
 			}
 #endif
 			if (workingset_test_recent(shadow, true, &workingset))
-- 
2.44.0


