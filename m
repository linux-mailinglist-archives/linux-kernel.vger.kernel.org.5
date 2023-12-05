Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE99B8048F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjLEE6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjLEE6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:58:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8AFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 20:58:38 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B54tdZl016948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 23:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1701752144; bh=xY31OtXpm6KSv94nmxlfIijYjDNR0HuHd+Om4l/DRL4=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=ULAuEAImbbRp/EKwZ7vqMIWXT6OjmvjIgkTgGyD2NyabpELmR3xt1M7Wv5tFphTNy
         XiZVg+kRB4tu3DD9cFnL521xALsq037uudWRmRUK7vkgoYcEoqgB+Htr4GUEL0xIyy
         LNPjeRK8WI4kaZRcQ+8btulffIuW+dUqWHrMOgabNvPzMOdbmgmh9p5eHW3WRVb/ep
         Yi7dzwjk72n8SsYenWwqy0BIa468+PEZe3uAIMnixXE8eMy6TAzFNehDAUg68SjnCk
         /52qTNwdL2JoY1vDMEizYdaR4Y9c40vZA++hZxVi6HpdiFL1SvlEc/7gPguBe1Lv+1
         /K1ac43DNI/4Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 626A415C02E0; Mon,  4 Dec 2023 23:55:39 -0500 (EST)
Date:   Mon, 4 Dec 2023 23:55:39 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231205045539.GH509422@mit.edu>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-18-john.g.garry@oracle.com>
 <20231109152615.GB1521@lst.de>
 <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
 <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
 <20231128135619.GA12202@lst.de>
 <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
 <20231204134509.GA25834@lst.de>
 <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:19:15PM +0000, John Garry wrote:
> > 
> > What is the 'dubious amazon torn-write prevention'?
> 
> https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage-twp.html
> 
> AFAICS, this is without any kernel changes, so no guarantee of unwanted
> splitting or merging of bios.

Well, more than one company has audited the kernel paths, and it turns
out that for selected Kernel versions, after doing desk-check
verification of the relevant kernel baths, as well as experimental
verification via testing to try to find torn writes in the kernel, we
can make it safe for specific kernel versions which might be used in
hosted MySQL instances where we control the kernel, the mysql server,
and the emulated block device (and we know the database is doing
Direct I/O writes --- this won't work for PostgreSQL).  I gave a talk
about this at Google I/O Next '18, five years ago[1].

[1] https://www.youtube.com/watch?v=gIeuiGg-_iw

Given the performance gains (see the talk (see the comparison of the
at time 19:31 and at 29:57) --- it's quite compelling. 

Of course, I wouldn't recommend this approach for a naive sysadmin,
since most database adminsitrators won't know how to audit kernel code
(see the discussion at time 35:10 of the video), and reverify the
entire software stack before every kernel upgrade.  The challenge is
how to do this safely.

The fact remains that both Amazon's EBS and Google's Persistent Disk
products are implemented in such a way that writes will not be torn
below the virtual machine, and the guarantees are in fact quite a bit
stronger than what we will probably end up advertising via NVMe and/or
SCSI.  It wouldn't surprise me if this is the case (or could be made
to be the case) For Oracle Cloud as well.

The question is how to make this guarantee so that the kernel knows
when various cloud-provided block devicse do provide these greater
guarantees, and then how to make it be an architected feature, as
opposed to a happy implementation detail that has to be verified at
every kernel upgrade.

Cheers,

						- Ted
