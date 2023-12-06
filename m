Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF53806A19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjLFIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLFIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:50:45 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860B21BE5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:50:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE058227A8E; Wed,  6 Dec 2023 09:50:44 +0100 (CET)
Date:   Wed, 6 Dec 2023 09:50:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 2/4] nvme: initialize head before namespace
Message-ID: <20231206085044.GA24484@lst.de>
References: <20231206081244.32733-1-dwagner@suse.de> <20231206081244.32733-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:12:42AM +0100, Daniel Wagner wrote:
> In preparation to use struct nvme_ns_head pointers instead of a struct
> nvme_ns pointers, initialize the head pointer before we create the disk.
> This allows us to attach the head as private data to the disk object.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/core.c | 46 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 900c045fcae0..1fabe1b81de0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3474,10 +3474,11 @@ static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
>  	return ret;
>  }
>  
> -static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
> +static int nvme_init_ns_head(struct nvme_ctrl *ctrl,
> +			     struct nvme_ns_info *info,
> +			     struct nvme_ns_head **head)

Can we just return the head or an ERR_PTR here instead of an additional 
argument?  That would also remove the need for the variable renaming
below.

I'd also rename the function to nvme_find_or_alloc_ns_head if you're at
it.

> +	mutex_lock(&ctrl->subsys->lock);
> +	list_add_tail_rcu(&ns->siblings, &ns->head->list);
> +	mutex_unlock(&ctrl->subsys->lock);

This can't race with someone else adding the ns as all scanning is
from the scan work item.  Maybe ad da comment on why this pattern is
safe?  Because I think it wasn't when the code was originally added..

Otherwise this looks good to me.
