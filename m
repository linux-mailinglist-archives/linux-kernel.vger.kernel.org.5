Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139077E8173
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbjKJS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbjKJSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:25:45 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3F72A8;
        Thu,  9 Nov 2023 22:29:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FB5467373; Fri, 10 Nov 2023 07:29:44 +0100 (CET)
Date:   Fri, 10 Nov 2023 07:29:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, axboe@kernel.dk,
        kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231110062944.GC26516@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-22-john.g.garry@oracle.com> <20231109153603.GA2188@lst.de> <ZUz98KriiLsM8oQd@casper.infradead.org> <20231109154619.GA3491@lst.de> <61b25fe8-22ae-c299-3225-ca835b337d41@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b25fe8-22ae-c299-3225-ca835b337d41@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 07:08:40PM +0000, John Garry wrote:
>>> send a write that crossed the atomic write limit, but the drive wouldn't
>>> guarantee that it was atomic except at the atomic write boundary.
>>> Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
>>> into a single 80kB write, and if the power failed midway through, the
>>> drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
>>> all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
>>> 64-80kB and not the other three.
>
> I didn't think that there are any atomic write guarantees at all if we ever 
> exceed AWUN or AWUPF or cross the atomic write boundary (if any).

You're quoting a few mails before me, but I agree.

>> I can see some use for that, but I'm really worried that debugging
>> problems in the I/O merging and splitting will be absolute hell.
>
> Even if bios were merged for NVMe the total request length still should not 
> exceed AWUPF. However a check can be added to ensure this for a submitted 
> atomic write request.

Yes.

> As for splitting, it is not permitted for atomic writes and only a single 
> bio is permitted to be created per write. Are more integrity checks 
> required?

I'm more worried about the problem where we accidentally add a split.
The whole bio merge/split path is convoluted and we had plenty of
bugs in the past by not looking at all the correct flags or opcodes.
