Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE79792609
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbjIEQKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350919AbjIEFFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1D3CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2533B810A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C4C433CB;
        Tue,  5 Sep 2023 05:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890307;
        bh=Rf7azYzBuF/8w9Rf8KpcVWynps2sflW/2Bm2YEq1sPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFJQnmRMHGo7F7J3flPrlMPtbNKTBKzXkiISct84njz7/3npLhu420WZEawZDcnSS
         BhACFv6MlmxqOHwx9CyH8j9oNa9AIQ98n5j0dUImHcFgaYTXhr+cmAvfe/iXDDe73k
         3G82UNltz1vWEg0QFNC71M1r1IgnvPQZhyktnmpuIctLWXP4hfxfhzhGbafilKQXw/
         REe8jc++7BZTZ72y1gzzhhTvnmWD7epFpRGwM15zk9iR7gZE+ROv+cz4FiMjRQduYT
         SAD0J9/IWhh4aEcnZ5HukPKX4HwUNXwOC4QXWT5aeoUZjeGrtV9tzdlWZXDQqMQedd
         lg2lCOIg+DzxQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 01/20] x86/srso: Fix srso_show_state() side effect
Date:   Mon,  4 Sep 2023 22:04:45 -0700
Message-ID: <27d128899cb8aee9eb2b57ddc996742b0c1d776b.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the 'spec_rstack_overflow' sysfs file can trigger an unnecessary
MSR write, and possibly even a (handled) exception if the microcode
hasn't been updated.

Avoid all that by just checking X86_FEATURE_IBPB_BRTYPE instead, which
gets set by srso_select_mitigation() if the updated microcode exists.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f081d26616ac..bdd3e296f72b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2717,7 +2717,7 @@ static ssize_t srso_show_state(char *buf)
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
 }
 
 static ssize_t gds_show_state(char *buf)
-- 
2.41.0

