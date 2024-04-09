Return-Path: <linux-kernel+bounces-137274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3789DFC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509F91C22986
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4AE13B5B8;
	Tue,  9 Apr 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="EPZmPHnm"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A339137C21
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678101; cv=none; b=WAoUf/mltpcSZKXllnDOwdKNtttin9XKO7+4HpgwTdotazCEI37DEqr4nu15Nx8v/T0yt0LnLjom7d/PBrejJpjrouevTslUKWokyVBVhKTrLmKNK2BLwKxZEfpaQRr1Ype3KKyqDx1HAL2TNWi0Rq1rmlyhisHo8ZkiycBCB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678101; c=relaxed/simple;
	bh=1l2tPS/uw+PB8D9xP3EBZO3PYpd//HCxeQtArQ8R/zI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMh8iK8mJuF7CXip8udbRFte1DP1pO7f+XT2rmTfObjp3RsbIBERd5MAFVanRyXHYVuSnmZCA8edA3RBdhtsiDyemzQbrKvp7ju3xuFWCy0qOe1CdYHikhFM9IGFNAcgsonng3Toc8MgpM8cUSZVAOm5JXO9MH494b86CCOQAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=EPZmPHnm; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439D47Ad019489;
	Tue, 9 Apr 2024 15:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=y37/eCMfvVuk9cmZXA5UvUTrgMOmLUFWq9k52hU/Lh8=;
 b=EPZmPHnmn+EPPxEl7cg2pK4N8REz4+PznD+lgeUWv0P6t+ChS0LUw7K/MhvA6t6zSJ2V
 4b3+hNOwZ5HHQlg3HZ+nItE9bs8Y/nktshRVU2x8M2hP8VkrCWH+QwsJGuYX7B2tr0ir
 eKYVEiG5STxWZgh0okJvOPq7g5bvAlqvzHvrlnxURf2GFXd8u+mxGRcyzWCZOkiKLCLY
 ck2UZR0o0/W0hooGCL9zD7qOtU1924fWG0UHfdYuUTuLIB0jzYrBVFdX+UdlSDf+2wne
 dkUMzCv108wOJjtSYFjdRekx15f5eUm6gFiPv0X4NwiCWigNfatqNe8DMxr1zI+cLw6q uA== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xd0n6c43s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:54:43 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3118E295EF;
	Tue,  9 Apr 2024 15:54:43 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id D6A7B809046;
	Tue,  9 Apr 2024 15:54:42 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 530A9302F4723; Tue,  9 Apr 2024 10:54:39 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH 2/2 RESEND] sched/topology: Optimize topology_span_sane()
Date: Tue,  9 Apr 2024 10:52:50 -0500
Message-Id: <20240409155250.3660517-3-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240409155250.3660517-1-kyle.meyer@hpe.com>
References: <20240409155250.3660517-1-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aEZwzJ6g0c0-bGY4Q_cvmnctZtRuwETF
X-Proofpoint-ORIG-GUID: aEZwzJ6g0c0-bGY4Q_cvmnctZtRuwETF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=861 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090104

Optimize topology_span_sane() by removing duplicate comparisons.

The total number of comparisons is reduced from N * (N - 1) to
N * (N - 1) / 2 (per non-NUMA scheduling domain level).

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea5986038c..b6bcafc09969 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2347,7 +2347,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(struct sched_domain_topology_level *tl,
 			      const struct cpumask *cpu_map, int cpu)
 {
-	int i;
+	int i = cpu + 1;
 
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
@@ -2359,9 +2359,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	 * breaking the sched_group lists - i.e. a later get_group() pass
 	 * breaks the linking done for an earlier span.
 	 */
-	for_each_cpu(i, cpu_map) {
-		if (i == cpu)
-			continue;
+	for_each_cpu_from(i, cpu_map) {
 		/*
 		 * We should 'and' all those masks with 'cpu_map' to exactly
 		 * match the topology we're about to build, but that can only
-- 
2.44.0


