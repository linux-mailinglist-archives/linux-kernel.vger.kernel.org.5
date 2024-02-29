Return-Path: <linux-kernel+bounces-86200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A976386C17C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C239B216CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9A446AC;
	Thu, 29 Feb 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/YgP0wg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2D3BBF4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189880; cv=none; b=uLXTEEOwYn3bWshWgAIxWJKuk60IANEcv/I47LEyyCCW9UDS9GKHWQPm0eoi8Uqguz+WWyoAmxT1kzwojWVBri7npJuuUL0MoSlOu0k6Uqc3plnxrzH4MVINumhGgZ6bHHVJld9p9h4GXmd72uXXDTB2434TdKyElk+ncAbZMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189880; c=relaxed/simple;
	bh=YJig5ebYDQY5wtAFytmqoCfXqJMvgCsZZ5rmGbjcLVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t8v8z2vYvIIL5JKenMOxnDK7gOJ2Eeq1Z2tTzlSVgrK9Zt6XuRnWeGyVJqOvJAu+ZBzzYic7vAZ+v4OMz6yIQtMcRC/oMN48wfa3bHgTSaa7NOmBGL7VMdP2gyfEQ9htY8dwdkYMEuA8XVmNJq0eoxD7mR7KT8usEcTSeC/XyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/YgP0wg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709189876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7nd7E2+HpEQtuS8MhHXByc9SOCzXfhgdn+43wVJB1Iw=;
	b=D/YgP0wgKq60R+i613vKRgX1m0yoeFxXi09BSrlDhDwDFl5uW9UGdSjDUfS8HqPqiYmwQp
	Chtg9i2LEo8vuWFiwDP97yE/7a6Tun4M8pToZ89DQJNSJdtGTotlrCbs/QyEkrZnEfJo/H
	I69X+S1EyYjBeDVYrfW10TzSRMplE6I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-yPUgX7eQNzW3MNiR-31mPw-1; Thu,
 29 Feb 2024 01:57:54 -0500
X-MC-Unique: yPUgX7eQNzW3MNiR-31mPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99A283C11A05;
	Thu, 29 Feb 2024 06:57:53 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 37F83F63EA;
	Thu, 29 Feb 2024 06:57:53 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Eric Auger <eauger@redhat.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	James Morse <james.morse@arm.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 0/3] KVM: selftests: aarch64: Introduce pmu_event_filter_test
Date: Thu, 29 Feb 2024 01:56:18 -0500
Message-Id: <20240229065625.114207-1-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

The test is inspired by the pmu_event_filter_test which implemented by x86. On
the arm64 platform, there is the same ability to set the pmu_event_filter
through the KVM_ARM_VCPU_PMU_V3_FILTER attribute. So add the test for arm64.

The series first create the helper function which can be used
for the vpmu related tests. Then, it implement the test.

Changelog:
----------
v4->v5:
  - Rebased to v6.8-rc6.
  - Refactor the helper function, make it fine-grained and easy to be used.
  - Namimg improvements.
  - Use the kvm_device_attr_set() helper.
  - Make the test descriptor array readable and clean.
  - Delete the patch which moves the pmu related helper to vpmu.h.
  - Remove the kvm_supports_pmu_event_filter() function since nobody will run
  this on a old kernel.

v3->v4:
  - Rebased to the v6.8-rc2.

v2->v3:
  - Check the pmceid in guest code instead of pmu event count since different
  hardware may have different event count result, check pmceid makes it stable
  on different platform.                        [Eric]
  - Some typo fixed and commit message improved.

v1->v2:
  - Improve the commit message.                 [Eric]
  - Fix the bug in [enable|disable]_counter.    [Raghavendra & Marc]
  - Add the check if kvm has attr KVM_ARM_VCPU_PMU_V3_FILTER.
  - Add if host pmu support the test event throught pmceid0.
  - Split the test_invalid_filter() to another patch. [Eric]

v1: https://lore.kernel.org/all/20231123063750.2176250-1-shahuang@redhat.com/
v2: https://lore.kernel.org/all/20231129072712.2667337-1-shahuang@redhat.com/
v3: https://lore.kernel.org/all/20240116060129.55473-1-shahuang@redhat.com/
v4: https://lore.kernel.org/all/20240202025659.5065-1-shahuang@redhat.com/

Shaoqin Huang (3):
  KVM: selftests: aarch64: Add helper function for the vpmu vcpu
    creation
  KVM: selftests: aarch64: Introduce pmu_event_filter_test
  KVM: selftests: aarch64: Add invalid filter test in
    pmu_event_filter_test

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/aarch64/pmu_event_filter_test.c       | 325 ++++++++++++++++++
 .../kvm/aarch64/vpmu_counter_access.c         |  33 +-
 .../selftests/kvm/include/aarch64/vpmu.h      |  29 ++
 4 files changed, 362 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h

-- 
2.40.1


