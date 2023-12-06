Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4592807AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377411AbjLFVxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377371AbjLFVxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:53:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A1BD5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:53:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB8DC433C8;
        Wed,  6 Dec 2023 21:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701899587;
        bh=9wE7t5kK/YCsuLwHfAgKzLt+nO/2533i+EX2OMKT0XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1xKEUQ75etOxiDE0K3MohK/zhxSqmqsUrV3Dwgc8LfrQeERy3Cm02LZfoG4g+ebY
         PeMhkdMKpA4FsfLJCz5AQUNPVg5ZNJJSrhrWm+k7ddCfKQzUXpUO61KwkIEi5TSfLQ
         tISTkTdSHSHrQOFBjLAAAfUQhK7zSThcgsLour0dyf3R5ze7ItyEMRC1XsTC17LvTH
         uHWpaWMWCbCmBg3bKlTOPvSLIwiQ7yDMDH2QQZSHrFY6JM2hsHJHJ5cU5hv0c7Ktop
         bxXpBNN/PAlDLBODscJApIJlWC6jJgP38azdgXp+nD1vi5JJZ5xNtCqSmkMr8otBVf
         qkp1X8G2hc+TQ==
Date:   Wed, 6 Dec 2023 13:53:06 -0800
From:   Saeed Mahameed <saeed@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Simon Horman <horms@kernel.org>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net/mlx5e: fix a potential double-free in
 fs_udp_create_groups
Message-ID: <ZXDtQj_lGub3-cWT@x130>
References: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Nov 17:40, Dinghao Liu wrote:
>When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
>fs_udp_create_groups() will free ft->g. However, its caller
>fs_udp_create_table() will free ft->g again through calling
>mlx5e_destroy_flow_table(), which will lead to a double-free.
>Fix this by setting ft->g to NULL in fs_udp_create_groups().
>
>Fixes: 1c80bd684388 ("net/mlx5e: Introduce Flow Steering UDP API")
>Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>---
>
>Changelog:
>
>v2: Setting ft->g to NULL instead of removing the kfree().
>---

Applied to net-mlx5.

- Saeed
