Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F279A120
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjIKCEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIKCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:04:53 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DCC132
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:04:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RkVQg5nTGz4f3kK5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:04:43 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
        by APP1 (Coremail) with SMTP id cCh0CgA3vq67df5k58qfAA--.49340S2;
        Mon, 11 Sep 2023 10:04:44 +0800 (CST)
Message-ID: <853d7e18-f264-7b1d-b5f5-1b11c2eba8a2@huaweicloud.com>
Date:   Mon, 11 Sep 2023 10:04:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: remove duplicated vma->vm_flags check when expanding
 stack
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc:     Liam.Howlett@oracle.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230906103312.645712-1-xiujianfeng@huaweicloud.com>
 <20230910142627.0dce42578bfaab7c4c67e316@linux-foundation.org>
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <20230910142627.0dce42578bfaab7c4c67e316@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgA3vq67df5k58qfAA--.49340S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1rArW5WrW8Xr47Zw4kCrg_yoWDurcE93
        9ruF4xJwsYqFy7Gw4kGa40vr4agF4UJr1fXryruF13Jw1UGr1rXFyqkr9xJFW5tFZrK3s8
        Cwn0ya9akw1IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUU
        UU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/9/11 5:26, Andrew Morton wrote:
> On Wed,  6 Sep 2023 10:33:12 +0000 Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:
> 
>> expand_upwards() and expand_downwards() will return -EFAULT if VM_GROWSUP
>> or VM_GROWSDOWN is not correctly set in vma->vm_flags, however in
>> !CONFIG_STACK_GROWSUP case, expand_stack_locked() returns -EINVAL first
>> if !(vma->vm_flags & VM_GROWSDOWN) before calling expand_downwards(), to
>> keep the consistency with CONFIG_STACK_GROWSUP case, remove this check.
> 
> What are the user-visible effects of this change?
> 
> Do you believe this fix should be backported into earlier kernel versions?

The usages of this function are as bellow:

A:fs/exec.c
ret = expand_stack_locked(vma, stack_base);
if (ret)
	ret = -EFAULT;

or

B:mm/memory.c mm/mmap.c
if (expand_stack_locked(vma, addr))
	return NULL;

which means the return value will not propagate to other places, so I
believe there is no user-visible effects of this change, and it's
unnecessary to backport to earlier versions.

