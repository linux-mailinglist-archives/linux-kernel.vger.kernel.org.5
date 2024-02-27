Return-Path: <linux-kernel+bounces-82673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60374868813
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A95B28E612
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC84D131;
	Tue, 27 Feb 2024 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr18jKrY"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052D199B4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005907; cv=none; b=VS1f0Mm35556C23uWs1fQMXC12YbNSUetzt3p8p2P/nOkz7meKfmkQBWGPA0dNXoOPeFDti9W5y83fXX5XBTSedvn0K21aEDyWXsIihclCzEZU8aNbrzTyCysH0JRS81GbunNSvWYUr6cFG9zKnYpHOf9xvh/OmYJw+MVedGBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005907; c=relaxed/simple;
	bh=jyTFedxemoJdbhZ2y1imcmJRvPeOxYPV59O1HswSVbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fN0MmrdSpdKE9+5vLc1h3r94WbIW3U2r2hYcgG6hWRSID4cqHaNOc1XUOhxUZBFKgnbJPezwxQZN84T7KKaqMqWcbC87OfMzX5gc95QugEohJFXvoJ5yOavl+ZmiXI6vHxMxTde4MYxCAcVvp8s6Oj7askxzPmVXTfb5N0orw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr18jKrY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dca160163dso15962485ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709005905; x=1709610705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gs6SqwqU20wxdOxc0g113G0JKB/kw5agZtCRYieg9ro=;
        b=gr18jKrYEoHNCf8K+Nm6kHKFsZYnQPhguk6s7IpoB+MpT/4y8lR/6E8pTGgqfOfWJG
         6Q5aA3hItRrtqpWlYZpgO+vH44g6/mTOcdgANlVBexaxGLNy0vKbeTSoBlBSovNA5kQJ
         2dDg2rjg8+wCOjCjsnBmXIucvf1m6R4I680UO/MWw3N5GCa1z1Vd4bueVB14QIRVBfIP
         IjqofnRHXPaTq6BTUXVlSG9zYUi9X5B1qEKC3cL9Wyq2oAywzWWTqHSbbGXNlTmu3ILW
         JwrmE21shLDjW93JfgDMWBbpmM4zVxN3gN8D17dHAGOGnymSc3m4w9FbIcgS/lbxkTrn
         xrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709005905; x=1709610705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gs6SqwqU20wxdOxc0g113G0JKB/kw5agZtCRYieg9ro=;
        b=IGXWxeLiNNDSTTgzZy9XrtMi3b9QTa64KltCd3Dcct0u1up/1pssQgSjkFCw3W7qZI
         4LI66lBZZ8r5FmHOwvjaN1fzb9Xq5ANpPKpONRrhWAp9ry8ns33jEZT++WeFU7G+ErHd
         6Z449ig/XEvBmg8v5aeTKwqJLHwxBUK5Xiva3rDID3a5ot/9EYtu2LDa3Q1faqsmfb8D
         kTw3yReqOB37QdftxTopkyosLVW3Wo11gNowqSqIV8fzAq+K3nTQfTcVagp963Agb6J7
         7TPyH0fa5m7rdzz9jtwh3xGKWZutKf7M1vg7fPApJgw2APbC1GqxUTOSrttLbg9VX0Xu
         GXBw==
X-Forwarded-Encrypted: i=1; AJvYcCVlykeJOHbRQ8ebqpgcA8cKYmQvL0/crb4542SPYuJkv9gjQxgd8o13I34K5otZeD0f0vjVc11RuI/QCyQrb7WI0uKkyM44wGlUX/b5
X-Gm-Message-State: AOJu0Ywvwl9kIvyUKZ61x7hfbkUg3WtWdx09QdXmcLnUus5kAwidjP/w
	IpaT+ziqJi9FIuDpNsF6zu4xId2BS0RolNOC/IZGvkW6zigVQ+RQ
X-Google-Smtp-Source: AGHT+IFUJaqZlI0Vq/9WwW8Wl/li66JCXaHzA+eLWv4EOWIFuTvi0IVAvLpFfcTvB/5Hgvo4GB8e/Q==
X-Received: by 2002:a17:902:d587:b0:1dc:ae92:7e9 with SMTP id k7-20020a170902d58700b001dcae9207e9mr3507796plh.62.1709005905360;
        Mon, 26 Feb 2024 19:51:45 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.225.117])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902821200b001d949393c50sm433519pln.187.2024.02.26.19.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 19:51:45 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: shy828301@gmail.com,
	mhocko@suse.com,
	zokeefe@google.com,
	david@redhat.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/1] mm/khugepaged: keep mm in mm_slot without MMF_DISABLE_THP check
Date: Tue, 27 Feb 2024 11:51:35 +0800
Message-Id: <20240227035135.54593-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, we removed the mm from mm_slot and dropped mm_count
if the MMF_THP_DISABLE flag was set. However, we didn't re-add
the mm back after clearing the MMF_THP_DISABLE flag. Additionally,
We add a check for the MMF_THP_DISABLE flag in hugepage_vma_revalidate().

Fixes: 879c6000e191 ("mm/khugepaged: bypassing unnecessary scans with MMF_DISABLE_THP check")

Signed-off-by: Lance Yang <ioworker0@gmail.com>
Suggested-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2771fc043b3b..1c0073daad82 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -920,7 +920,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 {
 	struct vm_area_struct *vma;
 
-	if (unlikely(hpage_collapse_test_exit(mm)))
+	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
 		return SCAN_ANY_PROCESS;
 
 	*vmap = vma = find_vma(mm, address);
@@ -1428,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 
 	lockdep_assert_held(&khugepaged_mm_lock);
 
-	if (hpage_collapse_test_exit_or_disable(mm)) {
+	if (hpage_collapse_test_exit(mm)) {
 		/* free mm_slot */
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
@@ -2456,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	 * Release the current mm_slot if this mm is about to die, or
 	 * if we scanned all vmas of this mm.
 	 */
-	if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
+	if (hpage_collapse_test_exit(mm) || !vma) {
 		/*
 		 * Make sure that if mm_users is reaching zero while
 		 * khugepaged runs here, khugepaged_exit will find
-- 
2.33.1


