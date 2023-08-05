Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD07770EE1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjHEIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHEIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:41:50 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA444B8
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 01:41:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RHwzp1NHpz4f3l7H
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 16:41:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKtGC85kcXBwPg--.1103S5;
        Sat, 05 Aug 2023 16:41:44 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/2] kobject: Add sanity check for kset->kobj.ktype in kset_register()
Date:   Sat,  5 Aug 2023 16:41:13 +0800
Message-Id: <20230805084114.1298-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230805084114.1298-1-thunder.leizhen@huaweicloud.com>
References: <20230805084114.1298-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKtGC85kcXBwPg--.1103S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWDKFW3Cr47uw45Zw13Jwb_yoW8Xr1UpF
        4akF13trWrCr47Zw4DJF4kCry5XF1kuF4DurWYgw1Fqr4rKFWqgw13tr1kZF43urWxXFW2
        qF10yws0v3yDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9mb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UtsqAUUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

When I register a kset in the following way:
	static struct kset my_kset;
	kobject_set_name(&my_kset.kobj, "my_kset");
        ret = kset_register(&my_kset);

A null pointer dereference exception is occurred:
[ 4453.568337] Unable to handle kernel NULL pointer dereference at \
virtual address 0000000000000028
... ...
[ 4453.810361] Call trace:
[ 4453.813062]  kobject_get_ownership+0xc/0x34
[ 4453.817493]  kobject_add_internal+0x98/0x274
[ 4453.822005]  kset_register+0x5c/0xb4
[ 4453.825820]  my_kobj_init+0x44/0x1000 [my_kset]
... ...

Because I didn't initialize my_kset.kobj.ktype.

According to the description in Documentation/core-api/kobject.rst:
 - A ktype is the type of object that embeds a kobject.  Every structure
   that embeds a kobject needs a corresponding ktype.

So add sanity check to make sure kset->kobj.ktype is not NULL.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/kobject.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index 14e845209226ab8..72fa20f405f1520 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -861,6 +861,11 @@ int kset_register(struct kset *k)
 	if (!k)
 		return -EINVAL;
 
+	if (!k->kobj.ktype) {
+		pr_err("must have a ktype to be initialized properly!\n");
+		return -EINVAL;
+	}
+
 	kset_init(k);
 	err = kobject_add_internal(&k->kobj);
 	if (err) {
-- 
2.34.1

