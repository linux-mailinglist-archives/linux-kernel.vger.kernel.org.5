Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACE6802C60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjLDHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjLDHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:51:33 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D02FF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:51:38 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC0DA227A8E; Mon,  4 Dec 2023 08:51:34 +0100 (CET)
Date:   Mon, 4 Dec 2023 08:51:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v2 2/3] nvme: move ns id info to struct nvme_ns_head
Message-ID: <20231204075134.GB29377@lst.de>
References: <20231201092735.28592-1-dwagner@suse.de> <20231201092735.28592-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201092735.28592-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (head) {
>  		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
> -		       ns->disk ? ns->disk->disk_name : "?",
> +		       head->disk ? head->disk->disk_name : "?",
>  		       nvme_get_opcode_str(nr->cmd->common.opcode),
>  		       nr->cmd->common.opcode,
> -		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
> -		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
> +		       (unsigned long long)nvme_sect_to_lba(head, blk_rq_pos(req)),

Please avoid the overly long line here.  Best done by removing the pointless
unsigned long long casts, as u64 is always an unsigned long long in the
kernel these days.

> -			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> -			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> +			u64 slba = nvme_sect_to_lba(head, bio->bi_iter.bi_sector);

Please avoid the overly long line here as well.

> +static void nvme_set_ref_tag(struct nvme_ns_head *head, struct nvme_command *cmnd,

.. and here.  I'm going to stop now, please also fix up all other
places.

>  void nvme_failover_req(struct request *req)
>  {
> -	struct nvme_ns *ns = req->q->queuedata;
> +	struct nvme_ns_head *head = req->q->queuedata;
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> +	struct nvme_ns *ns;
>  	u16 status = nvme_req(req)->status & 0x7ff;
>  	unsigned long flags;
>  	struct bio *bio;
>  
> -	nvme_mpath_clear_current_path(ns);
> +	nvme_mpath_clear_current_path(head);
>  
>  	/*
>  	 * If we got back an ANA error, we know the controller is alive but not
>  	 * ready to serve this namespace.  Kick of a re-read of the ANA
>  	 * information page, and just try any other available path for now.
>  	 */
> -	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
> +	if (nvme_is_ana_error(status) && ctrl->ana_log_buf) {
> +		ns = nvme_find_get_ns(ctrl, head->ns_id);

This looks unrelated.

> -bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> +bool nvme_mpath_clear_current_path(struct nvme_ns_head *head)
>  {
> -	struct nvme_ns_head *head = ns->head;
>  	bool changed = false;
>  	int node;
>  
> @@ -181,7 +183,7 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>  		goto out;
>  
>  	for_each_node(node) {
> -		if (ns == rcu_access_pointer(head->current_path[node])) {
> +		if (head == rcu_access_pointer(head->current_path[node])->head) {

and this can't work.  We need to check the actual ns for the path
selection, as that's kindof the point.

