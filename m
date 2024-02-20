Return-Path: <linux-kernel+bounces-72929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6A85BAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2787A1C22394
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12E76773B;
	Tue, 20 Feb 2024 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YmHq88Nj"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482F657D7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429482; cv=none; b=cM17oT/d5eMoHTLwTW3QBBqoHsBsUYO4YntdhGmCjrpYvgIurS/syfaP9RHuFSpFi5HgncGgLa/xezCBm87523BRMP6z/KpgW5a6RcWrvunPhok6thRtyAU1n3Tvn9B/LMVwptbxZSX9gyAhIEvxV2+pSvvhbceofV531Z1evwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429482; c=relaxed/simple;
	bh=wFwGQOpNEBJ6RvCPo1NYthjN1KIzKMJfv7sjFw0IOrM=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=KByJSQNBXccnm+aTS1QlF8PFUKkbBzIyYlTTFuN6sHoCwvGKVDorzrJBA5dsJgeEW9TYOWJiCw8Dq0Ixey69Ar6vLkWlX1Y6QiLCafbAPg+tiRo9QkDnJEs6odywrMIjtYsZhov6tamcAYJllR8dKFys8gsOuGaTMTedMfyR0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YmHq88Nj; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH RESEND 0/3] mm/zsmalloc: some cleanup for get/set_zspage_mapping()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708429478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xPhvAK2/CwxqosuPKJ0uCWAeLXDmPfN7jw3gdgYocrs=;
	b=YmHq88Njyhm2Pr867Jk7e9cUM2YgV5Kw5R56B72cWgMekDcZeeLfL0BQPB9jq5YMk5MFmx
	mOIG0lcvWGGuVitAvxPsy8lXXPjObsqOO+eaM562LT9q7mhHjnN9CBmdLUdgnCr9Jp/3Bl
	5wLfMRybgk/lk9sIi0HeifL5arIXVcg=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAJyQ1GUC/43OwY4CIQwG4FcxnMUAA4N68j02HmipDgkyZnDIqpl3t9mz2cyp+Zv8X/sWlaZEVR
 w3bzFRSzWNhYPebgQOoVxJpshZGGWsMkZJsPJVbyHnESVmCmW+S9erYLU7APQguAmhkoQpFBy4W+ac
 eTmk+hin59+lpnn8/I82LZV06IgsYox7f4LngyKjtMPxJs5sNrPCMewoH7UjD36P9pvTrXA6doL3Ti
 N/FDv45tgVjmXncnABLj0pZd0ppzL/7iI1cV6W5QM2/Mo3kwEAAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 20 Feb 2024 11:44:28 +0000
Message-Id: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
To: hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 nphamcs@gmail.com, yosryahmed@google.com, Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708429476; l=1438;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=wFwGQOpNEBJ6RvCPo1NYthjN1KIzKMJfv7sjFw0IOrM=;
 b=7GscvdD0HgdL3NVA9Yals2j5vg6+eQzCDNJ83CWGDzCEBZF3YqfAw/rT+BdvASJen2APnlDj8
 yDqQN8Y7o79AW5g1RKPfWYqrkF7aqBy4VANvhGNrzttBKKGJLrKZ4eM
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

RESEND:
- The sent patches were put into spam folder because of my mail problem,
  so resend after I fixed it, sorry! It should be ok this time.
- Link to v1: https://lore.kernel.org/r/20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com

Hello,

The discussion[1] with Sergey shows there are some cleanup works to do
in get/set_zspage_mapping():

- the fullness returned from get_zspage_mapping() is not stable outside
  pool->lock, this usage pattern is confusing, but should be ok in this
  free_zspage path.

- we seldom use the class_idx returned from get_zspage_mapping(), only
  free_zspage path use to get its class.

- set_zspage_mapping() always set the zspage->class, but it's never
  changed after zspage allocated.

Thanks for review and comments!

[1] https://lore.kernel.org/all/a6c22e30-cf10-4122-91bc-ceb9fb57a5d6@bytedance.com/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (3):
      mm/zsmalloc: remove set_zspage_mapping()
      mm/zsmalloc: remove_zspage() don't need fullness parameter
      mm/zsmalloc: remove get_zspage_mapping()

 mm/zsmalloc.c | 55 +++++++++++++------------------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)
---
base-commit: 207636f0f52428f3b46540b212d6f93c6ac484cf
change-id: 20240220-b4-zsmalloc-cleanup-560a4159bb6b

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>

