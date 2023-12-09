Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAA80B385
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjLIKFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIKFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:05:13 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415210EF;
        Sat,  9 Dec 2023 02:05:18 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SnNt20MXjzYcmL;
        Sat,  9 Dec 2023 18:05:14 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 9 Dec 2023 18:05:15 +0800
Message-ID: <e39845b3-e9b4-6ad3-4c53-402628471bcc@huawei.com>
Date:   Sat, 9 Dec 2023 18:05:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: divide error in mb_update_avg_fragment_size
Content-Language: en-US
To:     xingwei lee <xrivendell7@gmail.com>, <harperchen1110@gmail.com>
CC:     <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <syzkaller@googlegroups.com>, <tytso@mit.edu>,
        Baokun Li <libaokun1@huawei.com>,
        yangerkun <yangerkun@huawei.com>
References: <CABOYnLwVDrhLB6yqqDgS7xixzo-OA=ZcJwBDoMPeQDMiFR7scA@mail.gmail.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CABOYnLwVDrhLB6yqqDgS7xixzo-OA=ZcJwBDoMPeQDMiFR7scA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/8 22:12, xingwei lee wrote:
> Hello I saw you can't reproduce this bug and I reproduce it with
> repro.c and repro.txt
> I test the repro.c in the lastest HEAD: 5e3f5b81de80c98338bcb47c233aebefee5a4801
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=6ae1a4ee971a7305
> and the bug also existed.

Hello xingwei!

Thanks for the reproducer!

The problem is that the same range of physical blocks are freed in
ext4_mb_release_inode_pa() and ext4_process_freed_data() successively.
Thus in mb_free_blocks() bb_free is added twice, while bb_fragments
is added only once, the second time exiting early due to checking
for release of already freed blocks. So when fstrim marks all the
blocks in the group as already used, bb_free not being 0 and
bb_fragments being 0 triggers a divide-by-zero problem in
mb_update_avg_fragment_size().

We should avoid freeing blocks in ext4_mb_release_inode_pa() that
are about to be freed in ext4_process_freed_data().  I will send out
a patch after doing some tests.

Cheers!
-- 
With Best Regards,
Baokun Li
.
