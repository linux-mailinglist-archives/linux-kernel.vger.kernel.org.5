Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04BE78241A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjHUHDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHUHDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:03:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985AAC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEEBA62B51
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD898C433C7;
        Mon, 21 Aug 2023 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692601416;
        bh=vRar8l9ILaoEFw2+hFnxiFjdmBLeNqB26P7+WKEFpEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmnUrr+ijfI+YGEqR+Dwr+2FoqGPF814T8gAkuNXxPnMFtxclMIt6kb/18LEtRBU/
         eC4f8rSexpWfvcMeD2j4Bzr1s5ZlX6hc3bln2n4HhWsdWoa0hZPRb6iqOOmrJru9LQ
         SXBl7UL/zgnbqnZNdCjUdWZ/QOnvdAsBDJr+FOofLaDNW7SnMDTwW3xic+ZMtveILc
         vps3FXciom+5+DWOK5WXGIngg/+WjfQxo0EqGboc1Yc+Gv1ouqG0x+qiQ5E0kmoW9s
         Fogp5aNi2IXPrNBUHT/ihu0mmbuV2YCNxup2AfpYcupXhefJ7x04SOLPEAYqO0XgRL
         n2H95Iugz0rrw==
Date:   Mon, 21 Aug 2023 09:03:31 +0200
From:   Simon Horman <horms@kernel.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        gongruiqi1@huawei.com
Subject: Re: [PATCH RESEND net-next] alx: fix OOB-read compiler warning
Message-ID: <20230821070331.GA2711035@kernel.org>
References: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:32:18AM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> The following message shows up when compiling with W=1:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘alx_get_ethtool_stats’ at drivers/net/ethernet/atheros/alx/ethtool.c:297:2:
> ./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |    __read_overflow2_field(q_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In order to get alx stats altogether, alx_get_ethtool_stats() reads
> beyond hw->stats.rx_ok. Fix this warning by directly copying hw->stats,
> and refactor the unnecessarily complicated BUILD_BUG_ON btw.
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

