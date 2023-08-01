Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECF676B2C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjHALKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjHALKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:10:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215B84ED2;
        Tue,  1 Aug 2023 04:04:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2FAC56732D; Tue,  1 Aug 2023 13:04:32 +0200 (CEST)
Date:   Tue, 1 Aug 2023 13:04:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, chengming.zhou@linux.dev,
        axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH v2 1/4] blk-flush: flush_rq should inherit first_rq's
 cmd_flags
Message-ID: <20230801110432.GA2781@lst.de>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev> <20230725130102.3030032-2-chengming.zhou@linux.dev> <20230731060957.GA30409@lst.de> <de6ba52c-0f14-670f-7262-93f2aced926a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6ba52c-0f14-670f-7262-93f2aced926a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:28:01PM +0200, Hannes Reinecke wrote:
> The flush machinery is sending flushes before and/or after the original 
> request (preflush/postflush). For blocked transports (ie during FC RSCN 
> handling) the transport will error out commands depending on the FAILFAST 
> setting. If FAILFAST is set the SCSI layer gets an STS_TRANSPORT error 
> (causing the I/O to be retried), but STS_ERROR if not set (causing I/O to 
> failed).
>
> So if the FAILFAST setting is _not_ aligned between flush_rq and the 
> original we'll get an error on the flush rq and a retry on the original rq, 
> causing the entire command to fail.
>
> I guess we need to align them.

But you can't, because multiple pre/postflushes are coalesced into a
single outstanding flush request.  They can and will not match quite
commonly.
