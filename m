Return-Path: <linux-kernel+bounces-108365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545488809AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9F2282FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362B1173F;
	Wed, 20 Mar 2024 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="R5q+Vv4l"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC087F9E8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902546; cv=none; b=gA3TxpETtY1ADT27wJlXuPGXkW9S2okqH5HAsa7rLfpWVNWg45LuY7MCsrgkNwQmqR6Akw7EJZW1M/boOwbO/jgSxx4m4kOtxX22p21qEgBsbm5RvnKH3UlHj8o9z5TUhRh1relZGl/ld5xLqf+8w/v9nNcYpUuuav/aS/OOjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902546; c=relaxed/simple;
	bh=qrzIBtExBXCUXHgWYojzqnQkh/sdDvI8P9QCLSv5BYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpiw2pidyB70QOX58EK6QNB/EpXbBJQP0H+aAAQJFRd8w169A7Qm38g6DcgP9erL2JMoyjfA9uBoguNQXqCuJlLQ3i8rF6O29DVdXpbQ7meB49EGA25Vy9yuL9Dde2IEIOxWD6fKbj8Mhz3YlTOpHyUJrqyP3obAGyqKkxR9jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=R5q+Vv4l; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789ddcd57f4so376556785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710902541; x=1711507341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3nx6/aDk3VJUuN8aHF02HR1BsWsxIjtwUpot61xzcjI=;
        b=R5q+Vv4lYkMVZG43PwoUBAvHC4CcqWkyhX+gSGfpGf5sF7Jpba8MTEWto87m6xo8bJ
         v2CNiRT5MJ1u1ZU/CoG6tihqWa/wE82KP8SpqgjumeTKh+L6lLzap380INLdeY5IS1O0
         LHuQmWldNc3p2N7Lt4SOeNtvE6seGRWLpaEHeiev7A/AxTHRhizxqAAUdE2dSAQ5WR5J
         qvcL7kSeiClHicaLjgSqjTTLo4CkKjhDdTDG80nYbP5UMm+2WYd7iK82paSzY7PNmNQq
         RIXXhrQ2FlFwmZSc3PiOw1TwYNw6GjpRUSlHATybkDNFv1c56i9+MvB7Dhx0owCLck3x
         +7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902541; x=1711507341;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nx6/aDk3VJUuN8aHF02HR1BsWsxIjtwUpot61xzcjI=;
        b=gUWn0pH27chjdx4AqPgF9cWfTlfoI65xo3fsAaQ9LRMaxKuwG662aeanyaDfW1Q1ZK
         3nC7AARWK4in9dJHR0EagmtrGztjAgNVHMydImbKI7DpQtisq10lA+IoV2S2kvPKvHcU
         Mvu0AjcRf/OkeukaB9C1DkUFlLRm+MGkzPmpTGqH1faSI4TTIcHn5/QPjyLll1OHBFhD
         aUYAqTEt38wgrHLGbPQtTaVvhW+BpFQyrgg75x7mgLkKvuDN5zGG8Z2KHPjJOjSqg2TI
         YIoFfLgSgc7cd6hdVrjzBGC/IWwgpY0hkaD69CN2UnPBMhSUpqO2OqB0XbeaE5tMzmni
         EPJw==
X-Forwarded-Encrypted: i=1; AJvYcCXUaXQBNUYrqLqVilsOnvglVot3LnDigJc1BIRLASPrlxfAoZ7Og9BliQ7dFIy0f+Guk+8UIcQ+Juo0cGT+vB/bzFSyN/zpgMES+QtC
X-Gm-Message-State: AOJu0YzIhIOU4UnwHAtVs5+zx/+d1hafu03XinTIfeUMKiuah7nh73GA
	z1kduNKPeZytNqN54qPfr8g8vr6SFz+8ubtwBSlGRBWptxbtPyUNPoSO2o1cuA==
X-Google-Smtp-Source: AGHT+IE8ey/Y7RHs4C66DCwZWoviXuK1UpbUhJUPjIEBgTvetqJ0Lw+B0vwcdezjuc587wrWuN/E9w==
X-Received: by 2002:a05:620a:4484:b0:788:30a5:6aaf with SMTP id x4-20020a05620a448400b0078830a56aafmr22805144qkp.52.1710902541638;
        Tue, 19 Mar 2024 19:42:21 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id vr17-20020a05620a55b100b00789ea5b08bcsm4074525qkn.23.2024.03.19.19.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:42:21 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	dskarlat@cs.cmu.edu
Subject: [RFC PATCH 2/7] Disallows high-order movable allocations in other zones if ZONE_MOVABLE is populated
Date: Wed, 20 Mar 2024 02:42:13 +0000
Message-Id: <20240320024218.203491-3-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
References: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
Reply-To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Use ZONE_MOVABLE exclusively for non-0 order allocations

Signed-off-by: Kaiyang Zhao <zh_kaiyang@hotmail.com>
---
 mm/page_alloc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..9ad9357e340a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3403,6 +3403,16 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		struct page *page;
 		unsigned long mark;
 
+		/*
+		 * Disallows high-order movable allocations in other zones if
+		 * ZONE_MOVABLE is populated on this node.
+		 */
+		if (ac->highest_zoneidx >= ZONE_MOVABLE &&
+			order > 0 &&
+			zone_idx(zone) != ZONE_MOVABLE &&
+			populated_zone(&(zone->zone_pgdat->node_zones[ZONE_MOVABLE])))
+				continue;
+
 		if (cpusets_enabled() &&
 			(alloc_flags & ALLOC_CPUSET) &&
 			!__cpuset_zone_allowed(zone, gfp_mask))
-- 
2.40.1


