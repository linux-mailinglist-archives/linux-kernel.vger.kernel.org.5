Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932217F10EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjKTK4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjKTKz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D15E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700477751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w3RVGtwvMaa0LWKwchTi9Ln865mxgwWs3dJKxuLZfco=;
        b=I4EqiGCnLPfV7lAjM9em7p7V6qCAAnWZTlJ+QwA2hzhIO+upLwO6osjvgmT0lhaVDPN00M
        zaebeB36y0u+9n4oS6uOFfqJJkvv9v9ROs0ozVAe8TWPgFWsOuVQQ1EoaNFZQuAAq665xs
        an+v5Bl2RtmbvwcGvf9O8A9FUzFb0Ek=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-KaDYnevWOLCl99oI2912ag-1; Mon,
 20 Nov 2023 05:55:47 -0500
X-MC-Unique: KaDYnevWOLCl99oI2912ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79FFD28B72E2;
        Mon, 20 Nov 2023 10:55:46 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.195.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AA7A2026D4C;
        Mon, 20 Nov 2023 10:55:40 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 0/5] jump_label: Fix __ro_after_init keys for modules & annotate some keys
Date:   Mon, 20 Nov 2023 11:55:23 +0100
Message-ID: <20231120105528.760306-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

After chatting about deferring IPIs [1] at LPC I had another look at my patches
and realized a handful of them could already be sent as-is.

This series contains the __ro_after_init static_key bits, which fixes
__ro_after_init keys used in modules (courtesy of PeterZ) and flags more keys as
__ro_after_init.

[1]: https://lore.kernel.org/lkml/20230720163056.2564824-1-vschneid@redhat.com/

Cheers,
Valentin

Peter Zijlstra (1):
  jump_label,module: Don't alloc static_key_mod for __ro_after_init keys

Valentin Schneider (4):
  context_tracking: Make context_tracking_key __ro_after_init
  x86/kvm: Make kvm_async_pf_enabled __ro_after_init
  x86/speculation: Make mds_user_clear __ro_after_init
  x86/tsc: Make __use_tsc __ro_after_init

 arch/x86/kernel/cpu/bugs.c     |  2 +-
 arch/x86/kernel/kvm.c          |  2 +-
 arch/x86/kernel/tsc.c          |  2 +-
 include/asm-generic/sections.h |  5 ++++
 include/linux/jump_label.h     |  1 +
 init/main.c                    |  1 +
 kernel/context_tracking.c      |  2 +-
 kernel/jump_label.c            | 49 ++++++++++++++++++++++++++++++++++
 8 files changed, 60 insertions(+), 4 deletions(-)

--
2.41.0

