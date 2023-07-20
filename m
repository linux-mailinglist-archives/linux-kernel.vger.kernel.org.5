Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D881375B279
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjGTPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGTPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE6132
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C3361B4A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78D0C433C7;
        Thu, 20 Jul 2023 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866672;
        bh=pjnKekjE71gAy7Zg6XstIv+bO3ieMLEzUP4PJ4z6uOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g/D6JRa9WygFmgZkTLCrBiBZQahul/3Farf9/Mx+xxESjqX4WZNkrFL4aUJpyCXVr
         xPOxRcDdSOTQ2mp89tl79bwSUCKq98cJVJbNZjfZ3eEcIkv7NI8o9Qph3Erjn0kMUZ
         bwd5p/mNXN0dCU7OPM4Ooo3c0Of+EqoRfmoUKmGEUguHvcGSaU3Ek5AEW5cdTTreTJ
         KYhJaxzvDd4adlLHthh9C6y26eCXH+s8CnAa8/lzBZ88t3Em36D7hovjmVySBovTmb
         gZMxkl+suYqa7X8ldNjGY7JCNCzmkx+U/sE/vdKlt8aZBukg7q82PU9PmEzplXY+db
         QHCm0tGXd4Qgw==
Date:   Thu, 20 Jul 2023 08:24:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fec: add XDP_TX feature support
Message-ID: <20230720082431.5428050e@kernel.org>
In-Reply-To: <AM5PR04MB3139D4C0F26B5768784B9CAF883EA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
        <20230719204553.46856b29@kernel.org>
        <AM5PR04MB3139D4C0F26B5768784B9CAF883EA@AM5PR04MB3139.eurprd04.prod.outlook.com>
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

On Thu, 20 Jul 2023 07:06:05 +0000 Wei Fang wrote:
> > Are you taking budget into account? When NAPI is called with budget of 0 we
> > are *not* in napi / softirq context. You can't be processing any XDP tx under
> > such conditions (it may be a netpoll call from IRQ context).  
> 
> Actually, the fec driver never takes the budget into account for cleaning up tx BD
> ring. The budget is only valid for rx.

I know, that's what I'm complaining about. XDP can only run in normal
NAPI context, i.e. when NAPI is called with budget != 0. That works out
without any changes on Rx, if budget is zero drivers already don't
process Rx. But similar change must be done on Tx when adding XDP
support. You can still process all normal skb packets on Tx when budget
is 0 (in fact you should), but you _can't_ process any XDP Tx frame.
