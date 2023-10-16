Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C867CA8C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjJPNBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPNBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:01:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43026E6;
        Mon, 16 Oct 2023 06:01:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED62BC433C8;
        Mon, 16 Oct 2023 13:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697461279;
        bh=vpUNhljwKgb5BP6YZVQ66zALANNusDgM5UcSvt8Sps4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gk40ngiHuktiRRugnzG55mRti11EX4y9uDBCB1q1eVfbRZVuInK+za3E+27xlz1fF
         KS6UQnQ24AlJjUlOuDX8bWcLbbBf6Tfct6tZ/NYh8+fSLv+3EwDVbMjFqHcgjE3OB+
         7YdCfEEJdsMYOZhwIB3xmNdhdzB8s3K6cuT6LSBhdBzJxV+rwdu7+3O+QwsgxT1c82
         m4Pzc3+GvO3ynlYAI8uKanqqJZuSY8drD6v4ZrN/1fTe9QvcGUDqMbao9ekZhLtuY1
         iq8R4E7uTDVIvczEdSlBpnVHc3pNv+v5kjOh7r6jFBADpR2EUc+WhEnkjC5OC2raFe
         nB4Q9oQVdskOQ==
Message-ID: <cc4d812e-073a-41f5-95c9-575f20c3edba@kernel.org>
Date:   Mon, 16 Oct 2023 22:01:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: use ATA-12 pass-thru for OPAL as fallback
Content-Language: en-US
To:     Milan Broz <gmazyland@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org
References: <20231016070211.39502-1-gmazyland@gmail.com>
 <20231016070531.GA28537@lst.de>
 <bf4d0580-62b1-4959-8fc4-a7ab86b7e980@gmail.com>
 <0c7f0599-40de-417a-842d-d0aba842d115@kernel.org>
 <5831286b-e3d0-4b87-9c5c-dbcb420d1b67@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5831286b-e3d0-4b87-9c5c-dbcb420d1b67@gmail.com>
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

On 10/16/23 21:46, Milan Broz wrote:
> On 10/16/23 13:54, Damien Le Moal wrote:
>> On 10/16/23 16:24, Milan Broz wrote:
>>> On 10/16/23 09:05, Christoph Hellwig wrote:
>>>> On Mon, Oct 16, 2023 at 09:02:11AM +0200, Milan Broz wrote:
>>>>> All common USB/SATA or USB/NVMe adapters I tested need this patch.
>>>>>
>>>>> In short, these steps are run for OPAL support check:
>>>>>     1) Storage driver enables security driver flag (security_supported).
>>>>>        USB-attached storage drivers will enable it in a separate patchset.
>>>>>        SCSI and NNVMe drivers do it already. If the flag is not enabled,
>>>>>        no following steps are run, and OPAL remains disabled.
>>>>>     2) SCSI device enumerates SECURITY IN/OUT command support. If detected,
>>>>>        SECURITY ON/OUT wrapper is used (as in the current code).
>>>>>        If not, new ATA-12 pass-thru wrapper is used instead.
>>>>>     3) SED OPAL code tries OPAL discovery command for the device.
>>>>>        If it receives a correct reply, OPAL is enabled for the device.
>>>>>        If SCSI SECURITY or ATA-12 command with discovery command is rejected,
>>>>>        OPAL remains disabled.
>>>>>
>>>>> Note, USB attached storage needs an additional patchset sent separately
>>>>> as requested by USB driver maintainers (it contains required changes
>>>>> related to USB quirk processing).
>>>>
>>>> This just feels wrong.  These adapters are broken if they can't
>>>> translated, and we should not put ATA command submission into
>>>> sd.c.
>>>
>>> I think it is blocked in USB layer as not running command enumeration,
>>> SCSI SECURITY will be never sent to the adapter through USB.
>>>
>>> I understand the problem, but if you configure OPAL from userspace, ATA-12 is sent
>>> to these devices already - so why kernel cannot use it too?
>>>
>>>>
>>>>> +	cdb[0] = ATA_12;
>>>>> +	cdb[1] = (send ? 5 /* ATA_PROTOCOL_PIO_DATA_IN */ : 4 /* ATA_PROTOCOL_PIO_DATA_OUT */) << 1;
>>>>> +	cdb[2] = 2 /* t_length */ | (1 << 2) /* byt_blok */ | ((send ?  0 : 1) << 3) /* t_dir */;
>>>>> +	cdb[3] = secp;
>>>>> +	put_unaligned_le16(len / 512, &cdb[4]);
>>>>> +	put_unaligned_le16(spsp, &cdb[6]);
>>>>> +	cdb[9] = send ? 0x5e /* ATA_CMD_TRUSTED_SND */: 0x5c /* ATA_CMD_TRUSTED_RCV */;
>>>>
>>>>
>>>> Also avoid all these crazy long lines, and please use the actual
>>>> constants.  Using a good old if/else is actually a very good way to
>>>> structure the code in a somewhat readable way.
>>>
>>> Sure, I was trying to no add additional includes that will mess this up, I'll reformat it if needed.
>>>
>>> Otherwise, this wrapper is exactly what is used is sedutils and also in our test utility
>>> that tries to work with OPAL commands directly
>>> https://github.com/mbroz/opal-toolset
>>>
>>>>
>>>>> +		if (sdkp->security)
>>>>> +		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_sec_submit);
>>>>> +		else
>>>>> +		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_ata12_submit);
>>>>
>>>> Messed up indentation here.
>>>
>>> sorry, my bad, I hate such formatting myself and missed it here :-)
>>>    
>>>> besides the fact that the statement is fundamentally wrong and you'll
>>>> start sending ATA command to random devices.
>>>
>>> So what do you suggest? As I said, this exactly happen if you configure it from userspace.
>>>
>>> Can this be somehow limited? I did not find and way how to do it.
>> The translation of SECURITY IN/OUT commands should go into usb uas.c, at the
>> very least. And even having it there is not great in my opinion. If the adapter
>> does not support Opal, don't use that feature, or use it only to lock/unlock the
>> drive from user space with passthrough.
> 
> I was resisting to support OPAL hw for long time, but once we decided to add it as
> an additional (and optional) layer for LUKS, I would like it to be supported also
> for external drives (if technically possible).
> 
> The problem is that we (for simplicity) decided to use kernel SED-ioctl interface that
> internally wraps OPAL command to SCSI SECURITY command only. It means, that all devices
> that can use ATA-12 just cannot work with this kernel interface (unlike userspace which
> can decide which wrapper to use).
> 
> And IMO it is not correct - if it was designed only for some servers with directly connected
> devices, then it is really not generic OPAL support. It should work for any hw that supports it.
> 
> For USB, it actually works quite nice with the patch (ignoring usual bugs in firmware).
> 
>>
>> Note that nowhere in your patch do you test if you are talking to an ATA device.
> 
> Yes, I know. I expected the command to be rejected if not supported.
> 
>> This can be done by testing for the existence of VPD page 89h. See
>> scsi_cdl_enable() in drivers/scsi/scsi.c for an example where we had to check
>> for that. But also note that we do not issue ATA commands based on that test. We
>> keep issuing SCSI commands and libata takes care of the translation. uas does
>> not use libata though, so if translation is needed, do it there.
> 
> So, you mean translate SCSI SECURITY to ATA-12 inside USB storage drivers?
> 
> (There are actually two places, UAS driver and then SCSI glue for mass-storage -
> unfortunately, we need both.)

In the generic uas code, yes. sd is scsi-disk driver. That has no business
issuing ATA commands with passthrough. The UAS based translation would be like a
complement to the adapter SAT layer, which is the one not supporting OPAL in the
first place.

>> But I have the same opinion as Christoph: working around USB adapters lack of
>> support for a feature with passthrough commands issued from the kernel is really
>> not ideal.
> 
> Well, I have several adapters and many OPAL drives, none works with SCSI commands
> if connected through USB. Partially it is missing support in USB layer, but the rest
> is mess in hw. I know it is **** but that's how it is; people have these and want
> to use it (including myself).

Yes, USB mass storage adapters are generally dumb beyond help... Even technology
several years old are still not supported (e.g. host managed SMR).

> 
> IMO it is quite similar to discard/TRIM support...

I do not think so. These have well defined translations. There are a lot of
drives with buggy implementations of these commands though.

> 
> Thanks,
> Milan

-- 
Damien Le Moal
Western Digital Research

