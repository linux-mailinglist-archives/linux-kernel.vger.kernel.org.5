Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002DF7F6911
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjKWWjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWWj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:39:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC1D54
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700779174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uxvMU/Xo7MVeCzgBFSVtpLXkJ+M09hdrAxYgaD5WzoM=;
        b=WgqYOoSnIjDn7BHCjxheDdIu0zArlUxzKHNEXCWwT+8iQRXtvBhac3PFrrhdATxgndfMUd
        I4PpJlJAXyWyc+COL4ts+zKZY66uNEE6wWbLf47UiUi7LIKvn+HF8XcMlJpE3WV33/D0Fw
        2SRgMi8lKCFjHaazhX0QIY6jYCWyfI8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-a2tobkelM2yaFdGp6a481w-1; Thu, 23 Nov 2023 17:39:32 -0500
X-MC-Unique: a2tobkelM2yaFdGp6a481w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67a0921b293so2183016d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700779172; x=1701383972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxvMU/Xo7MVeCzgBFSVtpLXkJ+M09hdrAxYgaD5WzoM=;
        b=DC/y27QPA+13ysKAA0XUb5pA8WWI31e/TKpSWnHblRrTGPWsuNbRQJSa+cm5F7usjq
         lJCAxEx70P7lHyyqofKnbzW34e78r0hGc1UANxjVFT6vD2lB9Wjan6rGKRb+yyMmgv6e
         PJO5Xpukivyx05hjuxfKA55TSz4WZvBVmB6gOOIKCh68N73R4b6eyQivKoC7YAKXtwDs
         rpih3JKDtQAokuuu4UrlOPbJgeCTpWcgXvxpxqdY+LN6vzTlgrpR1N13z+YXQfi8eOX3
         JxF2b6Bvl1oUt+uTCADCuDvMOhXRrv4BcS7Z8+pb/aHgaA8Lc2uW3xT0dzJuXVrgdzCl
         gfFA==
X-Gm-Message-State: AOJu0YxfGm9ghOsVaA9rHL5VCK1i1bwCsrn42aNbGiBdyB2mSZKh8gfa
        nGy3VUA+FKeHmsssqfVTOAgPs/VLeJREwFVDl7Zl1H7w+J5v0oFkK3iahkPzylkIQ7SropxeB67
        kD+RkIrTys59ANzdDks4dLFfh8fOwqH8gEi0KTLuGA/3FlB+ILCscl1LKChhKKdVbVNoqysPtYc
        77UHFwyQ==
X-Received: by 2002:ad4:4242:0:b0:67a:11a9:e579 with SMTP id l2-20020ad44242000000b0067a11a9e579mr743244qvq.3.1700779171941;
        Thu, 23 Nov 2023 14:39:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvUeYsikfky/jSIEaAUmbV6X8zYGpERKvvHbE6LK2W5XgyAicVdgusWE5DO059Yw/o9j2ixA==
X-Received: by 2002:ad4:4242:0:b0:67a:11a9:e579 with SMTP id l2-20020ad44242000000b0067a11a9e579mr743224qvq.3.1700779171591;
        Thu, 23 Nov 2023 14:39:31 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id n11-20020ad444ab000000b0067a08bba0bbsm774131qvt.0.2023.11.23.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:39:31 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/Kconfig: Make hugetlbfs a menuconfig
Date:   Thu, 23 Nov 2023 17:39:29 -0500
Message-ID: <20231123223929.1059375-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugetlb vmemmap default option (HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON)
is a sub-option to hugetlbfs, but it shows in the same level as hugetlbfs
itself, under "Pesudo filesystems".

Make the vmemmap option a sub-option to hugetlbfs, by changing hugetlbfs
into a menuconfig.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/Kconfig | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index fd1f655b4f1f..8636198a8689 100644
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
@@ -266,14 +266,7 @@ config HUGETLBFS
 
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
@@ -282,6 +275,15 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	  The HugeTLB VmemmapvOptimization (HVO) defaults to off. Say Y here to
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

