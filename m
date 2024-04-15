Return-Path: <linux-kernel+bounces-145519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A188A5753
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF32285AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2770781752;
	Mon, 15 Apr 2024 16:12:42 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C080635;
	Mon, 15 Apr 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197561; cv=none; b=qJr/fK+lUE5dcvHHKR65L/zoXbKbARJF3ftN/j2ajZE4912AX+7fcrAyrAoehPtrG/2wMcsMjlJZuZimZAuMnQEX+VV4RYFHX12dEqWKCgVWXxHXMDrx4LY8pbj6IgCUrnWXZvNVT7Ne0ypU6vy1D7dTZdPefSDyyE/BDLfYLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197561; c=relaxed/simple;
	bh=JHPuKB2cACTEpt/cnPDWe+nSC05Prn8YFIRzP5Ua1qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDjPpsxc7GXPb1vxgDr01w4fceutG9OpJz2tVjQzOHDcFYBcn0DnMcA9adHgFO3qdUXjfjrjHBuPHMszT5DVU8HDVZXgFtvv2Aoz7/7kkMPOflPyvzmx8s//qA95F0EvWh+gYAaMHQRFE+LHxVuvcVytNxH3QX7O/qrba96deKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VJBVl4PwCz9xqv8;
	Mon, 15 Apr 2024 23:51:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 7A7DB140B20;
	Tue, 16 Apr 2024 00:12:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S7;
	Mon, 15 Apr 2024 17:12:28 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v2 5/9] ima: Modify existing boot-time built-in policies with digest cache policies
Date: Mon, 15 Apr 2024 18:10:40 +0200
Message-Id: <20240415161044.2572438-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415161044.2572438-1-roberto.sassu@huaweicloud.com>
References: <20240415161044.2572438-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXry7Jw1fZFyfWFW3Cw4kJFb_yoW5ur15pa
	9rWryFkrZxXF97Cw1fA3W29F4rK3ykta1UGa1qg345Aa15GF1qv3W0yr43ZFyUGr10qFW7
	AF45Kw4jk3WqvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5h14AAGsy

From: Roberto Sassu <roberto.sassu@huawei.com>

Setting the boot-time built-in policies 'digest_cache_measure' and
'digest_cache_appraise' is not sufficient to use the digest_cache LSM to
measure and appraise files, since their effect is only to measure and
appraise digest lists.

Modify existing measurement rules if the 'digest_cache_measure' built-in
policy is specified by adding to them:

digest_cache=data pcr=12

Other than enabling the usage of the digest_cache LSM for measurement, the
additional keywords also store measurements in the PCR 12, to not confuse
new style measurements with the original ones still stored on PCR 10.

Modify existing appraisal rules if the 'digest_cache_appraise' built-in
policy is specified by adding to them:

digest_cache=data

The additional keyword enables the usage of digest_cache LSM for appraisal.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++--
 security/integrity/ima/ima_policy.c             | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index df877588decc..dc96e6f4eb40 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2074,11 +2074,16 @@
 			critical data.
 
 			The "digest_cache_measure" policy measures digest lists
-			into PCR 12 (can be changed with kernel config).
+			into PCR 12 (can be changed with kernel config), enables
+			the digest cache to be used for the other selected
+			measure rules (if compatible), and measures the files
+			with digest not found in the digest list into PCR 12
+			(changeable).
 
 			The "digest_cache_appraise" policy appraises digest
 			lists with IMA signatures or module-style appended
-			signatures.
+			signatures, and enables the digest cache to be used for
+			the other selected appraise rules (if compatible).
 
 	ima_tcb		[IMA] Deprecated.  Use ima_policy= instead.
 			Load a policy which meets the needs of the Trusted
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f049543f6b64..21bd7a123548 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -918,6 +918,20 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 	for (i = 0; i < count; i++) {
 		struct ima_rule_entry *entry;
 
+		if (IS_ENABLED(CONFIG_SECURITY_DIGEST_CACHE) &&
+		    entries[i].action == MEASURE && ima_digest_cache_measure &&
+		    ima_digest_cache_func_allowed(&entries[i])) {
+			entries[i].digest_cache_usage |= IMA_DIGEST_CACHE_MEASURE_DATA;
+			entries[i].pcr = CONFIG_IMA_DIGEST_CACHE_MEASURE_PCR_IDX;
+			entries[i].flags |= IMA_PCR;
+		}
+
+		if (IS_ENABLED(CONFIG_SECURITY_DIGEST_CACHE) &&
+		    entries[i].action == APPRAISE &&
+		    ima_digest_cache_appraise &&
+		    ima_digest_cache_func_allowed(&entries[i]))
+			entries[i].digest_cache_usage |= IMA_DIGEST_CACHE_APPRAISE_DATA;
+
 		if (policy_rule & IMA_DEFAULT_POLICY)
 			list_add_tail(&entries[i].list, &ima_default_rules);
 
-- 
2.34.1


