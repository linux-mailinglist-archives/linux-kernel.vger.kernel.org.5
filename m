Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008037B1051
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjI1BWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:22:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA14B3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 18:22:31 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RwwcQ1vsHzVlFv;
        Thu, 28 Sep 2023 09:19:18 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 28 Sep 2023 09:22:27 +0800
Subject: Re: [PATCH 2/3] mm/kmemleak: fix partially freeing unknown object
 warning
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20230927035923.1425340-1-liushixin2@huawei.com>
 <20230927035923.1425340-3-liushixin2@huawei.com> <ZRRhDgR/SIxbOCDk@arm.com>
CC:     Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <0d54b2b9-07f9-965f-b2b7-50139f39b459@huawei.com>
Date:   Thu, 28 Sep 2023 09:22:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <ZRRhDgR/SIxbOCDk@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/28 1:06, Catalin Marinas wrote:
> On Wed, Sep 27, 2023 at 11:59:22AM +0800, Liu Shixin wrote:
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index 54c2c90d3abc..5a2bbd85df57 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -208,6 +208,8 @@ static struct rb_root object_tree_root = RB_ROOT;
>>  static struct rb_root object_phys_tree_root = RB_ROOT;
>>  /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
>>  static DEFINE_RAW_SPINLOCK(kmemleak_lock);
>> +/* Serial delete_object_part() to ensure all objects is deleted correctly */
>> +static DEFINE_RAW_SPINLOCK(delete_object_part_mutex);
> Don't call this mutex, it implies sleeping.
Sorry, I used to define it as a mutex lock and forgot to change it.
>
>>  
>>  /* allocation caches for kmemleak internal data */
>>  static struct kmem_cache *object_cache;
>> @@ -784,13 +786,16 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
>>  {
>>  	struct kmemleak_object *object;
>>  	unsigned long start, end;
>> +	unsigned long flags;
>>  
>> +	raw_spin_lock_irqsave(&delete_object_part_mutex, flags);
>>  	object = find_and_remove_object(ptr, 1, is_phys);
>>  	if (!object) {
>>  #ifdef DEBUG
>>  		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
>>  			      ptr, size);
>>  #endif
>> +		raw_spin_unlock_irqrestore(&delete_object_part_mutex, flags);
> I prefer a goto out and a single place for unlocking.
>
> However, we already take the kmemleak_lock in find_and_remove_object().
> So better to open-code that function here and avoid introducing a new
> lock. __create_object() may need a new bool argument, no_lock or
> something. Or just split it into separate functions for allocating the
> kmemleak structure and adding it to the corresponding trees/lists under
> a lock.
>

