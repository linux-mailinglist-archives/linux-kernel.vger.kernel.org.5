Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0479F5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjINApX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjINApW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:45:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C61BCD;
        Wed, 13 Sep 2023 17:45:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7A5C433C7;
        Thu, 14 Sep 2023 00:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694652317;
        bh=kBnMBN/ENgZGPLk+e6DZnKxk/Ir9kgGRHyAkZz0wr5k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pUq+IybfYXCAweicGW8I8ecrJZIzywOdWLZLgWZpqz2JRaXBGZ0TW6nxQ9HZcj3QF
         lcsqCU+hvLgRYtxu0EiLQxCJHUycj8RhKu9y1PhVDnzGJ+SuzgOkn6hKvGhy6QEgO2
         gFhOCUTmgE/tCgEmbnm9EOFZcQXcr3HetDRYBPqC14vSXvWKjcd9JbmMoXMhkhtwXE
         8tcJR1c10jg/v3Euepy2LgBCeCnPhEfiL0eLcx5D13Vc2WzNXDxY0Ir7UqN8Tg9eYC
         gC7OLMSTGGNLnDRTchlScHk+ALWHulljolJFUAKksls6EmdqT85MRC0E/+Q48yNzX2
         4+v2WV9pVXuhQ==
Message-ID: <b00738c5-751a-b345-a77f-bfabb93ecab5@kernel.org>
Date:   Thu, 14 Sep 2023 09:45:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
To:     John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
 <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
 <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
 <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
 <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
 <CAK7LNATktSBFe=7cE8kHEGx2R90iVV6AJsCfgg5ZD2+ssMmzow@mail.gmail.com>
 <040a0941-936b-87ab-aedd-5a933383b500@bell.net>
 <b919c7fd-babb-5557-dd8d-c2b8bb428d54@bell.net>
 <4fee8886-daa3-fb03-f9e7-89358fb5fc38@bell.net>
 <b9ceba24-345e-20dc-783b-3759a9819359@bell.net>
 <10887293-fa2e-83e1-9305-487905a8afd2@kernel.org>
 <3e4040cf-bb54-7652-72cc-0ad2d1288cb8@bell.net>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3e4040cf-bb54-7652-72cc-0ad2d1288cb8@bell.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 09:29, John David Anglin wrote:
>>> dave@atlas:~/linux/linux$ git diff drivers/scsi/scsi.c
>>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>>> index d0911bc28663..dc3a283ebd75 100644
>>> --- a/drivers/scsi/scsi.c
>>> +++ b/drivers/scsi/scsi.c
>>> @@ -578,6 +578,8 @@ static bool scsi_cdl_check_cmd(struct scsi_device *sdev, u8 opcode, u16 sa,
>>>           int ret;
>>>           u8 cdlp;
>>>
>>> +       return false;
>>> +
>>>           /* Check operation code */
>>>           ret = scsi_report_opcode(sdev, buf, SCSI_CDL_CHECK_BUF_LEN, opcode, sa);
>>>           if (ret <= 0)
>> It is weird that this solves anything... the MAINTENANCE_IN command issued by
>> scsi_report_opcode() ends up being emulated in libata with
>> ata_scsiop_maint_in(). There are no actual commands issued to the drive, so
>> nothing that could actually fail/cause issues. By the time this is issued, the
>> ATA drive is also fully probed...
>>
>> Or is the drive connected to the Broadcom HBA you have ? In that case, libata is
>> not used and the HBA FW SAT (scsi-ata-translation) is likely to blame.
> /boot, / and swap partitions reside on a ST373207LW drive connected to a Broadcom HBA.  A
> ST4000VN008-2DR1 drive is connected to the  Silicon Image, Inc. SiI 3124 PCI-X Serial
> ATA Controller.  It mounts on /home.  There's also a cdrom connected to the Silicon
> Image, Inc. PCI0680 Ultra ATA-133 Host Controller and another ST4000VN008-2DR1 drive
> connected to a Broadcom HBA.  There are two Broadcom HBAs.
> 
> I think the issue is with the root ST373207LW drive.  The console output indicates that the
> ROOT drive doesn't exist when the boot fails.
> 
> Your change only appeared to affect actual SCSI drives.  That's why I tried disabling CDL.

OK. I can see from the dmesg snippets you sent that the drives on the ATA ports
seem OK. A quick search tells me that the ST373207LW drive is a Ultra320 SCSI
drive, not ATA. So that MAINTENANCE_IN command issued by scsi_report_opcode()
will straight as-is.

This command has been issued to devices since a long time ago, and given that
your system was working, the drive is probably fine with it in its simplest form
(one command format). CDL changes however added probing command support with the
service action field (One command format with service action). And what may be
happening is that the drive does not like/does not support that format and
chokes on it.

Let me check the specs to see what scsi level support this format. What is sure
is that Ultra320 SCSI disks will definitely *not* support CDL, so we could exit
early in scsi_cdl_check_cmd() returning false for drives with an old scsi level
support.

Let me send something along these lines.

>>
>> Could you send a full dmesg output for a clean boot and for a failed one so that
>> I can compare ?
> I'll try to get this together tomorrow.
> 
> Dave
> 

-- 
Damien Le Moal
Western Digital Research

