Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ADE783758
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjHVB2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjHVB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:28:06 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40C11D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:27:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RVBY85qNXz4f3jMN
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:27:40 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgCXDSoOD+Rk4z7YBA--.32329S2;
        Tue, 22 Aug 2023 09:27:43 +0800 (CST)
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Mel Gorman <mgorman@techsingularity.net>,
        Chris Li <chrisl@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        John Sperbeck <jsperbeck@google.com>
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <6a18b295-92ac-1633-0b79-6aaf18a8496d@huaweicloud.com>
Date:   Tue, 22 Aug 2023 09:27:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230821103225.qntnsotdzuthxn2y@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgCXDSoOD+Rk4z7YBA--.32329S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryUJF1UKr1fJF1DCr13twb_yoWftrg_ua
        9Fgwn29r4jvrZFvFn5WrWaqFZ7K3s7Z34rXrWqqr43u34DXFyDJFWrCr92gF4xArWrGFn3
        ua1fJr4jvr1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 8/21/2023 6:32 PM, Mel Gorman wrote:
> On Thu, Aug 17, 2023 at 11:05:22PM -0700, Chris Li wrote:
>> In this patch series I want to safeguard
>> the free_pcppage_bulk against change in the
>> pcp->count outside of this function. e.g.
>> by BPF program inject on the function tracepoint.
>>
>> I break up the patches into two seperate patches
>> for the safeguard and clean up.
>>
>> Hopefully that is easier to review.
>>
>> Signed-off-by: Chris Li <chrisl@kernel.org>
> 
> This sounds like a maintenance nightmare if internal state can be arbitrary
> modified by a BPF program and still expected to work properly in all cases.
> Every review would have to take into account "what if a BPF script modifies
> state behind our back?"
> 
Agreed. We assume pcp->count is protected by pcp->lock. Instead of make code
work in case pcp->count could be changed without lock held, it's more reasonble
to modify pcp->count with pcp->lock held in BPF program.

