Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC217929FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355231AbjIEQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353734AbjIEHod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:44:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E121A8;
        Tue,  5 Sep 2023 00:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 656C3CE1084;
        Tue,  5 Sep 2023 07:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A7AC433C7;
        Tue,  5 Sep 2023 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693899866;
        bh=+l3rfFLGFzBDr18wALmhu/B90ZUTWBu/id4MmC+UIgQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UhWjRbUlfuJ2tN7GCYvW3E7bsjmpLghbeMv3jJV1a80bm1070gWcws1PQWwk74rUS
         uqWVAS9xlN5aGEkpDGm2DCdOxxu4LMgkF7mxkSYAfIE2QvGByiYb/7UbSC8MmOHHJi
         0S8gsykFqUOAhYbbGSB6d4ke55rr2sCABf7GfrIeZ0QikxPZWhIBp8I6PW1lL2DnD1
         ZFtAEKaEcqBQti5eB1/E0ZGuBF4qnWVdIUds+5yEyot819V1Kq8BKt0r3odSNtDU6O
         aVKdKYkEd1snVPRNP72E0eGF/x7eDxTHWVZ+uHNTEQf+oEjxLNZsF0EL/u/oBVke8D
         Rvs8zXzXfxQ+Q==
Message-ID: <c4d397c4-1969-935f-6dc3-cf7775d96f5c@kernel.org>
Date:   Tue, 5 Sep 2023 16:44:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Content-Language: en-US
To:     linan666@huaweicloud.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
References: <20230905034840.478332-1-linan666@huaweicloud.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230905034840.478332-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 12:48, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>

Please change the patch title to something like:

ata: libata-eh: Honor all EH scheduling requests

Because the issue could happen I think with other ata drivers than AHCI.


> 
> If a disk is removed and quickly inserted when an I/O error is processing,
> the disk may not be able to be re-added. The function call timeline is as
> follows:
> 
>   interrupt                            scsi_eh
> 
>   ahci_error_intr
>    ata_port_freeze
>     __ata_port_freeze
>      =>ahci_freeze (turn IRQ off)
>     ata_port_abort
>      ata_do_link_abort
>       ata_port_schedule_eh
>        =>ata_std_sched_eh
>         ata_eh_set_pending
> 	 set EH_PENDING
>         scsi_schedule_eh
>          shost->host_eh_scheduled++ (=1)
>                                        scsi_error_handler
>                                         =>ata_scsi_error
>                                          ata_scsi_port_error_handler
> 					  clear EH_PENDING
>                                           =>ahci_error_handler
>                                           . sata_pmp_error_handler
>                                           .  ata_eh_reset
>                                           .   ata_eh_thaw_port
>                                           .   . =>ahci_thaw (turn IRQ on)
>   ahci_error_intr			  .   .
>    ata_port_freeze			  .   .
>     __ata_port_freeze			  .   .
>      =>ahci_freeze (turn IRQ off)	  .   .
>     ...					  .   .
>         ata_eh_set_pending		  .   .
> 	 set EH_PENDING			  .   .
>         scsi_schedule_eh		  .   .
>          shost->host_eh_scheduled++ (=2)  .   .
> 					  .   clear EH_PENDING
> 					  check EH_PENDING
>                                           =>ata_std_end_eh
>                                            host->host_eh_scheduled = 0;
> 
> 'host_eh_scheduled' is 0 and scsi eh thread will not be scheduled again.
> The ata port remain freeze and will never be enabled.

s/remain freeze/remains frozen

> 
> Decrease ’host_eh_scheduled‘ instead of set it to 0 roughly and move
> WARN_ON of nr_active_links to ata_scsi_port_error_handler().

To fix this issue, decrease ’host_eh_scheduled‘ instead of setting it to 0 so
that EH is scheduled again to re-enable the port. Also move the update of
nr_active_links to 0 when host_eh_scheduled is 0 to ata_scsi_port_error_handler().

> 
> Reported-by: luojian <luojian5@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
> Changes in v2:
>   - fix the bug by decrease 'host_eh_scheduled’
>   - improve commit message.
> 
>  drivers/ata/libata-eh.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 159ba6ba19eb..b9454756ecde 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -735,6 +735,12 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
>  	 */
>  	ap->ops->end_eh(ap);
>  
> +	if (!ap->scsi_host->host_eh_scheduled) {
> +		/* make sure nr_active_links is zero after EH */
> +		WARN_ON(ap->nr_active_links);
> +		ap->nr_active_links = 0;> +	}
> +
>  	spin_unlock_irqrestore(ap->lock, flags);
>  	ata_eh_release(ap);
>  
> @@ -948,7 +954,7 @@ void ata_std_end_eh(struct ata_port *ap)
>  {
>  	struct Scsi_Host *host = ap->scsi_host;
>  
> -	host->host_eh_scheduled = 0;
> +	host->host_eh_scheduled--;

While at it, please drop the host variable:

	ap->scsi_host->host_eh_scheduled--;

is just fine.

>  }
>  EXPORT_SYMBOL(ata_std_end_eh);
>  
> @@ -3922,10 +3928,6 @@ void ata_eh_finish(struct ata_port *ap)
>  			}
>  		}
>  	}
> -
> -	/* make sure nr_active_links is zero after EH */
> -	WARN_ON(ap->nr_active_links);
> -	ap->nr_active_links = 0;
>  }
>  
>  /**

-- 
Damien Le Moal
Western Digital Research

