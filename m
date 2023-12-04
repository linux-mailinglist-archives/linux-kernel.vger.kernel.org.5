Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED48803B11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjLDRCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLDRCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:02:39 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D6B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:02:45 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3B4Bnm3I027658;
        Mon, 4 Dec 2023 18:02:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=WQKPT/9MbLKDIXnkNmjJg5GFttYLgVQHEvKahTCagBk=; b=GK
        8LMuOv9RBwxlUOk6/A37nnVxuf4lJRlrChmJnIKDgmGfV2SvlADt180wZ45i3shb
        SEtM+gT9SOPvcNl09SbgUo79fO1/8WbzXoDYZ8vhdAxpKAkQkpqmZktOL1tC/zeP
        YxVzivJuQB7R5b5SIee2oAQRH0aqYlSp7mnFxCnzmgtsUgmWdcrGSsTdHzoRHmeT
        G5eJjxGsfEvQEen1BVLev2w3MKBY+xH1skJXFnw2ta195jOKheuI/mc5bfnm7Exd
        K8Z5RGclO2jIqWK7YU83l0M9N8MgVxVlBJWV5sre4hh3VlmI6gsDBNisYpsm6iCt
        d5IEf6OKsm8ughJPFYZg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3urf14xfw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 18:02:32 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A8DBA10008B;
        Mon,  4 Dec 2023 18:02:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3A2026029D;
        Mon,  4 Dec 2023 18:02:29 +0100 (CET)
Received: from [10.201.20.163] (10.201.20.163) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Dec
 2023 18:02:29 +0100
Message-ID: <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
Date:   Mon, 4 Dec 2023 18:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer
 registration
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Sumit Garg <sumit.garg@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
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
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.163]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_16,2023-12-04_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/23 17:40, Jens Axboe wrote:
> On 12/4/23 9:36 AM, Jens Axboe wrote:
>> On 12/4/23 5:42 AM, Sumit Garg wrote:
>>> IMO, access_ok() should be the first thing that import_ubuf() or
>>> import_single_range() should do, something as follows:
>>>
>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>> index 8ff6824a1005..4aee0371824c 100644
>>> --- a/lib/iov_iter.c
>>> +++ b/lib/iov_iter.c
>>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>>
>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>>  {
>>> -       if (len > MAX_RW_COUNT)
>>> -               len = MAX_RW_COUNT;
>>>         if (unlikely(!access_ok(buf, len)))
>>>                 return -EFAULT;
>>> +       if (len > MAX_RW_COUNT)
>>> +               len = MAX_RW_COUNT;
>>>
>>>         iov_iter_ubuf(i, rw, buf, len);
>>>         return 0;
>>>
>>> Jens A., Al Viro,
>>>
>>> Was there any particular reason which I am unaware of to perform
>>> access_ok() check on modified input length?
>>
>> This change makes sense to me, and seems consistent with what is done
>> elsewhere too.
> 
> For some reason I missed import_single_range(), which does it the same
> way as import_ubuf() currently does - cap the range before the
> access_ok() check. The vec variants sum as they go, but access_ok()
> before the range.
> 
> I think part of the issue here is that the single range imports return 0
> for success and -ERROR otherwise. This means that the caller does not
> know if the full range was imported or not. OTOH, we always cap any data
> transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
> here.
> 

Should we limit to MAX_RW_COUNT or return an error?
Seems to me that limiting could generate side effect later that could be not
simple to debug.


>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>>  {
>>> -       if (len > MAX_RW_COUNT)
>>> +               return -EFAULT;
>>>         if (unlikely(!access_ok(buf, len)))
>>>                 return -EFAULT;
>>>
>>>         iov_iter_ubuf(i, rw, buf, len);
>>>         return 0;

or perhaps just remove the test as __access_ok() already tests that the
size < TASK_SIZE

https://elixir.bootlin.com/linux/v6.7-rc4/source/include/asm-generic/access_ok.h#L31


Thanks,
Arnaud

