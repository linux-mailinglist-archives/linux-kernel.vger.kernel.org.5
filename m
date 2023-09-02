Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8FC7904CD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 04:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351501AbjIBCyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 22:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIBCyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 22:54:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DF10FE;
        Fri,  1 Sep 2023 19:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E980CCE2531;
        Sat,  2 Sep 2023 02:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9760AC433C7;
        Sat,  2 Sep 2023 02:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693623274;
        bh=GXCRWO0jMBN7wM4ldPOMOsT+647zmRpPM5BTumXY1Zg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RCxq/1geyO1kOiweTGCMCADZmcX8Q7A9SBjKTMKU52nVimuUzi8cPoNhB8Rt/UoUi
         isjtYlSJmnrDPWD/EKnWb3m7A6thN9hd5nHKAm1qrnvQ/oHzl3YqLNcTNbzuUqpNNA
         QqmadZg6emwVv+Gf7JbfBRumGF29zMDUTViadkvGB+oFhl6kOd8GfzR2UM3qo6imz1
         IecLu/NgOlRnU5Hc263fjgaoTxiazw14dCOhv6sSmV7LqZAvcRZLh4sC2bOKkwlcKs
         LHdA6B1yKvMVRo4DrZF4oJ88bK90i0Cln3BfjyvwU5qmqvrlr5VH9A4loqnmlguSmg
         0w5co7S0kpavQ==
Message-ID: <91dc19a5-ea7f-1abf-1c35-5a9582036b83@kernel.org>
Date:   Sat, 2 Sep 2023 11:54:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ata: Disable NCQ_TRIM on Micron 1100 drives
To:     Pawel Zmarzly <pzmarzly@meta.com>, Niklas.Cassel@wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZPIyxg+iSWa+W93Q@x1-carbon>
 <20230901200220.3891806-1-pzmarzly@meta.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230901200220.3891806-1-pzmarzly@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/23 05:02, Pawel Zmarzly wrote:
> Micron 1100 drives lock up when encountering queued TRIM command.
> It is a quite old hardware series, for past years we have been
> running our machines with these drives using
> libata.force=noncqtrim.
> 
> Signed-off-by: Pawel Zmarzly <pzmarzly@meta.com>

This does not apply cleanly on the fo-6.6 branch. Can you rebase your patch
please and make sure it applies to libata tree for-6.6 branch ?

> ---
> V1 -> V2: Fixed formatting.
> V2 -> V3: Added missing Signed off line. Sorry, this is my
> first time upstreaming.
> 
>  drivers/ata/libata-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 175b2a9dc000..116f5fd6e3f7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4564,6 +4564,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "Micron_1100_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> 
>  	/* devices that don't properly handle TRIM commands */
>  	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
> --
> 2.39.3

-- 
Damien Le Moal
Western Digital Research

