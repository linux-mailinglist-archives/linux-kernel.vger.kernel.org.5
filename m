Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D180509B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346617AbjLEKio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjLEKia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB561711
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701772672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EsQ/ScQJftZQ38BrXkVofNWM2kNPQwbMRUJ0a1EdV7M=;
        b=OfReK5YHyAFRefDWG67UoOutdP/g7oSQWSlp0I+9YebKcCmX5ye0l5G5AaT0W4uKWzzUv1
        OrwyTKiBYeQ2f0Q4BpXbJGdw8gqDB3PZ1/B7Am6JuY1Ex/V9PP6IgayxNvUFUrxuJz+bZu
        QDE9ZtUGUWC46g/v6YxnoS8JTGRvzoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-QCBqOJBcMhinqUqTnoYdWA-1; Tue, 05 Dec 2023 05:37:49 -0500
X-MC-Unique: QCBqOJBcMhinqUqTnoYdWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BF5283B825;
        Tue,  5 Dec 2023 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.225.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2241EC15968;
        Tue,  5 Dec 2023 10:37:45 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v4 0/4] KVM: x86: tracepoint updates
Date:   Tue,  5 Dec 2023 12:37:41 +0200
Message-Id: <20231205103745.506724-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is intended to add some selected information=0D
to the kvm tracepoints to make it easier to gather insights about=0D
running nested guests.=0D
=0D
This patch series was developed together with a new x86 performance analysi=
s tool=0D
that I developed recently (https://gitlab.com/maximlevitsky/kvmon)=0D
which aims to be a better kvm_stat, and allows you at glance=0D
to see what is happening in a VM, including nesting.=0D
=0D
V4: addressed review feedback=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (4):=0D
  KVM: x86: refactor req_immediate_exit logic=0D
  KVM: x86: add more information to the kvm_entry tracepoint=0D
  KVM: x86: add information about pending requests to kvm_exit=0D
    tracepoint=0D
  KVM: x86: add new nested vmexit tracepoints=0D
=0D
 arch/x86/include/asm/kvm-x86-ops.h |   2 +-=0D
 arch/x86/include/asm/kvm_host.h    |  10 +--=0D
 arch/x86/kvm/svm/nested.c          |  22 ++++++=0D
 arch/x86/kvm/svm/svm.c             |  24 ++++++-=0D
 arch/x86/kvm/trace.h               | 105 +++++++++++++++++++++++++++--=0D
 arch/x86/kvm/vmx/nested.c          |  27 ++++++++=0D
 arch/x86/kvm/vmx/vmx.c             |  30 +++++----=0D
 arch/x86/kvm/vmx/vmx.h             |   2 -=0D
 arch/x86/kvm/x86.c                 |  34 +++++-----=0D
 9 files changed, 209 insertions(+), 47 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D

