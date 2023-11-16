Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4177ED8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 01:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbjKPA43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 19:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPA40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 19:56:26 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D38ADAF;
        Wed, 15 Nov 2023 16:56:21 -0800 (PST)
Received: from loongson.cn (unknown [10.180.129.93])
        by gateway (Coremail) with SMTP id _____8Dx_7uzaFVlU2Y6AA--.56070S3;
        Thu, 16 Nov 2023 08:56:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.129.93])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxri+waFVlAIZDAA--.15990S2;
        Thu, 16 Nov 2023 08:56:16 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bojan Smojver <bojan@rexursive.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        stable@vger.kernel.org, Weihao Li <liweihao@loongson.cn>
Subject: [PATCH v2] PM: hibernate: use acquire/release ordering when compress/decompress image
Date:   Thu, 16 Nov 2023 08:56:09 +0800
Message-Id: <20231116005609.1583858-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxri+waFVlAIZDAA--.15990S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAQB2VUKqkG2gABs5
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw47uFWkJrW7ZFyrXFWkGrX_yoW7KFy5pF
        W8Xan0kr4UXrs8Z39rAay8Z345A3ZYyFZrGrsxG34fuasIgrsYya40gF9Yvr1YyFy8t34v
        9a17K34qgryqqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we test S4(suspend to disk) on LoongArch 3A6000 platform, the
test case sometimes fails. The dmesg log shows the following error:
	Invalid LZO compressed length
After we dig into the code, we find out that:
When compress/decompress the image, the synchronization operation
between the control thread and the compress/decompress/crc thread
uses relaxed ordering interface, which is unreliable, and the
following situation may occur:
CPU 0					CPU 1
save_image_lzo				lzo_compress_threadfn
					  atomic_set(&d->stop, 1);
  atomic_read(&data[thr].stop)
  data[thr].cmp = data[thr].cmp_len;
	  				  WRITE data[thr].cmp_len
Then CPU0 get a old cmp_len and write to disk. When cpu resume from S4,
wrong cmp_len is loaded.

To maintain data consistency between two threads, we should use the
acquire/release ordering interface. So we change atomic_read/atomic_set
to atomic_read_acquire/atomic_set_release.

Fixes: 081a9d043c98 ("PM / Hibernate: Improve performance of LZO/plain hibernation, checksum image")
Cc: stable@vger.kernel.org
Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Weihao Li <liweihao@loongson.cn>
---
v1 -> v2:
	1. add Cc: stable@vger.kernel.org in commit log
	2. add Fixes: line in commit log
---
 kernel/power/swap.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index a2cb0babb5ec..d44f5937f1e5 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -606,11 +606,11 @@ static int crc32_threadfn(void *data)
 	unsigned i;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -619,7 +619,7 @@ static int crc32_threadfn(void *data)
 		for (i = 0; i < d->run_threads; i++)
 			*d->crc32 = crc32_le(*d->crc32,
 			                     d->unc[i], *d->unc_len[i]);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -649,12 +649,12 @@ static int lzo_compress_threadfn(void *data)
 	struct cmp_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -663,7 +663,7 @@ static int lzo_compress_threadfn(void *data)
 		d->ret = lzo1x_1_compress(d->unc, d->unc_len,
 		                          d->cmp + LZO_HEADER, &d->cmp_len,
 		                          d->wrk);
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -798,7 +798,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 
 			data[thr].unc_len = off;
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -806,12 +806,12 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			break;
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -850,7 +850,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
 			}
 		}
 
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 
@@ -1132,12 +1132,12 @@ static int lzo_decompress_threadfn(void *data)
 	struct dec_data *d = data;
 
 	while (1) {
-		wait_event(d->go, atomic_read(&d->ready) ||
+		wait_event(d->go, atomic_read_acquire(&d->ready) ||
 		                  kthread_should_stop());
 		if (kthread_should_stop()) {
 			d->thr = NULL;
 			d->ret = -1;
-			atomic_set(&d->stop, 1);
+			atomic_set_release(&d->stop, 1);
 			wake_up(&d->done);
 			break;
 		}
@@ -1150,7 +1150,7 @@ static int lzo_decompress_threadfn(void *data)
 			flush_icache_range((unsigned long)d->unc,
 					   (unsigned long)d->unc + d->unc_len);
 
-		atomic_set(&d->stop, 1);
+		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
 	return 0;
@@ -1335,7 +1335,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		if (crc->run_threads) {
-			wait_event(crc->done, atomic_read(&crc->stop));
+			wait_event(crc->done, atomic_read_acquire(&crc->stop));
 			atomic_set(&crc->stop, 0);
 			crc->run_threads = 0;
 		}
@@ -1371,7 +1371,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 					pg = 0;
 			}
 
-			atomic_set(&data[thr].ready, 1);
+			atomic_set_release(&data[thr].ready, 1);
 			wake_up(&data[thr].go);
 		}
 
@@ -1390,7 +1390,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 		for (run_threads = thr, thr = 0; thr < run_threads; thr++) {
 			wait_event(data[thr].done,
-			           atomic_read(&data[thr].stop));
+				atomic_read_acquire(&data[thr].stop));
 			atomic_set(&data[thr].stop, 0);
 
 			ret = data[thr].ret;
@@ -1421,7 +1421,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
 				ret = snapshot_write_next(snapshot);
 				if (ret <= 0) {
 					crc->run_threads = thr + 1;
-					atomic_set(&crc->ready, 1);
+					atomic_set_release(&crc->ready, 1);
 					wake_up(&crc->go);
 					goto out_finish;
 				}
@@ -1429,13 +1429,13 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		}
 
 		crc->run_threads = thr;
-		atomic_set(&crc->ready, 1);
+		atomic_set_release(&crc->ready, 1);
 		wake_up(&crc->go);
 	}
 
 out_finish:
 	if (crc->run_threads) {
-		wait_event(crc->done, atomic_read(&crc->stop));
+		wait_event(crc->done, atomic_read_acquire(&crc->stop));
 		atomic_set(&crc->stop, 0);
 	}
 	stop = ktime_get();
-- 
2.33.0

