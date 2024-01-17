Return-Path: <linux-kernel+bounces-28923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F08304B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73F11C242CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E71DFD2;
	Wed, 17 Jan 2024 11:46:33 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5681DFC8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491992; cv=none; b=dmK3o6ditS+ztGdEDhseqQRYwPMzjlVXp1xKn2xotrtLnsyB/trmRFdv8LotDMSRdIQkt1sJjbSrKlEAdI3thT1W7E4S3FhQ5suk+Hnf0smHVstkmBlKYRov0cvmZeJZ1c9lL7WLV5RGItm3y98yuuJ4RDTJhoP4HBzKZX5s50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491992; c=relaxed/simple;
	bh=LH2POZOBi2Nlbb69xaERw+Hb7wxNOYKCDSU2IuqkJY0=;
	h=Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-b4-tracking:X-Report-Abuse:From:Date:Message-Id:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Migadu-Flow; b=jGexUQsWzLFCk8Q4KUGelFEps1xp+/pir4aHusIaMVqN9R8ntr1AiJV0Js+qp9sRwrJeFi4U4YOpCQvKdAI7IKhIE9go6g4ai3la0o8w4YNofVOHLUeUIp/VwZLB2UkG+wy/sr0CRdtDN2YvtR0JM93GCPX7+oi9p2hAS4qgjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH 0/3] mm/slub: some minor optimization and cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAPW9p2UC/w3LQQqAIBBA0avIrBtQS4RuM9qUA2bgUJvo7rl88P8Lyl1YYTUvdH5E5WoDbjKQC7
 WDUbZh8NYv1rmIWinhKZoxUNjnSMH5EGH0iZQxdWq5jKPdtX7fD0vf9htgAAAA
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Wed, 17 Jan 2024 11:45:57 +0000
Message-Id: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705491984; l=1399;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=LH2POZOBi2Nlbb69xaERw+Hb7wxNOYKCDSU2IuqkJY0=;
 b=8UfcsT2NimbgxMb0PydrroxP+zgswxjFuRTxcFMTcE5IxZ2/Ppoc490EFt1Iik4Cy/JP2AOkJ
 a+dOgBfLGZkCOaawgKAxZfM2UsgXZcPTEJy0aW0mEGqnUVw70ZcyrlT
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Hi,

This series include a minor optimization of cpu partial slab fastpath,
which directly load freelist from cpu partial slab in the likely case.

It has small performance improvement in testing:
perf bench sched messaging -g 5 -t -l 100000

            mm-stable   slub-optimize
Total time      7.473    7.209

The other two patches are cleanups, which are included for convenience.

Thanks for review and comment!

To: Christoph Lameter <cl@linux.com>
To: Pekka Enberg <penberg@kernel.org>
To: David Rientjes <rientjes@google.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
To: Roman Gushchin <roman.gushchin@linux.dev>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

---
Chengming Zhou (3):
      mm/slub: directly load freelist from cpu partial slab in the likely case
      mm/slub: remove full list manipulation for non-debug slab
      mm/slub: remove unused parameter in next_freelist_entry()

 mm/slub.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)
---
base-commit: ab27740f76654ed58dd32ac0ba0031c18a6dea3b
change-id: 20240117-slab-misc-5a5f37a51257

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

