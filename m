Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36C78A4AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjH1Ch0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjH1ChC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:37:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC1F9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 19:36:59 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RYvkg6PkyzJrlg;
        Mon, 28 Aug 2023 10:33:47 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 28 Aug 2023 10:36:57 +0800
Message-ID: <ce28f147-8c97-36d9-3b5a-bb7a1ac3130f@huawei.com>
Date:   Mon, 28 Aug 2023 10:36:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230821091312.2034844-1-tongtiangen@huawei.com>
 <ZOOt6S+I9ywyNQjP@casper.infradead.org>
 <0bbbb7d8-699b-30ac-9657-840112c41a78@huawei.com>
 <ZOSlVGxcxT9JLoUv@casper.infradead.org>
 <20230825060221.GA3948311@ik1-406-35019.vs.sakura.ne.jp>
 <9e205429-1f27-4d18-faca-8a4fe9d429e3@huawei.com>
 <ZOpgXCAAz7PAxT7b@casper.infradead.org>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <ZOpgXCAAz7PAxT7b@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/27 4:28, Matthew Wilcox 写道:
> On Sat, Aug 26, 2023 at 09:46:53AM +0800, Tong Tiangen wrote:
>> " the ``task_struct`` object is freed only after one or more
>> grace periods elapse, with the help of call_rcu(), which is invoked via
>> put_task_struct_rcu_user(). "
>>
>> Combined with the code,when the task exits：
>>
>> release_task()
>> 	__exit_signal()
>> 		__unhash_process()
>> 			list_del_rcu(&p->tasks)
>> 	
>> 	put_task_struct_rcu_user()
>> 		call_rcu(&task->rcu, delayed_put_task_struct);
>> 			
>> delayed_put_task_struct()
>> 	put_task_struct()
>> 		if (refcount_sub_and_test(nr, &t->usage))
>> 			__put_task_struct()
>> 				free_task()
>> 	
>> The code is consistent with the description in the document.
>>
>> According to this understanding, i think for_each_process() under the
>> protection of rcu locl is safe, that is, task_struct in the list will not be
>> destroyed, and get_task_struct() is also safe.
> 
> Aha!  This is different from the usual pattern.  What I'm used to seeing
> is:
> 
> if (refcount_sub_and_test()) {
> 	list_del_rcu();
> 	rcu_free();
> }
> 
> and then on the read side you need a refcount_inc_not_zero(), which we
> didn't have here.  Given this new information you've found, I withdraw
> my objection.  It'd be nice to include some of this analysis in an
> updated changelog (and maybe improved documentation for tasklist?).

OK, commit message and changelog have been updated, and a new patch 
version v3 has been sent.

Thanks,
Tong.

> 
> .
