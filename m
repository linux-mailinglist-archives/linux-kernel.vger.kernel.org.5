Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC495803C2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjLDSCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjLDSC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:02:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF79A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701712954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ugER1Flx8boWLZORMECd29fL9yUWjUsWmkZBQzd3BUk=;
        b=dTQXFXTay5P55GzsAtI+fLsevHkG5cj5+nP/5HEsH/gvd186Mdmopic1tUN+8CVjgSb95c
        xH8qsiwsHn3a8BPTpT5LAeKD7wGmpghWbzs5Vf5R+VHqf54+ybEujhiJqQ0nSnW6Qt4vTs
        PMAYfkUptsGMeLGo4XsS8iY+P50cPNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-GFGpfNJZN5q5POYOLc7XrA-1; Mon, 04 Dec 2023 13:02:31 -0500
X-MC-Unique: GFGpfNJZN5q5POYOLc7XrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77667831523;
        Mon,  4 Dec 2023 18:02:30 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit2023-praritguest.khw1.lab.eng.bos.redhat.com [10.16.200.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E90BA2026D68;
        Mon,  4 Dec 2023 18:02:29 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Wei Liu <wei.liu@kernel.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        David Malcolm <dmalcolm@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Don Zickus <dzickus@redhat.com>
Subject: [PATCH] x86/ioapic: io_apic fix null dereference check
Date:   Mon,  4 Dec 2023 13:02:26 -0500
Message-ID: <20231204180226.383745-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

The gcc plugin -fanalyzer [1] tries to detect various
patterns of incorrect behaviour.  The tool reports

arch/x86/kernel/apic/io_apic.c: In function ‘ioapic_destroy_irqdomain’:
arch/x86/kernel/apic/io_apic.c:2390:12: warning: check of ‘ioapics[idx].irqdomain’ for NULL after already dereferencing it [-Wanalyzer-deref-before-check]
    |
    | 2388 |         struct fwnode_handle *fn = ioapics[idx].irqdomain->fwnode;
    |      |                               ^~
    |      |                               |
    |      |                               (1) pointer ‘ioapics[idx].irqdomain’ is dereferenced here
    | 2389 |
    | 2390 |         if (ioapics[idx].irqdomain) {
    |      |            ~
    |      |            |
    |      |            (2) pointer ‘ioapics[idx].irqdomain’ is checked for NULL here but it was already dereferenced at (1)
    |

Fix the null dereference check in ioapic_destroy_irqdomain().

[1] https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Static-Analyzer-Options.html

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Wei Liu <wei.liu@kernel.org>
CC: Prarit Bhargava <prarit@redhat.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>
CC: Johan Hovold <johan+linaro@kernel.org>
CC: Michael Kelley <mikelley@microsoft.com>
CC: David Malcolm <dmalcolm@redhat.com>
CC: David Arcari <darcari@redhat.com>
CC: Don Zickus <dzickus@redhat.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 arch/x86/kernel/apic/io_apic.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 00da6cf6b07d..f6f19eee0339 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2381,14 +2381,14 @@ static int mp_irqdomain_create(int ioapic)
 static void ioapic_destroy_irqdomain(int idx)
 {
 	struct ioapic_domain_cfg *cfg = &ioapics[idx].irqdomain_cfg;
-	struct fwnode_handle *fn = ioapics[idx].irqdomain->fwnode;
 
-	if (ioapics[idx].irqdomain) {
-		irq_domain_remove(ioapics[idx].irqdomain);
-		if (!cfg->dev)
-			irq_domain_free_fwnode(fn);
-		ioapics[idx].irqdomain = NULL;
-	}
+	if (!ioapics[idx].irqdomain)
+		return;
+
+	irq_domain_remove(ioapics[idx].irqdomain);
+	if (!cfg->dev)
+		irq_domain_free_fwnode(ioapics[idx].irqdomain->fwnode);
+	ioapics[idx].irqdomain = NULL;
 }
 
 void __init setup_IO_APIC(void)
-- 
2.43.0

