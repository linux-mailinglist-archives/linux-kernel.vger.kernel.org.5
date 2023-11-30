Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343767FF8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjK3Rpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3Rph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:45:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E2131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:45:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46670C433C8;
        Thu, 30 Nov 2023 17:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701366344;
        bh=Z0rdqtHB/1WMoBlhdId/h4N42zIR/AZb8/VyMLb5Q5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGjc5wG/kkTHxD/lxA7nYlI8B/lqCH7zV4eRtVsh+EZtg3ogSB5inawWs3OHhDYhW
         yKe/VZ1Lar5bpOXWgf4pgrDHCRCjha8UzuB69T/FCn1SbCKVMShSWv7UeyfoOf6Uer
         2DYmS0ZvlO9ezGxBnK98vfZaq/oOPcHz9uoH/0zU9MosKFjWVptF+laAxnbwUkRd/w
         kDeNv9N7XmIrTe0TcwpS3TohkaiD3vQ/mIvskFWjc6NFui194Kpeo+gHUHfr4MnSmY
         x0W0/fWd3oARFwsT76pDle5EEBnX90e+XDgqNodb5t25+/VBuJ1aPP5t1ngdAQaG3b
         gNwqNbGobVc/g==
Date:   Thu, 30 Nov 2023 17:45:38 +0000
From:   Simon Horman <horms@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] net/mlx5e: fix a potential double-free in
 fs_udp_create_groups
Message-ID: <20231130174538.GK32077@kernel.org>
References: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:40:53PM +0800, Dinghao Liu wrote:
> When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
> fs_udp_create_groups() will free ft->g. However, its caller
> fs_udp_create_table() will free ft->g again through calling
> mlx5e_destroy_flow_table(), which will lead to a double-free.
> Fix this by setting ft->g to NULL in fs_udp_create_groups().
> 
> Fixes: 1c80bd684388 ("net/mlx5e: Introduce Flow Steering UDP API")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: Setting ft->g to NULL instead of removing the kfree().

Reviewed-by: Simon Horman <horms@kernel.org>

