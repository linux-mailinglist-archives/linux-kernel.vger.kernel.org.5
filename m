Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAFF771875
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHGCwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHGCv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:51:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1041721;
        Sun,  6 Aug 2023 19:51:56 -0700 (PDT)
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RK1421ZTDz1Z1Tk;
        Mon,  7 Aug 2023 10:49:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemm600006.china.huawei.com
 (7.193.23.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 10:51:52 +0800
From:   Wenyu Liu <liuwenyu7@huawei.com>
To:     <ebiederm@xmission.com>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <vschneid@redhat.com>,
        <pmenzel@molgen.mpg.de>, <bhe@redhat.com>,
        <louhongxiang@huawei.com>
Subject: [PATCH v2 RESEND] kexec_lock: Replace kexec_mutex() by kexec_lock() in two comments
Date:   Mon, 7 Aug 2023 10:52:06 +0800
Message-ID: <20230807025206.3682381-1-liuwenyu7@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec_mutex is replaced by an atomic variable
in 05c6257433b (panic, kexec: make __crash_kexec() NMI safe).

But there are still two comments that referenced kexec_mutex,
replace them by kexec_lock.

Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v1 -> v2
 - fixed some mistakes in the submission information

 kernel/kexec_file.c                | 2 +-
 security/integrity/ima/ima_kexec.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 881ba0d1714c..b5bbb2fe0668 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -624,7 +624,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
  * kexec_add_buffer - place a buffer in a kexec segment
  * @kbuf:	Buffer contents and memory parameters.
  *
- * This function assumes that kexec_mutex is held.
+ * This function assumes that kexec_lock is held.
  * On successful return, @kbuf->mem will have the physical address of
  * the buffer in memory.
  *
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 419dc405c831..ad133fe120db 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -77,7 +77,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
  * Called during kexec_file_load so that IMA can add a segment to the kexec
  * image for the measurement list for the next kernel.
  *
- * This function assumes that kexec_mutex is held.
+ * This function assumes that kexec_lock is held.
  */
 void ima_add_kexec_buffer(struct kimage *image)
 {
-- 
2.33.0

