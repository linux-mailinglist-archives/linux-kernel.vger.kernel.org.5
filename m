Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84E805C21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442449AbjLEPis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442439AbjLEPip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA483
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701790730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=N3kw6rDyr94qyK+OsXWnvGsGgv24XSuPC3YEVr9KhIF+qhB3e8qBorY5SGKV3fq/W9yk03
        HK59APqX0SU79U95esvNr1XobP/icVuElUusFWdQbov9JmfMWfAax1MA+d5DDsbHcw+QzV
        LSIp3bh9GueJI2Yo2ThMmVdqm9Z1o9c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-xwj0RPsdP5eDHz9Vm4sFOQ-1; Tue, 05 Dec 2023 10:38:03 -0500
X-MC-Unique: xwj0RPsdP5eDHz9Vm4sFOQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54cc7651e4eso131456a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790673; x=1702395473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=q4QrdIxN9u4BmlTPTMATWietESfkguhAxoSrWMD5Sooq/ymNdfzZBjlPb/qv+V61+O
         qe3YtzHwwJZ7847MjQKcCAkW0dXmTD37E89LFmKtZ/i6AHcDvTj3/eN8304pEFPvSQPP
         WsFg/TmgPH9fooAqICQmQDfhtfgXvXkMsN54b4yzzcUZ4CO337qc27Wp8fnph+2mJGdf
         J57qoJx3tVsDzPOvXAQWGqTN5kgeQb1X6BpZdjX0egGVsfM0XSis1buggNY2V3gKqedk
         9UIrCuUxkuD3Se11UJ9408pPPk6UjoC8dwGQ4F6uPwxDZZnQbsp2fsnI5rev/bjzRak2
         yr5A==
X-Gm-Message-State: AOJu0YxxKTJzX919DS9dYCB2C9i9eEDuCVeSgQADo7ynGw6I2fsu021+
        5fhgfBIr/sQpEB2pbsXomAwJUzGqsLbkg31woU21NeVhwu6jZhEgnw/dkUFGiFHRHlaTu/5tmKt
        DQfHZUuUJGlE0FEQg4EbFX7NS
X-Received: by 2002:a05:6402:1d0e:b0:54d:2efd:369e with SMTP id dg14-20020a0564021d0e00b0054d2efd369emr1100573edb.1.1701790673581;
        Tue, 05 Dec 2023 07:37:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMWm/1bFBFbNN6jWtOQ+6Wi9ETG9A4NbaILiBypRArdxNy576pceUJLgrbNKwNpAp9z7aoNA==
X-Received: by 2002:a05:6402:1d0e:b0:54d:2efd:369e with SMTP id dg14-20020a0564021d0e00b0054d2efd369emr1100547edb.1.1701790673178;
        Tue, 05 Dec 2023 07:37:53 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:912:71c8:c243:7b37:30b:a236])
        by smtp.gmail.com with ESMTPSA id r15-20020a056402018f00b0054c21d1fda7sm1244578edv.1.2023.12.05.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:37:52 -0800 (PST)
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
Subject: [PATCH v4 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date:   Tue,  5 Dec 2023 16:36:26 +0100
Message-ID: <20231205153629.26020-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205153629.26020-2-pstanner@redhat.com>
References: <20231205153629.26020-2-pstanner@redhat.com>
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

