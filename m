Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74C793596
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjIFGtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjIFGtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:49:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C245CC3;
        Tue,  5 Sep 2023 23:49:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1417FC433C8;
        Wed,  6 Sep 2023 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693982969;
        bh=uasGGamLNhO03kpRJBSDvMhv53fkVk6TGqwr6D9fAUM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZTV4w53S1Ii+kDtOeQ5PC9Jvkg4JkabOW2cGFCrMOjSUOh0B+9I7Lc+ZSFElqPrVb
         cZj8johtSRAlTGszjIxIJuuAQbxNeSSmhDJlpg3OTMIK98Ao5+ZUfQc9oxrF4gSZkf
         5keAtyf41z4W+PoI5WfzibIbRGAWDqQd7Pdhl/xK/ZOc1BS5xvE5VeMER+LBrVkk45
         Hf6k29t5lKzHlgIty8tYPorrXuqaAIM4R4yBokQsBNC1l1WKCJGudGQhWYLFgvH1J5
         4K05RnLHDwPH0NCDuAmXYnZwvSFWKzGGVsu3UWR02oNubTQReslh0PTUHLNSpEFHIx
         DwIzm9adZgxRw==
Message-ID: <a01dc25c-16c0-2d72-23f1-d0955007fcc0@kernel.org>
Date:   Wed, 6 Sep 2023 15:49:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ata: libata-eh: Honor all EH scheduling requests
Content-Language: en-US
To:     linan666@huaweicloud.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
References: <20230906063321.905103-1-linan666@huaweicloud.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230906063321.905103-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 15:33, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
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
> The ata port remains frozen and will never be enabled.
> 
> To fix this issue, decrease 'host_eh_scheduled' instead of setting it to 0
> so that EH is scheduled again to re-enable the port. Also move the update
> of 'nr_active_links' to 0 when 'host_eh_scheduled' is 0 to
> ata_scsi_port_error_handler().
> 
> Reported-by: luojian <luojian5@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>

Looks good to me, but I think this needs a Fixes tag, and "Cc: stable".
Please add that.

> ---
> Changes in v3:
>  - change patch title, previously it was: "scsi: ata: Fix a race condition
>    between scsi error handler and ahci interrupt".
>  - drop the variable 'host' in ata_std_end_eh().
>  - improve commit message.
> 
>  drivers/ata/libata-eh.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 159ba6ba19eb..2d5ecd68b7e0 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -735,6 +735,12 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
>  	 */
>  	ap->ops->end_eh(ap);
>  
> +	if (!ap->scsi_host->host_eh_scheduled) {
> +		/* make sure nr_active_links is zero after EH */
> +		WARN_ON(ap->nr_active_links);
> +		ap->nr_active_links = 0;
> +	}
> +
>  	spin_unlock_irqrestore(ap->lock, flags);
>  	ata_eh_release(ap);
>  
> @@ -946,9 +952,7 @@ EXPORT_SYMBOL_GPL(ata_std_sched_eh);
>   */
>  void ata_std_end_eh(struct ata_port *ap)
>  {
> -	struct Scsi_Host *host = ap->scsi_host;
> -
> -	host->host_eh_scheduled = 0;
> +	ap->scsi_host->host_eh_scheduled--;
>  }
>  EXPORT_SYMBOL(ata_std_end_eh);
>  
> @@ -3922,10 +3926,6 @@ void ata_eh_finish(struct ata_port *ap)
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

