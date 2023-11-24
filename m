Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F57F7787
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKXPTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbjKXPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2EE1BC1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700839146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sUP0938eWxrh/qcHUeeo6YZetnQrjCIIyWqIBPJP/FA=;
        b=PSBuLy+otRIBqwjnDCFFN8NtaOdKxHHcPIhnEUTHLpVv08jVIn/h08OuKmDU9hKiRFTKU/
        KsgGYP732peyUzk3SYAl6Jq5zH2n3W43zmXgKlCG7J6HXoJRglZG4gTLirx0LYJT1V+g6B
        649/0/elvpV8zMKsitPeBmBs6/TuOl8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-eqQkVLsRMDa-cOScrZb58A-1; Fri, 24 Nov 2023 10:19:05 -0500
X-MC-Unique: eqQkVLsRMDa-cOScrZb58A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a0921b293so4055636d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839144; x=1701443944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUP0938eWxrh/qcHUeeo6YZetnQrjCIIyWqIBPJP/FA=;
        b=gQz8OUzj75hdicp6ZGSKV3OUFjCOLax2Y0In8k9H1pxjzC4V/5+QOpoxoGPXl2Tcg4
         0NMPykQJm8LBGZ89cWGlQjVziKy3KSyKgmGQpaVLrH5KiJt5GI0jLv5ZZzpgzABL9OoB
         iNYaTcECeY7u5mH+sYM3d+f3sEhqlT25VBGaonc1fxDBUrEBZX1N58isyKXlEUM91zCd
         dP9fn1sM0Mc9QUP1I35vrGzKpI/HmRFiBDQ7Cji9TtAl4QY1/oHKXAEjB7nlOqdJyWcw
         f/bG99G7zTYezVc4WLE5f6fKzuMh1kpYtaQkjv67DA7vvjswBg+bn3Cj+3MFxRRUHB4k
         agBQ==
X-Gm-Message-State: AOJu0YzvF+Qx7S1cPjrlaDYlSB/CR6sY/+U18a4Ije2csYej2mZQeJGR
        lx5He4CDf9bLmngqwtQI2D1WnSoRsqrIk7wFnyyT8prc5ZZyXlzVgnkqd7c5rhkevfnA301jBXu
        oSmKQhUO1f75Vn9XTfiUmYOe2
X-Received: by 2002:a05:6214:e62:b0:679:dfc4:a5b with SMTP id jz2-20020a0562140e6200b00679dfc40a5bmr3427595qvb.5.1700839144714;
        Fri, 24 Nov 2023 07:19:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH65tZjZ4kmXbh/d9VdlWOCPV9PyBUVtyw/3egpKaKfZhkxUJBi3CqSgdCBKJPV4rh40sArzw==
X-Received: by 2002:a05:6214:e62:b0:679:dfc4:a5b with SMTP id jz2-20020a0562140e6200b00679dfc40a5bmr3427564qvb.5.1700839144350;
        Fri, 24 Nov 2023 07:19:04 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id kr6-20020ac861c6000000b004180fb5c6adsm1339987qtb.25.2023.11.24.07.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:19:03 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs/Kconfig: Make hugetlbfs a menuconfig
Date:   Fri, 24 Nov 2023 10:19:02 -0500
Message-ID: <20231124151902.1075697-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugetlb vmemmap default option (HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON)
is a sub-option to hugetlbfs, but it shows in the same level as hugetlbfs
itself, under "Pesudo filesystems".

Make the vmemmap option a sub-option to hugetlbfs, by changing hugetlbfs
into a menuconfig.  When moving it, fix a typo 'v' spot by Randy.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Fix a typo in the relevant area [Randy]
---
 fs/Kconfig | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index fd1f655b4f1f..0b404e61c80b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -254,7 +254,7 @@ config TMPFS_QUOTA
 config ARCH_SUPPORTS_HUGETLBFS
 	def_bool n
 
-config HUGETLBFS
+menuconfig HUGETLBFS
 	bool "HugeTLB file system support"
 	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
 	depends on (SYSFS || SYSCTL)
@@ -266,22 +266,24 @@ config HUGETLBFS
 
 	  If unsure, say N.
 
-config HUGETLB_PAGE
-	def_bool HUGETLBFS
-
-config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
-	def_bool HUGETLB_PAGE
-	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
-	depends on SPARSEMEM_VMEMMAP
-
+if HUGETLBFS
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
 	default n
 	depends on HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	help
-	  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to
+	  The HugeTLB Vmemmap Optimization (HVO) defaults to off. Say Y here to
 	  enable HVO by default. It can be disabled via hugetlb_free_vmemmap=off
 	  (boot command line) or hugetlb_optimize_vmemmap (sysctl).
+endif # HUGETLBFS
+
+config HUGETLB_PAGE
+	def_bool HUGETLBFS
+
+config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
+	depends on SPARSEMEM_VMEMMAP
 
 config ARCH_HAS_GIGANTIC_PAGE
 	bool
-- 
2.41.0

