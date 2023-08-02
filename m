Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8876D5E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjHBRrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjHBRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161830C4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ADF261A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50900C433C7;
        Wed,  2 Aug 2023 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690998428;
        bh=sE6AgUQ0F8B532TRUZLvOvqkjOvFLzeZinak6Pnz2BQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cj3wlW0o4CuBFv2vgVAJKJx0C5RTeD92PotxBduWEsCb2JeCdBxIzPOE0e1kGDABR
         Ruu2Id3g5aUv4LzY8w+SmaQp4ti4eZ/ETrNKOCg7RsDsAJ+oyoeMMyvQCULrCJDoMn
         UrZVHWJYRpLHmmNuAhI3BK70A8+dvC1m5LdMTd0wCuunpNqzmQ7NQ+wbMOJkErT2kA
         tpi0F7OOB6xp8FyK5w4Gs7315AkjZ8B1oKLq1YLnSAAcEk4HBeUSsdq1RNRXo09idd
         XztNeB9fxfB6g3w08n6s7VYnnTPL5Szu1KttO5DNUX0H0dYMNoqAH1jeYlnnR7oe19
         qUT1O6TbWF7IQ==
Date:   Wed, 2 Aug 2023 10:47:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230802104706.5ce541e9@kernel.org>
In-Reply-To: <20230731060025.3117343-1-wei.fang@nxp.com>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 14:00:25 +0800 Wei Fang wrote:
>  		} else {
> -			xdp_return_frame(xdpf);
> +			xdp_return_frame_rx_napi(xdpf);

If you implement Jesper's syncing suggestions, I think you can use

	page_pool_put_page(pool, page, 0, true);

for XDP_TX here to avoid the DMA sync on page recycle.
