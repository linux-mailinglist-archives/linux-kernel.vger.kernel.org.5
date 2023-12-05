Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878288055B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbjLENTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbjLENTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:19:01 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44138197;
        Tue,  5 Dec 2023 05:19:06 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sl1Fp4YsBz14L97;
        Tue,  5 Dec 2023 21:14:06 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 21:19:03 +0800
Message-ID: <cda525e9-0dac-9629-9c8e-d69d22811777@huawei.com>
Date:   Tue, 5 Dec 2023 21:19:03 +0800
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
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231205041755.GG509422@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2023/12/5 12:17, Theodore Ts'o wrote:
> On Mon, Dec 04, 2023 at 09:50:18PM +0800, Baokun Li wrote:
>> The problem is with a one-master-twoslave MYSQL database with three
>> physical machines, and using sysbench pressure testing on each of the
>> three machines, the problem occurs about once every two to three hours.
>>
>> The problem is with the relay log file, and when the problem occurs,
>> the middle dozens of bytes of the file are read as all zeros, while
>> the data on disk is not. This is a journal-like file where a write
>> process gets the data from the master node and writes it locally,
>> and another replay process reads the file and performs the replay
>> operation accordingly (some SQL statements).  The problem is that
>> when replaying, it finds that the data read is corrupted, not valid
>> SQL data, while the data on disk is normal.
> You mentioned "scripts" --- are these locally developped scripts by
> any chance?
This refers to the sql commands to be replayed in the relay log file.
  I don't know much about this file, but you can read the official
documentation.
https://dev.mysql.com/doc/refman/8.0/en/replica-logs-relaylog.html
> The procedure suggested in a few places that I looked up
> don't involve needing to read the replay log.   For example from[1]:
>
> On the master server:
>
> root@repl-master:~# mysql -uroot -p;
> mysql> CREATE USER ‘slave’@’12.34.56.789‘ IDENTIFIED BY ‘SLAVE_PASSWORD‘;
> mysql> GRANT REPLICATION SLAVE ON . TO ‘slave’@’12.34.56.222 ‘;
> mysql> FLUSH PRIVILEGES;
> mysql> FLUSH TABLES WITH READ LOCK;
>
> This will make the master server read-only, with all pending writes
> flushed out (so you don't need to worry about the replay log), and
> then you move the data from the master to slave:
>
> root@repl-master:~# mysqldump -u root -p –all-databases –master-data > data.sql
> root@repl-master:~# scp data.sql root@12.34.56.222
>
> Then on the slave:
>
> root@repl-slave:~# mysql -uroot -p < data.sql
> root@repl-slave:~# mysql -uroot -p;
> mysql> STOP SLAVE;
>
> ... and then on the master:
>
> root@repl-master:~# mysql -uroot -p;
> mysql> UNLOCK TABLES;
>
> ... and back on the slave:
>
> root@repl-slave:~# mysql -uroot -p;
> mysql> START SLAVE;
>
> [1] https://hevodata.com/learn/mysql-master-slave-replication/
>
> ... or you could buy the product advertised at [1] which is easier for
> the database administrators, but results in $$$ flowing to the Hevo
> company.  :-)
>
> In any case, I'm pretty sure that the official documented way of
> setting up a failover replication setup doesn't involve buffered reads
> of the replay file.
>
> It is certainly the case that mysqldump uses buffered reads, but
> that's why you have to temporary make the database read-only using
> "FLUSH TABLES WITH READ LOCK" before taking a database snapshot, and
> then re-enable database updates the "UNLOCK TABLES" SQL commands.
>
> Cheers,
>
> 					- Ted
Thank you very much for your detailed explanation!
But the downstream users do have buffered reads to read the relay log
file, as I confirmed with bpftrace. Here's an introduction to turning on
relay logging, but I'm not sure if you can access this link:
https://blog.csdn.net/javaanddonet/article/details/112596148

Thanks!
-- 
With Best Regards,
Baokun Li
.
