Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246B37DEDED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjKBILw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKBILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:11:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814BF111;
        Thu,  2 Nov 2023 01:11:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 394B521A1D;
        Thu,  2 Nov 2023 08:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698912704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMhGQiqfq445PFxKNMsZNs39FeGTNET/PPbR3dvt2CY=;
        b=bfMbt/c+wYJ3JgnGgoQXiYFLKmZEnT92LSFOTSPFyaHHPkwBnyjg/kt02AmXxdUcfdcCw5
        +FKcCAeEJANEhv6hTABpht+cXSaarHFJW8mvhMZyyW9gLvTPlluO1Xd+caPVkAIeQ8mB8D
        pBwItobwOzHaxYv5T4AwcpFs1/FRuyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698912704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMhGQiqfq445PFxKNMsZNs39FeGTNET/PPbR3dvt2CY=;
        b=NQxIIzE3X/154Mm5u40Ky61N0P8GzT2JE4zkRdJKmf2PAzbQIlTLwCq3HFL7/bOpgGMCyA
        sMbqVE7XtnE/RYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA07B13584;
        Thu,  2 Nov 2023 08:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cpcMNL9ZQ2WHRAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 02 Nov 2023 08:11:43 +0000
Message-ID: <7f8d8801-2f70-4608-9b42-4a0f98aff3d3@suse.de>
Date:   Thu, 2 Nov 2023 09:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic driver
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-13-kartilak@cisco.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027180302.418676-13-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 20:03, Karan Tilak Kumar wrote:
> Implement support for MQ in fnic driver:
> 
> The block multiqueue layer issues IO to the fnic driver
> with an MQ tag. Use the mqtag and derive a tag from it.
> Derive the hardware queue from the mqtag and use it
> in all paths. Modify queuecommand to handle mqtag.
> 
> Replace wq and cq indices to support MQ. Replace the
> zeroth queue with a hardware queue.
> Implement spin locks on a per hardware queue basis.
> Replace io_lock with per hardware queue spinlock.
> Implement out of range tag checks.
> 
> Allocate an io_req_table to track status of the io_req.
> 
> Test the driver by building it, loading it,
> and configuring 64 queues in UCSM. Issue IOs using
> Medusa on multiple fnics. Enable/disable links to exercise
> the abort and clean up path.
> 
> Changes between v1 and v2:
>      Incorporate the following review comments from Bart:
>      Remove outdated comment,
>      Remove unnecessary out of range tag checks,
>      Remove unnecessary local variable,
>      Modify function name.
> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/fnic.h      |   2 -
>   drivers/scsi/fnic/fnic_io.h   |   2 +
>   drivers/scsi/fnic/fnic_main.c |   3 -
>   drivers/scsi/fnic/fnic_scsi.c | 571 ++++++++++++++++++++--------------
>   4 files changed, 346 insertions(+), 232 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
> index 3dc4e9ff100a..87dab09a426d 100644
> --- a/drivers/scsi/fnic/fnic.h
> +++ b/drivers/scsi/fnic/fnic.h
> @@ -36,7 +36,6 @@
>   #define FNIC_MIN_IO_REQ			256 /* Min IO throttle count */
>   #define FNIC_MAX_IO_REQ		1024 /* scsi_cmnd tag map entries */
>   #define FNIC_DFLT_IO_REQ        256 /* Default scsi_cmnd tag map entries */
> -#define	FNIC_IO_LOCKS		64 /* IO locks: power of 2 */
>   #define FNIC_DFLT_QUEUE_DEPTH	256
>   #define	FNIC_STATS_RATE_LIMIT	4 /* limit rate at which stats are pulled up */
>   
> @@ -292,7 +291,6 @@ struct fnic {
>   	struct fnic_host_tag *tags;
>   	mempool_t *io_req_pool;
>   	mempool_t *io_sgl_pool[FNIC_SGL_NUM_CACHES];
> -	spinlock_t io_req_lock[FNIC_IO_LOCKS];	/* locks for scsi cmnds */
>   
>   	unsigned int cpy_wq_base;
>   	struct work_struct link_work;
> diff --git a/drivers/scsi/fnic/fnic_io.h b/drivers/scsi/fnic/fnic_io.h
> index f4c8769df312..5895ead20e14 100644
> --- a/drivers/scsi/fnic/fnic_io.h
> +++ b/drivers/scsi/fnic/fnic_io.h
> @@ -52,6 +52,8 @@ struct fnic_io_req {
>   	unsigned long start_time; /* in jiffies */
>   	struct completion *abts_done; /* completion for abts */
>   	struct completion *dr_done; /* completion for device reset */
> +	unsigned int tag;
> +	struct scsi_cmnd *sc; /* midlayer's cmd pointer */
>   };
>   
>   enum fnic_port_speeds {
> diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
> index 5b60396e7349..9ab115a5fc74 100644
> --- a/drivers/scsi/fnic/fnic_main.c
> +++ b/drivers/scsi/fnic/fnic_main.c
> @@ -816,9 +816,6 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		fnic->fw_ack_index[i] = -1;
>   	}
>   
> -	for (i = 0; i < FNIC_IO_LOCKS; i++)
> -		spin_lock_init(&fnic->io_req_lock[i]);
> -
>   	err = -ENOMEM;
>   	fnic->io_req_pool = mempool_create_slab_pool(2, fnic_io_req_cache);
>   	if (!fnic->io_req_pool)
> diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
> index ffdbdbfcdf57..fdc4d73ba63c 100644
> --- a/drivers/scsi/fnic/fnic_scsi.c
> +++ b/drivers/scsi/fnic/fnic_scsi.c
> @@ -92,20 +92,6 @@ static const char *fnic_fcpio_status_to_str(unsigned int status)
>   
>   static void fnic_cleanup_io(struct fnic *fnic);
>   
> -static inline spinlock_t *fnic_io_lock_hash(struct fnic *fnic,
> -					    struct scsi_cmnd *sc)
> -{
> -	u32 hash = scsi_cmd_to_rq(sc)->tag & (FNIC_IO_LOCKS - 1);
> -
> -	return &fnic->io_req_lock[hash];
> -}
> -
> -static inline spinlock_t *fnic_io_lock_tag(struct fnic *fnic,
> -					    int tag)
> -{
> -	return &fnic->io_req_lock[tag & (FNIC_IO_LOCKS - 1)];
> -}
> -
>   /*
>    * Unmap the data buffer and sense buffer for an io_req,
>    * also unmap and free the device-private scatter/gather list.
> @@ -129,23 +115,23 @@ static void fnic_release_ioreq_buf(struct fnic *fnic,
>   }
>   
>   /* Free up Copy Wq descriptors. Called with copy_wq lock held */
> -static int free_wq_copy_descs(struct fnic *fnic, struct vnic_wq_copy *wq)
> +static int free_wq_copy_descs(struct fnic *fnic, struct vnic_wq_copy *wq, unsigned int hwq)
>   {
>   	/* if no Ack received from firmware, then nothing to clean */
> -	if (!fnic->fw_ack_recd[0])
> +	if (!fnic->fw_ack_recd[hwq])
>   		return 1;
>   
>   	/*
>   	 * Update desc_available count based on number of freed descriptors
>   	 * Account for wraparound
>   	 */
> -	if (wq->to_clean_index <= fnic->fw_ack_index[0])
> -		wq->ring.desc_avail += (fnic->fw_ack_index[0]
> +	if (wq->to_clean_index <= fnic->fw_ack_index[hwq])
> +		wq->ring.desc_avail += (fnic->fw_ack_index[hwq]
>   					- wq->to_clean_index + 1);
>   	else
>   		wq->ring.desc_avail += (wq->ring.desc_count
>   					- wq->to_clean_index
> -					+ fnic->fw_ack_index[0] + 1);
> +					+ fnic->fw_ack_index[hwq] + 1);
>   
>   	/*
>   	 * just bump clean index to ack_index+1 accounting for wraparound
> @@ -153,10 +139,10 @@ static int free_wq_copy_descs(struct fnic *fnic, struct vnic_wq_copy *wq)
>   	 * to_clean_index and fw_ack_index, both inclusive
>   	 */
>   	wq->to_clean_index =
> -		(fnic->fw_ack_index[0] + 1) % wq->ring.desc_count;
> +		(fnic->fw_ack_index[hwq] + 1) % wq->ring.desc_count;
>   
>   	/* we have processed the acks received so far */
> -	fnic->fw_ack_recd[0] = 0;
> +	fnic->fw_ack_recd[hwq] = 0;
>   	return 0;
>   }
>   
> @@ -207,7 +193,7 @@ int fnic_fw_reset_handler(struct fnic *fnic)
>   	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
>   
>   	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[0])
> -		free_wq_copy_descs(fnic, wq);
> +		free_wq_copy_descs(fnic, wq, 0);
>   
>   	if (!vnic_wq_copy_desc_avail(wq))
>   		ret = -EAGAIN;
> @@ -253,7 +239,7 @@ int fnic_flogi_reg_handler(struct fnic *fnic, u32 fc_id)
>   	spin_lock_irqsave(&fnic->wq_copy_lock[0], flags);
>   
>   	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[0])
> -		free_wq_copy_descs(fnic, wq);
> +		free_wq_copy_descs(fnic, wq, 0);
>   
>   	if (!vnic_wq_copy_desc_avail(wq)) {
>   		ret = -EAGAIN;
> @@ -303,7 +289,9 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
>   					  struct vnic_wq_copy *wq,
>   					  struct fnic_io_req *io_req,
>   					  struct scsi_cmnd *sc,
> -					  int sg_count)
> +					  int sg_count,
> +					  uint32_t mqtag,
> +					  uint16_t hwq)
>   {
>   	struct scatterlist *sg;
>   	struct fc_rport *rport = starget_to_rport(scsi_target(sc->device));
> @@ -311,7 +299,6 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
>   	struct host_sg_desc *desc;
>   	struct misc_stats *misc_stats = &fnic->fnic_stats.misc_stats;
>   	unsigned int i;
> -	unsigned long intr_flags;
>   	int flags;
>   	u8 exch_flags;
>   	struct scsi_lun fc_lun;
> @@ -351,13 +338,10 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
>   	int_to_scsilun(sc->device->lun, &fc_lun);
>   
>   	/* Enqueue the descriptor in the Copy WQ */
> -	spin_lock_irqsave(&fnic->wq_copy_lock[0], intr_flags);
> -
> -	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[0])
> -		free_wq_copy_descs(fnic, wq);
> +	if (vnic_wq_copy_desc_avail(wq) <= fnic->wq_copy_desc_low[hwq])
> +		free_wq_copy_descs(fnic, wq, hwq);
>   
>   	if (unlikely(!vnic_wq_copy_desc_avail(wq))) {
> -		spin_unlock_irqrestore(&fnic->wq_copy_lock[0], intr_flags);
>   		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host,
>   			  "fnic_queue_wq_copy_desc failure - no descriptors\n");
>   		atomic64_inc(&misc_stats->io_cpwq_alloc_failures);
> @@ -375,7 +359,7 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
>   	    (rp->flags & FC_RP_FLAGS_RETRY))
>   		exch_flags |= FCPIO_ICMND_SRFLAG_RETRY;
>   
> -	fnic_queue_wq_copy_desc_icmnd_16(wq, scsi_cmd_to_rq(sc)->tag,
> +	fnic_queue_wq_copy_desc_icmnd_16(wq, mqtag,
>   					 0, exch_flags, io_req->sgl_cnt,
>   					 SCSI_SENSE_BUFFERSIZE,
>   					 io_req->sgl_list_pa,
> @@ -396,31 +380,23 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
>   		atomic64_set(&fnic->fnic_stats.fw_stats.max_fw_reqs,
>   		  atomic64_read(&fnic->fnic_stats.fw_stats.active_fw_reqs));
>   
> -	spin_unlock_irqrestore(&fnic->wq_copy_lock[0], intr_flags);
>   	return 0;
>   }
>   
> -/*
> - * fnic_queuecommand
> - * Routine to send a scsi cdb
> - * Called with host_lock held and interrupts disabled.
> - */
> -static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
> +static int fnic_queuecommand_int(struct scsi_cmnd *sc, uint32_t mqtag, uint16_t hwq)
>   {
>   	void (*done)(struct scsi_cmnd *) = scsi_done;
> -	const int tag = scsi_cmd_to_rq(sc)->tag;
>   	struct fc_lport *lp = shost_priv(sc->device->host);
>   	struct fc_rport *rport;
>   	struct fnic_io_req *io_req = NULL;
>   	struct fnic *fnic = lport_priv(lp);
>   	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
>   	struct vnic_wq_copy *wq;
> -	int ret;
> +	int ret = 1;
>   	u64 cmd_trace;
>   	int sg_count = 0;
>   	unsigned long flags = 0;
>   	unsigned long ptr;
> -	spinlock_t *io_lock = NULL;
>   	int io_lock_acquired = 0;
>   	struct fc_rport_libfc_priv *rp;
>   
> @@ -514,7 +490,7 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
>   	sg_count = scsi_dma_map(sc);
>   	if (sg_count < 0) {
>   		FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
> -			  tag, sc, 0, sc->cmnd[0], sg_count, fnic_priv(sc)->state);
> +			  mqtag, sc, 0, sc->cmnd[0], sg_count, fnic_priv(sc)->state);
>   		mempool_free(io_req, fnic->io_req_pool);
>   		goto out;
>   	}
> @@ -549,11 +525,9 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
>   	}
>   
>   	/*
> -	* Will acquire lock defore setting to IO initialized.
> +	* Will acquire lock before setting to IO initialized.
>   	*/
> -
> -	io_lock = fnic_io_lock_hash(fnic, sc);
> -	spin_lock_irqsave(io_lock, flags);
> +	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
>   
>   	/* initialize rest of io_req */
>   	io_lock_acquired = 1;
> @@ -562,21 +536,34 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
>   	fnic_priv(sc)->state = FNIC_IOREQ_CMD_PENDING;
>   	fnic_priv(sc)->io_req = io_req;
>   	fnic_priv(sc)->flags |= FNIC_IO_INITIALIZED;
> +	io_req->sc = sc;
> +
> +	if (fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] != NULL) {
> +		WARN(1, "fnic<%d>: %s: hwq: %d tag 0x%x already exists\n",
> +				fnic->fnic_num, __func__, hwq, blk_mq_unique_tag_to_tag(mqtag));
> +		return SCSI_MLQUEUE_HOST_BUSY;
> +	}
> +
> +	fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] = io_req;
> +	io_req->tag = mqtag;
>   
>   	/* create copy wq desc and enqueue it */
> -	wq = &fnic->hw_copy_wq[0];
> -	ret = fnic_queue_wq_copy_desc(fnic, wq, io_req, sc, sg_count);
> +	wq = &fnic->hw_copy_wq[hwq];
> +	atomic64_inc(&fnic_stats->io_stats.ios[hwq]);
> +	ret = fnic_queue_wq_copy_desc(fnic, wq, io_req, sc, sg_count, mqtag, hwq);
>   	if (ret) {
>   		/*
>   		 * In case another thread cancelled the request,
>   		 * refetch the pointer under the lock.
>   		 */
>   		FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
> -			  tag, sc, 0, 0, 0, fnic_flags_and_state(sc));
> +			  mqtag, sc, 0, 0, 0, fnic_flags_and_state(sc));
>   		io_req = fnic_priv(sc)->io_req;
>   		fnic_priv(sc)->io_req = NULL;
> +		if (io_req)
> +			fnic->sw_copy_wq[hwq].io_req_table[blk_mq_unique_tag_to_tag(mqtag)] = NULL;
>   		fnic_priv(sc)->state = FNIC_IOREQ_CMD_COMPLETE;
> -		spin_unlock_irqrestore(io_lock, flags);
> +		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
>   		if (io_req) {
>   			fnic_release_ioreq_buf(fnic, io_req, sc);
>   			mempool_free(io_req, fnic->io_req_pool);
> @@ -601,18 +588,30 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
>   			sc->cmnd[5]);
>   
>   	FNIC_TRACE(fnic_queuecommand, sc->device->host->host_no,
> -		   tag, sc, io_req, sg_count, cmd_trace,
> +		   mqtag, sc, io_req, sg_count, cmd_trace,
>   		   fnic_flags_and_state(sc));
>   
>   	/* if only we issued IO, will we have the io lock */
>   	if (io_lock_acquired)
> -		spin_unlock_irqrestore(io_lock, flags);
> +		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
>   
>   	atomic_dec(&fnic->in_flight);
>   	return ret;
>   }
>   
> -DEF_SCSI_QCMD(fnic_queuecommand)
> +int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
> +{
> +	struct request *const rq = scsi_cmd_to_rq(sc);
> +	uint32_t mqtag = 0;
> +	int tag = 0;
> +	uint16_t hwq = 0;
> +
> +	mqtag = blk_mq_unique_tag(rq);
> +	hwq = blk_mq_unique_tag_to_hwq(mqtag);
> +	tag = blk_mq_unique_tag_to_tag(mqtag);
> +
> +	return fnic_queuecommand_int(sc, mqtag, hwq);
> +}
>   
That is odd.
If you pass in 'mqtag' you can derive the hardware queue from it,
so you don't need to pass it in separately.
Alternative it would make sense to pass in the 'tag' value instead
of 'mqtag', as this would simplify the code (seeint that you don't
have to call blk_mq_unique_tag_to_tag() all over the place).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

