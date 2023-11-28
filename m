Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360607FC1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjK1N4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344863AbjK1N4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:56:19 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F58D1;
        Tue, 28 Nov 2023 05:56:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E6897227A87; Tue, 28 Nov 2023 14:56:19 +0100 (CET)
Date:   Tue, 28 Nov 2023 14:56:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231128135619.GA12202@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com> <20231109152615.GB1521@lst.de> <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com> <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:56:37AM +0000, John Garry wrote:
> Are you suggesting some sort of hybrid between the atomic write series you 
> had a few years ago and this solution?

Very roughly, yes.

> To me that would be continuing with the following:
> - per-IO RWF_ATOMIC (and not O_ATOMIC semantics of nothing is written until 
> some data sync)

Yes.

> - writes must be a power-of-two and at a naturally-aligned offset

Where offset is offset in the file?  It would not require it.  You
probably want to do it for optimal performance, but requiring it
feeels rather limited.

> - relying on atomic write HW support always

And I think that's where we have different opinions.  I think the hw
offload is a nice optimization and we should use it wherever we can.
But building the entire userspace API around it feels like a mistake.

> BTW, we also have rtvol support which does not use forcealign as it already 
> can guarantee alignment, but still does rely on the same principle of 
> requiring alignment - would you want CoW support there also?

Upstream doesn't have out of place write support for the RT subvolume
yet.  But Darrick has a series for it and we're actively working on
upstreaming it.
