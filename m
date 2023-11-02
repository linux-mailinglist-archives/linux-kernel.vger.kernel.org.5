Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2277DED96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbjKBHqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:46:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9170116;
        Thu,  2 Nov 2023 00:45:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E6D21F853;
        Thu,  2 Nov 2023 07:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698911157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drUbrc11J6ytXmNCTzI9BIktdJ0NORugCX3jLmrUqlw=;
        b=1SjLOaQNrq3coKjpxOPZCNpY+NoDJWyNS60k4hfhGvtG52Cn6P27ZgO37dV6hjRL462sJC
        Q0Ww8scgvswO1ibobnDFmK2gw7Ij+/gaXv68BBlH4ArMpSbaOgFENsYft4er4v79c0GQ2q
        +M+rjx74MWCwHETQj/pVTmxkdEjIADg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698911157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drUbrc11J6ytXmNCTzI9BIktdJ0NORugCX3jLmrUqlw=;
        b=8NM7zJI64EXxa+K37wCA70pGiIKt2Htz5fKERBmELK6o1U8Nl6w6PryEJ4ufMF2izsn9lG
        sFdqwiOId5e2FaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25349138EC;
        Thu,  2 Nov 2023 07:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xBTQB7VTQ2WuOAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 02 Nov 2023 07:45:57 +0000
Message-ID: <9538044a-e761-45ca-8507-5a3377cbe993@suse.de>
Date:   Thu, 2 Nov 2023 08:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] scsi: fnic: Modify ISRs to support
 multiqueue(MQ)
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-8-kartilak@cisco.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027180302.418676-8-kartilak@cisco.com>
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

On 10/27/23 20:02, Karan Tilak Kumar wrote:
> Modify interrupt service routines for INTx, MSI, and MSI-x
> to support multiqueue.
> Modify parameter list of fnic_wq_copy_cmpl_handler
> to take cq_index.
> Modify fnic_cleanup function to use the new
> function call of fnic_wq_copy_cmpl_handler.
> Refactor code to set
> interrupt mode to MSI-x to a new function.
> Add a new stat for intx_dummy.
> 
> Changes between v1 and v2:
>      Suppress warning from kernel test bot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310251847.4T8BVZAZ-lkp@intel.com/
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/fnic.h       |   3 +-
>   drivers/scsi/fnic/fnic_isr.c   | 164 ++++++++++++++++++++++++---------
>   drivers/scsi/fnic/fnic_main.c  |   4 +-
>   drivers/scsi/fnic/fnic_scsi.c  |  38 +++-----
>   drivers/scsi/fnic/fnic_stats.h |   1 +
>   5 files changed, 140 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
> index f4390fc96323..9e104468b0d4 100644
> --- a/drivers/scsi/fnic/fnic.h
> +++ b/drivers/scsi/fnic/fnic.h
> @@ -343,6 +343,7 @@ extern const struct attribute_group *fnic_host_groups[];
>   
>   void fnic_clear_intr_mode(struct fnic *fnic);
>   int fnic_set_intr_mode(struct fnic *fnic);
> +int fnic_set_intr_mode_msix(struct fnic *fnic);
>   void fnic_free_intr(struct fnic *fnic);
>   int fnic_request_intr(struct fnic *fnic);
>   
> @@ -369,7 +370,7 @@ void fnic_scsi_cleanup(struct fc_lport *);
>   void fnic_scsi_abort_io(struct fc_lport *);
>   void fnic_empty_scsi_cleanup(struct fc_lport *);
>   void fnic_exch_mgr_reset(struct fc_lport *, u32, u32);
> -int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int);
> +int fnic_wq_copy_cmpl_handler(struct fnic *fnic, int copy_work_to_do, unsigned int cq_index);
>   int fnic_wq_cmpl_handler(struct fnic *fnic, int);
>   int fnic_flogi_reg_handler(struct fnic *fnic, u32);
>   void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
> diff --git a/drivers/scsi/fnic/fnic_isr.c b/drivers/scsi/fnic/fnic_isr.c
> index dff9689023e4..82e4e3e8ec4b 100644
> --- a/drivers/scsi/fnic/fnic_isr.c
> +++ b/drivers/scsi/fnic/fnic_isr.c
> @@ -38,8 +38,13 @@ static irqreturn_t fnic_isr_legacy(int irq, void *data)
>   		fnic_log_q_error(fnic);
>   	}
>   
> +	if (pba & (1 << FNIC_INTX_DUMMY)) {
> +		atomic64_inc(&fnic->fnic_stats.misc_stats.intx_dummy);
> +		vnic_intr_return_all_credits(&fnic->intr[FNIC_INTX_DUMMY]);
> +	}
> +
>   	if (pba & (1 << FNIC_INTX_WQ_RQ_COPYWQ)) {
> -		work_done += fnic_wq_copy_cmpl_handler(fnic, io_completions);
> +		work_done += fnic_wq_copy_cmpl_handler(fnic, io_completions, FNIC_MQ_CQ_INDEX);
>   		work_done += fnic_wq_cmpl_handler(fnic, -1);
>   		work_done += fnic_rq_cmpl_handler(fnic, -1);
>   
> @@ -60,7 +65,7 @@ static irqreturn_t fnic_isr_msi(int irq, void *data)
>   	fnic->fnic_stats.misc_stats.last_isr_time = jiffies;
>   	atomic64_inc(&fnic->fnic_stats.misc_stats.isr_count);
>   
> -	work_done += fnic_wq_copy_cmpl_handler(fnic, io_completions);
> +	work_done += fnic_wq_copy_cmpl_handler(fnic, io_completions, FNIC_MQ_CQ_INDEX);
>   	work_done += fnic_wq_cmpl_handler(fnic, -1);
>   	work_done += fnic_rq_cmpl_handler(fnic, -1);
>   
> @@ -109,12 +114,22 @@ static irqreturn_t fnic_isr_msix_wq_copy(int irq, void *data)
>   {
>   	struct fnic *fnic = data;
>   	unsigned long wq_copy_work_done = 0;
> +	int i;
>   
>   	fnic->fnic_stats.misc_stats.last_isr_time = jiffies;
>   	atomic64_inc(&fnic->fnic_stats.misc_stats.isr_count);
>   
> -	wq_copy_work_done = fnic_wq_copy_cmpl_handler(fnic, io_completions);
> -	vnic_intr_return_credits(&fnic->intr[FNIC_MSIX_WQ_COPY],
> +	i = irq - fnic->msix[0].irq_num;
> +	if (i >= fnic->wq_copy_count + fnic->cpy_wq_base ||
> +		i < 0 || fnic->msix[i].irq_num != irq) {
> +		for (i = fnic->cpy_wq_base; i < fnic->wq_copy_count + fnic->cpy_wq_base ; i++) {
> +			if (fnic->msix[i].irq_num == irq)
> +				break;
> +		}
> +	}
> +
> +	wq_copy_work_done = fnic_wq_copy_cmpl_handler(fnic, io_completions, i);
> +	vnic_intr_return_credits(&fnic->intr[i],
>   				 wq_copy_work_done,
>   				 1 /* unmask intr */,
>   				 1 /* reset intr timer */);
> @@ -128,7 +143,7 @@ static irqreturn_t fnic_isr_msix_err_notify(int irq, void *data)
>   	fnic->fnic_stats.misc_stats.last_isr_time = jiffies;
>   	atomic64_inc(&fnic->fnic_stats.misc_stats.isr_count);
>   
> -	vnic_intr_return_all_credits(&fnic->intr[FNIC_MSIX_ERR_NOTIFY]);
> +	vnic_intr_return_all_credits(&fnic->intr[fnic->err_intr_offset]);
>   	fnic_log_q_error(fnic);
>   	fnic_handle_link_event(fnic);
>   
> @@ -186,26 +201,30 @@ int fnic_request_intr(struct fnic *fnic)
>   		fnic->msix[FNIC_MSIX_WQ].isr = fnic_isr_msix_wq;
>   		fnic->msix[FNIC_MSIX_WQ].devid = fnic;
>   
> -		sprintf(fnic->msix[FNIC_MSIX_WQ_COPY].devname,
> -			"%.11s-scsi-wq", fnic->name);
> -		fnic->msix[FNIC_MSIX_WQ_COPY].isr = fnic_isr_msix_wq_copy;
> -		fnic->msix[FNIC_MSIX_WQ_COPY].devid = fnic;
> +		for (i = fnic->cpy_wq_base; i < fnic->wq_copy_count + fnic->cpy_wq_base; i++) {
> +			sprintf(fnic->msix[i].devname,
> +				"%.11s-scsi-wq-%d", fnic->name, i-FNIC_MSIX_WQ_COPY);
> +			fnic->msix[i].isr = fnic_isr_msix_wq_copy;
> +			fnic->msix[i].devid = fnic;
> +		}
>   
> -		sprintf(fnic->msix[FNIC_MSIX_ERR_NOTIFY].devname,
> +		sprintf(fnic->msix[fnic->err_intr_offset].devname,
>   			"%.11s-err-notify", fnic->name);
> -		fnic->msix[FNIC_MSIX_ERR_NOTIFY].isr =
> +		fnic->msix[fnic->err_intr_offset].isr =
>   			fnic_isr_msix_err_notify;
> -		fnic->msix[FNIC_MSIX_ERR_NOTIFY].devid = fnic;
> +		fnic->msix[fnic->err_intr_offset].devid = fnic;
> +
> +		for (i = 0; i < fnic->intr_count; i++) {
> +			fnic->msix[i].irq_num = pci_irq_vector(fnic->pdev, i);
>   
> -		for (i = 0; i < ARRAY_SIZE(fnic->msix); i++) {
> -			err = request_irq(pci_irq_vector(fnic->pdev, i),
> -					  fnic->msix[i].isr, 0,
> -					  fnic->msix[i].devname,
> -					  fnic->msix[i].devid);
> +			err = request_irq(fnic->msix[i].irq_num,
> +							fnic->msix[i].isr, 0,
> +							fnic->msix[i].devname,
> +							fnic->msix[i].devid);
>   			if (err) {
> -				shost_printk(KERN_ERR, fnic->lport->host,
> -					     "MSIX: request_irq"
> -					     " failed %d\n", err);
> +				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host,
> +							"fnic<%d>: %s: %d request_irq failed with error: %d\n",
> +							fnic->fnic_num, __func__, __LINE__,  err);
>   				fnic_free_intr(fnic);
>   				break;
>   			}
> @@ -220,44 +239,101 @@ int fnic_request_intr(struct fnic *fnic)
>   	return err;
>   }
>   
> -int fnic_set_intr_mode(struct fnic *fnic)
> +int fnic_set_intr_mode_msix(struct fnic *fnic)
>   {
>   	unsigned int n = ARRAY_SIZE(fnic->rq);
>   	unsigned int m = ARRAY_SIZE(fnic->wq);
>   	unsigned int o = ARRAY_SIZE(fnic->hw_copy_wq);
> +	unsigned int min_irqs = n + m + 1 + 1; /*rq, raw wq, wq, err*/
>   
>   	/*
> -	 * Set interrupt mode (INTx, MSI, MSI-X) depending
> -	 * system capabilities.
> -	 *
> -	 * Try MSI-X first
> -	 *
>   	 * We need n RQs, m WQs, o Copy WQs, n+m+o CQs, and n+m+o+1 INTRs
>   	 * (last INTR is used for WQ/RQ errors and notification area)
>   	 */
> -	if (fnic->rq_count >= n &&
> -	    fnic->raw_wq_count >= m &&
> -	    fnic->wq_copy_count >= o &&
> -	    fnic->cq_count >= n + m + o) {
> -		int vecs = n + m + o + 1;
> -
> -		if (pci_alloc_irq_vectors(fnic->pdev, vecs, vecs,
> -				PCI_IRQ_MSIX) == vecs) {
> +	FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
> +		"fnic<%d>: %s: %d: rq-array size: %d wq-array size: %d copy-wq array size: %d\n",
> +		fnic->fnic_num, __func__, __LINE__, n, m, o);
> +	FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
> +		"fnic<%d>: %s: %d: rq_count: %d raw_wq_count: %d wq_copy_count: %d cq_count: %d\n",
> +		fnic->fnic_num, __func__, __LINE__, fnic->rq_count, fnic->raw_wq_count,
> +		fnic->wq_copy_count, fnic->cq_count);
> +
> +	if (fnic->rq_count <= n && fnic->raw_wq_count <= m &&
> +		fnic->wq_copy_count <= o) {
> +		int vec_count = 0;
> +		int vecs = fnic->rq_count + fnic->raw_wq_count + fnic->wq_copy_count + 1;
> +
> +		vec_count = pci_alloc_irq_vectors(fnic->pdev, min_irqs, vecs,
> +					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
> +		FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
> +					"fnic<%d>: %s: %d: allocated %d MSI-X vectors\n",
> +					fnic->fnic_num, __func__, __LINE__, vec_count);
> +
> +		if (vec_count > 0) {
> +			if (vec_count < vecs) {
> +				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host,
> +				"fnic<%d>: %s: %d: interrupts number mismatch: vec_count: %d vecs: %d\n",
> +				fnic->fnic_num, __func__, __LINE__, vec_count, vecs);
> +				if (vec_count < min_irqs) {
> +					FNIC_ISR_DBG(KERN_ERR, fnic->lport->host,
> +								"fnic<%d>: %s: %d: no interrupts for copy wq\n",
> +								fnic->fnic_num, __func__, __LINE__);
> +					return 1;
> +				}
> +			}
> +
>   			fnic->rq_count = n;
>   			fnic->raw_wq_count = m;
> -			fnic->wq_copy_count = o;
> -			fnic->wq_count = m + o;
> -			fnic->cq_count = n + m + o;
> -			fnic->intr_count = vecs;
> -			fnic->err_intr_offset = FNIC_MSIX_ERR_NOTIFY;
> -
> -			FNIC_ISR_DBG(KERN_DEBUG, fnic->lport->host,
> -				     "Using MSI-X Interrupts\n");
> -			vnic_dev_set_intr_mode(fnic->vdev,
> -					       VNIC_DEV_INTR_MODE_MSIX);
> +			fnic->cpy_wq_base = fnic->rq_count + fnic->raw_wq_count;
> +			fnic->wq_copy_count = vec_count - n - m - 1;
> +			fnic->wq_count = fnic->raw_wq_count + fnic->wq_copy_count;
> +			if (fnic->cq_count != vec_count - 1) {
> +				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host,
> +				"fnic<%d>: %s: %d: CQ count: %d does not match MSI-X vector count: %d\n",
> +				fnic->fnic_num, __func__, __LINE__, fnic->cq_count, vec_count);
> +				fnic->cq_count = vec_count - 1;
> +			}
> +			fnic->intr_count = vec_count;
> +			fnic->err_intr_offset = fnic->rq_count + fnic->wq_count;
> +
> +			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
> +				"fnic<%d>: %s: %d: rq_count: %d raw_wq_count: %d cpy_wq_base: %d\n",
> +				fnic->fnic_num, __func__, __LINE__, fnic->rq_count,
> +				fnic->raw_wq_count, fnic->cpy_wq_base);
> +
> +			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
> +				"fnic<%d>: %s: %d: wq_copy_count: %d wq_count: %d cq_count: %d\n",
> +				fnic->fnic_num, __func__, __LINE__, fnic->wq_copy_count,
> +				fnic->wq_count, fnic->cq_count);
> +
> +			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
> +				"fnic<%d>: %s: %d: intr_count: %d err_intr_offset: %u",
> +				fnic->fnic_num, __func__, __LINE__, fnic->intr_count,
> +				fnic->err_intr_offset);
> +
> +			vnic_dev_set_intr_mode(fnic->vdev, VNIC_DEV_INTR_MODE_MSIX);
> +			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
> +					"fnic<%d>: %s: %d: fnic using MSI-X\n", fnic->fnic_num,
> +					__func__, __LINE__);
>   			return 0;
>   		}
>   	}
> +	return 1;
> +} //fnic_set_intr_mode_msix

Please avoid C99 style comments.

[ .. ]

Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

