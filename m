Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F177DED7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbjKBHhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjKBHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:37:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69E12D;
        Thu,  2 Nov 2023 00:36:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54DC921877;
        Thu,  2 Nov 2023 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698910615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dkp6PEiOqLQy+r2pUqF8bKxYAvZUiF5jHiLpQbze9c=;
        b=vJakYihiQwCgvAOPbBpTJ6t/6/f5UTQ2PpMFzPyXiw/JbWwClO8e9PucocxBIfTGuYQ/x3
        uyoXHTy6pMD9ifbqmEKJoJuJg1VPPYscfNkl8RUfRHzn03oINvD26yb1lSUaop6cpYc2AG
        v5xCpxdRFhSghOyzORZnJVDVANcfrQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698910615;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dkp6PEiOqLQy+r2pUqF8bKxYAvZUiF5jHiLpQbze9c=;
        b=VM4Rc1npSqCAR+GlevMwtns3b24dyPf8NihrnpOghH6FI1LQhZiWsCJCuFJOpaFsDOE8Oz
        qbo4GBz/IKigqnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3390138EC;
        Thu,  2 Nov 2023 07:36:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rtbnOZZRQ2XZNAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 02 Nov 2023 07:36:54 +0000
Message-ID: <f0e1431c-cfb3-4245-be79-a9f98d4b57fe@suse.de>
Date:   Thu, 2 Nov 2023 08:36:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] scsi: fnic: Refactor and redefine fnic.h for
 multiqueue
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-7-kartilak@cisco.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027180302.418676-7-kartilak@cisco.com>
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
> Refactor and re-define values in fnic.h to implement
> multiqueue(MQ) functionality.
> 
> VIC firmware allows fnic to create up to 64 copy
> workqueues. Update the copy workqueue max to 64.
> Modify the interrupt index to be in sync with the firmware
> to support MQ.
> Add irq number to the MSIX entry.
> Define a software workqueue table to track the status of
> io_reqs. Define a base for the copy workqueue.
> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/fnic.h | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
> index 9fd01a867788..f4390fc96323 100644
> --- a/drivers/scsi/fnic/fnic.h
> +++ b/drivers/scsi/fnic/fnic.h
> @@ -163,12 +163,21 @@ do {								\
>   #define FNIC_MAIN_NOTE(kern_level, host, fmt, args...)          \
>   	shost_printk(kern_level, host, fmt, ##args)
>   
> +#define FNIC_WQ_COPY_MAX 64
> +#define FNIC_WQ_MAX 1
> +#define FNIC_RQ_MAX 1
> +#define FNIC_CQ_MAX (FNIC_WQ_COPY_MAX + FNIC_WQ_MAX + FNIC_RQ_MAX)
> +#define FNIC_DFLT_IO_COMPLETIONS 256
> +
> +#define FNIC_MQ_CQ_INDEX        2
> +
>   extern const char *fnic_state_str[];
>   
>   enum fnic_intx_intr_index {
>   	FNIC_INTX_WQ_RQ_COPYWQ,
> -	FNIC_INTX_ERR,
> +	FNIC_INTX_DUMMY,
>   	FNIC_INTX_NOTIFY,
> +	FNIC_INTX_ERR,
>   	FNIC_INTX_INTR_MAX,
>   };
>   
> @@ -176,7 +185,7 @@ enum fnic_msix_intr_index {
>   	FNIC_MSIX_RQ,
>   	FNIC_MSIX_WQ,
>   	FNIC_MSIX_WQ_COPY,
> -	FNIC_MSIX_ERR_NOTIFY,
> +	FNIC_MSIX_ERR_NOTIFY = FNIC_MSIX_WQ_COPY + FNIC_WQ_COPY_MAX,
>   	FNIC_MSIX_INTR_MAX,
>   };
>   
> @@ -185,6 +194,7 @@ struct fnic_msix_entry {
>   	char devname[IFNAMSIZ + 11];
>   	irqreturn_t (*isr)(int, void *);
>   	void *devid;
> +	int irq_num;
>   };
>   
>   enum fnic_state {
> @@ -194,12 +204,6 @@ enum fnic_state {
>   	FNIC_IN_ETH_TRANS_FC_MODE,
>   };
>   
> -#define FNIC_WQ_COPY_MAX 1
> -#define FNIC_WQ_MAX 1
> -#define FNIC_RQ_MAX 1
> -#define FNIC_CQ_MAX (FNIC_WQ_COPY_MAX + FNIC_WQ_MAX + FNIC_RQ_MAX)
> -#define FNIC_DFLT_IO_COMPLETIONS 256
> -
>   struct mempool;
>   
>   enum fnic_evt {
> @@ -214,6 +218,13 @@ struct fnic_event {
>   	enum fnic_evt event;
>   };
>   
> +struct fnic_cpy_wq {
> +	unsigned long hw_lock_flags;
> +	u16 active_ioreq_count;
> +	u16 ioreq_table_size;
> +	____cacheline_aligned struct fnic_io_req **io_req_table;
> +};
> +
>   /* Per-instance private data structure */
>   struct fnic {
>   	int fnic_num;
> @@ -283,6 +294,7 @@ struct fnic {
>   	mempool_t *io_sgl_pool[FNIC_SGL_NUM_CACHES];
>   	spinlock_t io_req_lock[FNIC_IO_LOCKS];	/* locks for scsi cmnds */
>   
> +	unsigned int cpy_wq_base;

Please name it 'copy_wq_base'; all other instances in the driver
always names the structures 'copy', not 'cpy' too.
You are not really saving anything by omitting a single character.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

