Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E567F6A84
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjKXCEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjKXCEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:04:32 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C11708
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:04:06 -0800 (PST)
Received: from kwepemm000020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SbyvD4YXCzvR5d;
        Fri, 24 Nov 2023 10:03:36 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm000020.china.huawei.com (7.193.23.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 10:04:01 +0800
Message-ID: <e41dff89-9fc0-66ca-3156-9d61dbc3d92d@huawei.com>
Date:   Fri, 24 Nov 2023 10:04:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Huang, Ying" <ying.huang@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <fengwei.yin@intel.com>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
 <87a5r4988r.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <5b0e168a-dd43-80d4-2eeb-5c8a5d470f5e@huawei.com>
 <ZV9wt4+F/soWxVhR@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZV9wt4+F/soWxVhR@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000020.china.huawei.com (7.193.23.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/23 23:33, Matthew Wilcox wrote:

> On Thu, Nov 23, 2023 at 05:09:04PM +0800, zhangpeng (AS) wrote:
>>>> +		pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>>> +						  vmf->address, &vmf->ptl);
>>>> +		if (ptep) {
>>>> +			/*
>>>> +			 * Recheck pte with ptl locked as the pte can be cleared
>>>> +			 * temporarily during a read/modify/write update.
>>>> +			 */
>>>> +			if (unlikely(!pte_none(ptep_get(ptep))))
>>>> +				ret = VM_FAULT_NOPAGE;
>>>> +			pte_unmap_unlock(ptep, vmf->ptl);
>>>> +			if (unlikely(ret))
>>>> +				return ret;
>>>> +		}
>>>> +
>>> Need to deal with ptep == NULL.  Although that is high impossible.
>> If ptep == NULL, we may just need to return VM_FAULT_SIGBUS.
>> I'll add it in the next version.
> no?  wouldn't ptep being NULL mean that the ptep has been replaced with
> a PMD entry, and thus should return NOPAGE?

Yes, ptep == NULL means that the ptep has been replaced with a PMD entry.
I'll add return NOPAGE in the next version.

Thanks!

-- 
Best Regards,
Peng

