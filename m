Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F606758A91
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGSBBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjGSBBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:01:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C6136
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:01:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0611615E7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C750AC433C7;
        Wed, 19 Jul 2023 01:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689728510;
        bh=DErPakduFqhgq+XgSW/ZrwNOszO28tTHkZXEYy5pKSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=owbr9Ll38m9telfzm+Q+UeIGv0gZ+QJBwa+XOR/u3k/zDw3jyTdT12TSkk8Nv9vbm
         1L86mr3GPnXaV0zf20IU2MZmEGMa10XbA7MuKNwRwcSukUfm4R6LLmn48puNGKGz2R
         NUiWOom2OsnEU/v1r40sroRLsDDtNdZ3gTi6yS4BwsmdB2O5fw3uyoCkzJReuu4sw+
         dGbbt+sRIqE5U+u98C9yKylCnrloFczRmCFDKcknY8euiE5hJSobXs7HvyulGvDFb5
         8iOOA3iJ4NYJa0+6xt3Os7VZRXBB8ykzMIdC8YxkCbLKJsVeL6h7j3q4NG0nIVaYRo
         PYwSGTYEhV+FQ==
Date:   Tue, 18 Jul 2023 18:01:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net-next v5 0/2] net: stmmac: improve driver statistics
Message-ID: <20230718180148.4fe125d9@kernel.org>
In-Reply-To: <20230717160630.1892-1-jszhang@kernel.org>
References: <20230717160630.1892-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 00:06:28 +0800 Jisheng Zhang wrote:
> improve the stmmac driver statistics:
> 
> 1. don't clear network driver statistics in .ndo_close() and
> .ndo_open() cycle
> 2. avoid some network driver statistics overflow on 32 bit platforms
> 3. use per-queue statistics where necessary to remove frequent
> cacheline ping pongs.
> 
> NOTE: v1 and v2 are back ported from an internal LTS tree, I made
> some mistakes when backporting and squashing. Now, net-next + v3
> has been well tested with 'ethtool -s' and 'ip -s link show'.

Giuseppe, please take a look.
