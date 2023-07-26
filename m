Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F0762960
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGZDjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:39:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748E52695
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 116FC611C5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EB0C433C7;
        Wed, 26 Jul 2023 03:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690342790;
        bh=/DXkxDc0cjY513B5QGcbSthekDMBSig0Uuz5USmRB9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H157GANRAtY9o9O/MLKKTTbuWpOwR4XmTVaem5NtxNwnkOrUiwqdx6pKbPVRZyxZp
         XsrhqhKIY1O74VUIwmGYMvKVAa7F/mum5SbnVjk+tZ2dUYbv4brqLThJ0UPAXGhjc4
         nO1vw4bl4Iv66QnJ4u0WwqG0pd8FueE8M/yzw7B4zWsoHYI1fbR9LYzkXa78PgjWTJ
         DQVv4aw6MZVD7uzWaIvbUJ/K4ImsCSxC73xWyDRUOXIUKsX1rSQlztJloyiBGiOJ7k
         N/h7SBzK5mn5cwjYvmMEe9Da0xYHpv5gXt/zbrYdsZGYhFItjoUZKl2NSaVLZrTUkP
         pK1jE7jQdNRTQ==
Date:   Tue, 25 Jul 2023 20:39:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Johannes Zink <j.zink@pengutronix.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <20230725203948.4037fee7@kernel.org>
In-Reply-To: <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
        <20230725200606.5264b59c@kernel.org>
        <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
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

On Tue, 25 Jul 2023 20:22:53 -0700 Richard Cochran wrote:
> > any opinion on this one?  
> 
> Yeah, I saw it, but I can't get excited about drivers trying to
> correct delays.  I don't think this can be done automatically in a
> reliable way, and so I expect that the few end users who are really
> getting into the microseconds and nanoseconds will calibrate their
> systems end to end, maybe even patching out this driver nonsense in
> their kernels.
> 
> Having said that, I won't stand in the way of such driver stuff.
> After all, who cares about a few microseconds time error one way or
> the other?

I see :)
