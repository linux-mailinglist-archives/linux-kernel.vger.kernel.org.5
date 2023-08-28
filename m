Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C478A49C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjH1C2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjH1C2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:28:21 -0400
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA8DA;
        Sun, 27 Aug 2023 19:28:18 -0700 (PDT)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 5C8D620881;
        Mon, 28 Aug 2023 10:27:34 +0800 (CST)
Message-ID: <95e9525e-3101-4433-27e2-cd69f254af1c@rock-chips.com>
Date:   Mon, 28 Aug 2023 10:27:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     shawn.lin@rock-chips.com, angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        matthias.bgg@gmail.com, ulf.hansson@linaro.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/1] mmc: Set optimal I/O size when mmc_setip_queue
Content-Language: en-GB
To:     Sharp.Xia@mediatek.com
References: <769a67cb-1b32-fd4f-b37e-e3ec4dab5eb9@rock-chips.com>
 <20230826162635.617-1-Sharp.Xia@mediatek.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20230826162635.617-1-Sharp.Xia@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pISVZLSkkfGhoaQkxJTx5VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
        tLWQY+
X-HM-Tid: 0a8a39f7c8492eb6kusn5c8d620881
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pj46HDo5HT1DDTMcDDY8Eioo
        KU5PCwlVSlVKTUJISkNCTU5OS01PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhJTUk3Bg++
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sharp

On 2023/8/27 0:26, Sharp.Xia@mediatek.com wrote:
> On Fri, 2023-08-25 at 17:17 +0800, Shawn Lin wrote:
>>   	
>>

After more testing, most of my platforms which runs at HS400/HS200 mode 
shows nearly no differences with the readahead ranging from 128 to 1024. 
Yet just a board shows a performance drop now. Highly suspect it's eMMC
chip depends. I would recommand leave it to the BSP guys to decide which
readahead value is best for their usage.

> 
> I tested with RK3568 and sdhci-of-dwcmshc.c driver, the performance improved by 2~3%.
>   
> Before:
> root@OpenWrt:/mnt/mmcblk0p3# time dd if=test.img of=/dev/null
> 2097152+0 records in
> 2097152+0 records out
> real    0m 6.01s
> user    0m 0.84s
> sys     0m 2.89s
> root@OpenWrt:/mnt/mmcblk0p3# cat /sys/block/mmcblk0/queue/read_ahead_kb
> 128
>   
> After:
> root@OpenWrt:/mnt/mmcblk0p3# echo 3 > /proc/sys/vm/drop_caches
> root@OpenWrt:/mnt/mmcblk0p3# time dd if=test.img of=/dev/null
> 2097152+0 records in
> 2097152+0 records out
> real    0m 5.86s
> user    0m 1.04s
> sys     0m 3.18s
> root@OpenWrt:/mnt/mmcblk0p3# cat /sys/block/mmcblk0/queue/read_ahead_kb
> 1024
>   
> root@OpenWrt:/sys/kernel/debug/mmc0# cat ios
> clock:          200000000 Hz
> actual clock:   200000000 Hz
> vdd:            18 (3.0 ~ 3.1 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> 
