Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE597B756E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbjJCXop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbjJCXoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:44:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE0AC;
        Tue,  3 Oct 2023 16:44:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABD1C433C8;
        Tue,  3 Oct 2023 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696376681;
        bh=rO7tjPN6uZm4/JITt2OVrxGgcksZSVWaqqA8pZ0ZOyI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lqtIhGPHVnvZMhDfApG/78p4SAY3mcJ2ttjU9K4k5PG820Ykucd8bDs/rZvELZ4KE
         AAMFm9HT/4lOLaAi+C71LpWnp/7GYUbmLAAROIJgyOGfGV4xckXlHft5vSOo3Vl87f
         fPjTBryghCREO9zCrWxHOp91nEmZyraVzpmoO5uVkHyKnTQEpxM6klAzZNHmCBRc+u
         nSuqOdKAvzwQPD8UDEbw5lBFiEEUyaDOuTYBmBb6A/3jhUtlQI1OVqczGk7kQEg7zp
         gzkzKghKdRldVETkYSvlms60Sdc+DXGwb8b8mrc95b6Z/yvXZ+nqLKbm73VT3eTLu4
         N7I3+QggorWIw==
Message-ID: <32bda4e5-946d-44fd-8d80-e227f6b6dd18@kernel.org>
Date:   Wed, 4 Oct 2023 08:44:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] pata_parport: add custom version of wait_after_reset
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk>
 <20230930191511.24994-4-linux@zary.sk>
 <d2fd9a3c-3efd-dbfe-7b2a-dc36989b8379@kernel.org>
 <14129ea5-1597-efce-e782-23a95f3c0bd9@omp.ru>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <14129ea5-1597-efce-e782-23a95f3c0bd9@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 01:55, Sergey Shtylyov wrote:
> On 10/3/23 3:55 AM, Damien Le Moal wrote:
> 
> [...]
>>> Some parallel adapters (e.g. EXP Computer MC-1285B EPP Cable) return
>>> bogus values when there's no master device present. This can cause
>>> reset to fail, preventing the lone slave device (such as EXP Computer
>>> CD-865) from working.
>>>
>>> Add custom version of wait_after_reset that ignores master failure when
>>> a slave device is present. The custom version is also needed because
>>> the generic ata_sff_wait_after_reset uses direct port I/O for slave
>>> device detection.
>>>
>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>> ---
>>>  drivers/ata/pata_parport/pata_parport.c | 65 ++++++++++++++++++++++++-
>>>  1 file changed, 64 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
>>> index cf87bbb52f1f..b3db953e615a 100644
>>> --- a/drivers/ata/pata_parport/pata_parport.c
>>> +++ b/drivers/ata/pata_parport/pata_parport.c
>>> @@ -80,6 +80,69 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
>>>  	return (nsect == 0x55) && (lbal == 0xaa);
>>>  }
>>>  
>>> +static int pata_parport_wait_after_reset(struct ata_link *link,
>>> +					 unsigned int devmask,
>>> +					 unsigned long deadline)
>>> +{
>>> +	struct ata_port *ap = link->ap;
>>> +	struct pi_adapter *pi = ap->host->private_data;
>>> +	unsigned int dev0 = devmask & (1 << 0);
>>> +	unsigned int dev1 = devmask & (1 << 1);
>>> +	int rc, ret = 0;
>>> +
>>> +	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
>>> +
>>> +	/* always check readiness of the master device */
>>> +	rc = ata_sff_wait_ready(link, deadline);
>>> +	/* some adapters return bogus values if master device is not present,
>>> +	 * so don't abort now if a slave device is present
>>> +	 */
>>
>> In addition to Sergey's comment, please move this comment inside the "if", or
>> even better, merge it with the otherwise not very useful "always check
>> readiness..." comment.
> 
>    That comment was copied from ata_sff_wait_after_reset(), I think...

Even if that is the case. let's not copy bad stuff as is but rather improve it.


-- 
Damien Le Moal
Western Digital Research

