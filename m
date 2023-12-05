Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C9805649
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbjLENpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjLENpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:45:50 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7852BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:45:55 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3B5Cfi4f023034;
        Tue, 5 Dec 2023 14:45:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=FSRHGKoQ2y+P/hzJL2Gm/ynyDVH8OKOZpF8JV6g73hc=; b=xc
        BM+SaQa1mWzMBcckkW63sW2OkZZFaplXw5gEzG46J8EBbPcfqxE/P3QqdPyzeIfj
        mmPoHmoBQutnmxuRczMkb5J/frK3vgDkbCMsAo0bpb3JPUETW7Hha/TVPJOiqEFu
        EaW/EvbSwptc5qXlGSKBHS1CO8iezNQnmMdINLrv0HVI3E5sM1JmNNTJsDNeO0vw
        f/5qDIXgTxs8heBmmF+MVuorIyuof9fQBrD0HkRYHOzFcCOpXxKs1qMjUFPOWP0p
        HKPeXBdA3Yyd6pYlztLFVt/CCOGsRQwV8LPy8nruylvEVkxWMj9OS7enBiXsAqiy
        yhf3ouT9TT6u7iEl6qaA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uqtvm4k7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 14:45:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7AE210008D;
        Tue,  5 Dec 2023 14:45:36 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9EBDE24C438;
        Tue,  5 Dec 2023 14:45:36 +0100 (CET)
Received: from [10.201.20.163] (10.201.20.163) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Dec
 2023 14:45:36 +0100
Message-ID: <f970d6a2-d6b1-4602-b476-f63cd086cea2@foss.st.com>
Date:   Tue, 5 Dec 2023 14:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer
 registration
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
 <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com>
 <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
 <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
 <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
 <438a8b44-ea5f-4e13-bd7e-e1c2e2a481c4@kernel.dk>
 <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
 <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
 <CAFA6WYMi52WTWho5y=967fm8utqtdq9fuCjVJFA9G0MaHtNYgg@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <CAFA6WYMi52WTWho5y=967fm8utqtdq9fuCjVJFA9G0MaHtNYgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.163]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_09,2023-12-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On 12/5/23 13:07, Sumit Garg wrote:
> Hi Arnaud,
> 
> On Mon, 4 Dec 2023 at 22:32, Arnaud POULIQUEN
> <arnaud.pouliquen@foss.st.com> wrote:
>>
>> Hi,
>>
>> On 12/4/23 17:40, Jens Axboe wrote:
>>> On 12/4/23 9:36 AM, Jens Axboe wrote:
>>>> On 12/4/23 5:42 AM, Sumit Garg wrote:
>>>>> IMO, access_ok() should be the first thing that import_ubuf() or
>>>>> import_single_range() should do, something as follows:
>>>>>
>>>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>>>> index 8ff6824a1005..4aee0371824c 100644
>>>>> --- a/lib/iov_iter.c
>>>>> +++ b/lib/iov_iter.c
>>>>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>>>>
>>>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>>>>  {
>>>>> -       if (len > MAX_RW_COUNT)
>>>>> -               len = MAX_RW_COUNT;
>>>>>         if (unlikely(!access_ok(buf, len)))
>>>>>                 return -EFAULT;
>>>>> +       if (len > MAX_RW_COUNT)
>>>>> +               len = MAX_RW_COUNT;
>>>>>
>>>>>         iov_iter_ubuf(i, rw, buf, len);
>>>>>         return 0;
>>>>>
>>>>> Jens A., Al Viro,
>>>>>
>>>>> Was there any particular reason which I am unaware of to perform
>>>>> access_ok() check on modified input length?
>>>>
>>>> This change makes sense to me, and seems consistent with what is done
>>>> elsewhere too.
>>>
>>> For some reason I missed import_single_range(), which does it the same
>>> way as import_ubuf() currently does - cap the range before the
>>> access_ok() check. The vec variants sum as they go, but access_ok()
>>> before the range.
>>>
>>> I think part of the issue here is that the single range imports return 0
>>> for success and -ERROR otherwise. This means that the caller does not
>>> know if the full range was imported or not. OTOH, we always cap any data
>>> transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
>>> here.
>>>
>>
>> Should we limit to MAX_RW_COUNT or return an error?
>> Seems to me that limiting could generate side effect later that could be not
>> simple to debug.
>>
>>
>>>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>>>>  {
>>>>> -       if (len > MAX_RW_COUNT)
>>>>> +               return -EFAULT;
>>>>>         if (unlikely(!access_ok(buf, len)))
>>>>>                 return -EFAULT;
>>>>>
>>>>>         iov_iter_ubuf(i, rw, buf, len);
>>>>>         return 0;
>>
>> or perhaps just remove the test as __access_ok() already tests that the
>> size < TASK_SIZE
>>
>> https://elixir.bootlin.com/linux/v6.7-rc4/source/include/asm-generic/access_ok.h#L31
>>
> 
> It looks like there are predefined constraints for using import_ubuf()
> which doesn't properly match our needs. So let's directly use:
> iov_iter_ubuf() instead.

Yes, this seems a safer alternative. I will send a new version based on it.

Thanks,
Arnaud

> 
> -Sumit
> 
>>
>> Thanks,
>> Arnaud
>>
