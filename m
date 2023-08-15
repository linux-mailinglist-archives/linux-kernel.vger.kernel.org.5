Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00B677C602
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjHOClT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjHOClL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4E10C1;
        Mon, 14 Aug 2023 19:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 720FF62F7B;
        Tue, 15 Aug 2023 02:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68A8C433C8;
        Tue, 15 Aug 2023 02:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692067269;
        bh=Wd3AtZ5QJeRfmtmjPmDZBwtcv6Day3Ya/2gjacldXYo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nCrr+1o1bgT2H98WhNLpKFNom3CH2IRwpc46aFq/rV5xd61FHoTh56YNb35xLIWCD
         Q/J5oSMX3yI5inum3JadU1jx9ZmjlftMtEVDP4s7Ls9PpvK1LaKlKWe/gpiUbUXszb
         pQJ5Igoc0wGTDmFjyl8tSieTedo0tc60ZDx1kBkX8hQW7IAFcWpKwwr3MqIgx4zKzE
         mu5mttdJJEUygytQ3ENR2g3/rFiM03zVSTSv1FbKOoQrH16YDbmQBb5ya1LrKULiHq
         4ylLFixiczRJyVA1mh3tMffKMf2xkH3GEmWaud9bIq1q+wOUSxkBM1l9FGB60e2f/u
         7kKBMDJdlFM3A==
Message-ID: <611dfd5e-33b7-12ad-5902-ad20edf3b02e@kernel.org>
Date:   Tue, 15 Aug 2023 11:41:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Content-Language: en-US
To:     Li Nan <linan666@huaweicloud.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com, jianghong011@huawei.com,
        zhangcheng75@huawei.com
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
 <25c1aca7-d885-0fff-2639-bb68a7dff44f@kernel.org>
 <c2ae28b7-a105-9cd6-bf2e-63051a4000b0@huaweicloud.com>
 <eb135aff-dc33-d559-1826-9284a22c095a@kernel.org>
 <977879af-8603-82ae-07ad-38be3a27194d@huaweicloud.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <977879af-8603-82ae-07ad-38be3a27194d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 22:20, Li Nan wrote:
> 
> 在 2023/8/14 15:50, Damien Le Moal 写道:
>> On 8/14/23 15:41, Li Nan wrote:
>>>> This is definitely not correct because EH may have been scheduled for a non
>>>> fatal action like a device revalidate or to get sense data for successful
>>>> commands. With this change, the port will NOT be frozen when a hard error IRQ
>>>> comes while EH is waiting to start, that is, while EH waits for all commands to
>>>> complete first.
>>>>
>>>
>>> Yeah, we should find a better way to fix it. Do you have any suggesstions?
>>>
>>>> Furthermore, if you get an IRQ that requires the port to be frozen, it means
>>>> that you had a failed command. In that case, the drive is in error state per
>>>> ATA specs and stops all communication until a read log 10h command is issued.
>>>> So you should never ever see 2 error IRQs one after the other. If you do, it
>>>> very likely means that you have buggy hardware.
>>>>
>>>> How do you get into this situation ? What adapter and disk are you using ?
>>>>
>>>
>>>   > How do you get into this situation ?
>>> The first IRQ is io error, the second IRQ is disk link flash break.
>>
>> What does "link flash break" mean ?
>>
>>>
>>>   > What adapter and disk are you using ?
>>> It is a disk developed by our company, but we think the same issue
>>> exists when using other disks.
>>
>> As I said, I find this situation highly suspect because if the first IRQ was to
>> signal an IO error that the drive reported, then per ATA specifications, the
>> drive should be in error mode and should NOT have transmitted any other FIS
>> after the SDB FIS that signaled the error. Nothing at all should come after that
>> error SDB FIS, until the host issues a read log 10h to get thee drive out of
>> error state.
>>
>> If this is a prototype device, I would recommend that you take an ATA bus trace
>> and verify the FIS traffic. Something fishy is going on with the drive in my
>> opinion.
>>
> 
> Thank you for your patient explanation. I'm sorry I didn't explain the
> problem clearly before. After discussing with my colleagues who know
> more about dirvers, Let me re-describe the problem.
> 
> The problem`s situation is the SATA link is quickly disconnected and 
> connected. For example, when an I/O error is processed in error handling 
> thread, the disk is manually removed and inserted, and the AHCI chip 
> reports a hot plug interrupt.
> 
> This scenario is not just an NCQ error, but a disk is removed and 
> quickly inserted before the error processing is completed. For the error 
> handling process, the disk status needs to be restored after the error 
> handling is complete.

In your original email, you showed:

interrupt                            scsi_eh

ahci_error_intr
  =>ata_port_freeze
    =>__ata_port_freeze
      =>ahci_freeze (turn IRQ off)
    =>ata_port_abort
      =>ata_port_schedule_eh
        =>shost->host_eh_scheduled++;
        host_eh_scheduled = 1
                                     scsi_error_handler
                                       =>ata_scsi_error
                                         =>ata_scsi_port_error_handler
                                           =>ahci_error_handler
                                           . =>sata_pmp_error_handler
                                           .   =>ata_eh_thaw_port
                                           .     =>ahci_thaw (turn IRQ on)
ahci_error_intr                            .
  =>ata_port_freeze                        .
    =>__ata_port_freeze                    .
      =>ahci_freeze (turn IRQ off)         .
    =>ata_port_abort                       .
      =>ata_port_schedule_eh               .
        =>shost->host_eh_scheduled++;      .
        host_eh_scheduled = 2              .

But here, I do not understand how host_eh_scheduled can be incremented since the
shost state should still be SHOST_RECOVERY until scsi_restart_operations() is
called at the end of scsi_error_handler(), which is after ata_std_end_eh() is
executed toward the end of ata_scsi_port_error_handler().
Not sure how what you are showing here can happen. Can you have a closer look ?

                                           =>ata_std_end_eh
                                             =>host->host_eh_scheduled = 0;

In any case, for you particular failure pattern, given that the disk "goes away"
while EH is running, I would expect the commands executed during EH (e.g. read
log 10h) to timeout, which would cause a reset and a revalidate after that. The
reset should clear the port interrupt error bits, which should allow everything
to recover after aborting all commands caught by the first EH run.

-- 
Damien Le Moal
Western Digital Research

