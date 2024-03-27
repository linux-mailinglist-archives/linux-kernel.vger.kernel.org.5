Return-Path: <linux-kernel+bounces-120153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B0488D358
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534AAB229B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973F4C9B;
	Wed, 27 Mar 2024 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gCGGsymN"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86167168B7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711498925; cv=none; b=R2qfnGSHtzLNswU/nQjMnoIvHryUkQfPZk0JtJXdQimVW8dIGlVjFpqB7qMbAfVMFH+Si+VeDzTHbJATPjhAqDAawnOuFVHT17/9U1PZLeVfxqnn19LBIG65dIXoY4rjePtz8ds/QaMpO47POGzvcg+htHBQTDyPLj9WAJJ98AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711498925; c=relaxed/simple;
	bh=iaYyHGScj9w7mNRvH/1a3In8aabZyvbMCjqcEhPVA8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6E4h1mhGENYAbpP+3/jKClvfcPQjbVoKzvKwHtCKDWgBc0fRkUqXhAKyfyKF8arndBcQ0+NJYcDSdi7HlFjkROINWNr2Wo76RxvW9wve5639iXTaA4v+EtqIyMWG6tC70oP4vJR4QWLlgF2of+O8K/TZRQNvnl40d+jT9lS/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gCGGsymN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711498920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=btwyyvnLD/UWk0C2Dm1/rk2oyfpCBU9LE8SDT9RMO9E=;
	b=gCGGsymNpbWlj/bDgiEt7cj6pDJMIXZVo6tNoB6vfRuaj7rpACVCsd/vuIefH7Jh3BduHc
	y9hKaJp+ULLnjBo6C67pY1I4OOdKZDwgcgGjuw9xs+AnFPkTXChQvSr69jetrOL57zCadX
	82pXf1SXcNlFN07IsLhK+I97ASymPOw=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] fixup! fix missing vmalloc.h includes
Date: Tue, 26 Mar 2024 20:21:52 -0400
Message-ID: <20240327002152.3339937-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The previous patch added string.h to arch/alpha/lib/memcpy.c to fix a
warning about a missing forward declaration - but this breaks with -
presumably - some fortify source shenanigans that redefine memcpy as a
macro.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 arch/alpha/lib/memcpy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/lib/memcpy.c b/arch/alpha/lib/memcpy.c
index 0e536a1a39ff..cbac3dc6d963 100644
--- a/arch/alpha/lib/memcpy.c
+++ b/arch/alpha/lib/memcpy.c
@@ -18,7 +18,6 @@
 
 #include <linux/types.h>
 #include <linux/export.h>
-#include <linux/string.h>
 
 /*
  * This should be done in one go with ldq_u*2/mask/stq_u. Do it
-- 
2.43.0


