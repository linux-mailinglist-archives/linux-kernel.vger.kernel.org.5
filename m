Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DF7FEFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjK3NSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjK3NSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:18:37 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA501986
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:18:34 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AUAAQZ6005428;
        Thu, 30 Nov 2023 14:18:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=hhr85Bd114omXrt0eWX5Nwj0F7IbLj9+N891doD18cs=; b=01
        MKDsE0dQtlE4erouajdIh8tyG0wMkFY5ZajoZULrWrKIdCchQzi+T8d5z2hnZ5Gs
        C31OspggxVn8e0aaQtEQhSjogSKBHKByBaC4nwKAmI9+6ta0cMOUrrLtKeSAlTXn
        g2+Azi2UZtWSSJ3xKbFlcBns8+0SXcga/O55hIHiKXGV01sIiEgGRwYacr5fNwVO
        SSA8LCYP/ypZOjtp17ND5UN7ynCU1PsaP5wfQa85jC4k3n9jeze0POtOxZqXqtex
        9VtZPmb9KpqCMzxOgYm4MxU9Ogmm3nMFITjDhah2QbJOl9xi/n13xTcLy04+ehig
        Yi5WJ/s5nAIuVqLOR7rA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3unxcj7w00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 14:18:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6C18E10002A;
        Thu, 30 Nov 2023 14:18:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 639B6227EE3;
        Thu, 30 Nov 2023 14:18:20 +0100 (CET)
Received: from [10.252.15.82] (10.252.15.82) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 30 Nov
 2023 14:18:19 +0100
Message-ID: <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
Date:   Thu, 30 Nov 2023 14:18:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer
 registration
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
 <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com>
 <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.15.82]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_11,2023-11-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 13:00, Sumit Garg wrote:
> On Thu, 30 Nov 2023 at 14:38, Arnaud POULIQUEN
> <arnaud.pouliquen@foss.st.com> wrote:
>>
>>
>>
>> On 11/30/23 08:54, Sumit Garg wrote:
>>> On Wed, 29 Nov 2023 at 22:15, Arnaud Pouliquen
>>> <arnaud.pouliquen@foss.st.com> wrote:
>>>>
>>>> Currently it's not possible to register kernel buffers with TEE
>>>> which are allocated via vmalloc.
>>>>
>>>> Use iov_iter and associated helper functions to manage the page
>>>> registration for all type of memories.
>>>>
>>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>> ---
>>>> Update from V3 to V4:
>>>> - improve commit message,
>>>> - use import_ubuf() instead of iov_iter_init(),
>>>> - move shm_get_kernel_pages in register_shm_helper,
>>>> - put back untagged_addr in register_shm_helper(),
>>>> - move the comment related to pin pages from shm_get_kernel_pages()
>>>>   to register_shm_helper().
>>>>
>>>> Update from V2 to V3:
>>>> - break lines longer than 80 columns.
>>>>
>>>> Update from V1 to V2:
>>>> - replace ITER_SOURCE by ITER_DEST flag in tee_shm_register_user_buf(),
>>>> - replace IS_ERR_OR NULL(shm) by IS_ERR(shm) in tee_shm_register_user_buf().
>>>>
>>>> V1:
>>>> The support of buffer registration allocated with vmalloc is no more
>>>> available since c83900393aa1 ("tee: Remove vmalloc page support").
>>>>
>>>> This patch is an alternative to a revert and resulted from a discussion
>>>> with Christopher Hellwig [1].
>>>>
>>>> This patch has been tested using xtest tool in optee qemu environment [2]
>>>> and using the series related to the remoteproc tee that should be
>>>> proposed soon [3].
>>>>
>>>> References:
>>>> [1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
>>>> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#build-instructions
>>>> [3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
>>>> ---
>>>>  drivers/tee/tee_shm.c | 83 ++++++++++++++++++++++++-------------------
>>>>  1 file changed, 46 insertions(+), 37 deletions(-)
>>>>
>>>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>>>> index 673cf0359494..ac73e8143233 100644
>>>> --- a/drivers/tee/tee_shm.c
>>>> +++ b/drivers/tee/tee_shm.c
>>>> @@ -22,23 +22,12 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>>>>                 put_page(pages[n]);
>>>>  }
>>>>
>>>> -static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>>>> -                               struct page **pages)
>>>> +static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>>>>  {
>>>> -       struct page *page;
>>>>         size_t n;
>>>>
>>>> -       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
>>>> -                        is_kmap_addr((void *)start)))
>>>> -               return -EINVAL;
>>>> -
>>>> -       page = virt_to_page((void *)start);
>>>> -       for (n = 0; n < page_count; n++) {
>>>> -               pages[n] = page + n;
>>>> +       for (n = 0; n < page_count; n++)
>>>>                 get_page(pages[n]);
>>>> -       }
>>>> -
>>>> -       return page_count;
>>>>  }
>>>>
>>>>  static void release_registered_pages(struct tee_shm *shm)
>>>> @@ -214,13 +203,14 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>>>>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>>>>
>>>>  static struct tee_shm *
>>>> -register_shm_helper(struct tee_context *ctx, unsigned long addr,
>>>> -                   size_t length, u32 flags, int id)
>>>> +register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>>>> +                   int id)
>>>>  {
>>>>         struct tee_device *teedev = ctx->teedev;
>>>>         struct tee_shm *shm;
>>>> -       unsigned long start;
>>>> -       size_t num_pages;
>>>> +       unsigned long start, addr;
>>>> +       size_t num_pages, off;
>>>> +       ssize_t len;
>>>>         void *ret;
>>>>         int rc;
>>>>
>>>> @@ -245,31 +235,38 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>>>>         shm->flags = flags;
>>>>         shm->ctx = ctx;
>>>>         shm->id = id;
>>>> -       addr = untagged_addr(addr);
>>>> +       addr = untagged_addr((unsigned long)iter_iov_addr(iter));
>>>>         start = rounddown(addr, PAGE_SIZE);
>>>> -       shm->offset = addr - start;
>>>> -       shm->size = length;
>>>> -       num_pages = (roundup(addr + length, PAGE_SIZE) - start) / PAGE_SIZE;
>>>> +       num_pages = iov_iter_npages(iter, INT_MAX);
>>>> +       if (!num_pages) {
>>>> +               ret = ERR_PTR(-ENOMEM);
>>>> +               goto err_ctx_put;
>>>> +       }
>>>> +
>>>>         shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
>>>>         if (!shm->pages) {
>>>>                 ret = ERR_PTR(-ENOMEM);
>>>>                 goto err_free_shm;
>>>>         }
>>>>
>>>> -       if (flags & TEE_SHM_USER_MAPPED)
>>>> -               rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
>>>> -                                        shm->pages);
>>>> -       else
>>>> -               rc = shm_get_kernel_pages(start, num_pages, shm->pages);
>>>> -       if (rc > 0)
>>>> -               shm->num_pages = rc;
>>>> -       if (rc != num_pages) {
>>>> -               if (rc >= 0)
>>>> -                       rc = -ENOMEM;
>>>> -               ret = ERR_PTR(rc);
>>>> -               goto err_put_shm_pages;
>>>> +       len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
>>>> +                                    &off);
>>>> +       if (unlikely(len <= 0)) {
>>>> +               ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>>>> +               goto err_free_shm_pages;
>>>>         }
>>>>
>>>> +       /*
>>>> +        * iov_iter_extract_kvec_pages does not get reference on the pages,
>>>> +        * get a pin on them.
>>>
>>> I think you meant: "get a reference on them". But I don't see the
>>> value of this comment since iov_iter_extract_kvec_pages() already has
>>> been commented properly as follows:
>>>
>>> /*
>>>  * Extract a list of virtually contiguous pages from an ITER_KVEC iterator.
>>>  * This does not get references on the pages, nor does it get a pin on them.
>>>  */
>>>
>>
>> I spent some time debugging this part. Since we use the same API for both user
>> and kernel buffers, we wouldn't expect to have any specific actions to take.
>> Therefore, I thought it would be helpful to add a comment explaining the reason
>> for this specific code, rather than go deeper into iov_iter to understand it.
>>
> 
> Fair enough, let's keep it with s/pin/reference/.
> 
>> But if you don't see the value, I can remove the comment.
>>
>>>> +        */
>>>> +       if (iov_iter_is_kvec(iter))
>>>> +               shm_get_kernel_pages(shm->pages, num_pages);
>>>> +
>>>> +       shm->offset = off;
>>>> +       shm->size = len;
>>>> +       shm->num_pages = num_pages;
>>>> +
>>>>         rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>>>>                                              shm->num_pages, start);
>>>>         if (rc) {
>>>> @@ -279,10 +276,11 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>>>>
>>>>         return shm;
>>>>  err_put_shm_pages:
>>>> -       if (flags & TEE_SHM_USER_MAPPED)
>>>> +       if (!iov_iter_is_kvec(iter))
>>>>                 unpin_user_pages(shm->pages, shm->num_pages);
>>>>         else
>>>>                 shm_put_kernel_pages(shm->pages, shm->num_pages);
>>>> +err_free_shm_pages:
>>>>         kfree(shm->pages);
>>>>  err_free_shm:
>>>>         kfree(shm);
>>>> @@ -307,8 +305,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>>>>         u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>>>>         struct tee_device *teedev = ctx->teedev;
>>>>         struct tee_shm *shm;
>>>> +       struct iov_iter iter;
>>>>         void *ret;
>>>> -       int id;
>>>> +       int id, err;
>>>>
>>>>         if (!access_ok((void __user *)addr, length))
>>>>                 return ERR_PTR(-EFAULT);
>>>> @@ -319,7 +318,11 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>>>>         if (id < 0)
>>>>                 return ERR_PTR(id);
>>>>
>>>> -       shm = register_shm_helper(ctx, addr, length, flags, id);
>>>> +       err = import_ubuf(ITER_DEST, (void __user *)addr, length, &iter);
>>>
>>> As I mentioned in a previous review, import_ubuf() already does the
>>> access_ok() check, so we don't need the extra access_ok() check above.
>>> Also, you should move import_ubuf() to be the first invocation within
>>> this API.
>>
>> My apologies, I re-added import_ubuf() during testing to debug an issue and
> 
> I suppose you intended to mention access_ok() here, BTW, no worries :).

Re-running xtest after removing the access_ok() I have a crash in
regression_5006.3 Allocate_out_of_memory

[   89.258100] ------------[ cut here ]------------
[   89.258377] WARNING: CPU: 1 PID: 134 at mm/page_alloc.c:4402
__alloc_pages+0x674/0xd14
[   89.258988] Modules linked in:
[   89.259554] CPU: 1 PID: 134 Comm: xtest Not tainted 6.6.0-g1ebcc18a80d7-dirty #69
[   89.259763] Hardware name: linux,dummy-virt (DT)
[   89.259977] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   89.260143] pc : __alloc_pages+0x674/0xd14
[   89.260252] lr : alloc_pages+0xac/0x160
[   89.260364] sp : ffff8000803f3a30
[   89.260437] x29: ffff8000803f3a30 x28: ffff8000803f3d70 x27: 0000000000000000
[   89.260705] x26: 000000000000000b x25: 0000000000000000 x24: ffff000000178000
[   89.260847] x23: ffff00003f52b720 x22: ffff000001442720 x21: 0000000000000000
[   89.261022] x20: 000000000000000b x19: 0000000000000000 x18: ffff8000803f3b78
[   89.261162] x17: 0000000000000000 x16: ffffa7a428b67660 x15: 0000ffff63ffffff
[   89.261348] x14: 0000000000000008 x13: 1fffe00000a4c421 x12: ffff8000803f3b78
[   89.261528] x11: ffff000005262100 x10: ffff000005262108 x9 : ffff00000526210c
[   89.261739] x8 : 0000aaab0a97c000 x7 : 0000aaab0a90e000 x6 : ffff000005262150
[   89.261920] x5 : 0000000000000000 x4 : ffff000000976740 x3 : 0000000000000000
[   89.262098] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffa7a429daf000
[   89.262340] Call trace:
[   89.262921]  __alloc_pages+0x674/0xd14
[   89.263262]  alloc_pages+0xac/0x160
[   89.263373]  alloc_pages_exact+0x48/0x94
[   89.263464]  optee_shm_register+0xa8/0x1f4
[   89.263591]  register_shm_helper+0x1bc/0x28c
[   89.263687]  tee_shm_register_user_buf+0xb8/0x128
[   89.263816]  tee_ioctl+0xbc/0xfa0
[   89.263915]  __arm64_sys_ioctl+0xa8/0xec
[   89.264053]  invoke_syscall+0x48/0x114
[   89.264173]  el0_svc_common.constprop.0+0x40/0xe8
[   89.264321]  do_el0_svc+0x20/0x2c
[   89.264488]  el0_svc+0x40/0xf4
[   89.264578]  el0t_64_sync_handler+0x13c/0x158
[   89.264714]  el0t_64_sync+0x190/0x194
[   89.265003] ---[ end trace 0000000000000000 ]---


The issue is that, in import_ubuf(), it updates the length [1], making the

access_ok() succeed and leading to an issue later in the page allocation process.

To fix, I propose to add a test in tee_shm_register_user_buf() after calling

import_ubuf()

	if (length != iter_iov_len(&iter))
		return ERR_PTR(-EFAULT);


Would it be ok for you ? I'm afraid of side effects if I update import_ubuf()...

[1] https://elixir.bootlin.com/linux/latest/source/lib/iov_iter.c#L1553

Regards,
Arnaud


> 
> -Sumit
> 
>> forgot to
>> remove it afterwards.
>>
>> Thanks and regards,
>> Arnaud
>>
>>>
>>> -Sumit
>>>
>>>> +       if (err)
>>>> +               return ERR_PTR(err);
>>>> +
>>>> +       shm = register_shm_helper(ctx, &iter, flags, id);
>>>>         if (IS_ERR(shm)) {
>>>>                 mutex_lock(&teedev->mutex);
>>>>                 idr_remove(&teedev->idr, id);
>>>> @@ -352,8 +355,14 @@ struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>>>>                                             void *addr, size_t length)
>>>>  {
>>>>         u32 flags = TEE_SHM_DYNAMIC;
>>>> +       struct kvec kvec;
>>>> +       struct iov_iter iter;
>>>> +
>>>> +       kvec.iov_base = addr;
>>>> +       kvec.iov_len = length;
>>>> +       iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
>>>>
>>>> -       return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
>>>> +       return register_shm_helper(ctx, &iter, flags, -1);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>>>>
>>>> --
>>>> 2.25.1
>>>>
