Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A357C768B93
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGaGKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjGaGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:10:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE0CA;
        Sun, 30 Jul 2023 23:10:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A156E67373; Mon, 31 Jul 2023 08:09:57 +0200 (CEST)
Date:   Mon, 31 Jul 2023 08:09:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, hare@suse.de
Subject: Re: [PATCH v2 1/4] blk-flush: flush_rq should inherit first_rq's
 cmd_flags
Message-ID: <20230731060957.GA30409@lst.de>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev> <20230725130102.3030032-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725130102.3030032-2-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:00:59PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The cmd_flags in blk_kick_flush() should inherit the original request's
> cmd_flags, but the current code looks buggy to me:

Should it?  I know the code is kinda trying to do it, but does it really
make sense?  Adding Hannes who originally added this inheritance and
discussing the details below:

>  	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
> -	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
> +	flush_rq->cmd_flags |= (first_rq->cmd_flags & REQ_DRV) |
> +			       (first_rq->cmd_flags & REQ_FAILFAST_MASK);

Two cases here:

 1) REQ_FAILFAST_MASK:  I don't think this is actually set on flush request
    currently, and even if it was applying it to the flush that serves more
    than a single originating command seems wrong to me.
 2) REQ_DRV is only set by drivers that have seen a bio.  For dm this
    is used as REQ_DM_POLL_LIST which should never be set for a flush/fua
    request.  For nvme-mpath it is REQ_NVME_MPATH, which is set in the
    bio based driver and used for decision making in the I/O completion
    handler.  So I guess this one actually does need to get passed
    through.

