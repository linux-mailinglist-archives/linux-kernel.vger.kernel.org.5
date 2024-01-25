Return-Path: <linux-kernel+bounces-38195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB383BC53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F099CB24320
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CBD1B95D;
	Thu, 25 Jan 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9byiWQk"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702D11C84
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172692; cv=none; b=NaYtn5qHS1LtwEdqqacRwMMwKqWZ439BXxWiRS8o+YgvLiA7SAfUpyVnkUWTeT9EACWBELc1KarXbXYT9KOV/mwP1VMWR7Sx3wgFfvkOpX2Nr8KWqOXXRJY9KCxBp1oFxCx5l29h5gUL44rAhEyF2dlPxTfOZyApU9IkhYkCYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172692; c=relaxed/simple;
	bh=Y+lLAx83cNHZs5vINYxx2KNx2W2cYGODV6Ig6vdN0D8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MRW0OwmFGhHiMR1DJvTr7DHBGMC3F4PbrRt3Kf56vFxvOMAM7CfTlwt1LE9lfhmMRF23+Tk456Y3osw8ba7B66EQgnMEb6FGprXRPMInfO4Zr9+LW1QGDLjhVvJNYc5+5nVYIkLP8E1JUWAHwLwlf+5GbPRdB+J/LbtLRruyZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e9byiWQk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc221ed88d9so8577304276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706172690; x=1706777490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RohIgLrjWVqbBH18OwPUPby673o+oBFFq7JGaEpXbpE=;
        b=e9byiWQkS9FUVW9mHOgG4TUba3aHGxnQ8En6rnbzEmr79BL5BGV6Tue852JHoeCMrp
         mEnPoIfGPs9K2Zqf0IRRLi7sA+wf1y6/ImdZ2EqKmviBCJnwMKh5vKPFlsv0oIxjxpdK
         nMEHytZi7pH3AmCP1mgfw3XcDBI4Sru1GFEsKvYQNq3Td8uxRYnD3uYOpdzJxwn/T4Z2
         iL/P0DCOeZ2qwy+GSMFS6BwtB8RnHq3lo9//R4vLHRdKpvtzxUbsr3TQLx1hVc5PaW3m
         nxLyvsgJzjl71AWPf0Do2gNcd7Zy6BbE2WhiwilIJAp19wvApH7dKoBVPzMS86dXQnYx
         CWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172690; x=1706777490;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RohIgLrjWVqbBH18OwPUPby673o+oBFFq7JGaEpXbpE=;
        b=QPjKNjUiDDU1muVMArYiGAk35w+7X3qahdphboVsynfmOAFDuoyRD7EGI/VwfefL8y
         Ax+9E40jtNaYjOhhOSMHwFPAeQMUfDH0+raWb3SElOZYWhjasXG0pxvWCdhofJGzFe5d
         fgQYXzyvHuTb+B7bPNH+cQUilPEJRoAlWycAxYZKTWlrfSo7D9tlT+KjHt6W0Oocxl38
         mnE2U8mKsq4o60SGBR3gXnDs5hNMJXlil7nbC57PlpP67Bf6oR6szdHhMSeBIV7W4s3j
         +R+zn2BlKWxL6Br8bbw/nRX+8bfU/aGtkSMo4lZ7qOGwCOsGuXr3xIvhEEOoyMvZQ05m
         wUeg==
X-Gm-Message-State: AOJu0YyZzEjva4493xVjFnI8akD8hIe9B8k7maLm7EIwi8360Uo0IDXc
	eU04eYlfcQO8C637TJANHtXQsg4l/ykN8TbX+kEeQt41tB1LSsrWjFUFAkgQeJzJ66NzkE0W99+
	w3r4jg5EnHBJx+3V/bA==
X-Google-Smtp-Source: AGHT+IG1/Hsqz9ICsfnUgUMjxMtXfDta6xfbiPArXWACl8gSYY8PEXXbSOk7GppsayLhkPPaDAta+w1h4X+ApK3c
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1b8c:b0:dc2:57c9:b462 with
 SMTP id ei12-20020a0569021b8c00b00dc257c9b462mr67730ybb.9.1706172690108; Thu,
 25 Jan 2024 00:51:30 -0800 (PST)
Date: Thu, 25 Jan 2024 08:51:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125085127.1327013-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: fix missing folio cleanup in writeback race path
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In zswap_writeback_entry(), after we get a folio from
__read_swap_cache_async(), we grab the tree lock again to check that the
swap entry was not invalidated and recycled. If it was, we delete the
folio we just added to the swap cache and exit.

However, __read_swap_cache_async() returns the folio locked when it is
newly allocated, which is always true for this path, and the folio is
ref'd. Make sure to unlock and put the folio before returning.

This was discovered by code inspection, probably because this path
handles a race condition that should not happen often, and the bug would
not crash the system, it will only strand the folio indefinitely.

Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 8f4a7efc2bdae..00e90b9b5417d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1448,6 +1448,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 		spin_unlock(&tree->lock);
 		delete_from_swap_cache(folio);
+		folio_unlock(folio);
+		folio_put(folio);
 		return -ENOMEM;
 	}
 	spin_unlock(&tree->lock);
-- 
2.43.0.429.g432eaa2c6b-goog


