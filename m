Return-Path: <linux-kernel+bounces-132428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4EF8994C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF931C226D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A022C1A8;
	Fri,  5 Apr 2024 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+8uXzf3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE525774
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712295322; cv=none; b=pyWZhdiNrWcs2eH3FQGy3tf+Fap93T5eabVgDQeNmtWAeRIy8UflIVdjPMRA+GO6Xd2dPh74VgciGRg21FmClCu3oXHgqZFYL1EQK+B9XmqIHL+ojHeu8LUGHBwBRioLGkAChzp0b7YHHPqS9eMtagVizQBbVWQQ35RFszHyw8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712295322; c=relaxed/simple;
	bh=OBu0XPUtNujGfTv9FqY2iHyyiyKuVEz2ju3MZe/grPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nbuIBm4GzT7GqxjC23zeExR2oqbgjqO1fXTB5bvLXEntpWuAjtTpnejhyJmt9ohzK4z7pqefYKuEx0qy1Hg6RwIO9c5XdaOVFhb0dYdb5jRPPQSHz6fu/7IGFF4n1PJnYhI1rt1/DvXSlujk0NkB7w1g2l1qVvJpbsiIl82LxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+8uXzf3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dce775fa8adso3101494276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 22:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712295320; x=1712900120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JztYBciZAboPFg0UR8cifQAY1ELGwu5QR/HCIVJgmmg=;
        b=K+8uXzf3WSy28rVAsNxg+4n9zzs/W8BjIMbOLUpH6fppU9dM5GMHQMO9sJ2cGBOI4J
         esVT0FXsbjojvrQXuUYk7ZE4jDDO0cFKMIgCUzcRd6B/d96S/A2aPRDDPqP1OytZ9+jJ
         LjAeX+0iV3iEWVir4P9Aa8QpMJlZT1zQJAPf4X2jA2mwxZhF5KEMJX2BoKdHsZeUQcAD
         dzyhoeFP/Cl7P2coj3Yg942u0UYh87FfzHdRvRNyCnNviwUBeFnzEgxlHWjgUdrWV4Gy
         HTfMP4Eb83ZYQrZCQlkZT7ADfKptlrMHY67hESpjV50+4V2CQcNuAk4x2VZ+2z4kSCVi
         1ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712295320; x=1712900120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JztYBciZAboPFg0UR8cifQAY1ELGwu5QR/HCIVJgmmg=;
        b=Fpoowfav/+BwiLpX3Cm/OZ+dI8sLrodwJbt9/NSlziA+NmEHeJB/WZZKMIbtYFgUYA
         cL2jBUpCsU5GEgHVMjwPGNAiQIg14D6Iy6pXEx5V5ciLZn2EBEIG8f350gvwFwfaZp15
         N/07UXEBfFxPidppWK4VYM5KTN9QMYusEmHMDVpzViipJ4LbkwN4PS9jh+UVvdPdBdfV
         r4g+NdzA6Cu0kZHV3ZrsU9943C9mx/XAE4lRMiPX2gIWWXEFiVKyjj6VVOH4U0BMUgI9
         DS2fu/wDgDodBY+ztAMSguTNaDFRNsYwVgI/LTyRmyeBSTJU7pSmRmcAOJ11ThRh/Vd3
         lgwg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Xbj5kfaAjQQY2X46f/MeIcV8XN9Nw3Q8LgTgln+Q+YxgOv8YtPtlYElQ3OOv7BDFbTkjRH9fXUqwlWXsvtKQ92gAj83IRvVMH158
X-Gm-Message-State: AOJu0YxBjlSaEn79d8wTsmCQP6uccACPJxOemQbCA2K2AhRJ/QlJVXRE
	T6pmQlKbyaL3Q3/GSP1BBzDdyA4JW/4TiP/Ti2HbTVi2qmAzlPF71Td2avPW0Oa28CccHEJTlRD
	caJWbnirPHi5e3h3tyA==
X-Google-Smtp-Source: AGHT+IHCdA/5X8U1gt0bJVEbJvMDtws+40Zw9BGN0s2+vFjCACLLPLTtlCpMI+FJ2Yy+eJlQHuE46wlM5C0M0oGx
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:f30f:0:b0:dc6:cafd:dce5 with SMTP
 id c15-20020a25f30f000000b00dc6cafddce5mr105083ybs.12.1712295320201; Thu, 04
 Apr 2024 22:35:20 -0700 (PDT)
Date: Fri,  5 Apr 2024 05:35:09 +0000
In-Reply-To: <20240405053510.1948982-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405053510.1948982-5-yosryahmed@google.com>
Subject: [PATCH v2 4/5] mm: zswap: move more same-filled pages checks outside
 of zswap_store()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, zswap_store() checks zswap_same_filled_pages_enabled, kmaps
the folio, then calls zswap_is_page_same_filled() to check the folio
contents. Move this logic into zswap_is_page_same_filled() as well (and
rename it to use 'folio' while we are at it).

This makes zswap_store() cleaner, and makes following changes to that
logic contained within the helper. While we are at it, rename the
insert_entry label to store_entry to match xa_store().

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index ab3cd43cdfc9d..13869d18c13bd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1414,26 +1414,32 @@ static void shrink_worker(struct work_struct *w)
 	} while (zswap_total_pages() > READ_ONCE(zswap_accept_thr_pages));
 }
 
-static int zswap_is_page_same_filled(void *ptr, unsigned long *value)
+static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value)
 {
 	unsigned long *page;
 	unsigned long val;
 	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
+	bool ret = false;
 
-	page = (unsigned long *)ptr;
+	if (!zswap_same_filled_pages_enabled)
+		return false;
+
+	page = kmap_local_folio(folio, 0);
 	val = page[0];
 
 	if (val != page[last_pos])
-		return 0;
+		goto out;
 
 	for (pos = 1; pos < last_pos; pos++) {
 		if (val != page[pos])
-			return 0;
+			goto out;
 	}
 
 	*value = val;
-
-	return 1;
+	ret = true;
+out:
+	kunmap_local(page);
+	return ret;
 }
 
 static void zswap_fill_page(void *ptr, unsigned long value)
@@ -1466,6 +1472,7 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
+	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
@@ -1498,19 +1505,11 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_same_filled_pages_enabled) {
-		unsigned long value;
-		u8 *src;
-
-		src = kmap_local_folio(folio, 0);
-		if (zswap_is_page_same_filled(src, &value)) {
-			kunmap_local(src);
-			entry->length = 0;
-			entry->value = value;
-			atomic_inc(&zswap_same_filled_pages);
-			goto insert_entry;
-		}
-		kunmap_local(src);
+	if (zswap_is_folio_same_filled(folio, &value)) {
+		entry->length = 0;
+		entry->value = value;
+		atomic_inc(&zswap_same_filled_pages);
+		goto store_entry;
 	}
 
 	if (!zswap_non_same_filled_pages_enabled)
@@ -1533,7 +1532,7 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_compress(folio, entry))
 		goto put_pool;
 
-insert_entry:
+store_entry:
 	entry->swpentry = swp;
 	entry->objcg = objcg;
 
-- 
2.44.0.478.gd926399ef9-goog


