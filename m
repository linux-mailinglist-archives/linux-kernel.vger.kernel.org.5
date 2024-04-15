Return-Path: <linux-kernel+bounces-145513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB468A573A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026532853A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B52824B5;
	Mon, 15 Apr 2024 16:11:29 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA651E535;
	Mon, 15 Apr 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197488; cv=none; b=Yi+AIIoJUwUnqWmAJ1xWXFahUkyQ6GGXNLgSG8snX7Rwv0/veDebvyOPXT9vXUD+gEs/gN/VR5lZojxAjkGlJmb6YLBTJl/q7vQs9odrGUZw0pwWQ1zw6lP6/tgu2TioF99nxAcV0TjQFY++F6cboKIf703pVAeahgGbI3CjKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197488; c=relaxed/simple;
	bh=vrYz2NXhQnqxuh9h++AL0NeXjFJvJBO+eZJi+7eVy+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LgDwbAjuWl2rzOBgLLw2wku90bJqwygwFUxBRnwSbvyrOf2rktXXJ5qIeJwGeQSH36HtbKogVWC6BB3HbWa4spImJrKFrcDst3DrCkENtcH/QXKbQzPvBHLC642CPRIluwts7YSvD0KKsQm4RZqQ20/ubdYtSTNGyxMQ9odJybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VJBTK2txrz9xrnb;
	Mon, 15 Apr 2024 23:50:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 80F88140159;
	Tue, 16 Apr 2024 00:11:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0iaZUR1m4n9HBg--.16529S2;
	Mon, 15 Apr 2024 17:11:21 +0100 (CET)
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
Subject: [RFC][PATCH v2 0/9] ima: Integrate with digest_cache LSM
Date: Mon, 15 Apr 2024 18:10:35 +0200
Message-Id: <20240415161044.2572438-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDn0iaZUR1m4n9HBg--.16529S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr45JF1xZF1DKrW8try7ZFb_yoW7try5pa
	9Fg3W5tr1kZryxCr43Aa17CF4rKr95Ka17Gw4DJ34Yya15WF1jvw1Syry7uFy5Kr4Fqa17
	tw42gr1UCw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvj
	DU0xZFpf9x07jzE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5x3EgAAsD

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

https://lore.kernel.org/linux-integrity/20240415142436.2545003-15-roberto.sassu@huaweicloud.com/


Third, it makes a PCR predictable and suitable for TPM key sealing
policies.

Finally, it allows IMA to maintain a predictable PCR and to perform
appraisal from the very beginning of the boot, in the initial ram disk
(of course, it won't recognize automatically generated files, that don't
exist in the RPM packages).


Integration of IMA with the digest_cache LSM is straightforward.

Patch 1 lets IMA know when the digest_cache LSM is reading a digest list,
to populate a digest cache.

Patch 2 allows nested IMA verification of digest lists read by the
digest_cache LSM.

Patch 3 allows the usage of digest caches with the IMA policy.

Patch 4 introduces new boot-time built-in policies, to use digest caches
from the very beginning (it allows measurement/appraisal from the initial
ram disk).

Patch 5 modifies existing boot-time built-in policies if the digest_cache
LSM-specific policies have been selected at boot.

Patch 6 attaches the verification result of the digest list to the digest
cache being populated with that digest list.

Patch 7-8 enable the usage of digest caches respectively for measurement
and appraisal, at the condition that it is authorized with the IMA policy
and that the digest list itself was measured and appraised too.

Patch 9 subscribes to digest cache events and invalidates cached integrity
results on digest cache reset (file or directory modification).

Open points:
- Mimi prefers to extend flags in ima_iint_cache, rather than passing the
  parameter down to process_measurement() - will do in a next version
- Prefetching of digest lists should not be done if there is no
  measurement rule (not relevant for appraisal)

Changelog

v1:
- Change digest_cache= policy keyword value from 'content' to 'data'
  (suggested by Mimi)
- Move digest_cache LSM integration code to ima_digest_cache.c (suggested
  by Mimi)
- Don't store digest cache pointer in integrity metadata
- Rename 'digest_cache_mask' parameter of ima_get_action() and
  ima_match_policy() to 'digest_cache_usage'
- Rename 'digest_cache_mask' parameter of ima_store_measurement() and
  ima_appraise_measurement() to 'allowed_usage'
- Try digest cache method as first in ima_appraise_measurement() (suggested
  by Mimi)
- Introduce ima_digest_cache_change() to be called on digest cache reset
- Subscribe to digest cache events
- Add forgotten modification in ima_iint_lockdep_annotate() (reported by
  Mimi)
- Replace 'digest_cache_mask' member of the ima_rule_entry structure with
  'digest_cache_usage' (suggested by Mimi)
- Split patch introducing digest_cache LSM-specific boot-time built-in
  policies and modifying existing rules
- Add digest_cache LSM-specific boot-time built-in policies if the
  digest_cache LSM is enabled in the kernel configuration
- Rename IMA_DIGEST_CACHE_MEASURE_CONTENT and
  IMA_DIGEST_CACHE_APPRAISE_CONTENT to IMA_DIGEST_CACHE_MEASURE_DATA and
  IMA_DIGEST_CACHE_APPRAISE_DATA

Roberto Sassu (9):
  ima: Introduce hook DIGEST_LIST_CHECK
  ima: Nest iint mutex for DIGEST_LIST_CHECK hook
  ima: Add digest_cache policy keyword
  ima: Add digest_cache_measure/appraise boot-time built-in policies
  ima: Modify existing boot-time built-in policies with digest cache
    policies
  ima: Store allowed usage in digest cache based on integrity metadata
    flags
  ima: Use digest caches for measurement
  ima: Use digest caches for appraisal
  ima: Register to the digest_cache LSM notifier and process events

 Documentation/ABI/testing/ima_policy          |   6 +-
 .../admin-guide/kernel-parameters.txt         |  15 ++-
 security/integrity/ima/Kconfig                |  10 ++
 security/integrity/ima/Makefile               |   1 +
 security/integrity/ima/ima.h                  |  22 +++-
 security/integrity/ima/ima_api.c              |  21 ++-
 security/integrity/ima/ima_appraise.c         |  32 +++--
 security/integrity/ima/ima_digest_cache.c     | 123 ++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h     |  36 +++++
 security/integrity/ima/ima_iint.c             |  17 ++-
 security/integrity/ima/ima_main.c             |  46 +++++--
 security/integrity/ima/ima_policy.c           | 122 ++++++++++++++++-
 12 files changed, 413 insertions(+), 38 deletions(-)
 create mode 100644 security/integrity/ima/ima_digest_cache.c
 create mode 100644 security/integrity/ima/ima_digest_cache.h

-- 
2.34.1


