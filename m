Return-Path: <linux-kernel+bounces-72919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA65085BAB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FAE282300
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5472767E6E;
	Tue, 20 Feb 2024 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aSRHd7rF"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668667E62
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429049; cv=none; b=udVD9QDRcDGKGOKBSw4qHl07nIx/qdh/PAm5SQJtJSMGRahVvhtTGu8d9qvSOSHNOouNRQOkM2laYwCw1NOLYqflJ7Tc6WgUTlgbEEj6R/FfLfd9jXTWmWk5fG8NxFobNwSKrdcmRVrs3ct4gmd1PtADnEG1lcf5Madhn5vTUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429049; c=relaxed/simple;
	bh=u0BD650aenviDMkexxkYIC3vVeZXhWA7U/Zaa8RAnoI=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=Hqqsy7hUQxIdY/yjWbFlWCW9+JtZ6QPJOe9THc97M36OcCPD9wlM2T1TkZkRUwRCvNiISEydxwGc9/TLW5YnghG2+NfSQn8PXqHErPmjs1QehrbAJgTKZ6KFqZCW+RwPYCxm1tA5LXeG7MzL1jYVA8yEb3PgIKolNq8PaoFDHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aSRHd7rF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH RESEND 0/3] mm/zsmalloc: fix and optimize objects/page migration
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708429044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wK3jAFMoRRShh/6Xlb4Wy7eZ55CIyOLuDDLesxWb60E=;
	b=aSRHd7rFNs9ReBPtz9Se1im3/m/GcFiFJQ5FE+i2nCs7Pitnfhl2hAo7HTJeskqcIDo6Tf
	1mxqudLodJErPmx9qR4Xu6GY/NespWGwtMrmoYWbpTuhKQLV+dP0JdiTQRO6SNMY8AsUhP
	kxz6pTPI5UrAmurxpfSJLNwQAibFgDY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANmO1GUC/32NQQrCMBBFr1Jm7UgSUyWuvIe4yKRDG0gTSGqhlt7dwQO4+rwP7/8dGtfIDe7dDp
 XX2GLJAvrUQZh8HhnjIAxGGauMdkgW22f2KZWAcxyrXxidcTdtjCZSGsQk3xip+hwmcfM7JSmn2JZS
 t9/TqiWe/0dXjQovNgzWhWtve3rQtvAgo3wOZYbXcRxfTq7Vbr8AAAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 20 Feb 2024 11:36:57 +0000
Message-Id: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
To: hannes@cmpxchg.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, nphamcs@gmail.com, yosryahmed@google.com
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708429041; l=1162;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=u0BD650aenviDMkexxkYIC3vVeZXhWA7U/Zaa8RAnoI=;
 b=MIOQ87+xlG/4a34STTbnKRHRDuAUYK0iSc5rWvCaoG+mW8iELShm09k730ypEX2jTdl5bD65d
 7Dg/SY9HhN+D3R3Y/uHyh02AGkDosXRKSBCkhvxhJtWnT4K49cq2b2F
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

RESEND:
- The sent patches were put into spam folder because of my mail problem,
  so resend after I fixed it, sorry! It should be ok this time.
- Link to v1: https://lore.kernel.org/r/20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com

Hello,

This series is to fix and optimize the zsmalloc objects/page migration.

patch 01 fix the empty migrate_write_lock() when !CONFIG_COMPACTION.
patch 02 remove the migrate_write_lock_nested() in objects migration.
patch 03 remove the unused zspage->isolated counter in page migration.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (3):
      mm/zsmalloc: fix migrate_write_lock() when !CONFIG_COMPACTION
      mm/zsmalloc: remove migrate_write_lock_nested()
      mm/zsmalloc: remove unused zspage->isolated

 mm/zsmalloc.c | 63 ++++++++---------------------------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)
---
base-commit: 9951769060d8f5eb001acaca67c1439d2cfe1c6b
change-id: 20240219-b4-szmalloc-migrate-92971221bb01

Best regards,
-- 
Chengming Zhou <chengming.zhou@linux.dev>

