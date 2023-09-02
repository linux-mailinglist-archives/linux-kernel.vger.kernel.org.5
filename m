Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685F57904D3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 05:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjIBDLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjIBDL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 23:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146071702;
        Fri,  1 Sep 2023 20:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F56B617FF;
        Sat,  2 Sep 2023 03:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF57C433C7;
        Sat,  2 Sep 2023 03:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693624285;
        bh=X28DUTrrakziC1R8ljW6NezQrkXnBXwDTB+t/6P2T1I=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Pop7jan0dxtwYaJoigLcuWNCYAOHFkT90DxtQN46LjD44g4yeryuIiVIU/LzufWsC
         ZzEbRVMNg6xVB5cOvxePcJEaqEFgKFpzCew680OyJdYSjVjJRXzmDEqkfWNXdBRdBB
         uyWj+wEH/lFdTwgnjh5xAaMYreKT6IiwSliEvGUNOIVDDZ+h2CZmQe2pLr6K20cbuy
         vYTL+nyLITV1i6SjfYdrC6YNIMUOcjUmuYRtnmDqtVVa6sfSRTbiQFJTZy2fLzuv3H
         Em2OCWThwY7q1vlm7Qe8gXb/Ms++KfVgppX3wrygYt3lmRqM4KmFmZaVsvKSp0Z+5G
         yrg4cFACEC92A==
Message-ID: <b3bb71ed-2303-d715-2efe-4fac8e6048d9@kernel.org>
Date:   Sat, 2 Sep 2023 12:11:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ata: Disable NCQ_TRIM on Micron 1100 drives
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Pawel Zmarzly <pzmarzly@meta.com>, Niklas.Cassel@wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZPIyxg+iSWa+W93Q@x1-carbon>
 <20230901200220.3891806-1-pzmarzly@meta.com>
 <91dc19a5-ea7f-1abf-1c35-5a9582036b83@kernel.org>
Organization: Western Digital Research
In-Reply-To: <91dc19a5-ea7f-1abf-1c35-5a9582036b83@kernel.org>
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

On 9/2/23 11:54, Damien Le Moal wrote:
> On 9/2/23 05:02, Pawel Zmarzly wrote:
>> Micron 1100 drives lock up when encountering queued TRIM command.
>> It is a quite old hardware series, for past years we have been
>> running our machines with these drives using
>> libata.force=noncqtrim.
>>
>> Signed-off-by: Pawel Zmarzly <pzmarzly@meta.com>
> 
> This does not apply cleanly on the fo-6.6 branch. Can you rebase your patch
> please and make sure it applies to libata tree for-6.6 branch ?

Don't bother. I applied the patch manually with some minor tweaks.
It is now queued for 6.6. Thanks.

> 
>> ---
>> V1 -> V2: Fixed formatting.
>> V2 -> V3: Added missing Signed off line. Sorry, this is my
>> first time upstreaming.
>>
>>  drivers/ata/libata-core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 175b2a9dc000..116f5fd6e3f7 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4564,6 +4564,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>> +	{ "Micron_1100_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>>
>>  	/* devices that don't properly handle TRIM commands */
>>  	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
>> --
>> 2.39.3
> 

-- 
Damien Le Moal
Western Digital Research

