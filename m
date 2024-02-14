Return-Path: <linux-kernel+bounces-65342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08086854B84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713051F23FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132F5A78C;
	Wed, 14 Feb 2024 14:36:22 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB22F23;
	Wed, 14 Feb 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921381; cv=none; b=CElsHzjy4zHH7Oj5PE4HLnQ+AdMHe16JLHRlFoCyZIoFYC/cRYNKprAVPx/9q3kaBreHAtilGZP1a5UK2RyTcY3XoKNE+Lua3kkOKcxaS8CAqW3cwv6msVSR2/R/pDpTONQy9Vr3NjiJD1Xnsz4IHEyrtqsZISJ7tPmeTd0S92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921381; c=relaxed/simple;
	bh=/vEhcOnzmMbGKVXZewugVt8iIkBPxyUvm5o5iIZYPjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNZjkS1usNSM154a5UJIOU8E216JlG11RVIIlmMiYViLfV/qaCiU5JNkpMtiXrVs6sfG2UEJZkLIPdMtbWHpgD27nw8s4FlkMOHT3tchIlmABmLOjMhsgn7a1VVA/tTWn9oQ2NsIFVx6zUi/zpst+VmOyxdWKGKAXMw0053yaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZgHm10Wdz9xtVK;
	Wed, 14 Feb 2024 22:17:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5B18B14064F;
	Wed, 14 Feb 2024 22:36:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXgRrHz8xlZ55_Ag--.52204S2;
	Wed, 14 Feb 2024 15:36:04 +0100 (CET)
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
	petrtesarik@huaweicloud.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 0/8] ima: Integrate with digest_cache LSM
Date: Wed, 14 Feb 2024 15:35:16 +0100
Message-Id: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXgRrHz8xlZ55_Ag--.52204S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW3tw1kGFWkWFy3JrWkJFb_yoWrXF4Upa
	9agFn0yrykXryxCr43Aa12ka1rKrZ5tF4UJw4DG34Fkan8WF1jv34SyF45uFW5Kr4vva17
	trsIgryUuwn0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9S14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3
	JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0JUUl1kUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj5pZGAAAsi

From: Roberto Sassu <roberto.sassu@huawei.com>

One of the IMA shortcomings over the years has been the availability of
reference digest values for appraisal. Recently, the situation improved
and some Linux distributions are including file signatures.

The digest_cache LSM takes a different approach. Instead of requiring
Linux distributions to include file signatures in their packages, it parses
the digests from signed RPM package headers and exposes an API for
integrity providers to query a digest.

That enables Linux distributions to immediately gain the ability to do
integrity checks with the existing packages, lowering the burden for
software vendors.

In addition, integrating IMA with the digest_cache LSMs has even more
benefits.

First, it allows generating a new-style masurement list including the RPM
package headers and the unknown files, which improves system performance
due to the lower usage of the TPM. The cost is the less accuracy of the
information reported, which might not suitable for everyone.

Second, performance improve for appraisal too. It has been found that
verifying the signatures of only the RPM package headers and doing a digest
lookup is much less computationally expensive than verifying individual
file signatures.

For reference, a preliminary performance evaluation has been published
here:

https://lore.kernel.org/linux-integrity/20240209140917.846878-14-roberto.sassu@huaweicloud.com/


Third, it makes a PCR predictable and suitable for TPM key sealing
policies.

Finally, it allows IMA to maintain a predictable PCR and to perform
appraisal from the very beginning of the boot, in the initial ram disk
(of course, it won't recognize automatically generated files, that don't
exist in the RPM packages).


This patch set has some prerequisites:
- KEYS: Introduce user asymmetric keys and signatures (PGP keys and sigs)
- security: Move IMA and EVM to the LSM infrastructure
- security: digest_cache LSM (+digest_cache_changed(), introduced later)


Integration of IMA with the digest_cache LSM is straightforward.

Patch 1 lets IMA know when the digest_cache LSM is reading a digest list,
to populate a digest cache.

Patch 2 allows nested IMA verification of digest lists read by the
digest_cache LSM.

Patch 3 allows the usage of digest caches with the IMA policy.

Patch 4 introduces new boot-time policies, to use digest caches from the
very beginning (it allows measurement/appraisal from the initial ram disk).

Patch 5 attaches the verification result of the digest list to the digest
cache being populated with that digest list.

Patch 6-7 enable the usage of digest caches respectively for measurement
and appraisal, at the condition that it is authorized with the IMA policy
and that the digest list itself was measured and appraised too.

Patch 8 detects digest cache changes and consequently resets the IMA
cached verification result.

Roberto Sassu (8):
  ima: Introduce hook DIGEST_LIST_CHECK
  ima: Nest iint mutex for DIGEST_LIST_CHECK hook
  ima: Add digest_cache policy keyword
  ima: Add digest_cache_measure and digest_cache_appraise boot-time
    policies
  ima: Record IMA verification result of digest lists in digest cache
  ima: Use digest cache for measurement
  ima: Use digest cache for appraisal
  ima: Detect if digest cache changed since last measurement/appraisal

 Documentation/ABI/testing/ima_policy          |   6 +-
 .../admin-guide/kernel-parameters.txt         |  15 ++-
 security/integrity/ima/Kconfig                |  10 ++
 security/integrity/ima/ima.h                  |  24 +++-
 security/integrity/ima/ima_api.c              |  21 +++-
 security/integrity/ima/ima_appraise.c         |  33 +++--
 security/integrity/ima/ima_iint.c             |  14 ++-
 security/integrity/ima/ima_main.c             |  81 ++++++++++--
 security/integrity/ima/ima_policy.c           | 118 +++++++++++++++++-
 9 files changed, 285 insertions(+), 37 deletions(-)

-- 
2.34.1


