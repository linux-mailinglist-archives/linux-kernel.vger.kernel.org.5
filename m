Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68D9809D26
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573356AbjLHHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573264AbjLHHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988D819A2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702020673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikUZzEB5I5Nehs7sVU1WeIaxCZi2Fx3EHlR7/8OM9/M=;
        b=L2ka/jxMRo30TyqExkZcIoFflqyAx4+KtUsBQIH//LdLZz1fq7l3R6vfi4nMmputSoOfRh
        67fxAr3srr9n8yU1zUgHiMmqo9hDJuLnycBYdvBIRzIDLHxZKcBFR3wCmPxRw6y2WMBmNa
        DzB8N1sIJh/AZKD4M3kmi4paAPFZ820=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-Kgqun5sNNqKgQtHaeJfxqA-1; Fri, 08 Dec 2023 02:31:10 -0500
X-MC-Unique: Kgqun5sNNqKgQtHaeJfxqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AE9B185A782;
        Fri,  8 Dec 2023 07:31:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3517E8CD0;
        Fri,  8 Dec 2023 07:31:04 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-next@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com,
        sfr@canb.auug.org.au, ignat@cloudflare.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 5/5] x86, kexec: fix the wrong ifdeffery CONFIG_KEXEC
Date:   Fri,  8 Dec 2023 15:30:36 +0800
Message-ID: <20231208073036.7884-6-bhe@redhat.com>
In-Reply-To: <20231208073036.7884-1-bhe@redhat.com>
References: <20231208073036.7884-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current ifdeffery CONFIG_KEXEC, get_cmdline_acpi_rsdp() is only
available when kexec_load interface is taken, while kexec_file_load
interface can't make use of it.

Now change it to CONFIG_KEXEC_CORE.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 55c98fdd67d2..18d15d1ce87d 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -178,7 +178,7 @@ static unsigned long get_cmdline_acpi_rsdp(void)
 {
 	unsigned long addr = 0;
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	char val[MAX_ADDR_LEN] = { };
 	int ret;
 
-- 
2.41.0

