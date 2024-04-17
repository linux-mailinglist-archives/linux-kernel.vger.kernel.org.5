Return-Path: <linux-kernel+bounces-147907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45748A7B28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A825282651
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F347F6B;
	Wed, 17 Apr 2024 03:57:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86791E888;
	Wed, 17 Apr 2024 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326242; cv=none; b=QEOjJALqwRIS3/wYcNJS8Og9GjxRrXNxyPh9GH+GrjpZghmDpJlc/ESdCIJy1Ti6W6cAKUrNMbMQGyEmGiA+xoHwjvGBMZH49mb2NExR7s9n5+F8kYNEirqt5VJo9ihkaZ+CL503XTCXVdg3gaN//JuAyg5e7FJqRXRw+xgS3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326242; c=relaxed/simple;
	bh=wii6+rVTqhTSBdS8cUxVrVBgMqOcNLARz3i+uByjOt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=boPrnmGYsUl28sTs4r9Vtm+WS0wpr9DEBDGIWlprabL7eCk5QSme1ZEHSIgGvXtS7u3izDSPYJsl8nfH4Xy5Rd3zlC0HHbFVvVSXq2ELT62i2M++kyReR/eZxJOzYFL9pntugklyuWjoBeX1teuW5tJJAEYZh3mwtSqw8WZS0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK6YH67Hmz4f3tNZ;
	Wed, 17 Apr 2024 11:57:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BEA361A0175;
	Wed, 17 Apr 2024 11:57:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RGaSB9mzMnFKA--.65099S6;
	Wed, 17 Apr 2024 11:57:16 +0800 (CST)
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
Subject: [PATCH RESEND v2 2/2] perf/core: Fix incorrected time diff in tick adjust period
Date: Wed, 17 Apr 2024 11:54:46 +0000
Message-Id: <20240417115446.2908769-3-luogengkun@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAX6RGaSB9mzMnFKA--.65099S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4xCw4xuF4UCFWDZrykGrg_yoWrXF1rpr
	Wvyr13KFsrtF1j9wnYkFyrWry5Ww48Aan8G348Cw48Aw1fWr9xJF1kKF1UGF98CFZrZFyI
	y3s0gw43tFWUtaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUpj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5V
	A0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4c8EcI0En4kS14v26r1Y6r17MxAqzxv26xkF7I0En4kS14
	v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
	RERRR3UUUUU==
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

Adrian found that there is a probability that the number of samples
is small, which is caused by the unreasonable large sampling period.

 # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.010 MB perf.data (204 samples) ]
 # perf script
 ...
 test   865   265.377846:         16 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.378900:         15 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.379845:         14 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.380770:         14 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.381647:         15 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.382638:         16 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.383647:         16 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.384704:         15 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.385649:         14 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.386578:        152 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.396383:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.406183:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.415839:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.425445:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.435052:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.444708:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.454314:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.463970:        154 cs:  ffffffff832e927b schedule+0x2b
 test   865   265.473577:        154 cs:  ffffffff832e927b schedule+0x2b
 ...

It seems that the Timer Interrupts is not coming every TICK_NSEC when
system is idle. For example, counter increase n during 2 * TICK_NSEC,
and it call perf_adjust_period using n and TICK_NSEC, so the final period
we calculated will be bigger than expected one. What's more, if the
the overflow time is larger than 2 * TICK_NSEC we cannot tune the period
using __perf_event_account_interrupt. To fix this problem, perf can
calculate the tick interval by itself.

Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index afb028c54f33..2708f1d0692c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -265,6 +265,7 @@ struct hw_perf_event {
 	 * State for freq target events, see __perf_event_overflow() and
 	 * perf_adjust_freq_unthr_context().
 	 */
+	u64				freq_tick_stamp;
 	u64				freq_time_stamp;
 	u64				freq_count_stamp;
 #endif
diff --git a/kernel/events/core.c b/kernel/events/core.c
index cad50d3439f1..0f2025d631aa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4112,7 +4112,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
-	u64 now, period = TICK_NSEC;
+	u64 now, period, tick_stamp;
 	s64 delta;
 
 	/*
@@ -4151,6 +4151,10 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		 */
 		event->pmu->stop(event, PERF_EF_UPDATE);
 
+		tick_stamp = perf_clock();
+		period = tick_stamp - hwc->freq_tick_stamp;
+		hwc->freq_tick_stamp = tick_stamp;
+
 		now = local64_read(&event->count);
 		delta = now - hwc->freq_count_stamp;
 		hwc->freq_count_stamp = now;
@@ -4162,8 +4166,13 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		 * to perf_adjust_period() to avoid stopping it
 		 * twice.
 		 */
-		if (delta > 0)
-			perf_adjust_period(event, period, delta, false);
+		if (delta > 0) {
+			/*
+			 * we skip first tick adjust period
+			 */
+			if (likely(period != tick_stamp))
+				perf_adjust_period(event, period, delta, false);
+		}
 
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
 	next:
-- 
2.34.1


