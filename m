Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481D5810ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377917AbjLMKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377876AbjLMKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884CB99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702464574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=UXZcC0eGhRmFPV/dLLlTjq6U1zG2P/SpEL+PeFp8lAOIk6F8yz9Jxnq73KFY6S/cckwSRl
        R55oNeNApmajVU/T4GiajuEP9ZAkUhm4eBZ62xRjOh/Qj0IYZei/yKWteiEeD/GHDDLhjH
        vxM+Q4d967VqRszN7ZnVgzfMekUir3I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-UGb9cAUsNCyZg0QpEJtpaA-1; Wed, 13 Dec 2023 05:49:33 -0500
X-MC-Unique: UGb9cAUsNCyZg0QpEJtpaA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1fae8cca5bso60145466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464572; x=1703069372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=eUW/avKTaA1fT34/AjQdj1d4sJYLfBmUpEgMOzPfpVKliyvO2PGAABUceyKBWiB5UJ
         aDdHgUc+Vv0KfrsysyBfZawCJRY5ezwFJT40ZkjEe9jETJnSALAQBWkfhzzqhHYF7LiX
         xun1jVGMsHSmsqk/o9fvBkQmPRlN/cLOPzweqOqT6+5IF23uQWH2EzDW9Btl9VejAJtG
         DSmtz2BRM3MXbcdhggsgLQdQm5vrXoq+FfvFzs/tZBTNo3SsqoGTBaA/mYBZJbIjRO0a
         pDd0RsOUsFM81SfHlSy6Qw22+2A226pkkjr9JvgqJzt0sthk7nwmhw50zbdjqNDBxs0i
         Mt1g==
X-Gm-Message-State: AOJu0YyEcE8EtGPUtcvABG0lbb2H3HuzoBfTN8gSIGp/ZRGBMggRJ+VB
        wQ5nvM36hXpOvuJlHmxDnrxnPWNY+YEKUOq9YbhSMc8eZvINVxtjLXWsMh+1Rg0VsY4k2ufTN0o
        BNPCjgUMlRoJiZgSBeSB56zmJ
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr8780439ejc.5.1702464572485;
        Wed, 13 Dec 2023 02:49:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKgFPrh8KzPFJxkHMTnI08lj2bQ889ejHtYo2j82GcEnRYLPMKJx+/M/r6P6Msuj9VzaynPg==
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr8780419ejc.5.1702464572286;
        Wed, 13 Dec 2023 02:49:32 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:914:ed27:4fa9:dbce:10f5:d0b9])
        by smtp.gmail.com with ESMTPSA id vu8-20020a170907a64800b00a1d5c52d628sm7527135ejc.3.2023.12.13.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:49:31 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        NeilBrown <neilb@suse.de>, John Sanpe <sanpeqf@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Philipp Stanner <pstanner@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Yury Norov <yury.norov@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v5 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date:   Wed, 13 Dec 2023 11:49:18 +0100
Message-ID: <20231213104922.13894-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213104922.13894-1-pstanner@redhat.com>
References: <20231213104922.13894-1-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

pci_iounmap() in lib/pci_iomap.c is supposed to check whether an address
is within ioport-range IF the config specifies that ioports exist. If
so, the port should be unmapped with ioport_unmap(). If not, it's a
generic MMIO address that has to be passed to iounmap().

The bugs are:
  1. ioport_unmap() is missing entirely, so this function will never
     actually unmap a port.
  2. the #ifdef for the ioport-ranges accidentally also guards
     iounmap(), potentially compiling an empty function. This would
     cause the mapping to be leaked.

Implement the missing call to ioport_unmap().

Move the guard so that iounmap() will always be part of the function.

CC: <stable@vger.kernel.org> # v5.15+
Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Reported-by: Danilo Krummrich <dakr@redhat.com>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/pci_iomap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index ce39ce9f3526..6e144b017c48 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -168,10 +168,12 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 	uintptr_t start = (uintptr_t) PCI_IOBASE;
 	uintptr_t addr = (uintptr_t) p;
 
-	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
+		ioport_unmap(p);
 		return;
-	iounmap(p);
+	}
 #endif
+	iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
-- 
2.43.0

