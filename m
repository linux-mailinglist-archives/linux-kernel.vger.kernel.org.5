Return-Path: <linux-kernel+bounces-35002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A6A838A66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D0628B67F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF459B61;
	Tue, 23 Jan 2024 09:33:55 +0000 (UTC)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317859B62
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002434; cv=none; b=E+AGkol6jOpbqkVHkdu/M1DzZyAAIhz00sdtfHpllIXrZXiscX7c1ccfur+Q50dVTwF9eWBxqfNYjCt+1Y1tsTXnzwLcFbD7zJ62bgbpu2niqmlaiB/E/1nqvOC8L1WuXOSNLC43vgmjb6/A6uQPuAF4M29S/3w3wYoUKPIx448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002434; c=relaxed/simple;
	bh=eVMXKZAo6mMH3XIzuesaTRxENZPYrR21d0pV00ugJoA=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=AvMmCfbIEXRs8uq9pSCAR9Bn7rRzEL4YfwV9IswuoYYpzs6yhsHBiBpVRgxJWl5HN1L1RpghU0IC+DGJHG7CadJXa88dvSDrAxYV5JptsJgt3kbwh5CqeON87MypIJNcd8A71to8xyde71hcXop63Zr1V/iO8AFat8g31lGno8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v2 0/3] mm/slub: some minor optimization and cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAOiHr2UC/22MwQqDMBBEf0X23C1Jagjtqf8hPSTrWgMaIWsFEf+9S889DW+YeQcI18wCj+aAyl
 uWvBQFd2mAxljejLlXBmdca6wNKFNMOGch9NEPtxC9dT6A7lMUxlRjoVEf5TNNWo5Z1qXuP/9mNbp/
 qs2iwaG31N6JEgfzTPvKvar4SssMr/M8v5IA8fSrAAAA
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 23 Jan 2024 09:33:28 +0000
Message-Id: <20240117-slab-misc-v2-0-81766907896e@bytedance.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-mm@kvack.org, "Christoph Lameter (Ampere)" <cl@linux.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706002427; l=1261;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=eVMXKZAo6mMH3XIzuesaTRxENZPYrR21d0pV00ugJoA=;
 b=7EmvuAw7LCSLOid/Dwt/QI7NYHltCGe5nToDs6wYquYL4RGXYdJ8Nk17M+xbUBH28eqpO843V
 XlC9mRiHUnKBFUuoCLBCzCVxqGBRRLpNTDF6kXvt7MYn7/sm41HyuAb
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Changes in v2:
- Add VM_BUG_ON(!freelist) after get_freelist() for cpu partial slab case,
  since it's not possible to happen for this case.
- Collect tags.
- Link to v1: https://lore.kernel.org/r/20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com

Hi,

This series include a minor optimization of cpu partial slab fastpath,
which directly load freelist from cpu partial slab in the likely case.

It has small performance improvement in testing:
perf bench sched messaging -g 5 -t -l 100000

            mm-stable   slub-optimize
Total time      7.473    7.209

The other two patches are cleanups, which are included for convenience.

Thanks for review and comment!

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (3):
      mm/slub: directly load freelist from cpu partial slab in the likely case
      mm/slub: remove full list manipulation for non-debug slab
      mm/slub: remove unused parameter in next_freelist_entry()

 mm/slub.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)
---
base-commit: ab27740f76654ed58dd32ac0ba0031c18a6dea3b
change-id: 20240117-slab-misc-5a5f37a51257

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

