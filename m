Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FC8792A90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbjIEQja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353629AbjIEG5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:57:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C9CC2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 23:57:43 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rfx9H0WV7zrSc9;
        Tue,  5 Sep 2023 14:55:47 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 14:57:33 +0800
Message-ID: <60f989f0-cfe2-61b5-5f5c-afe9584d8755@huawei.com>
Date:   Tue, 5 Sep 2023 14:57:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] mm: memory-failure: use rcu lock instead of
 tasklist_lock when collect_procs()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linmiaohe <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230828022527.241693-1-tongtiangen@huawei.com>
 <20230903164122.fb7148f8004402a7552c3ec6@linux-foundation.org>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20230903164122.fb7148f8004402a7552c3ec6@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/4 7:41, Andrew Morton 写道:
> On Mon, 28 Aug 2023 10:25:27 +0800 Tong Tiangen <tongtiangen@huawei.com> wrote:
> 
>> We found a softlock issue in our test, analyzed the logs, and found that
>> the relevant CPU call trace as follows:
>>
>> ...
>>
>> By removing the use of tasklist_lock in task list iteration, we can break
>> the softlock chain above.
>>
> 
> So I assume we'd like to backport this fix into -stable kernels?
> 
> If so, are we able to identify a suitble Fixes: target?
> .

After checking the git logs of these functions, the lock-related code
line is available when the functions are first introduced, as follows:

	copy_process(): kernel/fork.c
		commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (tag: v2.6.12-rc2)
		Author: Linus Torvalds <torvalds@ppc970.osdl.org>
		Date:   Sat Apr 16 15:20:36 2005 -0700
		
			Linux-2.6.12-rc2
		
	wp_page_copy(): mm/memory.c
		commit 2f38ab2c3c7fef04dca0313fd89d91f142ca9281
		Author: Shachar Raindel <raindel@mellanox.com>
		Date:   Tue Apr 14 15:46:32 2015 -0700
		
			mm: refactor do_wp_page, extract the page copy flow
		
	pte_offset_map_lock: include/linux/mm.hq	
		commit c74df32c724a1652ad8399b4891bb02c9d43743a
		Author: Hugh Dickins <hugh@veritas.com>
		Date:   Sat Oct 29 18:16:23 2005 -0700
		
			[PATCH] mm: ptd_alloc take ptlock
	
	collect_procs_anon(): mm/memory-failure.c
		commit 6a46079cf57a7f7758e8b926980a4f852f89b34d
		Author: Andi Kleen <andi@firstfloor.org>
		Date:   Wed Sep 16 11:50:15 2009 +0200
			HWPOISON: The high level memory error handler in the VM v7

Is it appropriate to use the commit of the last introduction 
function(wp_page_copy())?
	Fixes: 2f38ab2c3c7f ("refactor do_wp_page, extract the page copy flow")

Or use the commit introduced by the error reporting 
function(collect_procs_anon())?
	Fixes: 6a46079cf57a ("HWPOISON: The high level memory error handler in 
the VM v7")
