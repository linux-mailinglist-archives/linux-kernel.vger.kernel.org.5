Return-Path: <linux-kernel+bounces-51680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CBD848E31
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C263C283AFC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD2225A4;
	Sun,  4 Feb 2024 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="MH57cDeK"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41089224D5;
	Sun,  4 Feb 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054552; cv=none; b=ox8qRW0sU9aR+0v8s1S+R7U559YpLhexqPuk3dY4EpcjwE5Ca2PHQwuJwV1cABKc923LjwSH7bOSRPQaUJUZH6XkWU7U+lfqNSqh4tjui02Rf/4K+3cBJhh3qhzxQ1VPSNM+J3Oa9bCEeFen7B6cOlo04+g8FU1X5RaxztOhfiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054552; c=relaxed/simple;
	bh=PBAj8pYVayUNKv2kDcL/faNAsbTdiZimmpd85dfB2ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPyXq2lO+4CcYCL0dKC5PTBWq/VKrZ/J26pcRyXiz2VtBVr2H1kB6ZWvQqGSBkjogdZwTDKUl5TQ4KBGrshjJyZWWZMolc0af7ZLWC+czco4ien8t/pc5yQrHTPyNvpyGujX4qZ3GzvGqiqxZDMw4yxzJv297BbhSz+jtfO3WLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=MH57cDeK; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5DE6C40F1DC7;
	Sun,  4 Feb 2024 13:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5DE6C40F1DC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707054546;
	bh=TRbuuNKODNr0ZF9osYOg1TOt2Lw0Gxq1svVXRYqAlxE=;
	h=From:To:Cc:Subject:Date:From;
	b=MH57cDeKZyKtqOiF4JcYFV5LKdyE1Xj8W3l2U6ibIoBbwLR0r8StuM88Vg/CGKo60
	 I5Rrb/lnpkvbvnwOvlnpm54OApiu7w4CHwWr8Tk7nC7jtS5hyWPTjmqUrlgMEyJr1g
	 2/tPQDc+0doFPjNAgd3QYbKFXuVruhkEpKshEZX4=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	x86@kernel.org,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] perf/x86/uncore: avoid null-ptr-deref on error in pmu_alloc_topology
Date: Sun,  4 Feb 2024 16:48:41 +0300
Message-Id: <20240204134841.80003-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If topology[die] array allocation fails then topology[die][idx] elements
can't be accessed on error path.

Checking this on the error path probably looks more readable than
decrementing the counter in the allocation loop.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4d13be8ab5d4 ("perf/x86/intel/uncore: Generalize IIO topology support")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 arch/x86/events/intel/uncore_snbep.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a96496bef678..7d4deb9126be 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3831,9 +3831,11 @@ static int pmu_alloc_topology(struct intel_uncore_type *type, int topology_type)
 	return 0;
 clear:
 	for (; die >= 0; die--) {
-		for (idx = 0; idx < type->num_boxes; idx++)
-			kfree(topology[die][idx].untyped);
-		kfree(topology[die]);
+		if (topology[die]) {
+			for (idx = 0; idx < type->num_boxes; idx++)
+				kfree(topology[die][idx].untyped);
+			kfree(topology[die]);
+		}
 	}
 	kfree(topology);
 err:
-- 
2.39.2


