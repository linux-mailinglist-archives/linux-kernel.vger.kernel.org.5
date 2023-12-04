Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EFE802A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjLDCgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:36:38 -0500
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98558C3;
        Sun,  3 Dec 2023 18:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=5vUcNk5ue3sk+3mKADerTcmAghwekiSZ+hMj+HfWZ60=;
        b=cGCIPOh9pBxoLykXW8kAFjTzsHMa9ftAQR3EaaIIHu0mT3dfOclIhiHElqgPnA
        lalPzq5bYLXKYyq7tRZOx1QpKfjSg1+W8H1setooKv95j7Bnu5zwgMJ23Kd/MrMD
        5+9N1n4M/KjqEOmY7NJB/gmKxC5nbsDrxRpQP6i0D4Dns=
Received: from [172.23.69.7] (unknown [121.32.254.149])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wCXq9a2OW1lFtWmDQ--.17161S2;
        Mon, 04 Dec 2023 10:30:15 +0800 (CST)
Message-ID: <35e833bf-8aa6-48bd-999c-6b4c9a4fe7f0@126.com>
Date:   Mon, 4 Dec 2023 10:30:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: Fix slab-out-of-bounds in
 mlx5_query_nic_vport_mac_list()
To:     Simon Horman <horms@kernel.org>,
        Shifeng Li <lishifeng@sangfor.com.cn>
Cc:     saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ogerlitz@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinghui@sangfor.com.cn
References: <20231130094656.894412-1-lishifeng@sangfor.com.cn>
 <20231203175015.GP50400@kernel.org>
From:   Shifeng Li <lishifeng1992@126.com>
In-Reply-To: <20231203175015.GP50400@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wCXq9a2OW1lFtWmDQ--.17161S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4ftw4rWw4UXr1UXFW8WFg_yoW8KFW3pF
        WaywnrZrykJFZ8ZFWUZ3Z5uF10kr4Uu3W7ua90qw13Aayvgrnrta4UAF1jka9rZFWUKrWv
        ya42vFnIvws8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWMKtUUUUU=
X-Originating-IP: [121.32.254.149]
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1tbiFx08r1pEIGvk+AAAsQ
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/4 1:50, Simon Horman wrote:
> On Thu, Nov 30, 2023 at 01:46:56AM -0800, Shifeng Li wrote:
>> Out_sz that the size of out buffer is calculated using query_nic_vport
>> _context_in structure when driver query the MAC list. However query_nic
>> _vport_context_in structure is smaller than query_nic_vport_context_out.
>> When allowed_list_size is greater than 96, calling ether_addr_copy() will
>> trigger an slab-out-of-bounds.
>>
>> [ 1170.055866] BUG: KASAN: slab-out-of-bounds in mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
>> [ 1170.055869] Read of size 4 at addr ffff88bdbc57d912 by task kworker/u128:1/461
>> [ 1170.055870]
>> [ 1170.055932] Workqueue: mlx5_esw_wq esw_vport_change_handler [mlx5_core]
>> [ 1170.055936] Call Trace:
>> [ 1170.055949]  dump_stack+0x8b/0xbb
>> [ 1170.055958]  print_address_description+0x6a/0x270
>> [ 1170.055961]  kasan_report+0x179/0x2c0
>> [ 1170.056061]  mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
>> [ 1170.056162]  esw_update_vport_addr_list+0x2c5/0xcd0 [mlx5_core]
>> [ 1170.056257]  esw_vport_change_handle_locked+0xd08/0x1a20 [mlx5_core]
>> [ 1170.056377]  esw_vport_change_handler+0x6b/0x90 [mlx5_core]
>> [ 1170.056381]  process_one_work+0x65f/0x12d0
>> [ 1170.056383]  worker_thread+0x87/0xb50
>> [ 1170.056390]  kthread+0x2e9/0x3a0
>> [ 1170.056394]  ret_from_fork+0x1f/0x40
>>
>> Fixes: e16aea2744ab ("net/mlx5: Introduce access functions to modify/query vport mac lists")
>> Cc: Ding Hui <dinghui@sangfor.com.cn>
>> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
> 
> Hi,
> 
> I am unsure how you calculated the 96 figure above.
> But in any case I agree that the cited patch introduced
> the mismatch that you describe.
> 
out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_in) + req_list_size * MLX5_ST_SZ_BYTES(mac_address_layout)
        = 0x80/8 + 128 * 0x40/8 = 0x410 (bytes)

nic_vport_ctx = MLX5_ADDR_OF(query_nic_vport_context_out, out, nic_vport_context)
               = 0x880/8 = 0x110 (bytes)
mac_addr = MLX5_ADDR_OF(nic_vport_context, nic_vport_ctx, current_uc_mac_address[96]) + 2
          = 0x110 + 96 * 8 + 2
          = 0x412 (bytes)

When i is 96,  the mac_addr offset is 0x412 but the out_sz is 0x410.
And that will trigger an slab-out-of-bounds.

Thanks.

> Reviewed-by: Simon Horman <horms@kernel.org>

