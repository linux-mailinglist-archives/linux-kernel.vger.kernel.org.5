Return-Path: <linux-kernel+bounces-43248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC96841166
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0180B245A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6BA7605F;
	Mon, 29 Jan 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6cxevWo"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBF7602D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550930; cv=none; b=hSBVDAHZeB6CtVkS0rfPwjnJvOeBfXpuV1fM9PmqyW2S3qZU4TugKspk6bBjMZ8QzCPJWVhx8FxO0WI/zXqA0R/xh8eFEH3kyQXxN705M2SJJRNu766gQttcnUfAzcUFBSls9qzurLH0tUo+lRx0kvEJpcowL+MKY7/cnV58hVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550930; c=relaxed/simple;
	bh=vXTxVyl4btISce8M1UdLUvnN2CnI6VvXo25TXabN8QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9bNUZHBH+5gUpm1XZwXkv3gWiCaISaZD41sFwdN9HfWnD4XoRei8ksBPgCqA6TVVoZ/5xhlJnegtCYaXT0w84cnlA8myV2kOSu3IYSu1vxH0f3w0uZYSUXuY0pOfpyA5ZkO1ibyQHod2g2oAhGM8oumlM0lBM7HtrOOGypJoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6cxevWo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6de2e24ea87so661615b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706550928; x=1707155728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GjZwqrF+fUuAybg+YCS1CGFEH6Sivr26PLz3uMvjpFw=;
        b=J6cxevWo7M1nlkY1mMXSkogjH9tPuvjDDswkuveDJP/VYj5k1P6E8HXI3k9GA1r53c
         0dlftRIMmg7BtqM+LTkt/4eKfcgue1BoNBPDPsSPx2dC9kGVJtRryBtSSAIKEE6hRlSd
         oDRnMov7Q/pdC6ctRjoTa1kmKihxg4F8X13sa91QAjpUX93pAs1T3MlpN0HBzq3HdYPy
         lpKbbLwRKNf21zLxJ4Ni++n9sx4gpTJm79msCJRO54c0yMomM65czKGYC/Q4bH1bL4kK
         0SEF09mQLDksKqxDUG2HkadRdkHF6+kGN+T37Q+Fqe2yhsO4A7XdWPsVA1wZMDs0FkYb
         qeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550928; x=1707155728;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjZwqrF+fUuAybg+YCS1CGFEH6Sivr26PLz3uMvjpFw=;
        b=b+tZjpwC3fHjIXBwqnVxLo+hot8znkgaouXAe6xiyZiF9L2EiVfG05Qw1jCm2avWGP
         nU/64zrRQ1dkzuCEfk8DNVyMrhF0FUSVBPfSf1HScvOIfPphqGx1VaqMQbWbAqUjdP1N
         H9NlrykTtem7T/Q5sxtyzCkgPwVrAIaCwMy+KsHBScndXPf7uB40llqNME/MngdZ3qSV
         J3IlXLxYXM6c2JMOUhcAdKqqjuSksDlmUp76gTev69VVY+nvSlDMalQ2mGIEmQjeR9R2
         LhFVA7aloefJs/1x3rVckO5kJUfCxGNsTqvmngnS+1orD3PhiQqKVs8UATX8Dy6bAgEf
         8pCw==
X-Gm-Message-State: AOJu0Yyc2ZzujSG2rUnf9h579CNt3ey1xNHwwD90efgspO56ikW71NXs
	UpUYimpFHleScnKg+u7oZ3zt0YG0AQVL9c1vWEB6hdOpUNN6pqwt
X-Google-Smtp-Source: AGHT+IFDh6I0Kp5R4i/kVA2C7S+t5BD4PS3SEfvTVBoyIvP27FzIislYT+FaobErhwcJx+cp8D2QWA==
X-Received: by 2002:a05:6a00:4fc4:b0:6dd:a24b:b5f3 with SMTP id le4-20020a056a004fc400b006dda24bb5f3mr5025963pfb.12.1706550928614;
        Mon, 29 Jan 2024 09:55:28 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b006ddcadb1e2csm6116676pfr.29.2024.01.29.09.55.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Jan 2024 09:55:28 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 7/7] mm/swap: refactor swap_cache_get_folio
Date: Tue, 30 Jan 2024 01:54:22 +0800
Message-ID: <20240129175423.1987-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129175423.1987-1-ryncsn@gmail.com>
References: <20240129175423.1987-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

No feature change, change the code layout to reduce object size
and kill redundant indent.

With gcc 13.2.1:

/scripts/bloat-o-meter mm/swap_state.o.old mm/swap_state.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-35 (-35)
Function                                     old     new   delta
swap_cache_get_folio                         380     345     -35
Total: Before=8785, After=8750, chg -0.40%

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 59 ++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 20c206149be4..2f809b69b65a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -341,9 +341,10 @@ static inline bool swap_use_vma_readahead(void)
  *
  * Caller must lock the swap device or hold a reference to keep it valid.
  */
-struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr, void **shadowp)
+struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_area_struct *vma,
+				   unsigned long addr, void **shadowp)
 {
+	bool vma_ra, readahead;
 	struct folio *folio;
 
 	folio = filemap_get_entry(swap_address_space(entry), swp_offset(entry));
@@ -352,37 +353,35 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 			*shadowp = folio;
 		return NULL;
 	}
+	if (!folio)
+		return NULL;
 
-	if (folio) {
-		bool vma_ra = swap_use_vma_readahead();
-		bool readahead;
+	/*
+	 * At the moment, we don't support PG_readahead for anon THP
+	 * so let's bail out rather than confusing the readahead stat.
+	 */
+	if (unlikely(folio_test_large(folio)))
+		return folio;
 
-		/*
-		 * At the moment, we don't support PG_readahead for anon THP
-		 * so let's bail out rather than confusing the readahead stat.
-		 */
-		if (unlikely(folio_test_large(folio)))
-			return folio;
-
-		readahead = folio_test_clear_readahead(folio);
-		if (vma && vma_ra) {
-			unsigned long ra_val;
-			int win, hits;
-
-			ra_val = GET_SWAP_RA_VAL(vma);
-			win = SWAP_RA_WIN(ra_val);
-			hits = SWAP_RA_HITS(ra_val);
-			if (readahead)
-				hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
-			atomic_long_set(&vma->swap_readahead_info,
-					SWAP_RA_VAL(addr, win, hits));
-		}
+	vma_ra = swap_use_vma_readahead();
+	readahead = folio_test_clear_readahead(folio);
+	if (vma && vma_ra) {
+		unsigned long ra_val;
+		int win, hits;
+
+		ra_val = GET_SWAP_RA_VAL(vma);
+		win = SWAP_RA_WIN(ra_val);
+		hits = SWAP_RA_HITS(ra_val);
+		if (readahead)
+			hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
+		atomic_long_set(&vma->swap_readahead_info,
+				SWAP_RA_VAL(addr, win, hits));
+	}
 
-		if (readahead) {
-			count_vm_event(SWAP_RA_HIT);
-			if (!vma || !vma_ra)
-				atomic_inc(&swapin_readahead_hits);
-		}
+	if (readahead) {
+		count_vm_event(SWAP_RA_HIT);
+		if (!vma || !vma_ra)
+			atomic_inc(&swapin_readahead_hits);
 	}
 
 	return folio;
-- 
2.43.0


