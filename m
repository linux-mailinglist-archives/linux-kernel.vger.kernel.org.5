Return-Path: <linux-kernel+bounces-4850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B69D8182D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD131F2818F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED112B92;
	Tue, 19 Dec 2023 07:59:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BA11725
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8395021E5A;
	Tue, 19 Dec 2023 07:59:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F8EE13AA6;
	Tue, 19 Dec 2023 07:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FI3uCE9NgWWyegAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 19 Dec 2023 07:59:11 +0000
Message-ID: <725ba59a-68b3-471c-b88c-4515c0415209@suse.de>
Date: Tue, 19 Dec 2023 08:59:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/16] nvmet-fc: untangle cross refcounting objects
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-9-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231218153105.12717-9-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 8395021E5A
X-Spam-Flag: NO

On 12/18/23 16:30, Daniel Wagner wrote:
> Associations take a refcount on queues, queues take a refcount on
> associations.
> 
> The existing code lead to the situation that the target executes a
> disconnect and the host triggers a reconnect immediately. The reconnect
> command still finds an existing association and uses this. Though the
> reconnect crashes later on because nvmet_fc_delete_target_assoc()
> blindly goes ahead and removes resources while the reconnect code wants
> to use it. The problem is that nvmet_fc_find_target_assoc() is able to
> lookup an association which is being removed.
> 
> So the first thing to address nvmet_fc_find_target_queue() is to remove
> the association out of the list and wait a RCU cycle and free resources
> in the free function callback of the kref_put().
> 
> The live time of the queues are strictly bound to the lifetime of an
> association. Thus we don't need to take reverse refcounts (queue ->
> association).
> 
> Furthermore, streamline the cleanup code by using the workqueue for
> delete the association in nvmet_fc_ls_disconnect. This ensures, that we
> run through the same shutdown path in all non error cases.
> 
> Reproducer: nvme/003
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 83 +++++++++++++++++++---------------------
>   1 file changed, 40 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 28e432e62361..db992df13c73 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -166,6 +166,7 @@ struct nvmet_fc_tgt_assoc {
>   	struct nvmet_fc_hostport	*hostport;
>   	struct nvmet_fc_ls_iod		*rcv_disconn;
>   	struct list_head		a_list;
> +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
>   	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
>   	struct kref			ref;
>   	struct work_struct		del_work;
> @@ -803,14 +804,11 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
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
> @@ -831,7 +829,8 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (ret)
>   		goto out_fail_iodlist;
>   
> -	WARN_ON(assoc->queues[qid]);
> +	WARN_ON(assoc->_queues[qid]);
> +	assoc->_queues[qid] = queue;
>   	rcu_assign_pointer(assoc->queues[qid], queue);
>   
Is it really worth is using an rcu pointer here?
In the end, creating and deleting queues for an association don't happen 
that often, and involve some synchronization points anyway.
IE the lifetime of the queue is actually bounded by the lifetime of the
association itself, so if the association is valid the queues will be
valid, too.

With that reasoning can't we drop rcu above and use the array directly,
delegating any synchronization to the association itself?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


