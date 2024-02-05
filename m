Return-Path: <linux-kernel+bounces-54080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFED884AA76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4474C28C8ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE06487BE;
	Mon,  5 Feb 2024 23:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZN1JhLO"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9804879C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175486; cv=none; b=cd96hdn5/vUsgvfWXQt3npIFE8B6GljEnmbA40YmU247WnQA5FxCgYuUTHJNzjZ2JqR4pPNZkmDvgSTe89BEaGj+0t1B5jOZuhLCYdgSt4sen3iJT0acFXAEzVqzs5hSsvaU2GWTIiwrn2ArL/3+e3SPvbEvF1lgJzCjTFzQ8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175486; c=relaxed/simple;
	bh=bdABCLyQUJNvkNShCuP1cOYey/ExcGNCA8pF91gWON8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YitTatMu/6f9mmr+K43rwQQSzm8EKzYfbaX7KWh+jbLN/1IVb0asu2gRsG3J4tFj+K2B+Q/7ohEsdBYFPxWNKsp5CFBFur79YdvXpkiGopE533kfAgjQNG1LkggUCgCq2ltxudyzaSwONtdRKS7me3StdXXjSE/K1b3kvj7diB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZN1JhLO; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-686a92a8661so26567356d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 15:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707175483; x=1707780283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y64gFmrSep8Jb0vFEjY7ZG/bOjun6eItlr5gW+o3hIQ=;
        b=VZN1JhLO5x7/cvn2LkcIlvyYUldcVkMhqZLfFnWpzku/QvdfNcPsagYB9Ww6X5PxTJ
         lOExewyjatmAB9gU6ummfJmWpUUnoFn74dQWDnLS4p9cvijenSdG6R0V+TyzK6/9NRAd
         o3diaD5saw7aKKlq5PiRQxwfQLQld/tlqOhBeDns54zJJJE/5pdPSsFcY7sMpyhzJViq
         3WJSuwsvKTqq0ZDO0Pve76G+ZHwkKXsYX7enIm77GWRLIqPFPCPqzgxrvu+KQDg0aoW6
         zuuHiUQYeIxCzbRcUvfRrh5+EWDHs/WvXg3yrnp5x73dZOi/HcWc/99YTHAJ3u1kwA5F
         KWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707175483; x=1707780283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y64gFmrSep8Jb0vFEjY7ZG/bOjun6eItlr5gW+o3hIQ=;
        b=vDrMs6PJeckh0dFl0rKvMPUTkW4YN2GxQdIc10jjOnwaJ5QDJHqjgztfzQ6VrZZb08
         ICK2qTRP5mGEGmRLsPikBQccpne0qn2AnkhLGwoBX5sIvNDCjRicfHLleluytuuP4PrM
         8wEzP7kbZg0O4NFiJ77RFkLZpOQWadHjtJV/kkcwn0ttcc9NX43taca64hSE0ZCuya+m
         nrlfU+hUSa8Pi4Rl31KWYqGY11QLtSryLNHBe79LcKTofVBXz8qGyd6hKBRsHFRm0egY
         u2Gk4wTaUSioiIYIfFwvmTbOalB+BdJpC/PfxqsI8Yo3l6iJS+hQO6LcW2h/jw//PPHe
         O00g==
X-Gm-Message-State: AOJu0YzyoLsoBFG7pvdbIKObxx4wHFQPT94d+pajsVwQl6fg2rojJe+X
	g9nm0vB76H31wRXQFevoF4sRc9rRLCho4/PrR0mq03QPy2mJOv+4
X-Google-Smtp-Source: AGHT+IH/EtuMqGFyfpQGNw+Sk+j1APJiECASWsMkSGapslq+bKPOrPjwErrzftRMZZugX15IhqfMBw==
X-Received: by 2002:ad4:5bc9:0:b0:68c:50cf:9e1a with SMTP id t9-20020ad45bc9000000b0068c50cf9e1amr976939qvt.33.1707175483242;
        Mon, 05 Feb 2024 15:24:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFKPVGcaS7HRKV0boBMfOmKjCW6tYNmFzg3u1JcmUEjLeIbHUyDogSKn7EluFN0t5C8SgnfrdebJwyRZUBb3CStDUa4OCd8qvp8yMqqlX225LnoD1qrv1v30hXz0dGAwozwbNerq9TY5TFF3ZMOhBFGMx5rwEXiea7buzcsk3XqX90hNYi2S7oufD+hxgx3UD1VF2OlGBDt/Cx+Wg5OSicWCiY/vq6DA==
Received: from localhost (fwdproxy-nao-009.fbsv.net. [2a03:2880:23ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a222800b007840c63ad70sm389447qkh.15.2024.02.05.15.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:24:43 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	chengming.zhou@linux.dev,
	yosryahmed@google.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/swap_state: update zswap LRU's protection range with the folio locked
Date: Mon,  5 Feb 2024 15:24:42 -0800
Message-Id: <20240205232442.3240571-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the zswap LRU protection range update above the swap_read_folio()
call, and only when a new page is allocated. This is the case where
(z)swapin could happen, which is a signal that the zswap shrinker should
be more conservative with its reclaiming action.

It also prevents a race, in which folio migration can clear the
memcg_data of the now unlocked folio, resulting in a warning in the
inlined folio_lruvec() call.

Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google.com/
Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap_state.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index e671266ad772..7255c01a1e4e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -680,9 +680,10 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	/* The page was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
-	if (unlikely(page_allocated))
+	if (unlikely(page_allocated)) {
+		zswap_folio_swapin(folio);
 		swap_read_folio(folio, false, NULL);
-	zswap_folio_swapin(folio);
+	}
 	return folio;
 }
 
@@ -855,9 +856,10 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	/* The folio was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
 					&page_allocated, false);
-	if (unlikely(page_allocated))
+	if (unlikely(page_allocated)) {
+		zswap_folio_swapin(folio);
 		swap_read_folio(folio, false, NULL);
-	zswap_folio_swapin(folio);
+	}
 	return folio;
 }
 

base-commit: 91f3daa1765ee4e0c89987dc25f72c40f07af34d
-- 
2.39.3


