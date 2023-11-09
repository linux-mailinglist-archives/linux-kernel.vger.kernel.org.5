Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC097E6DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343770AbjKIPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjKIPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:45:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0954C07;
        Thu,  9 Nov 2023 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YAvU/H8ewWgtj8+lNR19xNcK269Z+0oH3wD0bk8ZHoo=; b=Rc31F659WDeW93mMNfNBwa+tdF
        uKwVofNS0q2HXkMP46RrMFTXTHha4qswZX/hwdgITzDg3dYgi7sLu7amPuG2nBv0Kf6i3urQ5MnQq
        hJHw22feJPvCysjpzWN9+ZaXes9oAio1bTIDx3bt9xmcKIz5w+UUsXbiM7/6b1JKDDCQfGDogqqg9
        NPb3sreQQcZAF+G2Yc/g1705bZgjnMLJidH45aFxrQMxRAZF20Yd96rPyMngzwmKy0LiGoAQBvlDT
        zK/Vo03uJK1tOnG7QSLRhq0FPmH5tkp/XnKZlIbXSH8owdhmWnwBGsCMqdXlPPCjdcizCHa6+eO4o
        k1pR69pg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r17B2-00838t-P7; Thu, 09 Nov 2023 15:42:40 +0000
Date:   Thu, 9 Nov 2023 15:42:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <ZUz98KriiLsM8oQd@casper.infradead.org>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-22-john.g.garry@oracle.com>
 <20231109153603.GA2188@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109153603.GA2188@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 04:36:03PM +0100, Christoph Hellwig wrote:
> Also I really want a check in the NVMe I/O path that any request
> with the atomic flag set actually adhers to the limits to at least
> partially paper over the annoying lack of a separate write atomic
> command in nvme.

That wasn't the model we had in mind.  In our thinking, it was fine to
send a write that crossed the atomic write limit, but the drive wouldn't
guarantee that it was atomic except at the atomic write boundary.
Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
into a single 80kB write, and if the power failed midway through, the
drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
64-80kB and not the other three.

