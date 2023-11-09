Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92A7E6E28
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbjKIQD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjKIPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:48:46 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957EF4EF2;
        Thu,  9 Nov 2023 07:46:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB3BF68AA6; Thu,  9 Nov 2023 16:46:19 +0100 (CET)
Date:   Thu, 9 Nov 2023 16:46:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231109154619.GA3491@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-22-john.g.garry@oracle.com> <20231109153603.GA2188@lst.de> <ZUz98KriiLsM8oQd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUz98KriiLsM8oQd@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 03:42:40PM +0000, Matthew Wilcox wrote:
> That wasn't the model we had in mind.  In our thinking, it was fine to
> send a write that crossed the atomic write limit, but the drive wouldn't
> guarantee that it was atomic except at the atomic write boundary.
> Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
> into a single 80kB write, and if the power failed midway through, the
> drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
> all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
> 64-80kB and not the other three.

I can see some use for that, but I'm really worried that debugging
problems in the I/O merging and splitting will be absolute hell.
