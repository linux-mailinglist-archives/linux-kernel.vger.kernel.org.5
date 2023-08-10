Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3933776E33
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHJCtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHJCty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EC91AA;
        Wed,  9 Aug 2023 19:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0742464313;
        Thu, 10 Aug 2023 02:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712E4C433C8;
        Thu, 10 Aug 2023 02:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691635792;
        bh=ebULMWhvsPCO8F3ADghLHgSJcz00/IYtgPSSnkAJqnU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rc4gKSUXbCrMBCNr5W60PtLJzUAdG73P4Pfl4Y1yEm/Usx1y85vlEuXEoAdgCI60R
         E4eVAxXPtNzrn8pS8NiXWm6TRiFU0tr6PRV2L2RpnPcMu3AeC2AGhHyEb8te28fD21
         OrbOXryYFlgpcfglPd8lKGNkmlGjlhc7shbLHkWAK6qZclpD/O6hVclwjFOMMYkMxs
         qYrrwHeq9WSYdd/qiJ8mBL9+NIru0iSlchsdLrFoE+muF5Kw2AV00J5vydyerED/LD
         WjX64NdjdukO91jwSipS11W6kgKyZV4lHL76JgSRJdw4w5wwb3pulxFANKP5OKjBXR
         ix7fkL7+PrIlg==
Message-ID: <25c1aca7-d885-0fff-2639-bb68a7dff44f@kernel.org>
Date:   Thu, 10 Aug 2023 11:49:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Content-Language: en-US
To:     linan666@huaweicloud.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230810014848.2148316-1-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 10:48, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 

Please explain the problem first instead of starting with a function call
timeline which cannot ba analized without explanations.

> interrupt                            scsi_eh
> 
> ahci_error_intr
>   =>ata_port_freeze
>     =>__ata_port_freeze
>       =>ahci_freeze (turn IRQ off)
>     =>ata_port_abort
>       =>ata_port_schedule_eh
>         =>shost->host_eh_scheduled++;
>         host_eh_scheduled = 1
>                                      scsi_error_handler
>                                        =>ata_scsi_error
>                                          =>ata_scsi_port_error_handler
>                                            =>ahci_error_handler
>                                            . =>sata_pmp_error_handler
>                                            .   =>ata_eh_thaw_port
>                                            .     =>ahci_thaw (turn IRQ on)
> ahci_error_intr                            .
>   =>ata_port_freeze                        .
>     =>__ata_port_freeze                    .
>       =>ahci_freeze (turn IRQ off)         .
>     =>ata_port_abort                       .
>       =>ata_port_schedule_eh               .
>         =>shost->host_eh_scheduled++;      .
>         host_eh_scheduled = 2              .
>                                            =>ata_std_end_eh
>                                              =>host->host_eh_scheduled = 0;
> 
> 'host_eh_scheduled' is 0 and scsi eh thread will not be scheduled again,
> and the ata port remain freeze and will never be enabled.
> 
> If EH thread is already running, no need to freeze port and schedule
> EH again.
> 
> Reported-by: luojian <luojian5@huawei.com>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/ata/libahci.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index e2bacedf28ef..0dfb0b807324 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1840,9 +1840,17 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
>  
>  	/* okay, let's hand over to EH */
>  
> -	if (irq_stat & PORT_IRQ_FREEZE)
> +	if (irq_stat & PORT_IRQ_FREEZE) {
> +		/*
> +		 * EH already running, this may happen if the port is
> +		 * thawed in the EH. But we cannot freeze it again
> +		 * otherwise the port will never be thawed.
> +		 */
> +		if (ap->pflags & (ATA_PFLAG_EH_PENDING |
> +			ATA_PFLAG_EH_IN_PROGRESS))
> +			return;

This is definitely not correct because EH may have been scheduled for a non
fatal action like a device revalidate or to get sense data for successful
commands. With this change, the port will NOT be frozen when a hard error IRQ
comes while EH is waiting to start, that is, while EH waits for all commands to
complete first.

Furthermore, if you get an IRQ that requires the port to be frozen, it means
that you had a failed command. In that case, the drive is in error state per
ATA specs and stops all communication until a read log 10h command is issued.
So you should never ever see 2 error IRQs one after the other. If you do, it
very likely means that you have buggy hardware.

How do you get into this situation ? What adapter and disk are you using ?

>  		ata_port_freeze(ap);
> -	else if (fbs_need_dec) {
> +	} else if (fbs_need_dec) {
>  		ata_link_abort(link);
>  		ahci_fbs_dec_intr(ap);
>  	} else

-- 
Damien Le Moal
Western Digital Research

