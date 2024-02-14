Return-Path: <linux-kernel+bounces-64771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 360958542A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DC4B28AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF012E6C;
	Wed, 14 Feb 2024 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODbChT5F"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D0812B6D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890769; cv=none; b=asNbTL6K9LdBsyCsjX4ULQwP8VHazOIv+1WwsMZ1aHQHzAyyi/nNmHPoZOXUmBPFMF8YWF/ETJOSB+aA5RZYmJaVMg3PYrtZ+NEcQyVDSfj5trb+ftNR96ngefjhXSgob5OSKY+IyaB19YZWavEucSOEb8K8N29bB6q7CvabrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890769; c=relaxed/simple;
	bh=Nn2aC7Sxme7TmKC1R3Wk8wOWqMobubOZoyNWF/vBV5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MrvM8HGc044mcwXBqWt63tn/P5StNmBIGPzpGIEAF4CgO82dSos7dZ7OES6hAP22fMg04cwhaz3TUXvk282WuoPRrXKLbZzMb0OoK0JBdDhWKAv3o4RpXJ8e+7RQlNOzEgOE8RList0y54BvkSVwdAZMvDDGqDV56kDxopwmegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODbChT5F; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so9592209276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707890766; x=1708495566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6dfBLL0uVL4kHNX/u5ol8tmo8iu96qepQdMS5ybNno=;
        b=ODbChT5FsP0oX96JxVWgtHoQT/oywaMaxAkMh76Qw8EVQmlp9DwXnYFHwnwVoDKydf
         2fUspDR88SYD552K9bn3lZEF3xot/HRMYfl7xUT/KbbTxxcmQ6qZ3FjZi8LTw+HpfxAi
         P6qFEfmBm5OO7VXMoTXBx/RQKq8CO51DNJdlcp9A9zHz9DYPFt+EP4SsEz1xYcshw9/P
         Bu/TNTbzIlJUT6JR1QtMBRbcW2F9jdkMKx6XqL0krYuMHutCOYBf791CD2XxMvTKDgm+
         KYv/7C3ocsfJIsu0I0HzfwMyH58rTO8FD/Hw86RWH+bgX7RzYm46IyGwWPwKXIW04SIZ
         DO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890766; x=1708495566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6dfBLL0uVL4kHNX/u5ol8tmo8iu96qepQdMS5ybNno=;
        b=RXznkIOI3jaFEaEad2xMZTyrhIzdl1yiFy0jzYqkS8Egii8WDAp8xJsRzHEldL1tsz
         9H6mGfz6VWIuJTrN+Y/BAPIEnes6otwNozxC4klNeIvGiHCCLBhhME6Yd2vI6aLrwCSM
         LgLij64T/2/LQxl7DG5TPJp+L4yN1dLKg18xLLw/NGGQsgBXKT/xtS/ASJGP5ERtWQIt
         lLFdR8m0dXTxVqPM8h2DBiTF3PGVihuPxjoHizP6mwYTw4zjxPrID3B2mPqNpBrK80a/
         +xM37u0oBeS51MLP7hJucPh1qZfn9jSgnaheHfl7YcqvGt1pdWLthCdtskhREv9g64UW
         00yw==
X-Forwarded-Encrypted: i=1; AJvYcCXJx+Ul59RrWqll8A+7QmYyvmkLCyAsSs/s57tD7Z6OzFyHu2RxcJ+Nsxt4HnDoFfttBkIalxIxPtv+aOZbMafKb5MKOZkprcNjdjGf
X-Gm-Message-State: AOJu0YxlIH0YcntuID+LmVj/DEHMu6uelqAiP4Zs5VGA7MSUs08OxkyP
	/BU48jWtMuB0Ef25jWot06ISVJFI/xP3DvckydSPrT2L4Uv4ZNqlDdLkC2mDO6zI0hmQJGDD97K
	W+WCaZpBzJA==
X-Google-Smtp-Source: AGHT+IHOPse6hooZyvwZWR3IHI/yG7ozxgi8X654LcQX7pVVX8EA8QhnzcPnrBOOtpVKttd4Bb7zZdwtS85+rQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6902:1505:b0:dc6:cd85:bcd7 with SMTP
 id q5-20020a056902150500b00dc6cd85bcd7mr322452ybu.3.1707890766683; Tue, 13
 Feb 2024 22:06:06 -0800 (PST)
Date: Wed, 14 Feb 2024 06:05:38 +0000
In-Reply-To: <20240214060538.3524462-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214060538.3524462-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214060538.3524462-6-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 5/5] mm/mglru: improve swappiness handling
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

The reclaimable number of anon pages used to set initial reclaim
priority is only based on get_swappiness(). Use can_reclaim_anon_pages()
to include NUMA node demotion.

Also move the swappiness handling of when !__GFP_IO in
try_to_shrink_lruvec() into isolate_folios().

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/vmscan.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f1019afa7813..0daf932feb86 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4307,7 +4307,7 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 {
 	bool success;
 
-	/* swapping inhibited */
+	/* swap constrained */
 	if (!(sc->gfp_mask & __GFP_IO) &&
 	    (folio_test_dirty(folio) ||
 	     (folio_test_anon(folio) && !folio_test_swapcache(folio))))
@@ -4476,9 +4476,11 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	DEFINE_MIN_SEQ(lruvec);
 
 	/*
-	 * Try to make the obvious choice first. When anon and file are both
-	 * available from the same generation, interpret swappiness 1 as file
-	 * first and MAX_SWAPPINESS as anon first.
+	 * Try to make the obvious choice first, and if anon and file are both
+	 * available from the same generation,
+	 * 1. Interpret swappiness 1 as file first and MAX_SWAPPINESS as anon first.
+	 * 2. If !__GFP_IO, file first since clean pagecache is more likely to
+	 *    exist than clean swapcache.
 	 */
 	if (!swappiness)
 		type = LRU_GEN_FILE;
@@ -4488,6 +4490,8 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 		type = LRU_GEN_FILE;
 	else if (swappiness == MAX_SWAPPINESS)
 		type = LRU_GEN_ANON;
+	else if (!(sc->gfp_mask & __GFP_IO))
+		type = LRU_GEN_FILE;
 	else
 		type = get_type_to_scan(lruvec, swappiness, &tier);
 
@@ -4731,10 +4735,6 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	unsigned long scanned = 0;
 	int swappiness = get_swappiness(lruvec, sc);
 
-	/* clean file folios are more likely to exist */
-	if (swappiness && !(sc->gfp_mask & __GFP_IO))
-		swappiness = 1;
-
 	while (true) {
 		int delta;
 
@@ -4897,7 +4897,6 @@ static void set_initial_priority(struct pglist_data *pgdat, struct scan_control
 {
 	int priority;
 	unsigned long reclaimable;
-	struct lruvec *lruvec = mem_cgroup_lruvec(NULL, pgdat);
 
 	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
 		return;
@@ -4907,7 +4906,7 @@ static void set_initial_priority(struct pglist_data *pgdat, struct scan_control
 	 * where reclaimed_to_scanned_ratio = inactive / total.
 	 */
 	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_swappiness(lruvec, sc))
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	/* round down reclaimable and round up sc->nr_to_reclaim */
-- 
2.43.0.687.g38aa6559b0-goog


