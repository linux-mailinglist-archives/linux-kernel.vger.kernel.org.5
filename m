Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F37F8941
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjKYId7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17693E6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700901243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gbnARVNy5E0hGES1ua4xRZ6a56me/D63RWZkoJuQ94E=;
        b=DVU/aB9Lx+xRjUeBUPaiA4D8+hly/PJYRZZ09MataNBVTh/KQvuWbfIK/zQTtla9AF/e0b
        B/649h8y3xSdFZ5D0zRb5pw6moKGizOdu/udO5xES0RJFbFG8mdf1QIx4Uyq0+0+tqRfvL
        dy7OXW3jgfc1rbCxtWglJU+6EQuUDNE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-P13XO4xENne2rqMu9Rhw2g-1; Sat, 25 Nov 2023 03:34:01 -0500
X-MC-Unique: P13XO4xENne2rqMu9Rhw2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5203811E7B;
        Sat, 25 Nov 2023 08:34:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEB751121306;
        Sat, 25 Nov 2023 08:34:00 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, mlevitsk@redhat.com
Subject: [PATCH v2 0/4] KVM: x86/mmu: small locking cleanups
Date:   Sat, 25 Nov 2023 03:33:56 -0500
Message-Id: <20231125083400.1399197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

Remove "bool shared" argument from functions and iterators that need
not know if the lock is taken for read or write.  This is common because
protection is achieved via RCU and tdp_mmu_pages_lock or because the
argument is only used for assertions that can be written by hand.

Also always take tdp_mmu_pages_lock even if mmu_lock is currently taken
for write.

Paolo Bonzini (4):
  KVM: x86/mmu: remove unnecessary "bool shared" argument from functions
  KVM: x86/mmu: remove unnecessary "bool shared" argument from iterators
  KVM: x86/mmu: always take tdp_mmu_pages_lock
  KVM: x86/mmu: fix comment about mmu_unsync_pages_lock

 Documentation/virt/kvm/locking.rst |  7 +--
 arch/x86/include/asm/kvm_host.h    | 11 ++--
 arch/x86/kvm/mmu/mmu.c             |  6 +-
 arch/x86/kvm/mmu/tdp_mmu.c         | 90 ++++++++++++++----------------
 arch/x86/kvm/mmu/tdp_mmu.h         |  3 +-
 5 files changed, 54 insertions(+), 63 deletions(-)

-- 
2.39.1

