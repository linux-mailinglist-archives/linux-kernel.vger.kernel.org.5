Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB9279367E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjIFHmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjIFHme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:42:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D9E43;
        Wed,  6 Sep 2023 00:42:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0259220292;
        Wed,  6 Sep 2023 07:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693986149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLT9++gLsH6wOnPwciuBmMI0zO20Ea7hglEGidN48MQ=;
        b=ewl4az09MZSoxvvUfk2yXTISsVBv4TfyROEsejVZVORQjBio/DcJbRZRdxUaRXjuNk8rcH
        ls7l2CsyCbRHT6OX0ZJARevx4x/msAJf0ge7yvU5R2F9o2jmHejDY02fxo8cfV4akL0YhK
        pX/zQcSGf44BArl50349w5dJYjetPc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693986149;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLT9++gLsH6wOnPwciuBmMI0zO20Ea7hglEGidN48MQ=;
        b=ZhrlmfJqMN4zi3lzjL0nc/Bb2xEFfh7l91LvTDzyFJ+FYh6ycYcAZntAuWzxV/s1icZBWw
        f10axAfjPQadorCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 793B51346C;
        Wed,  6 Sep 2023 07:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qo27GmQt+GToSgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Sep 2023 07:42:28 +0000
Message-ID: <9ee5affc-54b3-4b27-9311-4ed3bb73afc9@suse.de>
Date:   Wed, 6 Sep 2023 09:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Cache coherency bug: stale reads on /dev/sda1
Content-Language: en-US
To:     Joshua Hudson <joshudson@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me>
 <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
 <20230827020635.GQ3390869@ZenIV>
 <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
 <20230827041716.GR3390869@ZenIV>
 <CA+jjjYRY4+ZwX6OJQ1Ax16i5roRh-BPePPjyGv7coxvBrxXiEQ@mail.gmail.com>
 <20230827163000.GS3390869@ZenIV>
 <CA+jjjYT1NgR79CuBso4O_C=jVKRG8GKbv8xu9aqPJFv1hOJ=3Q@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <CA+jjjYT1NgR79CuBso4O_C=jVKRG8GKbv8xu9aqPJFv1hOJ=3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 20:33, Joshua Hudson wrote:
> On Sun, Aug 27, 2023 at 9:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> On Sun, Aug 27, 2023 at 07:39:03AM -0700, Joshua Hudson wrote:
>>> Offset 0x1C into the FAT filesystem is defined as "Count of hidden
>>> sectors preceding
>>> the partition that contains this FAT volume." It's been there since
>>> DOS 3.0. The Linux
>>> Kernel does not care what's in this field, but I have tools that have
>>> a hard time of it
>>> not being there. One example of a tool is BootDuet.
>>>
>>> The rationale is to reduce the number of tools that have to walk the
>>> partition table, the
>>> most obvious one being the boot sector itself which doesn't have room.
>>
>> ???
>>
>> That makes no sense whatsoever; "boot sector" here is the first sector
>> of _partition_, not that of the entire disk (that would be MBR).
>>
>> To quote the same wikipedia,
>> ----
>> A volume boot record (VBR) (also known as a volume boot sector,
>> a partition boot record or a partition boot sector) is a type of boot
>> sector introduced by the IBM Personal Computer. It may be found on a
>> partitioned data storage device, such as a hard disk, or an unpartitioned
>> device, such as a floppy disk, and contains machine code for bootstrapping
>> programs (usually, but not necessarily, operating systems) stored in other
>> parts of the device. On non-partitioned storage devices, it is the first
>> sector of the device. On partitioned devices, it is the first sector of
>> an individual partition on the device, with the first sector of the entire
>> device being a Master Boot Record (MBR) containing the partition table.
>> ----
>>
>> So your rationale doesn't work - you need to know where the partition is
>> just to read the sector that contains that field.  Or have access to
>> something that can be asked to read from partition, as opposed to the
>> entire disk (kernel, for example), but that something can usually be
>> asked where the hell does partition start.
> 
> The MBR doesn't look at the BPB. It looks at the first four bytes of the
> partition table entry, loads that sector (which is the VBR), and jumps to
> it. In the late 90s it became a thing to pass DL all the way through to
> enable booting from ZIP disks, but nothing else is passed from the MBR
> to the VBR. Thus, the BPB is in the VBR and describes the filesystem
> and knows its own offset (otherwise the disk would not boot).
> 
> https://github.com/FDOS/kernel/blob/132a0a9f94d23f13c90319bb0e0232a5f33164d8/boot/boot.asm#L203
> 
> Almost everybody depended on this exact behavior for dual booting. Each
> OS was defined in the boot menu as a path to a 512 byte file, which was
> that OS's boot sector. They don't access disk relative to their own position,
> but rather what their position should be.
> 
> So what I did: unmounted /boot/efi, started a virtual machine with /dev/sda
> as the disk, booted a different OS than the host OS, shut it down, and got
> very confused when changes to /boot/efi via the guest OS were not reflected
> in the host OS.
> 
>>
>> On anything with UEFI the first sector of the entire disk is likely to be
>> the "protective MBR" in the beginning of GPT.
>>
> 
> # dd if=/dev/sda bs=c skip=446 count=66 | hexdump -C
> 00000000  00 00 02 00 ee ff ff ff  01 00 00 00 af 88 e0 e8  |....îÿÿÿ....¯.àè|
> 00000010  80 20 21 00 06 df 13 0c  00 08 00 00 00 20 03 00  |. !..ß....... ..|
> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000040  55 aa                                             |Uª|
> 00000042
> 
> I wouldn't be too sure of that. And yes, the second line corresponds
> exactly to the EFI partition's entry in GPT.

Weelll ... if you already know that there's something in the FAT 
documentation which isn't implemented in Linux, why are you surprised 
that things don't work if you modify it?
And if you know that tools are relying on that specific field, why not 
implement support for that feature in linux?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

