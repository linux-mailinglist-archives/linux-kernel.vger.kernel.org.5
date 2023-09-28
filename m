Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23F87B225D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjI1Qaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjI1Qar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F171A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695918603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IWBzhl2+9zQAshTpIDNPZTyRQI6yXSHj+8X91boesOM=;
        b=OHLt3WPXR1b47KPGWygTvb1rfy0YMBYPx9XSdf1WwMjLv+IGLAOA7efywkQ2aF/NNfwR6M
        TJE/KfOII2tiTAOZxSYQyKQxNfMavKoeHmEOwFVl7ZTCfMYuQf6N6mK++GLeIKOQhz7WLr
        +9bRlhNMMrBc9XdqsAVqo+JkJX333Io=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-mWrRzmaZNvK3w4IrQRzPpg-1; Thu, 28 Sep 2023 12:30:00 -0400
X-MC-Unique: mWrRzmaZNvK3w4IrQRzPpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20251101AA44;
        Thu, 28 Sep 2023 16:30:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06FCE140E969;
        Thu, 28 Sep 2023 16:30:00 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 0/3] KVM: x86/mmu: small locking cleanups
Date:   Thu, 28 Sep 2023 12:29:56 -0400
Message-Id: <20230928162959.1514661-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Paolo Bonzini (3):
  KVM: x86/mmu: remove unnecessary "bool shared" argument from functions
  KVM: x86/mmu: remove unnecessary "bool shared" argument from iterators
  KVM: x86/mmu: always take tdp_mmu_pages_lock

 Documentation/virt/kvm/locking.rst |  6 +-
 arch/x86/kvm/mmu/mmu.c             |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c         | 93 +++++++++++++++---------------
 arch/x86/kvm/mmu/tdp_mmu.h         |  3 +-
 4 files changed, 52 insertions(+), 52 deletions(-)

-- 
2.39.1

