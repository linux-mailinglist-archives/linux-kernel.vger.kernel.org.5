Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A749D78C00A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjH2IMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjH2ILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4609E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5009969be25so6453511e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296711; x=1693901511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDP4tqNUhlNIFZZBcXRgHZdwRMYy1Esdu/NCW7wWlsU=;
        b=T6NvuHclCxEppT8nFMh71q62sGE+tZlEA3hwVNUz/ZA8HpvLfE+jVsPEvlDkp2T6JA
         BvVtxAhcubFWHDu5ZanFy0HlsbfyU3/qbdz4bPI28m2qBXIlGa0rCttCqxWc/uXOIkl6
         6UE+UaAshUPaG0V/dJkZFtmhVNTtGPOu4CJjaX56Km4/Cqox9EMJRpbuy2p45aKZ3PEV
         ZfkG9G9bTOinVcpj5NxphQLFLuXXYYF71Lw3fOpDNkJDEWv7QBySNmUcO8Z9PAuRFoM/
         JueZT8bnCq4JbJcus2pTRqEENYrYmcJdD3FqrPZwA6rzNqirwxtGgAkf/SOxs02IMk+2
         BN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296711; x=1693901511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDP4tqNUhlNIFZZBcXRgHZdwRMYy1Esdu/NCW7wWlsU=;
        b=EGtcJEez1vphIilfyFXQgwexAXIatIulqe8PDKzuE36LWgm0vy1ND01cTsUt7oVFrZ
         UX5yzqU3kphgtUvDjhTWuDOWnzJgxFZKKT/UBnKle2/LgGSnNJeT1SbRDEF5uPs+9PtF
         1GUvx5kmEFSLlZsZ8JAPyJlyHedRqYmCaGaAG9MNbshW7xTT+Mp1CtzTcbklYwbelm+Q
         Zx775IxvOI/Prrb0tVZjttQVFHsufTBX8963QCC6S7GaQJ+iLmYSsNOWSpmtZBAakQwb
         jXuWl4hxuEdCyOyldS2jauI3Wt+M1K9O13yqegIT+NvBndoPUxOGF26nLC3wQWw1Gu7/
         opYg==
X-Gm-Message-State: AOJu0YwjhuOIWTRfmmuIajMuTcCJaopYEZkmbiKJC4T2kG3Iy/HorynW
        9mKyl+CjJ4IQklRafzQ4bOM=
X-Google-Smtp-Source: AGHT+IHUJH0ptBLC+Y1DnxMxgzbKnbR/6Fjs1YJ0+fTGbIM1B2rz7XjXZu/5VMJRPZ0+lDrr4JRlNg==
X-Received: by 2002:a19:ca12:0:b0:500:8fcd:c3b4 with SMTP id a18-20020a19ca12000000b005008fcdc3b4mr12372967lfg.69.1693296711166;
        Tue, 29 Aug 2023 01:11:51 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 9/9] mm: vmalloc: Set nr_nodes/node_size based on CPU-cores
Date:   Tue, 29 Aug 2023 10:11:42 +0200
Message-Id: <20230829081142.3619-10-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230829081142.3619-1-urezki@gmail.com>
References: <20230829081142.3619-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The density ratio is set to 2, i.e. two users per one node.
For example if there are 6 cores in a system the "nr_nodes"
is 3.

The "node_size" also depends on number of physical cores.
A high-threshold limit is hard-coded and set to SZ_4M.

For 32-bit, single/dual core systems an access to a global
vmap heap is not balanced. Such small systems do not suffer
from lock contentions due to limitation of CPU-cores.

Test on AMD Ryzen Threadripper 3970X 32-Core Processor:
sudo ./test_vmalloc.sh run_test_mask=127 nr_threads=64

<default perf>
 94.17%     0.90%  [kernel]    [k] _raw_spin_lock
 93.27%    93.05%  [kernel]    [k] native_queued_spin_lock_slowpath
 74.69%     0.25%  [kernel]    [k] __vmalloc_node_range
 72.64%     0.01%  [kernel]    [k] __get_vm_area_node
 72.04%     0.89%  [kernel]    [k] alloc_vmap_area
 42.17%     0.00%  [kernel]    [k] vmalloc
 32.53%     0.00%  [kernel]    [k] __vmalloc_node
 24.91%     0.25%  [kernel]    [k] vfree
 24.32%     0.01%  [kernel]    [k] remove_vm_area
 22.63%     0.21%  [kernel]    [k] find_unlink_vmap_area
 15.51%     0.00%  [unknown]   [k] 0xffffffffc09a74ac
 14.35%     0.00%  [kernel]    [k] ret_from_fork_asm
 14.35%     0.00%  [kernel]    [k] ret_from_fork
 14.35%     0.00%  [kernel]    [k] kthread
<default perf>
   vs
<patch-series perf>
 74.32%     2.42%  [kernel]    [k] __vmalloc_node_range
 69.58%     0.01%  [kernel]    [k] vmalloc
 54.21%     1.17%  [kernel]    [k] __alloc_pages_bulk
 48.13%    47.91%  [kernel]    [k] clear_page_orig
 43.60%     0.01%  [unknown]   [k] 0xffffffffc082f16f
 32.06%     0.00%  [kernel]    [k] ret_from_fork_asm
 32.06%     0.00%  [kernel]    [k] ret_from_fork
 32.06%     0.00%  [kernel]    [k] kthread
 31.30%     0.00%  [unknown]   [k] 0xffffffffc082f889
 22.98%     4.16%  [kernel]    [k] vfree
 14.36%     0.28%  [kernel]    [k] __get_vm_area_node
 13.43%     3.35%  [kernel]    [k] alloc_vmap_area
 10.86%     0.04%  [kernel]    [k] remove_vm_area
  8.89%     2.75%  [kernel]    [k] _raw_spin_lock
  7.19%     0.00%  [unknown]   [k] 0xffffffffc082fba3
  6.65%     1.37%  [kernel]    [k] free_unref_page
  6.13%     6.11%  [kernel]    [k] native_queued_spin_lock_slowpath
<patch-series perf>

confirms that a native_queued_spin_lock_slowpath bottle-neck
can be considered as negligible for the patch-series version.

The throughput is ~15x higher:

urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=127 nr_threads=64
Run the test with following parameters: run_test_mask=127 nr_threads=64
Done.
Check the kernel ring buffer to see the summary.

real    24m3.305s
user    0m0.361s
sys     0m0.013s
urezki@pc638:~$

urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=127 nr_threads=64
Run the test with following parameters: run_test_mask=127 nr_threads=64
Done.
Check the kernel ring buffer to see the summary.

real    1m28.382s
user    0m0.014s
sys     0m0.026s
urezki@pc638:~$

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9cce012aecdb..08990f630c21 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -796,6 +796,9 @@ struct vmap_node {
 	atomic_t fill_in_progress;
 };
 
+#define MAX_NODES U8_MAX
+#define MAX_NODE_SIZE SZ_4M
+
 static struct vmap_node *nodes, snode;
 static __read_mostly unsigned int nr_nodes = 1;
 static __read_mostly unsigned int node_size = 1;
@@ -4803,11 +4806,24 @@ static void vmap_init_free_space(void)
 	}
 }
 
+static unsigned int calculate_nr_nodes(void)
+{
+	unsigned int nr_cpus;
+
+	nr_cpus = num_present_cpus();
+	if (nr_cpus <= 1)
+		nr_cpus = num_possible_cpus();
+
+	/* Density factor. Two users per a node. */
+	return clamp_t(unsigned int, nr_cpus >> 1, 1, MAX_NODES);
+}
+
 static void vmap_init_nodes(void)
 {
 	struct vmap_node *vn;
 	int i;
 
+	nr_nodes = calculate_nr_nodes();
 	nodes = &snode;
 
 	if (nr_nodes > 1) {
@@ -4830,6 +4846,16 @@ static void vmap_init_nodes(void)
 		INIT_LIST_HEAD(&vn->free.head);
 		spin_lock_init(&vn->free.lock);
 	}
+
+	/*
+	 * Scale a node size to number of CPUs. Each power of two
+	 * value doubles a node size. A high-threshold limit is set
+	 * to 4M.
+	 */
+#if BITS_PER_LONG == 64
+	if (nr_nodes > 1)
+		node_size = min(SZ_64K << fls(num_possible_cpus()), SZ_4M);
+#endif
 }
 
 void __init vmalloc_init(void)
-- 
2.30.2

