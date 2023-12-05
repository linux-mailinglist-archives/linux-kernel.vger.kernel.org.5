Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF26880487C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjLEESe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:18:33 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32988FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 20:18:39 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B54HtgF018973
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 23:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1701749878; bh=1o/bCjAzFZcpDU/Upo0AbbDspDxX8m5wngzphZwiRqg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=H10iMOp8jBXz1T7Z61RNNYKslJY5CKV5RMwsoIj9e4TDGASxctktv/iVv1QW+BMvg
         jQYPIMpSWDkg5pI3OUhDZ2D/x9DU3kGX4qchiwQESXfI+wH0bVaYmVZVXQscdAhF2T
         K1gjb9tWQCZf7J6pSjyu1A1wusFlDSDQUU+Svs2Il1zhQL1dQwOtQQ1smqxSFW6M6P
         L78KDa/yQf1CX+O+KObZBDCazLk9OX7LNf5kl7DDXy7S5qY7fIPRJUcYTQ4lpWF0RI
         h8AsQD/KUSnXWP1QznGiyfYHvtfDH25SzYXXmUupfpr3QvdKarrD/9RpALMnH60HiK
         IDsfhqCNUNdcA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5294A15C02E0; Mon,  4 Dec 2023 23:17:55 -0500 (EST)
Date:   Mon, 4 Dec 2023 23:17:55 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        willy@infradead.org, akpm@linux-foundation.org,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <20231205041755.GG509422@mit.edu>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 09:50:18PM +0800, Baokun Li wrote:
> The problem is with a one-master-twoslave MYSQL database with three
> physical machines, and using sysbench pressure testing on each of the
> three machines, the problem occurs about once every two to three hours.
> 
> The problem is with the relay log file, and when the problem occurs,
> the middle dozens of bytes of the file are read as all zeros, while
> the data on disk is not. This is a journal-like file where a write
> process gets the data from the master node and writes it locally,
> and another replay process reads the file and performs the replay
> operation accordingly (some SQL statements).  The problem is that
> when replaying, it finds that the data read is corrupted, not valid
> SQL data, while the data on disk is normal.

You mentioned "scripts" --- are these locally developped scripts by
any chance?  The procedure suggested in a few places that I looked up
don't involve needing to read the replay log.   For example from[1]:

On the master server:

root@repl-master:~# mysql -uroot -p;
mysql> CREATE USER ‘slave’@’12.34.56.789‘ IDENTIFIED BY ‘SLAVE_PASSWORD‘;
mysql> GRANT REPLICATION SLAVE ON . TO ‘slave’@’12.34.56.222 ‘;
mysql> FLUSH PRIVILEGES;
mysql> FLUSH TABLES WITH READ LOCK;

This will make the master server read-only, with all pending writes
flushed out (so you don't need to worry about the replay log), and
then you move the data from the master to slave:

root@repl-master:~# mysqldump -u root -p –all-databases –master-data > data.sql
root@repl-master:~# scp data.sql root@12.34.56.222

Then on the slave:

root@repl-slave:~# mysql -uroot -p < data.sql
root@repl-slave:~# mysql -uroot -p;
mysql> STOP SLAVE;

... and then on the master:

root@repl-master:~# mysql -uroot -p;
mysql> UNLOCK TABLES;

... and back on the slave:

root@repl-slave:~# mysql -uroot -p;
mysql> START SLAVE;

[1] https://hevodata.com/learn/mysql-master-slave-replication/

... or you could buy the product advertised at [1] which is easier for
the database administrators, but results in $$$ flowing to the Hevo
company.  :-)

In any case, I'm pretty sure that the official documented way of
setting up a failover replication setup doesn't involve buffered reads
of the replay file.

It is certainly the case that mysqldump uses buffered reads, but
that's why you have to temporary make the database read-only using
"FLUSH TABLES WITH READ LOCK" before taking a database snapshot, and
then re-enable database updates the "UNLOCK TABLES" SQL commands.

Cheers,

					- Ted
