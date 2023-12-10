Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32780BA3D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjLJLBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:01:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47841106
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702206066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vcMTkBmsMSR+TJtwz30pl082Vy2SUA+d1o6O16UtCUc=;
        b=QL5BVqUvW6SPtJMygPSG5ZLZQ67zRlcDB9ZaQLAbIPozkmL8eRH0ZUuXOx/CPQosWJE6Wh
        Ix4FS1Wr8xoKkZzc2GGxQ2Qzul+WGLPNnZbb8OAQVzEcq0ZMvBNxCt+s9IcDobO73ZNg3a
        0dX36PqulyxNVuQECKu7Fa+JEEB3aYE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-bbEOZewPMF6L0_gJPRBFDQ-1; Sun,
 10 Dec 2023 06:01:02 -0500
X-MC-Unique: bbEOZewPMF6L0_gJPRBFDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81AE529AB3E6;
        Sun, 10 Dec 2023 11:01:02 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64F1CC157C0;
        Sun, 10 Dec 2023 11:01:02 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 6.7-rc5
Date:   Sun, 10 Dec 2023 06:01:01 -0500
Message-Id: <20231210110101.2435586-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 4cdf351d3630a640ab6a05721ef055b9df62277f:

  KVM: SVM: Update EFER software model on CR0 trap for SEV-ES (2023-12-08 13:37:05 -0500)

----------------------------------------------------------------
Generic:

* Set .owner for various KVM file_operations so that files refcount the
  KVM module until KVM is done executing _all_ code, including the last
  few instructions of kvm_put_kvm().  And then revert the misguided
  attempt to rely on "struct kvm" refcounts to pin KVM-the-module.

ARM:

* Do not redo the mapping of vLPIs, if they have already been mapped

s390:

* Do not leave bits behind in PTEs

* Properly catch page invalidations that affect the prefix of a nested
  guest

x86:

* When checking if a _running_ vCPU is "in-kernel", i.e. running at CPL0,
  get the CPL directly instead of relying on preempted_in_kernel (which
  is valid if and only if the vCPU was preempted, i.e. NOT running).

* Fix a benign "return void" that was recently introduced.

Selftests:

* Makefile tweak for dependency generation

* -Wformat fix

----------------------------------------------------------------
Claudio Imbrenda (2):
      KVM: s390: vsie: fix wrong VIR 37 when MSO is used
      KVM: s390/mm: Properly reset no-dat

David Woodhouse (1):
      KVM: selftests: add -MP to CFLAGS

Kunkun Jiang (1):
      KVM: arm64: GICv4: Do not perform a map to a mapped vLPI

Like Xu (2):
      KVM: x86: Get CPL directly when checking if loaded vCPU is in kernel mode
      KVM: x86: Remove 'return void' expression for 'void function'

Paolo Bonzini (3):
      Merge tag 'kvmarm-fixes-6.7-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into kvm-master
      Merge tag 'kvm-s390-master-6.7-1' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into kvm-master
      Merge tag 'kvm-x86-fixes-6.7-rcN' of https://github.com/kvm-x86/linux into kvm-master

Sean Christopherson (3):
      KVM: Set file_operations.owner appropriately for all such structures
      Revert "KVM: Prevent module exit until all VMs are freed"
      KVM: SVM: Update EFER software model on CR0 trap for SEV-ES

angquan yu (1):
      KVM: selftests: Actually print out magic token in NX hugepages skip message

 arch/arm64/kvm/vgic/vgic-v4.c                          |  4 ++++
 arch/s390/kvm/vsie.c                                   |  4 ----
 arch/s390/mm/pgtable.c                                 |  2 +-
 arch/x86/kvm/debugfs.c                                 |  1 +
 arch/x86/kvm/svm/svm.c                                 |  8 +++++---
 arch/x86/kvm/x86.c                                     |  9 ++++++---
 tools/testing/selftests/kvm/Makefile                   |  2 +-
 .../testing/selftests/kvm/x86_64/nx_huge_pages_test.c  |  2 +-
 virt/kvm/kvm_main.c                                    | 18 ++++++++----------
 9 files changed, 27 insertions(+), 23 deletions(-)

