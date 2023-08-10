Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB79E776ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjHJEBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjHJEBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:01:15 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76726E71;
        Wed,  9 Aug 2023 21:01:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RLtWm5K5mz4f3jYK;
        Thu, 10 Aug 2023 12:01:08 +0800 (CST)
Received: from vm-fedora-38.huawei.com (unknown [10.67.174.164])
        by APP4 (Coremail) with SMTP id gCh0CgCnhKf+YNRkntJqAQ--.7154S2;
        Thu, 10 Aug 2023 12:01:09 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Waqar Hameed <waqar.hameed@axis.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: [PATCH v2] iio: irsd200: fix -Warray-bounds bug in irsd200_trigger_handler
Date:   Thu, 10 Aug 2023 11:59:10 +0800
Message-ID: <20230810035910.1334706-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnhKf+YNRkntJqAQ--.7154S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrWF43Aw15urW7tF1xAFb_yoW8tF1xpF
        Z3Aw4UZrW8ZFy7CF18ZFyDWa4Fqa45J34j9FW7W3s8Zw4Fv3sY9F1Fkw1SgFyqgF4Iyr1j
        qrZ3JF48CF1DJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

When compiling with gcc 13 with -Warray-bounds enabled:

In file included from drivers/iio/proximity/irsd200.c:15:
In function ‘iio_push_to_buffers_with_timestamp’,
    inlined from ‘irsd200_trigger_handler’ at drivers/iio/proximity/irsd200.c:770:2:
./include/linux/iio/buffer.h:42:46: error: array subscript ‘int64_t {aka long long int}[0]’
is partly outside array bounds of ‘s16[1]’ {aka ‘short int[1]’} [-Werror=array-bounds=]
   42 |                 ((int64_t *)data)[ts_offset] = timestamp;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
drivers/iio/proximity/irsd200.c: In function ‘irsd200_trigger_handler’:
drivers/iio/proximity/irsd200.c:763:13: note: object ‘buf’ of size 2
  763 |         s16 buf = 0;
      |             ^~~

The problem seems to be that irsd200_trigger_handler() is taking a s16
variable as an int64_t buffer. As Jonathan suggested [1], fix it by
extending the buffer to a two-element array of s64.

Link: https://github.com/KSPP/linux/issues/331
Link: https://lore.kernel.org/lkml/20230809181329.46c00a5d@jic23-huawei/ [1]
Fixes: 3db3562bc66e ("iio: Add driver for Murata IRS-D200")
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---

v2: change buf to `s64 buf[2]`

 drivers/iio/proximity/irsd200.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index 5bd791b46d98..bdff91f6b1a3 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -759,14 +759,14 @@ static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
 {
 	struct iio_dev *indio_dev = ((struct iio_poll_func *)pollf)->indio_dev;
 	struct irsd200_data *data = iio_priv(indio_dev);
-	s16 buf = 0;
+	s64 buf[2] = {};
 	int ret;
 
-	ret = irsd200_read_data(data, &buf);
+	ret = irsd200_read_data(data, (s16 *)buf);
 	if (ret)
 		goto end;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, buf,
 					   iio_get_time_ns(indio_dev));
 
 end:
-- 
2.41.0

