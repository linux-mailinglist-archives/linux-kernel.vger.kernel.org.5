Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F91809D29
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573309AbjLHHcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjLHHcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:32:10 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCE241FED
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:32:05 -0800 (PST)
Received: from localhost.localdomain (unknown [10.190.70.178])
        by mail-app2 (Coremail) with SMTP id by_KCgDX309jxnJlZVpeAA--.64232S4;
        Fri, 08 Dec 2023 15:31:55 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: core: fix memleak in iio_device_register_sysfs
Date:   Fri,  8 Dec 2023 15:31:19 +0800
Message-Id: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgDX309jxnJlZVpeAA--.64232S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtFy8GF4DAry5XFyruw15Arb_yoWkGFg_ua
        129r1rXr95ta1jgryagr1YqrW5C3yDKrs5u34xtF4SkFy2qFZ7XFWDXry5Jr17Ww47XF98
        Z3y2grWxCa47WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEDBmVxlxRD3QAAsP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When iio_device_register_sysfs_group() fails, we should
free iio_dev_opaque->chan_attr_group.attrs to prevent
potential memleak.

Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/iio/industrialio-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c77745b594bd..e6d3d07a4c83 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1581,10 +1581,13 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	ret = iio_device_register_sysfs_group(indio_dev,
 					      &iio_dev_opaque->chan_attr_group);
 	if (ret)
-		goto error_clear_attrs;
+		goto error_free_chan_attrs;
 
 	return 0;
 
+error_free_chan_attrs:
+	kfree(iio_dev_opaque->chan_attr_group.attrs);
+	iio_dev_opaque->chan_attr_group.attrs = NULL;
 error_clear_attrs:
 	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
 
-- 
2.17.1

