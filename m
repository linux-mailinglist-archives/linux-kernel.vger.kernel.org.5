Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F4E79E6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbjIMLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjIMLix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:38:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251FF19AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:38:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE4EF1F461;
        Wed, 13 Sep 2023 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694605127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++Gf4nZevYukLnMCd8J7gk+s802IZpzJx/5E73wtImY=;
        b=SHILpcKUB+qttiLi6k4sYhNzmXEFE767/y3kD9zbG2bluvZ7ghrloO9UGyNAhPubecIaKP
        NGNWWh5CDcoRq9haIK8xFSRVnZ0ag62gtllZXtXM6vGJ8WcYBytmyjAszMfOa3Kyr1S2Ur
        7HXYBqGaBGWrqpTPsAL3X8ci5xu+xRw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9401D13582;
        Wed, 13 Sep 2023 11:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NCztIkefAWWVCwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 13 Sep 2023 11:38:47 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 3/3] x86/xen: allow nesting of same lazy mode
Date:   Wed, 13 Sep 2023 13:38:28 +0200
Message-Id: <20230913113828.18421-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230913113828.18421-1-jgross@suse.com>
References: <20230913113828.18421-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a paravirtualized guest under Xen, Linux is using
"lazy mode" for issuing hypercalls which don't need to take immediate
effect in order to improve performance (examples are e.g. multiple
PTE changes).

There are two different lazy modes defined: MMU and CPU lazy mode.
Today it is not possible to nest multiple lazy mode sections, even if
they are of the same kind. A recent change in memory management added
nesting of MMU lazy mode sections, resulting in a regression when
running as Xen PV guest.

Technically there is no reason why nesting of multiple sections of the
same kind of lazy mode shouldn't be allowed. So add support for that
for fixing the regression.

Fixes: bcc6cc832573 ("mm: add default definition of set_ptes()")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/hypervisor.h | 15 +++++++++++++--
 arch/x86/xen/enlighten_pv.c           |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index ed05ce3df5c7..7048dfacc04b 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -72,10 +72,18 @@ enum xen_lazy_mode {
 };
 
 DECLARE_PER_CPU(enum xen_lazy_mode, xen_lazy_mode);
+DECLARE_PER_CPU(unsigned int, xen_lazy_nesting);
 
 static inline void enter_lazy(enum xen_lazy_mode mode)
 {
-	BUG_ON(this_cpu_read(xen_lazy_mode) != XEN_LAZY_NONE);
+	enum xen_lazy_mode old_mode = this_cpu_read(xen_lazy_mode);
+
+	if (mode == old_mode) {
+		this_cpu_inc(xen_lazy_nesting);
+		return;
+	}
+
+	BUG_ON(old_mode != XEN_LAZY_NONE);
 
 	this_cpu_write(xen_lazy_mode, mode);
 }
@@ -84,7 +92,10 @@ static inline void leave_lazy(enum xen_lazy_mode mode)
 {
 	BUG_ON(this_cpu_read(xen_lazy_mode) != mode);
 
-	this_cpu_write(xen_lazy_mode, XEN_LAZY_NONE);
+	if (this_cpu_read(xen_lazy_nesting) == 0)
+		this_cpu_write(xen_lazy_mode, XEN_LAZY_NONE);
+	else
+		this_cpu_dec(xen_lazy_nesting);
 }
 
 enum xen_lazy_mode xen_get_lazy_mode(void);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 54b83825c4b6..bbbfdd495ebd 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -102,6 +102,7 @@ struct tls_descs {
 };
 
 DEFINE_PER_CPU(enum xen_lazy_mode, xen_lazy_mode) = XEN_LAZY_NONE;
+DEFINE_PER_CPU(unsigned int, xen_lazy_nesting);
 
 enum xen_lazy_mode xen_get_lazy_mode(void)
 {
-- 
2.35.3

