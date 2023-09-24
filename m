Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D77AC813
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjIXMmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:42:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6EFC6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 05:42:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA273C433C8;
        Sun, 24 Sep 2023 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695559357;
        bh=f9QaCT7P+Eym8wOvTxbBRKuAxNofL+bJzAubHNGHt38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ItdJ5hH5RCJ6d6zgIM5fgBlbKBcGnfLZiplra28IUBfcyypc6M0goS5gFA+Lrc6nr
         jzqhfMiqooOm5w4gGJk3DmTRMTk8z15JKyhAvJ9h7JO0ZzVt8qOwNiGdxKMW6hrtFo
         a5tWUZLakstd9aljmPuKFY63a2bFhcZfgCj7Ad96N6qa6s24hxBgxwHn2HeLyTZ6fP
         X+fmvPta6ILhdaWuTvKKRTmJHhPYssFBl6NGnKSrB7DUjF3mQJ2L5mSTjSrJvGnQ3b
         zin6fQm/DOfbFnvNLyi/Pg4FXu7dGsEs78XOSGZRwNumv/RUizVqHe6GE9zyQbBb9y
         o9StdWYawQGxQ==
Date:   Sun, 24 Sep 2023 20:42:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
Message-ID: <20230924124224.GC7231@dragon>
References: <20230819105002.132750-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819105002.132750-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 05:50:01AM -0500, Adam Ford wrote:
> Commit 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks
> from CCM node") removed the Audio clocks from the main clock node, because
> the intent is to force people to setup the audio PLL clocks per board
> instead of having a common set of rates, since not all boards may use
> the various audio PLL clocks in the same way.
> 
> Unfortunately, with this parenting removed, the SDMA2 and SDMA3
> clocks were slowed to 24MHz because the SDMA2/3 clocks are controlled
> via the audio_blk_ctrl which is clocked from IMX8MP_CLK_AUDIO_ROOT,
> and that clock is enabled by pgc_audio.
> 
> Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
> AHB, always 1:1 mode, to make sure there is enough throughput for all
> the audio use cases."
> 
> Instead of cluttering the clock node, place the clock rate and parent
> information into the pgc_audio node.
> 
> With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
> and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
> 400MHz again.
> 
> Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied both, thanks!
