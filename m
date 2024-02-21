Return-Path: <linux-kernel+bounces-74687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63B85D7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F63283680
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A014F5EA;
	Wed, 21 Feb 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vTYD1Ukl"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532547F46
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517593; cv=none; b=gTGULL0qFVRgs6lYXEozoJwDTm04TJpGlqBCiO4iEaMwR6KpGvuj4uVxwUByFY45Xi0hoZNR66P6/TRU50cT5IQTE8t50fy1LRYmxxdRurTdwa9Po9+HOknM9ogGJqPR8Cdgzeiab+fXooCce/z5AZDsY9e/CMB0ndMECyZUmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517593; c=relaxed/simple;
	bh=NS7tk7efrsJuXRhHDIrpruLzqy4vUvvkh9XAu5b/x0c=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=C1xXNCJbRAucWIsivL0DqlRCws79eEbDegootEVsu5SRyPtJaoQN+7iJEzF6nryOMmB8Qyt+XIYUYkKT12H/dvShqekxIpFWdfoKOoFm+Fw9UCYlGAsN6FtdYCpxUU3uOI2VFb/Z3z9kItUMV9y+o4G+Z/Uz/KlX1YsHBRSf4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vTYD1Ukl; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH 0/2] mm, slab: two minor cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708517588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YyFeFAas4vB0dada4uODHpuW+z80qf5vTLrFrMDt84U=;
	b=vTYD1Ukl/6JuCaUhkepVvZi3LcadMxR9MswwSvI7fiN/TCiBh0YHShvK1GIO6TBLmlLsLh
	lcHe8EMsqlOHcz26H2cs40ca0yLm46EgJkfsWy9EGKarUObqu7bqHVTdbFy7SRJUzSY2BB
	st6ZC11E2/Cb6yKBCNv6RVUDNZqHERM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAMTo1WUC/w3LMQqAMAwAwK9IZgNtUFF/k7ZRCyVKgy7i3+14w71gUrMYrN0LVZ5s+dQG33cQD9
 ZdMKdmIEeDI/JohQPGIqz3hWlbppH8PDlP0EpgEwyVNR4t6V3K9/3LTDErYwAAAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 21 Feb 2024 12:12:52 +0000
Message-Id: <20240221-slab-cleanup-v1-0-63382f41d699@linux.dev>
To: Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708517585; l=572;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=NS7tk7efrsJuXRhHDIrpruLzqy4vUvvkh9XAu5b/x0c=;
 b=3TzBimA+pFpGgJgezqzOceInyXlU1v3/aveS1LU+hy7LdO9YF43jeTccx0xJsn2J/tqk+Oi3k
 0ppRy2/thivAsBq6XfyglIunz9an6HGKfuSySAp3M04iF5+riV76Bbk
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

Just two minor cleanups when reviewing the code.

Thanks!

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
Chengming Zhou (2):
      mm, slab: remove unused object_size parameter in kmem_cache_flags()
      mm, slab: fix the comment

 mm/slab.h        |  3 +--
 mm/slab_common.c |  2 +-
 mm/slub.c        | 11 ++++-------
 3 files changed, 6 insertions(+), 10 deletions(-)
---
base-commit: c09a8e005eff6c064e2e9f11549966c36a724fbf
change-id: 20240221-slab-cleanup-df9652186012

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>

