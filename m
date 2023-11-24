Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDB87F6D09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbjKXHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbjKXHnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:43:12 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9650DEA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 23:43:18 -0800 (PST)
Received: from kwepemm000020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sc6Kf6NbtzMnNw;
        Fri, 24 Nov 2023 15:38:30 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm000020.china.huawei.com (7.193.23.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 15:43:15 +0800
Message-ID: <87731f92-d3bf-9c21-2adc-ffd023ac6b0e@huawei.com>
Date:   Fri, 24 Nov 2023 15:43:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <fengwei.yin@intel.com>,
        <ying.huang@intel.com>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
 <ZWA9EVlsuHIBi0xb@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZWA9EVlsuHIBi0xb@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000020.china.huawei.com (7.193.23.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/24 14:05, Matthew Wilcox wrote:

> On Wed, Nov 22, 2023 at 10:00:52PM +0800, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>> in application, which leading to an unexpected performance issue[1].
>>
>> This caused by temporarily cleared pte during a read/modify/write update
>> of the pte, eg, do_numa_page()/change_pte_range().
> What I haven't quite understood yet is why we need to set the pte to
> zero on x86 in the specific case of do_numa_page().  I understand that
> ppc needs to.

I'm also curious. Could ptep_modify_prot_start() of other architectures
(except ppc) not clear pte? We are mainly concerned with arm64 and x86.

> Could someone explain why the _default_ definition of
> ptep_modify_prot_start() is not:
>
> +++ b/include/linux/pgtable.h
> @@ -1074,7 +1074,7 @@ static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
>                                             unsigned long addr,
>                                             pte_t *ptep)
>   {
> -       return __ptep_modify_prot_start(vma, addr, ptep);
> +       return *ptep;
>   }
>
>   /*
>
>
-- 
Best Regards,
Peng

