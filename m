Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2171278E4E5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbjHaDBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbjHaDBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:01:05 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD2CD7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:01:00 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230831030058epoutp0160aa1d3f3edec83e21c181a181d51552~AWJVuyXwn0472904729epoutp01e
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:00:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230831030058epoutp0160aa1d3f3edec83e21c181a181d51552~AWJVuyXwn0472904729epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693450858;
        bh=hec1u34V3I1CHV5gBwDlNVvtJJwrt5aIdAZBIB1Pa4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3t6JcrrXfnxCc33FXV/z8/gTlKukWacG3tpZ3RgYlfFkMD8unOGG3a2QmhfcoSQA
         1AdKY+o63NXl7id8hybzO/zgPFnxE35hQwrRLVdc6peLtTxjGGttCB6s2VXmlOpJ1o
         ENtEs8gb21JezUWrMtPYD+cMh0gG4GZSnlOgX7lQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230831030058epcas2p2b0030830262e79321cb8aa68480c33d1~AWJVGfuLN3146331463epcas2p2F;
        Thu, 31 Aug 2023 03:00:58 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RbmBd426bz4x9Px; Thu, 31 Aug
        2023 03:00:57 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.4C.09693.96200F46; Thu, 31 Aug 2023 12:00:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230831030057epcas2p3031d3497e47e61182a5b593c2d8e5dd6~AWJULF7Kp1014810148epcas2p31;
        Thu, 31 Aug 2023 03:00:57 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230831030057epsmtrp2667d9bbb387e3d144d065a864afe8806~AWJUKCGTS2734327343epsmtrp2N;
        Thu, 31 Aug 2023 03:00:57 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-98-64f0026936a6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.6F.18916.86200F46; Thu, 31 Aug 2023 12:00:56 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230831030056epsmtip2e5d168be45f62354f93d2fc2b44f567d~AWJUAM5M22985129851epsmtip2k;
        Thu, 31 Aug 2023 03:00:56 +0000 (GMT)
From:   Bongkyu Kim <bongkyu7.kim@samsung.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        bongkyu7.kim@samsung.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v1 2/2] locking/rwsem: Make reader optimistic spinning
 optional
Date:   Thu, 31 Aug 2023 12:00:04 +0900
Message-Id: <20230831030004.16576-3-bongkyu7.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831030004.16576-1-bongkyu7.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsWy7bCmuW4m04cUg8YGOYvXjS+ZLNZsaWSy
        aF68ns3i8q45bBavmh+xWZw+doLF4tKBBUwWx3sPMFm03DF14PTYOesuu8fmFVoei/e8ZPLY
        tKqTzWP/3DXsHu/3XWXz6NuyitHj8ya5AI6oBkabxKLkjMyyVIXUvOT8lMy8dFul0BA3XQsl
        hYz84hJbpWhDQyM9QwNzPSMjIz1To1grI1MlhbzE3FRbpQpdqF4lhaLkAqDa3MpioAE5qXpQ
        cb3i1LwUh6z8UpCX9IoTc4tL89L1kvNzlRTKEnNKgUYo6Sd8Y8z42b+AreCecMWsf+wNjO0C
        XYycHBICJhJTp3eydzFycQgJ7GCUODD/DhuE84lRouH6DBY45+vhh2wwLbfe34VK7GSUOH7v
        HhOE841RoufdfUaQKjYBHYn/q2cAJTg4RATSJRa+yAcJMwtUSxzasRNskLBAoMSFnR9ZQUpY
        BFQldi4rBwnzCthKrL27EWqXvMTMS9/ZQWxOATuJw5/XM0LUCEqcnPmEBWKkvETz1tnMICdI
        CLRySLza9JcJotlF4uXNjewQtrDEq+NboGwpic/v9kItyJY4c+c8I4RdIfHy7x+oGmOJWc/a
        GUFuYxbQlFi/Sx/ElBBQljhyC2otn0TH4b9Q1YISp691M0OU8Ep0tAlBhNUkdj9vZYWwZSQO
        nl0LdZiHxOX/H5gnMCrOQvLMLCTPzELYu4CReRWjWGpBcW56arFRgSFyBG9iBCdgLdcdjJPf
        ftA7xMjEwXiIUYKDWUmEN9bsXYoQb0piZVVqUX58UWlOavEhxmRgSE9klhJNzgfmgLySeEMz
        M0sLSyNTC0tTUwvCwiaWBiZmZobmRqYG5krivPda56YICaQnlqRmp6YWpBbBbGHi4JRqYKo1
        sjhYOXGtvf4OkRUTmM+pha2J+fv24BM2oxkppbv+cwa5Hb8s9I3R7rOWn75EoWXHo155MZHF
        r5k5XadNVIrcUb8r4qryp+tG0zbm/rLdxVXQuuWJoqdsmfbD5otc39wrTEP83ZaczpkxOTD1
        KpvDjxTDyYrCe7nTfyzt/L+Vt+GY7WyBN2d7FRPyJjv4WN+NvSG/4/rqde7rFI58NY2fIydy
        oaO3P7u8S6Vk/7IVAfIeNau3cB2fuGbyPp9zr05qd/UKn+i5E7Nkx9zSGTuLSs8+Wfg4af7T
        b9sOvp6cLBB9NZDDs/etXaRwmyZP1/3E61rul1/tcUxUTpvz6Fje893/2445Oq0/m/ntdYYS
        S3FGoqEWc1FxIgBM/XHXdwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvG4G04cUg+mrrS1eN75kslizpZHJ
        onnxejaLy7vmsFm8an7EZnH62AkWi0sHFjBZHO89wGTRcsfUgdNj56y77B6bV2h5LN7zkslj
        06pONo/9c9ewe7zfd5XNo2/LKkaPz5vkAjiiuGxSUnMyy1KL9O0SuDJ+9i9gK7gnXDHrH3sD
        Y7tAFyMnh4SAicSt93dZuhi5OIQEtjNKvHh3jRUiISNx6N9aJghbWOJ+yxFWiKIvjBLz236B
        JdgEdCT+r54BZosI5Eo8/XIJzGYWqJc4vqmZrYuRg0NYwF9i7fMEEJNFQFVi57JykApeAVuJ
        tXc3skGMl5eYeek7O4jNKWAncfjzekYQWwioZsX6X4wQ9YISJ2c+YYGYLi/RvHU28wRGgVlI
        UrOQpBYwMq1iFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECA57raAdjMvW/9U7xMjEwXiIUYKD
        WUmEN9bsXYoQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QD
        U8StlNLI4HVz3zxPf3Oy4xFPQxG/z6JG3xnLNLqn3BZyYwvLubz5D6eccLlDr7+57pb919cd
        XGFbZiO4/NvrjcxWe7xe3ZvTtu+I9V2W+/MNG39yHriye8vxWedOWu3ZNo9VVPAlq9/HyPdN
        nbaXHj0Lilb026f2L77+39Z9RjcN3kzQLDi1bQt3Vbt7uPrkv8mmy+4x21yYvSj13tFIJ7V/
        p9ZtSzHU/hD4d1OBw/skqfy1IhIf7mz3eXjq9M6rLgHPluVo5WuvuX2QN/C90JaJrqwnZ7mH
        6N9ybXb3umdtY/k49e3P+/kxq3UzdAynBfdWnHdZeV7yW+XVecXtRZVbLKasP7vGwv3xHq3+
        v4ZKLMUZiYZazEXFiQCrqvxd6gIAAA==
X-CMS-MailID: 20230831030057epcas2p3031d3497e47e61182a5b593c2d8e5dd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230831030057epcas2p3031d3497e47e61182a5b593c2d8e5dd6
References: <20230831030004.16576-1-bongkyu7.kim@samsung.com>
        <CGME20230831030057epcas2p3031d3497e47e61182a5b593c2d8e5dd6@epcas2p3.samsung.com>
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
 .../admin-guide/kernel-parameters.txt          |  9 +++++++++
 kernel/locking/rwsem.c                         | 18 +++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

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
index 9c0462d515c1..de3f173d94d4 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -117,6 +117,19 @@
 # define DEBUG_RWSEMS_WARN_ON(c, sem)
 #endif
 
+#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+static bool rwsem_opt_rspin;
+
+static int __init opt_rspin(char *str)
+{
+        rwsem_opt_rspin = true;
+
+        return 0;
+}
+
+early_param("rwsem.opt_rspin", opt_rspin);
+#endif
+
 /*
  * On 64-bit architectures, the bit definitions of the count are:
  *
@@ -1083,7 +1096,7 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 	return false;
 }
 
-static inline bool rwsem_no_spinners(sem)
+static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
 {
 	return false;
 }
@@ -1157,6 +1170,9 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
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

