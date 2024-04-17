Return-Path: <linux-kernel+bounces-147906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD258A7B27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C5A282825
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9D42A93;
	Wed, 17 Apr 2024 03:57:21 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E68473;
	Wed, 17 Apr 2024 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326241; cv=none; b=L0JlqFCCU/CzqvC675MzXFdDpCiGy9Rgtd0k/84K51+Ya/9DYnvMuJIzFqJjbY1xtGSTOzwfotmFiZK3hsNTPK8jWMxsxXCbayb4llX5LSuoEAahvBmbG5pUVNIyn9La38qtmo7TTyUESuUNykBA2tQ7jvV2SWu3iph7pv9oe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326241; c=relaxed/simple;
	bh=CaJWLCdpiiwysIA0Q1EuxnIjXXUmHomP6gLyl8CgG+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KT4fkaKTY3bLwKSGKHtWc7LninitQM9+KRSBIEhHZVuRxZ5gEZgtWhLNNQuFSEUsAiXKwa5voPqz8nMPCTh0vIuka8d9gI+jA3xqCG8CP1Ds4r8QWjygqKZFPIQLvoChQUDipF3seqHKRNtNu0dA9y7IOlClwzkj9j/j/KTSdzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK6YH29m9z4f3lVb;
	Wed, 17 Apr 2024 11:57:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 369241A058D;
	Wed, 17 Apr 2024 11:57:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RGaSB9mzMnFKA--.65099S5;
	Wed, 17 Apr 2024 11:57:15 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH RESEND v2 1/2] perf/core: Fix small negative period being ignored
Date: Wed, 17 Apr 2024 11:54:45 +0000
Message-Id: <20240417115446.2908769-2-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417115446.2908769-1-luogengkun@huaweicloud.com>
References: <20240417115446.2908769-1-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RGaSB9mzMnFKA--.65099S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyxtr48tr1DuF4DKw43Awb_yoW5uFyfpr
	WvyrnxKr4kGFy5Kw1kAw1rXry5J3y8Aa17Wrn5KrW5Ca1Y9r4UJrWIvr12gr1kCF4Sva4I
	k3Z8Xr4fG3WvyF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUpqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4c8EcI0Ec7
	CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjTRP3kWUUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

In perf_adjust_period, we will first calculate period, and then use
this period to calculate delta. However, when delta is less than 0,
there will be a deviation compared to when delta is greater than or
equal to 0. For example, when delta is in the range of [-14,-1], the
range of delta = delta + 7 is between [-7,6], so the final value of
delta/8 is 0. Therefore, the impact of -1 and -2 will be ignored.
This is unacceptable when the target period is very short, because
we will lose a lot of samples.

Here are some tests and analyzes:
before:
  # perf record -e cs -F 1000  ./a.out
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.022 MB perf.data (518 samples) ]

  # perf script
  ...
  a.out     396   257.956048:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.957891:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.959730:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.961545:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.963355:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.965163:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.966973:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.968785:         23 cs:  ffffffff81f4eeec schedul>
  a.out     396   257.970593:         23 cs:  ffffffff81f4eeec schedul>
  ...

after:
  # perf record -e cs -F 1000  ./a.out
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.058 MB perf.data (1466 samples) ]

  # perf script
  ...
  a.out     395    59.338813:         11 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.339707:         12 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.340682:         13 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.341751:         13 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.342799:         12 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.343765:         11 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.344651:         11 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.345539:         12 cs:  ffffffff81f4eeec schedul>
  a.out     395    59.346502:         13 cs:  ffffffff81f4eeec schedul>
  ...

test.c

int main() {
        for (int i = 0; i < 20000; i++)
                usleep(10);

        return 0;
}

  # time ./a.out
  real    0m1.583s
  user    0m0.040s
  sys     0m0.298s

The above results were tested on x86-64 qemu with KVM enabled using
test.c as test program. Ideally, we should have around 1500 samples,
but the previous algorithm had only about 500, whereas the modified
algorithm now has about 1400. Further more, the new version shows 1
sample per 0.001s, while the previous one is 1 sample per 0.002s.This
indicates that the new algorithm is more sensitive to small negative
values compared to old algorithm.

Fixes: bd2b5b12849a ("perf_counter: More aggressive frequency adjustment")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 683dc086ef10..cad50d3439f1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4078,7 +4078,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
-	delta = (delta + 7) / 8; /* low pass filter */
+	if (delta >= 0)
+		delta += 7;
+	else
+		delta -= 7;
+	delta /= 8; /* low pass filter */
 
 	sample_period = hwc->sample_period + delta;
 
-- 
2.34.1


