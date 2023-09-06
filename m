Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B157E793AF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjIFLWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjIFLWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:22:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A88A8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:22:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC4FE20292;
        Wed,  6 Sep 2023 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693999348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3kZeIY3o8u5mmImBYMduzAVf4ue8edaI/OH615ksTE=;
        b=mmsdthIdTnsA3CmxvKMMVFKybYYv0KM4KCdKwdB8zzGXYFBcHfhe7GLn/8MVmtGIj5jAeR
        YT4H+Ue2ZXKBGrTlRIUJwEkENcI52tkyiOmZC2bd0aNO9AunxvRrAqGri6oRFlzSYSlVj2
        dvombgBQpMYeBCKZGkiT8fCcg4PDMSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693999348;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3kZeIY3o8u5mmImBYMduzAVf4ue8edaI/OH615ksTE=;
        b=nahEfNuUdeFOoXUsPue5prKLEGyneO1gEzfkJHk7c8qdjnr7oWFRcUEdhgXdEZyAUOEFxv
        ikWCVMAJYM6a8tBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E56A1333E;
        Wed,  6 Sep 2023 11:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 469TJfRg+GRXUAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Sep 2023 11:22:28 +0000
Message-ID: <69c8e29a-cba6-4bd4-adfe-81f507415d5f@suse.de>
Date:   Wed, 6 Sep 2023 13:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 3/4] nvmet-fc: untangle cross refcounting objects
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-4-dwagner@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230829091350.16156-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 11:13, Daniel Wagner wrote:
> Associations take a refcount on queues, queues take a refcount on
> associations.
> 
> The existing code lead to the situation that the target executes a
> disconnect and the host retriggers a reconnect immediately. The
> reconnect command still finds an existing association and uses this.
> Though the reconnect crashes later on because
> nvmet_fc_delete_target_assoc() blindly goes ahead and removes resources
> while the reconnect code wants to use it. The problem is that
> nvmet_fc_find_target_assoc() is able to lookup an association which is
> beeing removed.
> 
> So the first thing to address nvmet_fc_find_target_queue() is to remove
> the association out of the list and wait a RCU cycle and free resources
> in the free function callback of the kref_put().
> 
> The live time of the queues are strictly bound to the lifetime of an
> association. Thus we don't need to take reverse refcounts (queue ->
> assocation).
> 
> Furthermore, streamline the cleanup code by using the workqueue for
> delete the association in nvmet_fc_ls_disconnect. This ensures, that we
> run throught the same shutdown path in all non error cases.
> 
> Reproducer: nvme/003
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 67 ++++++++++++++++++++--------------------
>   1 file changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index df7d84aff843..9d7262a8e3db 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -165,6 +165,7 @@ struct nvmet_fc_tgt_assoc {
>   	struct nvmet_fc_hostport	*hostport;
>   	struct nvmet_fc_ls_iod		*rcv_disconn;
>   	struct list_head		a_list;
> +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
>   	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
>   	struct kref			ref;
>   	struct work_struct		del_work;
> @@ -802,14 +803,11 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (!queue)
>   		return NULL;
>   
> -	if (!nvmet_fc_tgt_a_get(assoc))
> -		goto out_free_queue;
> -
>   	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
>   				assoc->tgtport->fc_target_port.port_num,
>   				assoc->a_id, qid);
>   	if (!queue->work_q)
> -		goto out_a_put;
> +		goto out_free_queue;
>   
>   	queue->qid = qid;
>   	queue->sqsize = sqsize;
> @@ -830,7 +828,8 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (ret)
>   		goto out_fail_iodlist;
>   
> -	WARN_ON(assoc->queues[qid]);
> +	WARN_ON(assoc->_queues[qid]);
> +	assoc->_queues[qid] = queue;
>   	rcu_assign_pointer(assoc->queues[qid], queue);
>   
>   	return queue;
> @@ -838,8 +837,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   out_fail_iodlist:
>   	nvmet_fc_destroy_fcp_iodlist(assoc->tgtport, queue);
>   	destroy_workqueue(queue->work_q);
> -out_a_put:
> -	nvmet_fc_tgt_a_put(assoc);
>   out_free_queue:
>   	kfree(queue);
>   	return NULL;
> @@ -852,12 +849,8 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
>   	struct nvmet_fc_tgt_queue *queue =
>   		container_of(ref, struct nvmet_fc_tgt_queue, ref);
>   
> -	rcu_assign_pointer(queue->assoc->queues[queue->qid], NULL);
> -
>   	nvmet_fc_destroy_fcp_iodlist(queue->assoc->tgtport, queue);
>   
> -	nvmet_fc_tgt_a_put(queue->assoc);
> -
>   	destroy_workqueue(queue->work_q);
>   
>   	kfree_rcu(queue, rcu);
> @@ -1100,6 +1093,11 @@ nvmet_fc_delete_assoc(struct work_struct *work)
>   		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
>   
>   	nvmet_fc_delete_target_assoc(assoc);
> +
> +	/* release get taken in nvmet_fc_find_target_assoc */
> +	nvmet_fc_tgt_a_put(assoc);
> +
> +	/* final reference from nvmet_fc_ls_create_association */
>   	nvmet_fc_tgt_a_put(assoc);
>   }
>   
That feels wrong. If we're having to do two put in a row it seems that
we're taking one reference too many here.
I would assume that each queue takes a reference on the association; 
isn't that the case here?

> @@ -1172,13 +1170,18 @@ nvmet_fc_target_assoc_free(struct kref *ref)
>   	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
>   	struct nvmet_fc_ls_iod	*oldls;
>   	unsigned long flags;
> +	int i;
> +
> +	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
> +		if (assoc->_queues[i])
> +			nvmet_fc_delete_target_queue(assoc->_queues[i]);
> +	}
>   
>   	/* Send Disconnect now that all i/o has completed */
>   	nvmet_fc_xmt_disconnect_assoc(assoc);
>   
>   	nvmet_fc_free_hostport(assoc->hostport);
>   	spin_lock_irqsave(&tgtport->lock, flags);
> -	list_del_rcu(&assoc->a_list);
>   	oldls = assoc->rcv_disconn;
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   	/* if pending Rcv Disconnect Association LS, send rsp now */
> @@ -1208,7 +1211,6 @@ static void
>   nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
>   {
>   	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
> -	struct nvmet_fc_tgt_queue *queue;
>   	int i, terminating;
>   
>   	terminating = atomic_xchg(&assoc->terminating, 1);
> @@ -1217,29 +1219,21 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
>   	if (terminating)
>   		return;
>   
> +	/* prevent new I/Os entering the queues */
> +	for (i = NVMET_NR_QUEUES; i >= 0; i--)
> +		rcu_assign_pointer(assoc->queues[i], NULL);
> +	list_del_rcu(&assoc->a_list);
> +	synchronize_rcu();
>   
Watch out for 'list_del_rcu()'. That does _not_ modify the pointer for 
the element in question, only those from the list.
So to avoid concurrency with nvmet_fc_alloc_target_assoc() I guess we 
need to get the tgtport lock here.

> +	/* ensure all in-flight I/Os have been processed */
>   	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
> -		rcu_read_lock();
> -		queue = rcu_dereference(assoc->queues[i]);
> -		if (!queue) {
> -			rcu_read_unlock();
> -			continue;
> -		}
> -
> -		if (!nvmet_fc_tgt_q_get(queue)) {
> -			rcu_read_unlock();
> -			continue;
> -		}
> -		rcu_read_unlock();
> -		nvmet_fc_delete_target_queue(queue);
> -		nvmet_fc_tgt_q_put(queue);
> +		if (assoc->_queues[i])
> +			flush_workqueue(assoc->_queues[i]->work_q);
>   	}
>   
>   	dev_info(tgtport->dev,
>   		"{%d:%d} Association deleted\n",
>   		tgtport->fc_target_port.port_num, assoc->a_id);
> -
> -	nvmet_fc_tgt_a_put(assoc);
>   }
>   
>   static struct nvmet_fc_tgt_assoc *
> @@ -1497,6 +1491,8 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
>   			nvmet_fc_tgt_a_put(assoc);
>   	}
>   	rcu_read_unlock();
> +
> +	flush_workqueue(nvmet_wq);
>   }
>   
>   /**
> @@ -1870,9 +1866,6 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>   				sizeof(struct fcnvme_ls_disconnect_assoc_acc)),
>   			FCNVME_LS_DISCONNECT_ASSOC);
>   
> -	/* release get taken in nvmet_fc_find_target_assoc */
> -	nvmet_fc_tgt_a_put(assoc);
> -
>   	/*
>   	 * The rules for LS response says the response cannot
>   	 * go back until ABTS's have been sent for all outstanding
> @@ -1887,8 +1880,6 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>   	assoc->rcv_disconn = iod;
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   
> -	nvmet_fc_delete_target_assoc(assoc);
> -
>   	if (oldls) {
>   		dev_info(tgtport->dev,
>   			"{%d:%d} Multiple Disconnect Association LS's "
> @@ -1904,6 +1895,11 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>   		nvmet_fc_xmt_ls_rsp(tgtport, oldls);
>   	}
>   
> +	if (!queue_work(nvmet_wq, &assoc->del_work)) {
> +		/* already deleting - release local reference */
> +		nvmet_fc_tgt_a_put(assoc);
> +	}
> +
>   	return false;
>   }
>   
> @@ -2933,6 +2929,9 @@ static int __init nvmet_fc_init_module(void)
>   
>   static void __exit nvmet_fc_exit_module(void)
>   {
> +	/* ensure any shutdown operation, e.g. delete ctrls have finished */
> +	flush_workqueue(nvmet_wq);
> +
>   	/* sanity check - all lports should be removed */
>   	if (!list_empty(&nvmet_fc_target_list))
>   		pr_warn("%s: targetport list not empty\n", __func__);

Otherwise looks good.

Cheers,

Hannes

