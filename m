Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690D47FCFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjK2H1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2H1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:27:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A6DA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701242847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9JHYtqN+twx/AtEyT3VDqnE70xU96u5kUlPvxpv06qw=;
        b=Jk4fVvX2xAu/md09BvODSHr8P6FkSujDDHtBfzZVEovocE/RyQXhHsz8M/LxPGejyHUrj2
        2rpNwnNSsxcQg1+nyXfCUkW+kWBEz2WUkrVWDJFRvSQp5WDJYERr58kDOhCDMzWqPyCCOq
        ztcOw7GsXNdWBHxzd7cLLLAFK5NBoYY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-wuFVBLUqOLii4dpAtBKsVg-1; Wed, 29 Nov 2023 02:27:24 -0500
X-MC-Unique: wuFVBLUqOLii4dpAtBKsVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30D43101A53B;
        Wed, 29 Nov 2023 07:27:24 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAE961C060AE;
        Wed, 29 Nov 2023 07:27:23 +0000 (UTC)
From:   Shaoqin Huang <shahuang@redhat.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc:     Eric Auger <eauger@redhat.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        James Morse <james.morse@arm.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 0/5] KVM: selftests: aarch64: Introduce pmu_event_filter_test
Date:   Wed, 29 Nov 2023 02:27:02 -0500
Message-Id: <20231129072712.2667337-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test is inspired by the pmu_event_filter_test which implemented by x86. On
the arm64 platform, there is the same ability to set the pmu_event_filter
through the KVM_ARM_VCPU_PMU_V3_FILTER attribute. So add the test for arm64.

The series first move some pmu common code from vpmu_counter_access to
lib/aarch64/vpmu.c and include/aarch64/vpmu.h, which can be used by
pmu_event_filter_test. Then fix a bug related to the [enable|disable]_counter,
and at last, implement the test itself.

Changelog:
----------
v1->v2:
  - Improve the commit message.                 [Eric]
  - Fix the bug in [enable|disable]_counter.    [Raghavendra & Marc]
  - Add the check if kvm has attr KVM_ARM_VCPU_PMU_V3_FILTER.
  - Add if host pmu support the test event throught pmceid0.
  - Split the test_invalid_filter() to another patch. [Eric]

v1: https://lore.kernel.org/all/20231123063750.2176250-1-shahuang@redhat.com/

Shaoqin Huang (5):
  KVM: selftests: aarch64: Make the [create|destroy]_vpmu_vm() public
  KVM: selftests: aarch64: Move pmu helper functions into vpmu.h
  KVM: selftests: aarch64: Fix the buggy [enable|disable]_counter
  KVM: selftests: aarch64: Introduce pmu_event_filter_test
  KVM: selftests: aarch64: Add invalid filter test in
    pmu_event_filter_test

 tools/testing/selftests/kvm/Makefile          |   2 +
 .../kvm/aarch64/pmu_event_filter_test.c       | 267 ++++++++++++++++++
 .../kvm/aarch64/vpmu_counter_access.c         | 218 ++------------
 .../selftests/kvm/include/aarch64/vpmu.h      | 135 +++++++++
 .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  74 +++++
 5 files changed, 502 insertions(+), 194 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vpmu.c

-- 
2.40.1

