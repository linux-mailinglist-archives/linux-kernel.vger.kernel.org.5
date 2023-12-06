Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E87806A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377112AbjLFI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:59:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A91736
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:59:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 161D4227A8E; Wed,  6 Dec 2023 09:59:46 +0100 (CET)
Date:   Wed, 6 Dec 2023 09:59:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 4/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <20231206085945.GC24484@lst.de>
References: <20231206081244.32733-1-dwagner@suse.de> <20231206081244.32733-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206081244.32733-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:12:44AM +0100, Daniel Wagner wrote:
> libnvme is using the sysfs for enumarating the nvme resources. Though
> there are few missing attritbutes in the sysfs. For these libnvme issues
> commands during discovering.
> 
> As the kernel already knows all these attributes and we would like to
> avoid libnvme to issue commands all the time, expose these missing
> attributes.
> 
> The nuse value is updated on request because the nuse is a volatile
> value. Since any user can read the sysfs attribute, a very simple rate
> limit is added (update max every 5 seconds). A more sophisticated update
> strategy can be added later if there is actually a need for it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  drivers/nvme/host/core.c  | 28 ++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h  |  2 ++
>  drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index caa52c2f57c8..e7dd64ee1653 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1663,6 +1663,33 @@ static void nvme_ns_release(struct nvme_ns *ns)
>  	nvme_put_ns(ns);
>  }
>  
> +int nvme_ns_update_nuse(struct nvme_ns_head *head)
> +{
> +	static DEFINE_RATELIMIT_STATE(_rs, 5 * HZ, 1);
> +	struct nvme_id_ns *id;
> +	struct nvme_ns *ns;
> +	int srcu_idx, ret = -EWOULDBLOCK;
> +
> +	if (__ratelimit(&_rs))
> +		return 0;

Can you add a comment on the ratelimiting here?

> +
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	ns = nvme_find_path(head);
> +	if (!ns)
> +		goto out_unlock;
> +
> +	ret = nvme_identify_ns(ns->ctrl, head->ns_id, &id);
> +	if (ret)
> +		goto out_unlock;
> +
> +	head->nuse = le64_to_cpu(id->nuse);

This looks like the wrong thing to do for the non-multipath nodes,
which should be able to go straight to the ns.

I'd move this to sysfs.c, and then do a similar trick to say
nvme_send_pr_command to directly use the ns for the non-multipath
nodes, and do what you're doing here for the multipath nodes.

>  static struct attribute *nvme_ns_id_attrs[] = {

And I duess the _id is not correct now, I'd just drop it.

