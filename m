Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0307BBEF1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjJFSsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjJFSsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:48:46 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36486C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:48:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S2HDs2ZHqz9yqHk
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 02:35:57 +0800 (CST)
Received: from [10.81.201.45] (unknown [10.81.201.45])
        by APP1 (Coremail) with SMTP id LxC2BwA3RJV3ViBlpUa3AQ--.53719S2;
        Fri, 06 Oct 2023 19:48:30 +0100 (CET)
Message-ID: <53b8065f-1f65-6956-279c-05bd461a7284@huaweicloud.com>
Date:   Fri, 6 Oct 2023 20:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too
 long
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Leonardo Bras <leobras@redhat.com>,
        Imran Khan <imran.f.khan@oracle.com>
References: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwA3RJV3ViBlpUa3AQ--.53719S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWftFyrJFyxXrW3CrW8Xrb_yoW5Jry7pa
        40gFyYkr48X34UZr4rG3yruryI9wn0k347G34UWw4rCFy0kr4xZr15trnaqF9293s3Wa1a
        qF15ZasIgw4UJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this related to the qspinlock issue you described earlier?


jonas


Am 10/5/2023 um 6:48 PM schrieb Paul E. McKenney:
> The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> temporarily, it usually gets released in a few seconds, and sometimes
> up to one or two minutes.
>
> If the CSD lock stays stuck for more than several minutes, it never
> seems to get unstuck, and gradually more and more things in the system
> end up also getting stuck.
>
> In the latter case, we should just give up, so the system can dump out
> a little more information about what went wrong, and, with panic_on_oops
> and a kdump kernel loaded, dump a whole bunch more information about
> what might have gone wrong.
>
> Question: should this have its own panic_on_ipistall switch in
> /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> way than via BUG_ON?
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 8455a53465af..059f1f53fc6b 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -230,6 +230,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>   	}
>   
>   	ts2 = sched_clock();
> +	/* How long since we last checked for a stuck CSD lock.*/
>   	ts_delta = ts2 - *ts1;
>   	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
>   		return false;
> @@ -243,9 +244,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>   	else
>   		cpux = cpu;
>   	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> +	/* How long since this CSD lock was stuck. */
> +	ts_delta = ts2 - ts0;
>   	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> -		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
>   		 cpu, csd->func, csd->info);
> +	/*
> +	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> +	 * to become unstuck. Use a signed comparison to avoid triggering
> +	 * on underflows when the TSC is out of sync between sockets.
> +	 */
> +	BUG_ON((s64)ts_delta > 300000000000LL);
>   	if (cpu_cur_csd && csd != cpu_cur_csd) {
>   		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
>   			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),

