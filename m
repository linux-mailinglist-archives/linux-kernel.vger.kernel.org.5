Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49807802A3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjLDCXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:23:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0FCB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701656609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3oj/lBQzpBpheCv8g6m9tnnqQ9YL5qzNhLYbMSq4hU=;
        b=SIKrtVdDtLNtboFkQnNvawwXMFgLcmNW1wgxoUEyKzNc8j/W7+2PREJSZZGVG4NW9KQFnd
        /SL00dOdwjEviiaXvC3tn0EJcz7wXTS5X7PtbWGCWE8EE7XHJkjoeQ6RpVnAcGsVBl4V9G
        ZQootjWlBjvEyGKP0sWpIThDTqR5aUo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-itdX0an8McWg5ZpBNZWuxQ-1; Sun, 03 Dec 2023 21:23:27 -0500
X-MC-Unique: itdX0an8McWg5ZpBNZWuxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D4C180F82F;
        Mon,  4 Dec 2023 02:23:27 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80B4A2026D6E;
        Mon,  4 Dec 2023 02:23:26 +0000 (UTC)
Date:   Mon, 4 Dec 2023 10:23:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
        ignat@cloudflare.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, eric_devolder@yahoo.com
Subject: [PATCH 2/2] riscv, kexec: fix dependency of two items
Message-ID: <ZW04G/SKnhbE5mnX@MiWiFi-R3L-srv>
References: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
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

Drop the dependency on MMU from ARCH_SUPPORTS_KEXEC and
ARCH_SUPPORTS_KEXEC_FILE because CONFIG_MMU could be disabled while
people may still want to have KEXEC/KEXEC_FILE functionality.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..24c1799e2ec4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -685,7 +685,7 @@ config RISCV_BOOT_SPINWAIT
 	  If unsure what to do here, say N.
 
 config ARCH_SUPPORTS_KEXEC
-	def_bool MMU
+	def_bool y
 
 config ARCH_SELECTS_KEXEC
 	def_bool y
@@ -693,7 +693,7 @@ config ARCH_SELECTS_KEXEC
 	select HOTPLUG_CPU if SMP
 
 config ARCH_SUPPORTS_KEXEC_FILE
-	def_bool 64BIT && MMU
+	def_bool 64BIT
 
 config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
-- 
2.41.0

