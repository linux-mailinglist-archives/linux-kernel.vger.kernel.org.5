Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3120807AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377418AbjLFV4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377501AbjLFV4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:56:03 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC3D5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:56:10 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-122-214.bstnma.fios.verizon.net [173.48.122.214])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B6LtTXD027632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 16:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1701899732; bh=/7ZJSSTMxPqENXQP9mS+r24/FmYE5UmiqpIimksAM+4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=VpqBDJ31l4kNlgq06ADF3MorBzkDiJiBFy1L2qe+RuVQX+gdSbBPZFoc9TKp1X+c9
         f2Pn2b68MCJJNOLAJaz3SpEZHeR7+AbZLdTiVDYpR2FA7J03/4jsz6Px4d87Q8F54G
         GjEnMN+xvLTFDPJF1LOOE7HXfGjJNaue20Cr/PIzpoR/8znfIsMcdA4bvzxnlxX6DP
         savcig+eBkWNj2D6T+3E7mYtTiKo7/iKe+Hirv6T5fQJPM8BGAv0cFFQ6mYud82zKT
         t5AnVRBSyrq/Z2xdjpLPHw2KRvZw5/+3GuxOQKp0B0IMovT6bMl73p09jbFrtllaga
         05aRnThSHFqTA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 38F7315C057B; Wed,  6 Dec 2023 16:55:29 -0500 (EST)
Date:   Wed, 6 Dec 2023 16:55:29 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        willy@infradead.org, akpm@linux-foundation.org,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <20231206215529.GK509422@mit.edu>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <20231205041755.GG509422@mit.edu>
 <cda525e9-0dac-9629-9c8e-d69d22811777@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cda525e9-0dac-9629-9c8e-d69d22811777@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:19:03PM +0800, Baokun Li wrote:
> Thank you very much for your detailed explanation!
> But the downstream users do have buffered reads to read the relay log
> file, as I confirmed with bpftrace. Here's an introduction to turning on
> relay logging, but I'm not sure if you can access this link:
> https://blog.csdn.net/javaanddonet/article/details/112596148

Well, if a mysql-supplied program is trying read the relay log using a
buffered read, when it's being written using Direct I/O, that's a bug
in mysql, and it should be reported as such to the mysql folks.

It does look like there is a newer way of doing replication which
doesn't rely on messign with log files.   From:

    https://dev.mysql.com/doc/refman/8.0/en/replication.html

    MySQL 8.0 supports different methods of replication. The
    traditional method is based on replicating events from the
    source's binary log, and requires the log files and positions in
    them to be synchronized between source and replica. The newer
    method based on global transaction identifiers (GTIDs) is
    transactional and therefore does not require working with log
    files or positions within these files, which greatly simplifies
    many common replication tasks. Replication using GTIDs guarantees
    consistency between source and replica as long as all transactions
    committed on the source have also been applied on the replica. For
    more information about GTIDs and GTID-based replication in MySQL,
    see Section 17.1.3, “Replication with Global Transaction
    Identifiers”. For information on using binary log file position
    based replication, see Section 17.1, “Configuring Replication”.

Perhaps you can try and see how mysql handles GTID-based replication
using bpftrace?

Cheers,

						- Ted
