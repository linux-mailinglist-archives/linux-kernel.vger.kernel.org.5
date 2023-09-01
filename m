Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC49C78F692
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 03:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348019AbjIABHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjIABHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 21:07:46 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422AE0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 18:07:41 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230901010736epoutp020a7a4e2d27a00af704752083000d670d~AoPpC5wsZ0215902159epoutp02y
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:07:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230901010736epoutp020a7a4e2d27a00af704752083000d670d~AoPpC5wsZ0215902159epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693530456;
        bh=3lnqbhSVVHVANGMeuOJCj7uAUnONzIjPOVriyrfVKoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJEQLqjbL1C2aLD++xAzzXj2DsE0iH3dnfEIk5J2qknTTvz1KHvtxlT8Zon+qhI0E
         bJm8XGpWkVdB1SAtsabeq50Xjd0XEPZtC6cCMiuFZRx6YmGojzcXkNHfFlF8VN65gj
         wWpBh1l98pfp9FNVwSTmjLxwtiYvT9QZ4I3Zs7YQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230901010735epcas2p14995cd0872914edf689de6a87b82d5b1~AoPocGG7L2194821948epcas2p1V;
        Fri,  1 Sep 2023 01:07:35 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RcKdM31lpz4x9Q5; Fri,  1 Sep
        2023 01:07:35 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.97.08583.75931F46; Fri,  1 Sep 2023 10:07:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230901010734epcas2p1490c6648e41dfddeb0cc9c39a101da8b~AoPngWYb_1550015500epcas2p1O;
        Fri,  1 Sep 2023 01:07:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230901010734epsmtrp1cd996728e3533a6d21d6ba0e25cdd104~AoPnfSabv2935729357epsmtrp1p;
        Fri,  1 Sep 2023 01:07:34 +0000 (GMT)
X-AuditID: b6c32a43-96bfd70000002187-17-64f13957ea68
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.CF.08788.65931F46; Fri,  1 Sep 2023 10:07:34 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230901010734epsmtip2046538ba0ca8b746795695c88326e2ec~AoPnPfDMe2052620526epsmtip2v;
        Fri,  1 Sep 2023 01:07:34 +0000 (GMT)
From:   Bongkyu Kim <bongkyu7.kim@samsung.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bongkyu7.kim@samsung.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] locking/rwsem: Make reader optimistic spinning
 optional
Date:   Fri,  1 Sep 2023 10:07:04 +0900
Message-Id: <20230901010704.18493-3-bongkyu7.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmmW645ccUgyWfhSxeN75kslizpZHJ
        onnxejaLy7vmsFm8an7EZnH62AkWi0sHFjBZHO89wGTRcsfUgdNj56y77B6bV2h5LN7zkslj
        06pONo/9c9ewe7zfd5XNo2/LKkaPz5vkAjiiGhhtEouSMzLLUhVS85LzUzLz0m2VQkPcdC2U
        FDLyi0tslaINDY30DA3M9YyMjPRMjWKtjEyVFPISc1NtlSp0oXqVFIqSC4BqcyuLgQbkpOpB
        xfWKU/NSHLLyS0Fe0itOzC0uzUvXS87PVVIoS8wpBRqhpJ/wjTHjUcMvloKDwhVLnmxjbGD8
        xt/FyMkhIWAiMfP8JrYuRi4OIYEdjBKP73eyQjifGCUurnvODuF8Y5T4e2glUBkHWMvOB/kQ
        8b2MEq8/NjPDFV3+c44ZZC6bgI7E/9UzmEAaRATSJRa+yAcJMwtUSxzasZMNxBYWCJS419PI
        BGKzCKhK7NtzlQXE5hWwldi0fSUTxHnyEjMvfWcHsTkF7CT2vpzGClEjKHFy5hMWiJnyEs1b
        Z4PdICHQySHxYlcDK0Szi8T6n9uhbGGJV8e3sEPYUhIv+9ug7GyJM3fOM0LYFRIv//6BihtL
        zHrWzghyP7OApsT6XfoQvytLHLkFtZZPouPwX6hqQYnT17qZIUp4JTrahCDCahK7n7dCHSAj
        cfDsWqivPCT2TH7EOoFRcRaSZ2YheWYWwt4FjMyrGMVSC4pz01OTjQoMkWN4EyM4BWs572C8
        Mv+f3iFGJg7GQ4wSHMxKIryxZu9ShHhTEiurUovy44tKc1KLDzEmA4N6IrOUaHI+MAvklcQb
        mplZWlgamVpYmppaEBY2sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CGYLEwenVANT
        sPU/p0qdG7NULsraMs77p5UvzHJH6J7LicYggardueq7jvPtCbT5ckPYU6RbqYOh4XhD45yc
        TPUj5bEr/vgFstjGKNpYzZkaFbLvsa0Mm7GqxxW+/ORviTkV3zMMchca5qa9EV24k7VuiV7e
        vZbDSzm+LLPhenudN/HOE1GLu4de/ik5HLnvk/yJFVkJj5+LKp1mMQ9v7tvIu9/M7ealgqnu
        mu3WxZ9u7Z134vGnNXfKJt+0Pl8uc4D17azzGsumtigv3p7nvXeR0MMNRREzWLgLX16Pe1kr
        X1YiPEvGyqHJO5f57SvtaZoyH0JP3LAuOreBoVr5sCnP3Yufj33fP9GR9Y/wrwo7jmWb2SqV
        WIozEg21mIuKEwF2Ae/+eAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvG6Y5ccUg/n9RhavG18yWazZ0shk
        0bx4PZvF5V1z2CxeNT9iszh97ASLxaUDC5gsjvceYLJouWPqwOmxc9Zddo/NK7Q8Fu95yeSx
        aVUnm8f+uWvYPd7vu8rm0bdlFaPH501yARxRXDYpqTmZZalF+nYJXBmPGn6xFBwUrljyZBtj
        A+M3/i5GDg4JAROJnQ/yuxi5OIQEdjNK7N6zk7mLkRMoLiNx6N9aJghbWOJ+yxFWiKIvjBIH
        Vu9kBEmwCehI/F89A6xIRCBX4umXS2A2s0C9xPFNzWwgtrCAv8Smw+vBbBYBVYl9e66ygNi8
        ArYSm7avhFogLzHz0nd2EJtTwE5i78tprCC2EFDNyfUQM3kFBCVOznzCAjFfXqJ562zmCYwC
        s5CkZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwDWlo7GPes+qB3iJGJ
        g/EQowQHs5IIb6zZuxQh3pTEyqrUovz4otKc1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbB
        ZJk4OKUamDSO+9dF3e+cmLHL1yZk2ncBDd7uxC1r46cn6v/zsY2KL70n59R5ZRNX5z+2ORlf
        bta5/udirN4113nS1kmdWzbJmOQeCN+8cv2dV/e63V9Xpv5JZmg/zBS746DgOmaVn3rJPo/3
        9Nxyy72y4nv18/VXlDf4xka/YnhVXvzzy6PHefdkP81W4zlZodKZN6mDX+5wie/9OA69V+LR
        gekLuv6Z3DASW3vgZxXP9G/PrvoZXbSYOf9K/Gcerbvc9oWfd/+3mRNmUC+Qba76Yl/C6p+R
        NkvbjrA+fFW2cuWXgAnmDupafe/qbrqYCh/SSfoo6vrzVvLSE64d8y3V/POza1RkO3LUWTbv
        vuk1M9nRR4mlOCPRUIu5qDgRAK8G8FrwAgAA
X-CMS-MailID: 20230901010734epcas2p1490c6648e41dfddeb0cc9c39a101da8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230901010734epcas2p1490c6648e41dfddeb0cc9c39a101da8b
References: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
        <CGME20230901010734epcas2p1490c6648e41dfddeb0cc9c39a101da8b@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable reader optimistic spinning by default. And, can enable it
by "rwsem.opt_rspin" cmdline.

Also, fix compile error without CONFIG_RWSEM_SPIN_ON_OWNER (reported by
kernel test robot)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306010043.VJHcuCnb-lkp@intel.com/
Signed-off-by: Bongkyu Kim <bongkyu7.kim@samsung.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 kernel/locking/rwsem.c                          | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 772b54df084b..adf16a07fe4d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5605,6 +5605,15 @@
 
 	rw		[KNL] Mount root device read-write on boot
 
+	rwsem.opt_rspin [KNL]
+			Use rwsem reader optimistic spinning. Reader optimistic
+			spinning is helpful when the reader critical section is
+			short and there aren't that many readers around.
+			For example, enable this option may improve performance
+			in mobile workload that there're not many readers, but
+			may reduce performance in server workload that there're
+			many readers.
+
 	S		[KNL] Run init in single mode
 
 	s390_iommu=	[HW,S390]
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 9c0462d515c1..47c467880af5 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -117,6 +117,17 @@
 # define DEBUG_RWSEMS_WARN_ON(c, sem)
 #endif
 
+static bool __ro_after_init rwsem_opt_rspin;
+
+static int __init opt_rspin(char *str)
+{
+        rwsem_opt_rspin = true;
+
+        return 0;
+}
+
+early_param("rwsem.opt_rspin", opt_rspin);
+
 /*
  * On 64-bit architectures, the bit definitions of the count are:
  *
@@ -1083,7 +1094,7 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 	return false;
 }
 
-static inline bool rwsem_no_spinners(sem)
+static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
 {
 	return false;
 }
@@ -1157,6 +1168,9 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		return sem;
 	}
 
+	if (!IS_ENABLED(CONFIG_RWSEM_SPIN_ON_OWNER) || !rwsem_opt_rspin)
+		goto queue;
+
 	/*
 	 * Save the current read-owner of rwsem, if available, and the
 	 * reader nonspinnable bit.
-- 
2.36.1

