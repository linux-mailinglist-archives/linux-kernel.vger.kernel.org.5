Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3793802613
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjLCRuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCRuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:50:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056BCD3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:50:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9D5C433C8;
        Sun,  3 Dec 2023 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701625821;
        bh=KaCBA7aWetgNynrDp9I/L5TG0YXmHua23gxLEqwslEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7Y/TuEpYv7g7QuAjMRI8Pgilq10cC6gmaahN0JJV8K4PcZgm5SOqgVtdyu3VEXqp
         6iM8eukVtdjbPI+a2jeunwaut2pyMLHEaS3ryk43p74agXW/oFyY8J3IuUg0fN46Ms
         LS4DikhG8FmNVdryCKzC6wY1FXXavqZzCWoHRAJn1sQTFh+VKK6VW2kyE4uJWIoP2E
         7FWJs0s0aqlCyZUt7qeRhPAbuwqIbZE0UwchkYuO9iUmB0P1t26l91qfSae2rn/pBe
         vAdoca4MJ0wd9M4Se4RRPH8HHJlWFUlBulORCqW/YJhYfh3X0/tycYDEJDV1XpSz2e
         2PFfZ/EDXmL7g==
Date:   Sun, 3 Dec 2023 17:50:15 +0000
From:   Simon Horman <horms@kernel.org>
To:     Shifeng Li <lishifeng@sangfor.com.cn>
Cc:     saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ogerlitz@mellanox.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinghui@sangfor.com.cn, lishifeng1992@126.com
Subject: Re: [PATCH] net/mlx5e: Fix slab-out-of-bounds in
 mlx5_query_nic_vport_mac_list()
Message-ID: <20231203175015.GP50400@kernel.org>
References: <20231130094656.894412-1-lishifeng@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130094656.894412-1-lishifeng@sangfor.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:46:56AM -0800, Shifeng Li wrote:
> Out_sz that the size of out buffer is calculated using query_nic_vport
> _context_in structure when driver query the MAC list. However query_nic
> _vport_context_in structure is smaller than query_nic_vport_context_out.
> When allowed_list_size is greater than 96, calling ether_addr_copy() will
> trigger an slab-out-of-bounds.
> 
> [ 1170.055866] BUG: KASAN: slab-out-of-bounds in mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
> [ 1170.055869] Read of size 4 at addr ffff88bdbc57d912 by task kworker/u128:1/461
> [ 1170.055870]
> [ 1170.055932] Workqueue: mlx5_esw_wq esw_vport_change_handler [mlx5_core]
> [ 1170.055936] Call Trace:
> [ 1170.055949]  dump_stack+0x8b/0xbb
> [ 1170.055958]  print_address_description+0x6a/0x270
> [ 1170.055961]  kasan_report+0x179/0x2c0
> [ 1170.056061]  mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
> [ 1170.056162]  esw_update_vport_addr_list+0x2c5/0xcd0 [mlx5_core]
> [ 1170.056257]  esw_vport_change_handle_locked+0xd08/0x1a20 [mlx5_core]
> [ 1170.056377]  esw_vport_change_handler+0x6b/0x90 [mlx5_core]
> [ 1170.056381]  process_one_work+0x65f/0x12d0
> [ 1170.056383]  worker_thread+0x87/0xb50
> [ 1170.056390]  kthread+0x2e9/0x3a0
> [ 1170.056394]  ret_from_fork+0x1f/0x40
> 
> Fixes: e16aea2744ab ("net/mlx5: Introduce access functions to modify/query vport mac lists")
> Cc: Ding Hui <dinghui@sangfor.com.cn>
> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>

Hi,

I am unsure how you calculated the 96 figure above.
But in any case I agree that the cited patch introduced
the mismatch that you describe.

Reviewed-by: Simon Horman <horms@kernel.org>
