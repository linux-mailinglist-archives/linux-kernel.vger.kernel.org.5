Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4304B7F1FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjKTWAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjKTWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:00:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CB9124
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700517621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6mM1O9Y4nGezPDwxGvKwG2kSdvz61Ixp5WJTexZ/DY=;
        b=EBeigtjL0Ans0Am+cIVSf1wGfNaVoh+XdaxfbiMzlr7qVKfhYCPQR8N8rQ+VwXwibzjWt8
        hUOiEV7LPMRmdYj8K5BwuJeTmcNRQJj+NQDbWJ8h2Lb8vRvuPYjqehLxfWPsx2JoC3VQDd
        c0yt0G3qxktQvMo7BM9m+6YnerwQh2w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-avxLPpajM3Wkv2lLH2i_wQ-1; Mon, 20 Nov 2023 17:00:19 -0500
X-MC-Unique: avxLPpajM3Wkv2lLH2i_wQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-677fb270eacso8332366d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700517619; x=1701122419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6mM1O9Y4nGezPDwxGvKwG2kSdvz61Ixp5WJTexZ/DY=;
        b=IBNd/Yx1I4AdyPPsWKPpjHSRO7OpHQWZN3cJ3VoEV/7upGSq3k8VG1zNib7GfZR7ro
         HfDHJUToWJvIumKQSxflC+wlki6q6yHW2JmHChSOiCvp58XafEQd1FdoBTpyew7BFduH
         KgNsxc10+cX5SzgxAID5QRzRW5M5zgWNu9mG2cYT1ggMVOxSalJoHJ6Du49aoizWlJBd
         eHTnBgNAIZs05ZTRasLmvX/CqIHxHPohczbcpv6s7w2SKVNy4eiD8qUq7XDmCyfEH0V/
         d9Z1RoTEB/jAXkRs/Ytf/kh9CawHQDuiGEq6i4OUAM65JH+blBXa1mIcgg2LHtG3thU5
         4M5Q==
X-Gm-Message-State: AOJu0YyNHwUJLqmFMHelJ70/CzJuGXD3g8Qx7Qi8XhZ7/UfhGcVIyfOa
        +oFdNuJvOkAvY7JWxSwpDxzGPgNsHw2fo8YD4lmezTuuK7Sj+BPWVXYYbqtLpEVYt5wPvSag5vE
        A+MnOfSEDlHDZWGYHkNrQLYTA
X-Received: by 2002:a05:6214:2d12:b0:678:50:6975 with SMTP id mz18-20020a0562142d1200b0067800506975mr8227690qvb.6.1700517618744;
        Mon, 20 Nov 2023 14:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDNBpKfZvVPUrrZYBAMZoGj9EGU7GT1CpOL/fHM0KWf1UWxIehkkDc+4xA8TO8dDshmepQvw==
X-Received: by 2002:a05:6214:2d12:b0:678:50:6975 with SMTP id mz18-20020a0562142d1200b0067800506975mr8227634qvb.6.1700517618295;
        Mon, 20 Nov 2023 14:00:18 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32dd:2700:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id 3-20020ad45ba3000000b00677fb918337sm2762398qvq.53.2023.11.20.14.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:00:18 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        NeilBrown <neilb@suse.de>, Philipp Stanner <pstanner@redhat.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
Date:   Mon, 20 Nov 2023 22:59:46 +0100
Message-ID: <20231120215945.52027-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120215945.52027-2-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/iomap.c contains one of the definitions of pci_iounmap(). The
current comment above this out-of-place function does not clarify WHY
the function is defined here.

Linus's detailed comment above pci_iounmap() in drivers/pci/iomap.c
clarifies that in a far better way.

Extend the existing comment with an excerpt from Linus's and hint at the
other implementation in drivers/pci/iomap.c

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 lib/iomap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/iomap.c b/lib/iomap.c
index 4f8b31baa575..647aac8ea3e3 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -419,8 +419,17 @@ EXPORT_SYMBOL(ioport_unmap);
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
 #ifdef CONFIG_PCI
-/* Hide the details if this is a MMIO or PIO address space and just do what
- * you expect in the correct way. */
+/*
+ * Hide the details if this is a MMIO or PIO address space and just do what
+ * you expect in the correct way.
+ *
+ * pci_iounmap() somewhat illogically comes from lib/iomap.c for the
+ * CONFIG_GENERIC_IOMAP case, because that's the code that knows about
+ * the different IOMAP ranges.
+ *
+ * For more details see also the pci_iounmap() implementation in
+ * drivers/pci/iomap.c
+ */
 void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 {
 	IO_COND(addr, /* nothing */, iounmap(addr));
-- 
2.41.0

