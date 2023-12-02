Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431D9801A0D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjLBC1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBC1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:27:52 -0500
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 18:27:56 PST
Received: from mail-m12810.netease.com (mail-m12810.netease.com [103.209.128.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA638132;
        Fri,  1 Dec 2023 18:27:56 -0800 (PST)
Received: from [0.0.0.0] (unknown [IPV6:240e:3b7:3271:7f20:4433:b746:c1de:367])
        by mail-m12773.qiye.163.com (Hmail) with ESMTPA id ABC322C027E;
        Sat,  2 Dec 2023 10:21:37 +0800 (CST)
Message-ID: <db0f5324-a4a8-3ae7-58f5-e82dd24643a9@sangfor.com.cn>
Date:   Sat, 2 Dec 2023 10:21:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] net/mlx5e: Fix a race in command alloc flow
Content-Language: en-US
To:     Shifeng Li <lishifeng@sangfor.com.cn>, saeedm@nvidia.com,
        leon@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eranbe@mellanox.com,
        moshe@mellanox.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lishifeng1992@126.com,
        Moshe Shemesh <moshe@nvidia.com>
References: <20231130030559.622165-1-lishifeng@sangfor.com.cn>
From:   Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <20231130030559.622165-1-lishifeng@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS05LVh9DHU9DTk0fSUsaT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEpBTB1JS0FPT0hIQRlMT01BGEofHkFITUxZV1kWGg8SFR0UWU
        FZT0tIVUpNT0lOSVVKS0tVSkJZBg++
X-HM-Tid: 0a8c2854d8aeb249kuuuabc322c027e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M1E6CCo*DDw4CgstLSwyMkNM
        SDIaFE1VSlVKTEtKT0NITUJDQk9KVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxKQUwdSUtBT09ISEEZTE9NQRhKHx5BSE1MWVdZCAFZQUhDTkI3Bg++
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/30 11:05, Shifeng Li wrote:
> Fix a cmd->ent use after free due to a race on command entry.
> Such race occurs when one of the commands releases its last refcount and
> frees its index and entry while another process running command flush
> flow takes refcount to this command entry. The process which handles
> commands flush may see this command as needed to be flushed if the other
> process allocated a ent->idx but didn't set ent to cmd->ent_arr in
> cmd_work_handler(). Fix it by moving the assignment of cmd->ent_arr into
> the spin lock.
> 
> [70013.081955] BUG: KASAN: use-after-free in mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
> [70013.081967] Write of size 4 at addr ffff88880b1510b4 by task kworker/26:1/1433361
> [70013.081968]
> [70013.082028] Workqueue: events aer_isr
> [70013.082053] Call Trace:
> [70013.082067]  dump_stack+0x8b/0xbb
> [70013.082086]  print_address_description+0x6a/0x270
> [70013.082102]  kasan_report+0x179/0x2c0
> [70013.082173]  mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
> [70013.082267]  mlx5_cmd_flush+0x80/0x180 [mlx5_core]
> [70013.082304]  mlx5_enter_error_state+0x106/0x1d0 [mlx5_core]
> [70013.082338]  mlx5_try_fast_unload+0x2ea/0x4d0 [mlx5_core]
> [70013.082377]  remove_one+0x200/0x2b0 [mlx5_core]
> [70013.082409]  pci_device_remove+0xf3/0x280
> [70013.082439]  device_release_driver_internal+0x1c3/0x470
> [70013.082453]  pci_stop_bus_device+0x109/0x160
> [70013.082468]  pci_stop_and_remove_bus_device+0xe/0x20
> [70013.082485]  pcie_do_fatal_recovery+0x167/0x550
> [70013.082493]  aer_isr+0x7d2/0x960
> [70013.082543]  process_one_work+0x65f/0x12d0
> [70013.082556]  worker_thread+0x87/0xb50
> [70013.082571]  kthread+0x2e9/0x3a0
> [70013.082592]  ret_from_fork+0x1f/0x40
> 

It is better if you also put the diagram [1] in the commit log, that is easy to understand.

[1] https://www.spinics.net/lists/netdev/msg951955.html

> Fixes: 50b2412b7e78 ("net/mlx5: Avoid possible free of command entry while timeout comp handler")
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>

-- 
Thanks,
- Ding Hui

