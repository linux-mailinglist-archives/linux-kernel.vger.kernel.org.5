Return-Path: <linux-kernel+bounces-63254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F9852CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF6F1C213FB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E833CCC;
	Tue, 13 Feb 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ue3reT56"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661D224D6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817347; cv=none; b=RsnhS5SFbeLmofj71WDyN67R3bCeN2Fq8yltcGDG1GgKerc+KnLzUopXPFmux0dfmz8L5Txv3psX97oLHs6MWwup/mUObglXVYvnBwhUV2jJbV1wC34TKl2v9Yw1EJhMaPJCzGFQn2s+hVkEpOXlzhGCp9s8y1VSEut0n1rAJGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817347; c=relaxed/simple;
	bh=BBRquBRon3PszAnzHobEjBuxkFIZiY9f9MB60l15p2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui4jVmAQEkOUrh0khVFMBvNc8mVEByoRjPKDlW0Hf/YTLjkgZaw1AIOvRSofBEKUVxDfkIMSpqXScqCRIRXoiWQ66sby/FkjcFIFmD0M0iLR/YFFGeOeNksbT4Baqqfssz5xDzBO6CLup9tSO/qDHlZVpuOtwZH2H4QCUb00pxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ue3reT56; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707817344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+nhnpV9cTa5T5zRVWJVPTwjU5zRG8qikjP97n6jlxI=;
	b=ue3reT56fVXCKJyglvSSqFfaWxf6VnGHRUKrI4CNwKYTCq1mx3ZedLMj7I6j/No9Pmtoct
	y0ceCEmMeibOZUMIqToQlUb7zPn2sD5RK/QSx6aHLGR6hA7LeX8Ui5+aZUt6X1AUtdctXB
	7F83XFPIhmAamNtx76XTi0OBsk3QeSg=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v2 21/23] KVM: selftests: Use MPIDR_HWID_BITMASK from cputype.h
Date: Tue, 13 Feb 2024 09:42:02 +0000
Message-ID: <20240213094202.3962084-1-oliver.upton@linux.dev>
In-Reply-To: <20240213093250.3960069-1-oliver.upton@linux.dev>
References: <20240213093250.3960069-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

No need for a home-rolled definition, just rely on the common header.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/aarch64/psci_test.c         | 2 ++
 tools/testing/selftests/kvm/include/aarch64/processor.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/psci_test.c b/tools/testing/selftests/kvm/aarch64/psci_test.c
index 9b004905d1d3..9fa3578d47d5 100644
--- a/tools/testing/selftests/kvm/aarch64/psci_test.c
+++ b/tools/testing/selftests/kvm/aarch64/psci_test.c
@@ -13,7 +13,9 @@
 
 #define _GNU_SOURCE
 
+#include <linux/kernel.h>
 #include <linux/psci.h>
+#include <asm/cputype.h>
 
 #include "kvm_util.h"
 #include "processor.h"
diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index cf20e44e86f2..94e8f1892754 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -58,8 +58,6 @@
 	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |				\
 	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT))
 
-#define MPIDR_HWID_BITMASK (0xff00fffffful)
-
 void aarch64_vcpu_setup(struct kvm_vcpu *vcpu, struct kvm_vcpu_init *init);
 struct kvm_vcpu *aarch64_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
 				  struct kvm_vcpu_init *init, void *guest_code);
-- 
2.43.0.687.g38aa6559b0-goog


