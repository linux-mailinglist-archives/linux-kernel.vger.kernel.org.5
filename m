Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED775A91D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGTIY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGTIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:24:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D826AD;
        Thu, 20 Jul 2023 01:24:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E7A422A1E;
        Thu, 20 Jul 2023 08:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689841459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/lqrPJHJ301EskkP7uYoZhLyn+KpT4pekkb8H3GJ54=;
        b=HyrYogHBg4I7GNRpb0GpoEK+9TsC0eSYQo+9/zjkEx+NQuOdLP8OKgeSWK3z7fbYjbQ+lS
        XlPoSj4+TNI4A3k+8Wd+M5icKNLZBWOeG13615fZpMSUR1PyOGn9D3D0PnWSjXjCRmIZA0
        2vCJpO9l+iEyJRpGg8+rY5hcmzdbVkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689841459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/lqrPJHJ301EskkP7uYoZhLyn+KpT4pekkb8H3GJ54=;
        b=u7X9c28VCrMvNoTHJcbjY2dK/qJNm+Wmy73OTkIynCG2bZ5i1lKdJh1by+2369iENgNJqx
        LmbwrRzLf6Hiv1AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36E83133DD;
        Thu, 20 Jul 2023 08:24:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LtfiDDPvuGSIIwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 20 Jul 2023 08:24:19 +0000
Message-ID: <0592e021-237d-6d41-7faf-e5b93aefbeea@suse.de>
Date:   Thu, 20 Jul 2023 10:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 3/6] block: add new genhd flag GENHD_FL_NO_NVMEM
To:     Daniel Golle <daniel@makrotopia.org>, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
References: <cover.1689802933.git.daniel@makrotopia.org>
 <96510d925cb0ca1a3a132f8f8affd4bbdafd8fc9.1689802933.git.daniel@makrotopia.org>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <96510d925cb0ca1a3a132f8f8affd4bbdafd8fc9.1689802933.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 00:03, Daniel Golle wrote:
> Add new flag to destinguish block devices which should not act as an
> NVMEM provider, such as for example an emulated block device on top of
> an MTD partition which already acts as an NVMEM provider itself.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   include/linux/blkdev.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2f5371b8482c0..e853d1815be15 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -80,11 +80,14 @@ struct partition_meta_info {
>    * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
>    * scan for partitions from add_disk, and users can't add partitions manually.
>    *
> + * ``GENHD_FL_NO_NVMEM``: NVMEM emulation is disabled.  The kernel will not
> + * emulate an NVMEM device on top of this disk.
>    */
>   enum {
>   	GENHD_FL_REMOVABLE			= 1 << 0,
>   	GENHD_FL_HIDDEN				= 1 << 1,
>   	GENHD_FL_NO_PART			= 1 << 2,
> +	GENHD_FL_NO_NVMEM			= 1 << 3,
>   };
>   
>   enum {
Please reverse this flag. Most of the devices will not have an NVMEM 
partition, and we shouldn't require each and every driver to tag their 
devices.
So please use GENHD_FL_NVMEM and only set this flag on devices which 
really have an NVMEM partition.

Cheers,

Hannes

