Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7477E8080E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjLGGlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjLGGk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:40:59 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C6C137;
        Wed,  6 Dec 2023 22:41:04 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sm4KZ5VHWz14LrF;
        Thu,  7 Dec 2023 14:36:02 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 14:41:01 +0800
Message-ID: <fb79e430-97fb-176e-fc64-2c32a9d8a94f@huawei.com>
Date:   Thu, 7 Dec 2023 14:41:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <willy@infradead.org>, <akpm@linux-foundation.org>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <20231205041755.GG509422@mit.edu>
 <cda525e9-0dac-9629-9c8e-d69d22811777@huawei.com>
 <20231206215529.GK509422@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231206215529.GK509422@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/7 5:55, Theodore Ts'o wrote:
> On Tue, Dec 05, 2023 at 09:19:03PM +0800, Baokun Li wrote:
>> Thank you very much for your detailed explanation!
>> But the downstream users do have buffered reads to read the relay log
>> file, as I confirmed with bpftrace. Here's an introduction to turning on
>> relay logging, but I'm not sure if you can access this link:
>> https://blog.csdn.net/javaanddonet/article/details/112596148
> Well, if a mysql-supplied program is trying read the relay log using a
> buffered read, when it's being written using Direct I/O, that's a bug
> in mysql, and it should be reported as such to the mysql folks.
I was mistaken here, it now looks like reads and writes to the relay
log are buffered IO, and I'm still trying to locate the issue.
>
> It does look like there is a newer way of doing replication which
> doesn't rely on messign with log files.   From:
>
>      https://dev.mysql.com/doc/refman/8.0/en/replication.html
>
>      MySQL 8.0 supports different methods of replication. The
>      traditional method is based on replicating events from the
>      source's binary log, and requires the log files and positions in
>      them to be synchronized between source and replica. The newer
>      method based on global transaction identifiers (GTIDs) is
>      transactional and therefore does not require working with log
>      files or positions within these files, which greatly simplifies
>      many common replication tasks. Replication using GTIDs guarantees
>      consistency between source and replica as long as all transactions
>      committed on the source have also been applied on the replica. For
>      more information about GTIDs and GTID-based replication in MySQL,
>      see Section 17.1.3, “Replication with Global Transaction
>      Identifiers”. For information on using binary log file position
>      based replication, see Section 17.1, “Configuring Replication”.
>
> Perhaps you can try and see how mysql handles GTID-based replication
> using bpftrace?
>
> Cheers,
>
> 						- Ted
Thank you very much for your solution! I'll try it.

Thanks!
-- 
With Best Regards,
Baokun Li
.
