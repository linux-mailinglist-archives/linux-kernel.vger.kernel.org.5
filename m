Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42917DEDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbjKBHxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:53:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7335F102;
        Thu,  2 Nov 2023 00:52:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F2A9218A9;
        Thu,  2 Nov 2023 07:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698911573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLiBWhtmGnSDfPRy3xOdq8QnV5pYqVrSSRLgADW4v/s=;
        b=N040Ivc9HrD2B5PAPycFqB2ugdn9ZgLx8IhkGJYCAcL8rmwfgtVXsfkFCDdkIwm1jV/3F6
        AolvCgy6ZgPOjgmTxLup5Gns7wUiROWfI4bbiDMCpfMaXAlKxYmB1K1yMQWoH9uWe9c/ZM
        +d2IMurI4KfnZUGDlA9Sdn4D1vQeLXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698911573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLiBWhtmGnSDfPRy3xOdq8QnV5pYqVrSSRLgADW4v/s=;
        b=EeonnGI/UefJ0grKxDTGDvOLYSn3oCWZ9QLiUMJ4Qh2N01gx7qrJ0rJ8vUWUn9mvZstsua
        uOl17TRMaqFGGNAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEC1513584;
        Thu,  2 Nov 2023 07:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W+zVNFRVQ2WnOwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 02 Nov 2023 07:52:52 +0000
Message-ID: <325bba3b-01eb-438e-bd14-9f3d12372931@suse.de>
Date:   Thu, 2 Nov 2023 08:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] scsi: fnic: Remove usage of host_lock
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-10-kartilak@cisco.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027180302.418676-10-kartilak@cisco.com>
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
> Remove usage of host_lock.
> Replace with fnic_lock, where necessary.
> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/fnic_scsi.c | 27 ++++++---------------------
>   1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
> index f32781f8fdd0..9a1beb3e7269 100644
> --- a/drivers/scsi/fnic/fnic_scsi.c
> +++ b/drivers/scsi/fnic/fnic_scsi.c
> @@ -170,17 +170,14 @@ __fnic_set_state_flags(struct fnic *fnic, unsigned long st_flags,
>   			unsigned long clearbits)
>   {
>   	unsigned long flags = 0;
> -	unsigned long host_lock_flags = 0;
>   
>   	spin_lock_irqsave(&fnic->fnic_lock, flags);
> -	spin_lock_irqsave(fnic->lport->host->host_lock, host_lock_flags);
>   
>   	if (clearbits)
>   		fnic->state_flags &= ~st_flags;
>   	else
>   		fnic->state_flags |= st_flags;
>   
> -	spin_unlock_irqrestore(fnic->lport->host->host_lock, host_lock_flags);
>   	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
>    >   	return;
> @@ -479,12 +476,6 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
>   
>   	atomic_inc(&fnic->in_flight);
>   
> -	/*
> -	 * Release host lock, use driver resource specific locks from here.
> -	 * Don't re-enable interrupts in case they were disabled prior to the
> -	 * caller disabling them.
> -	 */
> -	spin_unlock(lp->host->host_lock);
>   	fnic_priv(sc)->state = FNIC_IOREQ_NOT_INITED;
>   	fnic_priv(sc)->flags = FNIC_NO_FLAGS;
>   
> @@ -569,8 +560,6 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
>   			mempool_free(io_req, fnic->io_req_pool);
>   		}
>   		atomic_dec(&fnic->in_flight);
> -		/* acquire host lock before returning to SCSI */
> -		spin_lock(lp->host->host_lock);
>   		return ret;
>   	} else {
>   		atomic64_inc(&fnic_stats->io_stats.active_ios);
> @@ -598,8 +587,6 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
>   		spin_unlock_irqrestore(io_lock, flags);
>   
>   	atomic_dec(&fnic->in_flight);
> -	/* acquire host lock before returning to SCSI */
> -	spin_lock(lp->host->host_lock);
>   	return ret;
>   }
>   
If you remove the need for the host_lock during queuecommand() in your 
driver please rename 'fnic_queuecommand_lck()' to 'fnic_queuecommand()'
and remove the line

DEF_SCSI_QCMD(fnic_queuecommand)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

