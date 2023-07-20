Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9895775A68E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGTGea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGTGeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:34:12 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B866D359B;
        Wed, 19 Jul 2023 23:32:54 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aee77.dynamic.kabel-deutschland.de [95.90.238.119])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0DCDB61E5FE04;
        Thu, 20 Jul 2023 08:31:31 +0200 (CEST)
Message-ID: <a658717c-8388-6e56-4d8d-096b0a1aefb9@molgen.mpg.de>
Date:   Thu, 20 Jul 2023 08:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] md/bitmap: Fix bitmap page writing problem when using
 block integrity
Content-Language: en-US
To:     Jinyoung Choi <j-young.choi@samsung.com>
References: <CGME20230720061234epcms2p32e02cd528fc834491816b379ae189012@epcms2p3>
 <20230720061234epcms2p32e02cd528fc834491816b379ae189012@epcms2p3>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     song@kernel.org, shli@fb.com, neilb@suse.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230720061234epcms2p32e02cd528fc834491816b379ae189012@epcms2p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jinyoung,


Thank you very much for your patch. Some minor comments, you can also 
ignore.

For the commit message summary/title you might be more specific. Maybe:

> Avoid protection error writing bitmap page with block integrity

Am 20.07.23 um 08:12 schrieb Jinyoung CHOI:
> Be careful when changing the page to perform DMA.
> Changing the bitmap page is also possible on the page where the DMA is
> being performed or scheduled in the MD.

Please add a blank line between paragraphs or do not wrap a line just 
because a sentence ends.

> When configuring raid1(mirror) with devices that support block integrity,

Add a space before the (?

> the same bitmap page is sent to the device twice during the resync process,
> causing the following problems.
> (When requeue is executed, integrity is not updated)
> 
>               [Func 1]                         [Func 2]
> 
> 1     A(page) + a(integrity)
> 2        (sq doorbell)
> 3                                         A(page) -> A-1(page)
> 4  A-1(page-updated) + a(integiry)     A-1(page) + a-1(integrity)

integ*rit*y

> 5      	                                    (sq doorbell)
> 6           (DMA)                               (DMA)
> 
> 	I/O Fail and retry N                 I/O Success
> 	To be Faulty Device
> 
> The following is the log when a problem occurs. The problematic device
> is in the faulty device state.
> 
> Log:
> [  135.037253] md/raid1:md0: active with 2 out of 2 mirrors
> [  135.038228] md0: detected capacity change from 0 to 7501212288
> [  135.038270] md: resync of RAID array md0
> [  151.252172] nvme2n1: I/O Cmd(0x1) @ LBA 16, 8 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
> [  151.252180] protection error, dev nvme2n1, sector 16 op 0x1:(WRITE) flags 0x10800 phys_seg 1 prio class 2
> [  151.252185] md: super_written gets error=-84
> [  151.252187] md/raid1:md0: Disk failure on nvme2n1, disabling device.
>                 md/raid1:md0: Operation continuing on 1 devices.
> [  151.267450] nvme3n1: I/O Cmd(0x1) @ LBA 16, 8 blocks, I/O Error (sct 0x2 / sc 0x82) MORE
> [  151.267457] protection error, dev nvme3n1, sector 16 op 0x1:(WRITE) flags 0x10800 phys_seg 1 prio class 2
> [  151.267460] md: super_written gets error=-84
> [  151.268458] md: md0: resync interrupted.
> [  151.320765] md: resync of RAID array md0
> [  151.321205] md: md0: resync done.

Although you explained the problem well, it’d be great nevertheless if 
you could add the details of your system to the commit message.

> Fixes: 85c9ccd4f026 ("md/bitmap: Don't write bitmap while earlier writes might be in-flight")
> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>

Your From line spells it CHOI. Maybe you can update your git 
configuration to also use Choi?

> ---
>   drivers/md/md-bitmap.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 1ff712889a3b..dfb7418ba48a 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -467,6 +467,13 @@ void md_bitmap_update_sb(struct bitmap *bitmap)
>   		return;
>   	if (!bitmap->storage.sb_page) /* no superblock */
>   		return;
> +
> +	/*
> +	 * Before modifying the bitmap page and re-issue it, wait for
> +	 * the requests previously sent to the device to be completed.
> +	 */
> +	md_bitmap_wait_writes(bitmap);
> +
>   	sb = kmap_atomic(bitmap->storage.sb_page);
>   	sb->events = cpu_to_le64(bitmap->mddev->events);
>   	if (bitmap->mddev->events < bitmap->events_cleared)


Kind regards,

Paul
