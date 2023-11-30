Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729E77FEB71
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjK3JIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:08:34 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2721A8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:08:38 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AU437hw005645;
        Thu, 30 Nov 2023 10:08:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=RWlzEoo51yVI95MkMgRPfpvbQAGfdwtvBoXEfFrIh5w=; b=TQ
        stO19N7hbGCldU2C/TgzfsBvqFDngC8YbQ+WwKjo+p26LkuW3wovjQ6IMlpuQko5
        YzE5mji0YY9YEi6J9oTRfwXAJpwMKobbOHqatittHq8DXufRl+qeQzVr7tmMk6x3
        II5uvxaEm6GCOY7yXn5GZBOHnnC0H3Ct1y0MH9mDGK4KM87wA7YGKH3omleY82II
        9E5h/nkoCecMyjsW2hjHWPHCsHEQScxlWT1WXaQi2mQKDMdWH4TLBe/SwZOP5ZIH
        4IXT75XxtGYmpt/kTpPN4xBddzBSrFer+YTucpIMKz+YxQ/gcfZtYhGXNSqJ4z5F
        F6i9MHHjwGH/9m/irpKg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3unxcj6gjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 10:08:19 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 402E610002A;
        Thu, 30 Nov 2023 10:08:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3853F217B67;
        Thu, 30 Nov 2023 10:08:15 +0100 (CET)
Received: from [10.252.15.82] (10.252.15.82) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 30 Nov
 2023 10:08:14 +0100
Message-ID: <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com>
Date:   Thu, 30 Nov 2023 10:08:14 +0100
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
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.15.82]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_07,2023-11-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/23 08:54, Sumit Garg wrote:
> On Wed, 29 Nov 2023 at 22:15, Arnaud Pouliquen
> <arnaud.pouliquen@foss.st.com> wrote:
>>
>> Currently it's not possible to register kernel buffers with TEE
>> which are allocated via vmalloc.
>>
>> Use iov_iter and associated helper functions to manage the page
>> registration for all type of memories.
>>
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> Update from V3 to V4:
>> - improve commit message,
>> - use import_ubuf() instead of iov_iter_init(),
>> - move shm_get_kernel_pages in register_shm_helper,
>> - put back untagged_addr in register_shm_helper(),
>> - move the comment related to pin pages from shm_get_kernel_pages()
>>   to register_shm_helper().
>>
>> Update from V2 to V3:
>> - break lines longer than 80 columns.
>>
>> Update from V1 to V2:
>> - replace ITER_SOURCE by ITER_DEST flag in tee_shm_register_user_buf(),
>> - replace IS_ERR_OR NULL(shm) by IS_ERR(shm) in tee_shm_register_user_buf().
>>
>> V1:
>> The support of buffer registration allocated with vmalloc is no more
>> available since c83900393aa1 ("tee: Remove vmalloc page support").
>>
>> This patch is an alternative to a revert and resulted from a discussion
>> with Christopher Hellwig [1].
>>
>> This patch has been tested using xtest tool in optee qemu environment [2]
>> and using the series related to the remoteproc tee that should be
>> proposed soon [3].
>>
>> References:
>> [1] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com/T/#m8ec683c44fcd9b69c2aee42eaed0793afac9dd18in
>> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#build-instructions
>> [3] https://lore.kernel.org/linux-arm-kernel/18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com/T/#maca0a1fc897aadd54c7deac432e11473fe970d1d
>> ---
>>  drivers/tee/tee_shm.c | 83 ++++++++++++++++++++++++-------------------
>>  1 file changed, 46 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index 673cf0359494..ac73e8143233 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -22,23 +22,12 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>>                 put_page(pages[n]);
>>  }
>>
>> -static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>> -                               struct page **pages)
>> +static void shm_get_kernel_pages(struct page **pages, size_t page_count)
>>  {
>> -       struct page *page;
>>         size_t n;
>>
>> -       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
>> -                        is_kmap_addr((void *)start)))
>> -               return -EINVAL;
>> -
>> -       page = virt_to_page((void *)start);
>> -       for (n = 0; n < page_count; n++) {
>> -               pages[n] = page + n;
>> +       for (n = 0; n < page_count; n++)
>>                 get_page(pages[n]);
>> -       }
>> -
>> -       return page_count;
>>  }
>>
>>  static void release_registered_pages(struct tee_shm *shm)
>> @@ -214,13 +203,14 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>>
>>  static struct tee_shm *
>> -register_shm_helper(struct tee_context *ctx, unsigned long addr,
>> -                   size_t length, u32 flags, int id)
>> +register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>> +                   int id)
>>  {
>>         struct tee_device *teedev = ctx->teedev;
>>         struct tee_shm *shm;
>> -       unsigned long start;
>> -       size_t num_pages;
>> +       unsigned long start, addr;
>> +       size_t num_pages, off;
>> +       ssize_t len;
>>         void *ret;
>>         int rc;
>>
>> @@ -245,31 +235,38 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>>         shm->flags = flags;
>>         shm->ctx = ctx;
>>         shm->id = id;
>> -       addr = untagged_addr(addr);
>> +       addr = untagged_addr((unsigned long)iter_iov_addr(iter));
>>         start = rounddown(addr, PAGE_SIZE);
>> -       shm->offset = addr - start;
>> -       shm->size = length;
>> -       num_pages = (roundup(addr + length, PAGE_SIZE) - start) / PAGE_SIZE;
>> +       num_pages = iov_iter_npages(iter, INT_MAX);
>> +       if (!num_pages) {
>> +               ret = ERR_PTR(-ENOMEM);
>> +               goto err_ctx_put;
>> +       }
>> +
>>         shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
>>         if (!shm->pages) {
>>                 ret = ERR_PTR(-ENOMEM);
>>                 goto err_free_shm;
>>         }
>>
>> -       if (flags & TEE_SHM_USER_MAPPED)
>> -               rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
>> -                                        shm->pages);
>> -       else
>> -               rc = shm_get_kernel_pages(start, num_pages, shm->pages);
>> -       if (rc > 0)
>> -               shm->num_pages = rc;
>> -       if (rc != num_pages) {
>> -               if (rc >= 0)
>> -                       rc = -ENOMEM;
>> -               ret = ERR_PTR(rc);
>> -               goto err_put_shm_pages;
>> +       len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
>> +                                    &off);
>> +       if (unlikely(len <= 0)) {
>> +               ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>> +               goto err_free_shm_pages;
>>         }
>>
>> +       /*
>> +        * iov_iter_extract_kvec_pages does not get reference on the pages,
>> +        * get a pin on them.
> 
> I think you meant: "get a reference on them". But I don't see the
> value of this comment since iov_iter_extract_kvec_pages() already has
> been commented properly as follows:
> 
> /*
>  * Extract a list of virtually contiguous pages from an ITER_KVEC iterator.
>  * This does not get references on the pages, nor does it get a pin on them.
>  */
> 

I spent some time debugging this part. Since we use the same API for both user
and kernel buffers, we wouldn't expect to have any specific actions to take.
Therefore, I thought it would be helpful to add a comment explaining the reason
for this specific code, rather than go deeper into iov_iter to understand it.

But if you don't see the value, I can remove the comment.

>> +        */
>> +       if (iov_iter_is_kvec(iter))
>> +               shm_get_kernel_pages(shm->pages, num_pages);
>> +
>> +       shm->offset = off;
>> +       shm->size = len;
>> +       shm->num_pages = num_pages;
>> +
>>         rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>>                                              shm->num_pages, start);
>>         if (rc) {
>> @@ -279,10 +276,11 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>>
>>         return shm;
>>  err_put_shm_pages:
>> -       if (flags & TEE_SHM_USER_MAPPED)
>> +       if (!iov_iter_is_kvec(iter))
>>                 unpin_user_pages(shm->pages, shm->num_pages);
>>         else
>>                 shm_put_kernel_pages(shm->pages, shm->num_pages);
>> +err_free_shm_pages:
>>         kfree(shm->pages);
>>  err_free_shm:
>>         kfree(shm);
>> @@ -307,8 +305,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>>         u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>>         struct tee_device *teedev = ctx->teedev;
>>         struct tee_shm *shm;
>> +       struct iov_iter iter;
>>         void *ret;
>> -       int id;
>> +       int id, err;
>>
>>         if (!access_ok((void __user *)addr, length))
>>                 return ERR_PTR(-EFAULT);
>> @@ -319,7 +318,11 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>>         if (id < 0)
>>                 return ERR_PTR(id);
>>
>> -       shm = register_shm_helper(ctx, addr, length, flags, id);
>> +       err = import_ubuf(ITER_DEST, (void __user *)addr, length, &iter);
> 
> As I mentioned in a previous review, import_ubuf() already does the
> access_ok() check, so we don't need the extra access_ok() check above.
> Also, you should move import_ubuf() to be the first invocation within
> this API.

My apologies, I re-added import_ubuf() during testing to debug an issue and
forgot to
remove it afterwards.

Thanks and regards,
Arnaud

> 
> -Sumit
> 
>> +       if (err)
>> +               return ERR_PTR(err);
>> +
>> +       shm = register_shm_helper(ctx, &iter, flags, id);
>>         if (IS_ERR(shm)) {
>>                 mutex_lock(&teedev->mutex);
>>                 idr_remove(&teedev->idr, id);
>> @@ -352,8 +355,14 @@ struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>>                                             void *addr, size_t length)
>>  {
>>         u32 flags = TEE_SHM_DYNAMIC;
>> +       struct kvec kvec;
>> +       struct iov_iter iter;
>> +
>> +       kvec.iov_base = addr;
>> +       kvec.iov_len = length;
>> +       iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, length);
>>
>> -       return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
>> +       return register_shm_helper(ctx, &iter, flags, -1);
>>  }
>>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>>
>> --
>> 2.25.1
>>
