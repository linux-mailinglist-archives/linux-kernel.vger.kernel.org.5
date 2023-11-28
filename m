Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C87FC640
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346598AbjK1UuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbjK1Utx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:49:53 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE21FF5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:55 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d21b9a5808so4365897b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204594; x=1701809394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nk58INbxx30xLOHUnMGn9OdPuZubp6H+G9gT2CVk01Q=;
        b=WmMV6ob0b1iKZbSvoDEuo7Zhr3ll+0w4z7L4bxJ3VHcKNLlu5o0YWFoPZyxSpURI86
         AryOsKwrKpXAz9/uV+6M8InS3TUYbhLQ6EepJJdqbCVHqrm+yEmI1AG1cYJ0KugcQAcn
         EN5kXQYsyvjioRz7ldO0Be6gmrHvQk9moBrkJ4eeHVH3nx7XV6v1Cv+DC3BGk7Tg6hB4
         /BDMvlQgP7rL0qsZI7GNP4AM98+vlBt520FtoqV0bio4wqV+AzdxD/6G8w43CY2X6BZd
         P+xzzHPeOJc1J67081r+ZbKwRU2cygCecyiN9TvfH2d3uPx8CpNp9vq21BKfk6LLsuZZ
         WE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204594; x=1701809394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk58INbxx30xLOHUnMGn9OdPuZubp6H+G9gT2CVk01Q=;
        b=TKNOGcvOCelmQKpMD8v3E7sxlnvY0+59upGjkhJ38TbsQLgdoanymbgTm7Qdp3HsPU
         8C6e2lKHnXddwrP+psYso7p5FKNr6WTQzCZi4eMzuhiw1Ael2CNxikioSTGIDuYX1R5o
         8VnZ4++lvNniU0qoovVTFv8IfLoknhhcDz2vunDKl1rjUZiBDKJV3rUC1jkbdgSovLL9
         vbrOD657EwNKgR3Tyi4To/3meHklHDnZXzEL6xJksNjmLWWCH3mL5C39c2VmWssbLDMx
         2xLwzpEPRV4KFltwyvBRLA7zX1oIfcEVFHs7NtbVSoT+Jw5leWQZdQFytu2TmPZyxP6H
         Iw3g==
X-Gm-Message-State: AOJu0YwBjYDNbSLpwUoj/K3QrkS+fMobQ03q4MJ2/90L4+9/Y01Vu/Im
        dgkptktnGnxsSGu2w+AvAebyBw==
X-Google-Smtp-Source: AGHT+IFeRft5lu3DnWQgWnRJh58TGHHoSR4IZRyS1wE4nkLKveRfays9X3IHaY/+Xezkx1Q2h+wp9Q==
X-Received: by 2002:a81:a507:0:b0:5cb:d645:8cdf with SMTP id u7-20020a81a507000000b005cbd6458cdfmr16849996ywg.48.1701204594372;
        Tue, 28 Nov 2023 12:49:54 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:54 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
        joro@8bytes.org, kevin.tian@intel.com,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        pasha.tatashin@soleen.com, paulmck@kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Subject: [PATCH 14/16] iommu: account IOMMU allocated memory
Date:   Tue, 28 Nov 2023 20:49:36 +0000
Message-ID: <20231128204938.1453583-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to limit the amount of memory that is allocated
by IOMMU subsystem, the memory must be accounted.

Account IOMMU as part of the secondary pagetables as it was discussed
at LPC.

The value of SecPageTables now contains mmeory allocation by IOMMU
and KVM.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 Documentation/filesystems/proc.rst      | 4 ++--
 drivers/iommu/iommu-pages.h             | 2 ++
 include/linux/mmzone.h                  | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3f85254f3cef..e004e05a7cde 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1418,7 +1418,7 @@ PAGE_SIZE multiple when read back.
 	  sec_pagetables
 		Amount of memory allocated for secondary page tables,
 		this currently includes KVM mmu allocations on x86
-		and arm64.
+		and arm64 and IOMMU page tables.
 
 	  percpu (npn)
 		Amount of memory used for storing per-cpu kernel
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 49ef12df631b..86f137a9b66b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1110,8 +1110,8 @@ KernelStack
 PageTables
               Memory consumed by userspace page tables
 SecPageTables
-              Memory consumed by secondary page tables, this currently
-              currently includes KVM mmu allocations on x86 and arm64.
+              Memory consumed by secondary page tables, this currently includes
+              KVM mmu and IOMMU allocations on x86 and arm64.
 NFS_Unstable
               Always zero. Previous counted pages which had been written to
               the server, but has not been committed to stable storage.
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index 69895a355c0c..cdd257585284 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -27,6 +27,7 @@ static inline void __iommu_alloc_account(struct page *pages, int order)
 	const long pgcnt = 1l << order;
 
 	mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, pgcnt);
+	mod_lruvec_page_state(pages, NR_SECONDARY_PAGETABLE, pgcnt);
 }
 
 /**
@@ -39,6 +40,7 @@ static inline void __iommu_free_account(struct page *pages, int order)
 	const long pgcnt = 1l << order;
 
 	mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, -pgcnt);
+	mod_lruvec_page_state(pages, NR_SECONDARY_PAGETABLE, -pgcnt);
 }
 
 /**
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1a4d0bba3e8b..aaabb385663c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -199,7 +199,7 @@ enum node_stat_item {
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
 	NR_PAGETABLE,		/* used for pagetables */
-	NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. KVM pagetables */
+	NR_SECONDARY_PAGETABLE, /* secondary pagetables, KVM & IOMMU */
 #ifdef CONFIG_IOMMU_SUPPORT
 	NR_IOMMU_PAGES,		/* # of pages allocated by IOMMU */
 #endif
-- 
2.43.0.rc2.451.g8631bc7472-goog

