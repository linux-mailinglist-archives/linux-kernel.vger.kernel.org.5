Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323307CEDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjJSCRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjJSCRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:17:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D99B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:17:06 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9rnt6YvbzvQ0V;
        Thu, 19 Oct 2023 10:12:18 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 10:17:04 +0800
Message-ID: <22acc5a1-39a7-4a44-b468-429f1ca23b5c@huawei.com>
Date:   Thu, 19 Oct 2023 10:17:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm/khugepaged: Convert collapse_pte_mapped_thp()
 to use folios
Content-Language: en-US
To:     Vishal Moola <vishal.moola@gmail.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <shy828301@gmail.com>
References: <20231018203213.50224-1-vishal.moola@gmail.com>
 <20231018203213.50224-6-vishal.moola@gmail.com> <ZTBjv4jyQ5/zu5cw@fedora>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZTBjv4jyQ5/zu5cw@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/19 7:01, Vishal Moola wrote:
> On Wed, Oct 18, 2023 at 01:32:13PM -0700, Vishal Moola (Oracle) wrote:
>> This removes 2 calls to compound_head() and helps convert khugepaged to
>> use folios throughout.
>>
>> Previously, if the address passed to collapse_pte_mapped_thp()
>> corresponded to a tail page, the scan would fail immediately. Using
>> filemap_lock_folio() we can get the corresponding folio back and try to
>> operate on the folio instead.
>>
>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> 
> Hi Andrew, I've attached a fix patch addressing the syzbot issue.
> It can be squashed into this patch, syzbot tested it on v2 already as
> well.

Hi Vishal, only IS_ERR(folio) is enough since filemap_lock_folio won't 
return NULL.
