Return-Path: <linux-kernel+bounces-152967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E869E8AC6D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EDC282A54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641FF50241;
	Mon, 22 Apr 2024 08:23:10 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92F4CB2E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774190; cv=none; b=OQVsNp5p4YRqUt1C7MHMcOGwyRHy/BIzDf1LZ7HLm69IR+jWCBfi1C5eRsDdjsr8Yr9jUksr5r2F556ww6oC6yO+6sQ9u48ynfxBDNXBFj0W6gNohchNS/z1jSTsajc6HP32yJzQu0DkOIiqaG7mElv2zkYmiGTI8d6CMvGm34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774190; c=relaxed/simple;
	bh=fx9YuYE5tfNvbEhu+Kifp+zfFy5kCKUb/5dSgbVi/Bw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n4I1BxsjzY/Fw7nIJkpX+uDsPAGmPtcROJtjfWcSGTDvqzhXHHZQD/fGZDppJumzlAExPBoqbkqRJ7eaca2qPyuSgSdEDzv+0NNPi8YzrYt9OJds5e21gDfF++DF1Wk76FpkBCWM9zfOFQT7/1MmwrdwJ3b+zlsz1hv+g2NmwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 43M8MmmN085755;
	Mon, 22 Apr 2024 16:22:48 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VNJ8b0qwzz2MxHx5;
	Mon, 22 Apr 2024 16:20:15 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 Apr 2024 16:22:42 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <yu.c.chen@intel.com>, <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>,
        <di.shen@unisoc.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds when reweight_eevdf
Date: Mon, 22 Apr 2024 16:22:38 +0800
Message-ID: <20240422082238.5784-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 43M8MmmN085755

kernel encounters the following error when running workload:

BUG: kernel NULL pointer dereference, address: 0000002c
EIP: set_next_entity (fair.c:?)

which was caused by NULL pointer returned by pick_eevdf().

Further investigation has shown that, the entity_eligible() has an
false-negative issue when the entity's vruntime is far behind the
cfs_rq.min_vruntime that, the (vruntime - cfs_rq->min_vruntime) * load
caused a s64 overflow, thus every entity on the rb-tree is not
eligible, which results in a NULL candidate.

The reason why entity's vruntime is far behind the cfs_rq.min_vruntime
is because during a on_rq task group's update_cfs_group()->reweight_eevdf(),
there is no limit on the new entity's vlag. If the new weight is much
smaller than the old one,

vlag = div_s64(vlag * old_weight, weight)

generates a huge vlag, and results in very small(negative) vruntime.

Thus limit the range of vlag accordingly.

Reported-by: Sergei Trofimovich <slyich@gmail.com>
Closes: https://lore.kernel.org/all/ZhuYyrh3mweP_Kd8@nz.home/
Reported-by: Igor Raits <igor@gooddata.com>
Closes: https://lore.kernel.org/all/CA+9S74ih+45M_2TPUY_mPPVDhNvyYfy1J1ftSix+KjiTVxg8nw@mail.gmail.com/
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
Reported-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
changes of v2:
-add reported-by (suggested by <yu.c.chen@intel.com>)
-remork the changelog (<yu.c.chen@intel.com>)
-remove the judgement of fork (Peter)
-remove the !on_rq case. (Peter)
---
Previous discussion link:
https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/
https://lore.kernel.org/all/20240130080643.1828-1-xuewen.yan@unisoc.com/
---
---
 kernel/sched/fair.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..64826f406d6d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -696,15 +696,21 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static s64 entity_lag(u64 avruntime, struct sched_entity *se)
 {
-	s64 lag, limit;
+	s64 vlag, limit;
+
+	vlag = avruntime - se->vruntime;
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+
+	return clamp(vlag, -limit, limit);
+}
 
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
 	SCHED_WARN_ON(!se->on_rq);
-	lag = avg_vruntime(cfs_rq) - se->vruntime;
 
-	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
-	se->vlag = clamp(lag, -limit, limit);
+	se->vlag = entity_lag(avg_vruntime(cfs_rq), se);
 }
 
 /*
@@ -3761,7 +3767,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	 *	   = V  - vl'
 	 */
 	if (avruntime != se->vruntime) {
-		vlag = (s64)(avruntime - se->vruntime);
+		vlag = entity_lag(avruntime, se);
 		vlag = div_s64(vlag * old_weight, weight);
 		se->vruntime = avruntime - vlag;
 	}
-- 
2.25.1


