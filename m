Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5057CA728
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjJPLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjJPLyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:54:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE98FA;
        Mon, 16 Oct 2023 04:54:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA2AC433C9;
        Mon, 16 Oct 2023 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697457261;
        bh=jnp5P3en1vHeqqxQoLLXerxN+beV4PtZf2uhERTkodE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jLJagp3fzr8HayPnMfB4McmPT5Y4qCyvwpKKWNBF1z9hB3CmU5G8suoiHJEyRsU3B
         bsQK+jwTpaoNODPUD/ngeY2DJ5dONQyL5KYt5/jUKZamoVrAj1PFg1yQYJMSAZUOiE
         q3iasQ8DNNapVa2dk0tPZch2rWljfiu18a0Yhu0mSxadkcvhqjncKrdNSJhbIqsfve
         Vch3Rl7oob+FkCu76xTSXNMidR94MiP9a71N0Fw/ZcFghyyXldoH+C7EvfOKUdCoXp
         2ZcsqJAsX+468w96mlzebOJLIo9sDhRNbIkQ8av7FVcQMvXKPA8Wrk0/dYgAeeLQPG
         kqCRP5xj7GMAw==
Message-ID: <0c7f0599-40de-417a-842d-d0aba842d115@kernel.org>
Date:   Mon, 16 Oct 2023 20:54:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: use ATA-12 pass-thru for OPAL as fallback
To:     Milan Broz <gmazyland@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org
References: <20231016070211.39502-1-gmazyland@gmail.com>
 <20231016070531.GA28537@lst.de>
 <bf4d0580-62b1-4959-8fc4-a7ab86b7e980@gmail.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <bf4d0580-62b1-4959-8fc4-a7ab86b7e980@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 16:24, Milan Broz wrote:
> On 10/16/23 09:05, Christoph Hellwig wrote:
>> On Mon, Oct 16, 2023 at 09:02:11AM +0200, Milan Broz wrote:
>>> All common USB/SATA or USB/NVMe adapters I tested need this patch.
>>>
>>> In short, these steps are run for OPAL support check:
>>>    1) Storage driver enables security driver flag (security_supported).
>>>       USB-attached storage drivers will enable it in a separate patchset.
>>>       SCSI and NNVMe drivers do it already. If the flag is not enabled,
>>>       no following steps are run, and OPAL remains disabled.
>>>    2) SCSI device enumerates SECURITY IN/OUT command support. If detected,
>>>       SECURITY ON/OUT wrapper is used (as in the current code).
>>>       If not, new ATA-12 pass-thru wrapper is used instead.
>>>    3) SED OPAL code tries OPAL discovery command for the device.
>>>       If it receives a correct reply, OPAL is enabled for the device.
>>>       If SCSI SECURITY or ATA-12 command with discovery command is rejected,
>>>       OPAL remains disabled.
>>>
>>> Note, USB attached storage needs an additional patchset sent separately
>>> as requested by USB driver maintainers (it contains required changes
>>> related to USB quirk processing).
>>
>> This just feels wrong.  These adapters are broken if they can't
>> translated, and we should not put ATA command submission into
>> sd.c.
> 
> I think it is blocked in USB layer as not running command enumeration,
> SCSI SECURITY will be never sent to the adapter through USB.
> 
> I understand the problem, but if you configure OPAL from userspace, ATA-12 is sent
> to these devices already - so why kernel cannot use it too?
> 
>>
>>> +	cdb[0] = ATA_12;
>>> +	cdb[1] = (send ? 5 /* ATA_PROTOCOL_PIO_DATA_IN */ : 4 /* ATA_PROTOCOL_PIO_DATA_OUT */) << 1;
>>> +	cdb[2] = 2 /* t_length */ | (1 << 2) /* byt_blok */ | ((send ?  0 : 1) << 3) /* t_dir */;
>>> +	cdb[3] = secp;
>>> +	put_unaligned_le16(len / 512, &cdb[4]);
>>> +	put_unaligned_le16(spsp, &cdb[6]);
>>> +	cdb[9] = send ? 0x5e /* ATA_CMD_TRUSTED_SND */: 0x5c /* ATA_CMD_TRUSTED_RCV */;
>>
>>
>> Also avoid all these crazy long lines, and please use the actual
>> constants.  Using a good old if/else is actually a very good way to
>> structure the code in a somewhat readable way.
> 
> Sure, I was trying to no add additional includes that will mess this up, I'll reformat it if needed.
> 
> Otherwise, this wrapper is exactly what is used is sedutils and also in our test utility
> that tries to work with OPAL commands directly
> https://github.com/mbroz/opal-toolset
> 
>>
>>> +		if (sdkp->security)
>>> +		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_sec_submit);
>>> +		else
>>> +		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_ata12_submit);
>>
>> Messed up indentation here.
> 
> sorry, my bad, I hate such formatting myself and missed it here :-)
>   
>> besides the fact that the statement is fundamentally wrong and you'll
>> start sending ATA command to random devices.
> 
> So what do you suggest? As I said, this exactly happen if you configure it from userspace.
> 
> Can this be somehow limited? I did not find and way how to do it.
The translation of SECURITY IN/OUT commands should go into usb uas.c, at the
very least. And even having it there is not great in my opinion. If the adapter
does not support Opal, don't use that feature, or use it only to lock/unlock the
drive from user space with passthrough.

Note that nowhere in your patch do you test if you are talking to an ATA device.
This can be done by testing for the existence of VPD page 89h. See
scsi_cdl_enable() in drivers/scsi/scsi.c for an example where we had to check
for that. But also note that we do not issue ATA commands based on that test. We
keep issuing SCSI commands and libata takes care of the translation. uas does
not use libata though, so if translation is needed, do it there.

But I have the same opinion as Christoph: working around USB adapters lack of
support for a feature with passthrough commands issued from the kernel is really
not ideal.

-- 
Damien Le Moal
Western Digital Research

