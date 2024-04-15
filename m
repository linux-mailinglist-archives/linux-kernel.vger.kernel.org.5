Return-Path: <linux-kernel+bounces-144478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084468A46D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7293283309
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED211CAF;
	Mon, 15 Apr 2024 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAAHIYwR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB13C17F8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146907; cv=none; b=cNTDvvz6Dcf3EIfkc/CxHt9PmrhMKp/Y7OlV4Nhlaqdk0r0vfHVa5jOwdpUrM+K63VaJl+Dl9bcUsUG2XNwDjAJexp4T6gkDvUX2HBNfH7cANidc2N2iD8Ob8lSmkCiWwyR0BIvYsimLaxsqINYF9pOPd0T/oKlEIVKTxmLli0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146907; c=relaxed/simple;
	bh=BqlLYs/pZxFq1BLSzcK2RbNfet4WOs7GBKNyjsJHj4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A7y1d5iO/4z8KvwHNeoRkth1HO12lM7VWMWkoRY1dX558T2Lt7XZ7R3OVfNjRwH5Ak8wzlYQXpn85jXDHu2zM7nUwMBQH3erC5FENdoIFjyGEko32GPC9MG9nX6k1ACEm3KvgBJWZxaAlIo1uVFq9a5iPLpkG/TtEPybjDOuoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAAHIYwR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so4627810276.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713146905; x=1713751705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/98u94op72EVu1rwcZBeQqBXmPZ1FBtvrZp8yXfae4Q=;
        b=SAAHIYwRmmw71KKVRAdpv0s1IVcC9uIFUEVyPfHQfLg/8kb+AnH2ZdHQ79ag5R+Gpt
         rs/H3s1tVsZxWnnjgzpQPCCZcQwQBmzKlIctqpvLWohB7ouqxFuDekZj+3dPs0gMD4kK
         hh5Wax3mItndML/4yoC4EDLyZUlOIpPVrkR2hA2e4O1gznPo47zTyDyuqMpbaFfinOIi
         HQsQwNB/quhScB4hic3UEIgvjDXKFEUP/wMJosq3Nf6REVLKsqAKNyNsDm6pWpWs2kFe
         kFzjWzRxsDGzmEKuFjAiAhm9PQZ0u1z3LbTmkBc5GVvMYs3u0wjE2uaaF87K9kzJutMk
         tAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713146905; x=1713751705;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/98u94op72EVu1rwcZBeQqBXmPZ1FBtvrZp8yXfae4Q=;
        b=R9UzjoWmN7gBSdTcYJpSwUKOkRYfNYqi0zTzIqnChy1komZnCaCr8MPPTn7Iwyy+48
         hGaf8nHvn/EtUYDFOZu/2B5fZRdwLfOX81pC0zpxAEWMHSZ1dwbhkLmQ0y9FLNDWT6eO
         vfYjNOzXFsqD4eLYZDrXbtoMuy3+0SLcp9KCYv3d/oS1rMSzrMkRhPMWa47k8cK3Walu
         TScButr+bLM7icl5M4TcZbBToDkxMEktEbnD3PqCkuMgeRdH8WUeA60t86axZy2+sr2Q
         kXSyyFVo3qM9njfhfFk/wtvqF3N2BbESmr2qw9t2gzx9imdVCdfvibKTaPBQocw3IQwh
         IMeA==
X-Forwarded-Encrypted: i=1; AJvYcCUxz9xaiVqvyQuCm0Rw0jpXlGbOflUenT4ZvPiDFjC4Ey64PhnIWNhw6KKr63Z8iqetZIJBZjgCGsyi8Jxpz4SxBYXJFenYRu0AVWtY
X-Gm-Message-State: AOJu0YwJU2pc3J5nIE6pLNUl1P/et0yMOv76P127STqhK1QGG4RRObsm
	DA1FS1hl87tiv1DKmcM2QqdpnatuyclMAxL1DfwY/djn/7frdqNiGyKy9nmqwf7knm631w4VdRv
	bjg==
X-Google-Smtp-Source: AGHT+IGZchVsO41d1crlhOYsiW9odtp2PFbpIfFEraBCHTjkLJTY2phNg19cKjJ2oBAtjRoIf3A1jhKhsms=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:4faf:b746:8f4e:5d6])
 (user=surenb job=sendgmr) by 2002:a05:6902:20c7:b0:dda:c57c:b69b with SMTP id
 dj7-20020a05690220c700b00ddac57cb69bmr2849394ybb.0.1713146904810; Sun, 14 Apr
 2024 19:08:24 -0700 (PDT)
Date: Sun, 14 Apr 2024 19:08:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415020821.1152951-1-surenb@google.com>
Subject: [PATCH 1/1] userfaultfd: remove WRITE_ONCE when setting folio->index
 during UFFDIO_MOVE
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@redhat.com, peterx@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

When folio is moved with UFFDIO_MOVE it gets locked before the rmap and
index are modified. Due to the folio lock being already held, WRITE_ONCE()
is not needed when setting the folio index. Remove it.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
---
 mm/huge_memory.c | 2 +-
 mm/userfaultfd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 58f2c4745d80..ee12726291f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2200,7 +2200,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 		}
 
 		folio_move_anon_rmap(src_folio, dst_vma);
-		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+		src_folio->index = linear_page_index(dst_vma, dst_addr);
 
 		_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
 		/* Follow mremap() behavior and treat the entry dirty after the move */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b70618e8dcd2..575ccf90325a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1026,7 +1026,7 @@ static int move_present_pte(struct mm_struct *mm,
 	}
 
 	folio_move_anon_rmap(src_folio, dst_vma);
-	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
+	src_folio->index = linear_page_index(dst_vma, dst_addr);
 
 	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
 	/* Follow mremap() behavior and treat the entry dirty after the move */

base-commit: 3aec6b2b34e219898883d1e9ea7e911b4d3762a9
-- 
2.44.0.683.g7961c838ac-goog


