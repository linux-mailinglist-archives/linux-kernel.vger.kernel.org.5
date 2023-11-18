Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0117F7EFF09
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjKRKlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKRKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:41 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9551A10C4;
        Sat, 18 Nov 2023 02:41:37 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXVgZ5X5Tz4f3l0y;
        Sat, 18 Nov 2023 18:41:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id DEFFD1A0175;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
        by APP1 (Coremail) with SMTP id cCh0CgDn6hDQlFhlQPAFBQ--.58135S7;
        Sat, 18 Nov 2023 18:41:34 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu@huaweicloud.com>
To:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org
Subject: [PATCH -next 03/14] kddv/core: Add io fault support to bpf program
Date:   Sat, 18 Nov 2023 18:40:29 +0800
Message-Id: <20231118104040.386381-4-zhangxiaoxu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
References: <20231118104040.386381-1-zhangxiaoxu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDn6hDQlFhlQPAFBQ--.58135S7
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWxuw4fJFWkGF17ur4kWFg_yoW5WF4xpF
        WxJ3y7CF1v9r4S9rnY9FZFqFWrXrnrWF40kr97Xa47Cw43Jrn5J3yxt3W5tF9xursYq395
        AryIgr1Uur48XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

Add common io fault interface, then the bpf program can use
it to mock the hardware io error.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 tools/testing/kddv/kddv/core/consts.py              |  1 +
 tools/testing/kddv/kddv/core/model.py               |  4 ++++
 .../kddv/kddv/data/bpf/include/bpf-xfer-conf.h      | 13 +++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/tools/testing/kddv/kddv/core/consts.py b/tools/testing/kddv/kddv/core/consts.py
index 22abd7fc655c..b761407f5e88 100755
--- a/tools/testing/kddv/kddv/core/consts.py
+++ b/tools/testing/kddv/kddv/core/consts.py
@@ -10,3 +10,4 @@ CFG_REG_MASK = 0x10
 CFG_REG_RSH = 0x11
 CFG_REG_LSH = 0x12
 CFG_REG_ORD = 0x13
+CFG_IO_FAULT = 0x20
diff --git a/tools/testing/kddv/kddv/core/model.py b/tools/testing/kddv/kddv/core/model.py
index 494b69566536..ff782c20313d 100755
--- a/tools/testing/kddv/kddv/core/model.py
+++ b/tools/testing/kddv/kddv/core/model.py
@@ -8,6 +8,7 @@
 
 from .driver import Driver
 from .mockup import Mockup
+from .consts import CFG_IO_FAULT
 
 class DriverModel(object):
     bus = None
@@ -89,3 +90,6 @@ class DriverModel(object):
 
     def write_regs(self, addr, data):
         self.mockup.write_regs(addr, data)
+
+    def trigger_io_fault(self, count = 1):
+        self.mockup.write_config(CFG_IO_FAULT, count)
diff --git a/tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h b/tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h
index 49adbcc6a1af..6a09bd391641 100644
--- a/tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h
+++ b/tools/testing/kddv/kddv/data/bpf/include/bpf-xfer-conf.h
@@ -18,6 +18,7 @@
 #define BPF_CONF_REG_RSHIFT	0x11
 #define BPF_CONF_REG_LSHIFT	0x12
 #define BPF_CONF_REG_XBSWAP	0x13
+#define BPF_CONF_IO_FAULT	0x20
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -28,6 +29,7 @@ struct {
 
 static u32 bpf_reg_mask, bpf_reg_xbswap;
 static u32 bpf_reg_rshift, bpf_reg_lshift;
+static u32 bpf_io_fault;
 
 static u32 bpf_xfer_read_conf(u32 key)
 {
@@ -59,6 +61,7 @@ static int bpf_xfer_update_config(void)
 	bpf_reg_rshift = bpf_xfer_read_conf(BPF_CONF_REG_RSHIFT);
 	bpf_reg_lshift = bpf_xfer_read_conf(BPF_CONF_REG_LSHIFT);
 	bpf_reg_xbswap = bpf_xfer_read_conf(BPF_CONF_REG_XBSWAP);
+	bpf_io_fault = bpf_xfer_read_conf(BPF_CONF_IO_FAULT);
 
 	return 0;
 }
@@ -108,4 +111,14 @@ u32 bpf_xfer_reg_u32(u32 reg)
 		reg = reg << bpf_reg_lshift;
 	return reg;
 }
+
+bool bpf_xfer_should_fault(void)
+{
+	bpf_xfer_update_config();
+
+	if (bpf_io_fault)
+		bpf_xfer_write_conf(BPF_CONF_IO_FAULT, bpf_io_fault - 1);
+
+	return !!bpf_io_fault;
+}
 #endif
-- 
2.34.1

