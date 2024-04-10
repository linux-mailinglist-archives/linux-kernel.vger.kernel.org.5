Return-Path: <linux-kernel+bounces-139384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5E8A0252
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FD41C21539
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEC1836FE;
	Wed, 10 Apr 2024 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mlfAaS3g"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55A15EFAD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785407; cv=none; b=ZZsuJwj271J7Q9fcTVoD76Gu+Y86cr8IqE0F82j/dpb/aRye/2qCkokkGImSDsaf7LT4bhtftodKYp8bZnT+Wc5DcCthyLBYp4TIOaOJ3i0GYnv6GMPp2o9NTLbw40kiOmFkc0gMwfY9L66N++ZUM8UtGjoNB/9VNKQpXMbrZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785407; c=relaxed/simple;
	bh=+Mgviufa9dDw5VVbgkJBA+nGF7OT6R8MJwMmJkPife4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jWn1ymoUWKEBOvQoHt/rAK44lI/7J1S7tuXe/moLKeMyhi0IwTV2y0hW54M2Kxsa+fZhiM29OUeb+y0Qh45T1vkN+oDb6nZwXBV9RYBT7Ksq7990fy8cPHAITPdrfZ2etxHK+PVrkKXtp3dM8hRuFh/Zl9MHz1hg9yUGuuz8lNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mlfAaS3g; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AI3MkH017300;
	Wed, 10 Apr 2024 21:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pps0720;
 bh=MwP1ARqe+inhC3lDYv3k3Y9+RrxgpGeRI1A8m8GSgUc=;
 b=mlfAaS3go7SGJL/t5XJ1YtUxEJbS9sWM8f4N2AMfkIFTWcEH0l+Em4Rc5pIhIlg4AfMJ
 tKce6d6yJAiIJ6H8NZzZiC29g3PorTK1yV2BS/qkVD+MOniTtUKdPucYTFhyGX2XRtwM
 0WEe/2AyIyE2TkDpErioocRQv98vQMuLM9tWjS1LZNDjVfRsmYdhetKUFBvDsbzoN2SN
 yhta3ZMOvbJYoqmc6QJBOgbPTds6a0XZbssdbNKxz27xSKLQQeuYFAknpOJ37Tk2gunt
 sDaT5rRUxL8YXyHKsfzasO7hMnV7r0oMd7hmuzUxYLzzLKdsXWBUihPyK5b1WdLNC/wK sA== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xdtpymnk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 21:43:12 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7030F1317A;
	Wed, 10 Apr 2024 21:43:11 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id BFD8E80047C;
	Wed, 10 Apr 2024 21:43:10 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 4AD72302F4723; Wed, 10 Apr 2024 16:33:19 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v2 0/2] sched/topology: Optimize topology_span_sane()
Date: Wed, 10 Apr 2024 16:33:09 -0500
Message-Id: <20240410213311.511470-1-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
X-Proofpoint-ORIG-GUID: UoHMcuuEjPBEIrT-Rm-IdZ63igZGdgbJ
X-Proofpoint-GUID: UoHMcuuEjPBEIrT-Rm-IdZ63igZGdgbJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=521
 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100159

A soft lockup is being detected in build_sched_domains() on 32 socket
Sapphire Rapids systems with 3840 processors.

topology_span_sane(), called by build_sched_domains(), checks that each
processor's non-NUMA scheduling domains are completely equal or
completely disjoint. If a non-NUMA scheduling domain partially overlaps
another, scheduling groups can break.

This series adds for_each_cpu_from() as a generic cpumask macro to
optimize topology_span_sane() by removing duplicate comparisons. The
total number of comparisons is reduced from N * (N - 1) to
N * (N - 1) / 2 on each non-NUMA scheduling domain level, decreasing
the boot time by approximately 20 seconds and preventing the soft lockup
on the mentioned systems.

Changes in v2:
  * 1/2: Change for_each_cpu()'s description.
  * 2/2: Add more information to the commit message.
  * https://lore.kernel.org/linux-kernel/20240409155250.3660517-1-kyle.meyer@hpe.com/T/

Kyle Meyer (2):
  cpumask: Add for_each_cpu_from()
  sched/topology: Optimize topology_span_sane()

 include/linux/cpumask.h | 10 ++++++++++
 kernel/sched/topology.c |  6 ++----
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.44.0


