Return-Path: <linux-kernel+bounces-12239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518881F1D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E255F283CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58747F63;
	Wed, 27 Dec 2023 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrvdMeg6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E4B45946;
	Wed, 27 Dec 2023 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703708933; x=1735244933;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=LBP3V9OVBPjggE/TmVHcccYGhdeKMXq8wuA+Oj8KhSM=;
  b=lrvdMeg6hJel9gW1qCCb4dTZzUjHVynqB9RtZ3HDpCPLw+77heW9mvKJ
   S7KeIAJPmf+FxvlD/NTWiUZDpwGm0YS1x6XAgEuvjOtvDeo+2RSd8UpNO
   P1AIeEKC/HibBPuCcH/UZ7IaMQT/DHndpiwSsTkEcHDApdg/o21bnCqyb
   5yX17O65mrYyktZMqX9DezrLWF6/3K9liAJoIjuMwS6ZYNigesL2KfaDK
   QCPcSGa+GT/FEY/Jt6DYx21Lsg/cKnijfvJnx3tYtCGBHyuFcqoG7NlI1
   4/ciUPFFJgag7pfjGDcwjiZZzAmuPfCSxwdUHixOSXc3Hw2np7OyhLKqC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="9872934"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="9872934"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 12:28:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="807241852"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="807241852"
Received: from kkvillar-mobl.amr.corp.intel.com ([10.213.180.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 12:28:33 -0800
Message-ID: <4bd63cf80a77a696b78d1f16f586ac6517320cd6.camel@linux.intel.com>
Subject: [PATCH v2] crypto: iaa - Account for cpu-less numa nodes
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, fenghua.yu@intel.com
Cc: rex.zhang@intel.com, dave.jiang@intel.com, tony.luck@intel.com, 
	rdunlap@infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date: Wed, 27 Dec 2023 14:28:32 -0600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

In some configurations e.g. systems with CXL, a numa node can have 0
cpus and cpumask_nth() will return a cpu value that doesn't exist,
which will result in an attempt to add an entry to the wq table at a
bad index.

To fix this, when iterating the cpus for a node, skip any node that
doesn't have cpus.

Also, as a precaution, add a warning and bail if cpumask_nth() returns
a nonexistent cpu.

Reported-by: Zhang, Rex <rex.zhang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 v2: In iaa_crypto_init_module(), if nr_nodes is 0, print an error message =
and return.

 drivers/crypto/intel/iaa/iaa_crypto_main.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/in=
tel/iaa/iaa_crypto_main.c
index 5093361b0107..4ebf1950568a 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1017,12 +1017,17 @@ static void rebalance_wq_table(void)
 		return;
 	}
=20
-	for_each_online_node(node) {
+	for_each_node_with_cpus(node) {
 		node_cpus =3D cpumask_of_node(node);
=20
 		for (cpu =3D 0; cpu < nr_cpus_per_node; cpu++) {
 			int node_cpu =3D cpumask_nth(cpu, node_cpus);
=20
+			if (WARN_ON(node_cpu >=3D nr_cpu_ids)) {
+				pr_debug("node_cpu %d doesn't exist!\n", node_cpu);
+				return;
+			}
+
 			if ((cpu % cpus_per_iaa) =3D=3D 0)
 				iaa++;
=20
@@ -2095,9 +2100,15 @@ static struct idxd_device_driver iaa_crypto_driver =
=3D {
 static int __init iaa_crypto_init_module(void)
 {
 	int ret =3D 0;
+	int node;
=20
 	nr_cpus =3D num_online_cpus();
-	nr_nodes =3D num_online_nodes();
+	for_each_node_with_cpus(node)
+		nr_nodes++;
+	if (!nr_nodes) {
+		pr_err("IAA couldn't find any nodes with cpus\n");
+		return -ENODEV;
+	}
 	nr_cpus_per_node =3D nr_cpus / nr_nodes;
=20
 	if (crypto_has_comp("deflate-generic", 0, 0))
--=20
2.34.1



