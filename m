Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5679398B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbjIFKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjIFKKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:10:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00967171D;
        Wed,  6 Sep 2023 03:10:04 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qdpTx-0003eF-Va; Wed, 06 Sep 2023 12:09:58 +0200
Message-ID: <4a639fff-445e-455b-9a31-57368d6b7021@leemhuis.info>
Date:   Wed, 6 Sep 2023 12:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH AUTOSEL 6.1 10/15] scsi: aacraid: Reply queue mapping to
 CPUs based on IRQ affinity
Content-Language: en-US, de-DE
To:     Sasha Levin <sashal@kernel.org>,
        Sagar Biradar <sagar.biradar@microchip.com>
Cc:     Gilbert Wu <gilbert.wu@microchip.com>,
        John Garry <john.g.garry@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        aacraid@microsemi.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230829133245.520176-1-sashal@kernel.org>
 <20230829133245.520176-10-sashal@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230829133245.520176-10-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693995005;d2075766;
X-HE-SMSGID: 1qdpTx-0003eF-Va
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.23 15:32, Sasha Levin wrote:
> From: Sagar Biradar <sagar.biradar@microchip.com>
> 
> [ Upstream commit 9dc704dcc09eae7d21b5da0615eb2ed79278f63e ]
> 
> Fix the I/O hang that arises because of the MSIx vector not having a mapped
> online CPU upon receiving completion.

Sasha: you might want to consider dropping this from the 6.1 and 5.15
autosel queues for now, as this commit apparently causes a regression:
https://bugzilla.kernel.org/show_bug.cgi?id=217599

Sagar Biradar: as this is a commit of yours; could you please look into
the report? It was bisected a few weeks ago, but I suspect nobody told
you. Ahh, the joys of bugzilla.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

> SCSI cmds take the blk_mq route, which is setup during init. Reserved cmds
> fetch the vector_no from mq_map after init is complete. Before init, they
> have to use 0 - as per the norm.
> 
> Reviewed-by: Gilbert Wu <gilbert.wu@microchip.com>
> Signed-off-by: Sagar Biradar <Sagar.Biradar@microchip.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Link: https://lore.kernel.org/r/20230519230834.27436-1-sagar.biradar@microchip.com
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/scsi/aacraid/aacraid.h |  1 +
>  drivers/scsi/aacraid/commsup.c |  6 +++++-
>  drivers/scsi/aacraid/linit.c   | 14 ++++++++++++++
>  drivers/scsi/aacraid/src.c     | 25 +++++++++++++++++++++++--
>  4 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
> index 5e115e8b2ba46..7c6efde75da66 100644
> --- a/drivers/scsi/aacraid/aacraid.h
> +++ b/drivers/scsi/aacraid/aacraid.h
> @@ -1678,6 +1678,7 @@ struct aac_dev
>  	u32			handle_pci_error;
>  	bool			init_reset;
>  	u8			soft_reset_support;
> +	u8			use_map_queue;
>  };
>  
>  #define aac_adapter_interrupt(dev) \
> diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
> index deb32c9f4b3e6..3f062e4013ab6 100644
> --- a/drivers/scsi/aacraid/commsup.c
> +++ b/drivers/scsi/aacraid/commsup.c
> @@ -223,8 +223,12 @@ int aac_fib_setup(struct aac_dev * dev)
>  struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
>  {
>  	struct fib *fibptr;
> +	u32 blk_tag;
> +	int i;
>  
> -	fibptr = &dev->fibs[scsi_cmd_to_rq(scmd)->tag];
> +	blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
> +	i = blk_mq_unique_tag_to_tag(blk_tag);
> +	fibptr = &dev->fibs[i];
>  	/*
>  	 *	Null out fields that depend on being zero at the start of
>  	 *	each I/O
> diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
> index 5ba5c18b77b46..bff49b8ab057d 100644
> --- a/drivers/scsi/aacraid/linit.c
> +++ b/drivers/scsi/aacraid/linit.c
> @@ -19,6 +19,7 @@
>  
>  #include <linux/compat.h>
>  #include <linux/blkdev.h>
> +#include <linux/blk-mq-pci.h>
>  #include <linux/completion.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -505,6 +506,15 @@ static int aac_slave_configure(struct scsi_device *sdev)
>  	return 0;
>  }
>  
> +static void aac_map_queues(struct Scsi_Host *shost)
> +{
> +	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
> +
> +	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
> +			      aac->pdev, 0);
> +	aac->use_map_queue = true;
> +}
> +
>  /**
>   *	aac_change_queue_depth		-	alter queue depths
>   *	@sdev:	SCSI device we are considering
> @@ -1489,6 +1499,7 @@ static struct scsi_host_template aac_driver_template = {
>  	.bios_param			= aac_biosparm,
>  	.shost_groups			= aac_host_groups,
>  	.slave_configure		= aac_slave_configure,
> +	.map_queues			= aac_map_queues,
>  	.change_queue_depth		= aac_change_queue_depth,
>  	.sdev_groups			= aac_dev_groups,
>  	.eh_abort_handler		= aac_eh_abort,
> @@ -1776,6 +1787,8 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>  	shost->max_lun = AAC_MAX_LUN;
>  
>  	pci_set_drvdata(pdev, shost);
> +	shost->nr_hw_queues = aac->max_msix;
> +	shost->host_tagset = 1;
>  
>  	error = scsi_add_host(shost, &pdev->dev);
>  	if (error)
> @@ -1908,6 +1921,7 @@ static void aac_remove_one(struct pci_dev *pdev)
>  	struct aac_dev *aac = (struct aac_dev *)shost->hostdata;
>  
>  	aac_cancel_rescan_worker(aac);
> +	aac->use_map_queue = false;
>  	scsi_remove_host(shost);
>  
>  	__aac_shutdown(aac);
> diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
> index 11ef58204e96f..61949f3741886 100644
> --- a/drivers/scsi/aacraid/src.c
> +++ b/drivers/scsi/aacraid/src.c
> @@ -493,6 +493,10 @@ static int aac_src_deliver_message(struct fib *fib)
>  #endif
>  
>  	u16 vector_no;
> +	struct scsi_cmnd *scmd;
> +	u32 blk_tag;
> +	struct Scsi_Host *shost = dev->scsi_host_ptr;
> +	struct blk_mq_queue_map *qmap;
>  
>  	atomic_inc(&q->numpending);
>  
> @@ -505,8 +509,25 @@ static int aac_src_deliver_message(struct fib *fib)
>  		if ((dev->comm_interface == AAC_COMM_MESSAGE_TYPE3)
>  			&& dev->sa_firmware)
>  			vector_no = aac_get_vector(dev);
> -		else
> -			vector_no = fib->vector_no;
> +		else {
> +			if (!fib->vector_no || !fib->callback_data) {
> +				if (shost && dev->use_map_queue) {
> +					qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
> +					vector_no = qmap->mq_map[raw_smp_processor_id()];
> +				}
> +				/*
> +				 *	We hardcode the vector_no for
> +				 *	reserved commands as a valid shost is
> +				 *	absent during the init
> +				 */
> +				else
> +					vector_no = 0;
> +			} else {
> +				scmd = (struct scsi_cmnd *)fib->callback_data;
> +				blk_tag = blk_mq_unique_tag(scsi_cmd_to_rq(scmd));
> +				vector_no = blk_mq_unique_tag_to_hwq(blk_tag);
> +			}
> +		}
>  
>  		if (native_hba) {
>  			if (fib->flags & FIB_CONTEXT_FLAG_NATIVE_HBA_TMF) {
