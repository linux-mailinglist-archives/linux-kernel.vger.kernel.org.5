Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6617CAB32
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjJPOSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjJPOR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:17:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6039F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:17:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA46C433C7;
        Mon, 16 Oct 2023 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697465877;
        bh=vG5dUiaoYpNcLFNAh/ByVOdSrpjZW8Cfq1lBFKNYtSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UG1OvhCSuO7NSxwdw0CmsE1JEnaiDqPvtIVyLV80H9TWBhu4m5CfiNjJSvimHtQDk
         +eApjR4jM5WrRlLF1CcsOS/92VdHmG4jnLeCL3vjCO4cSiS0l25t4BltBT8H+R4X93
         YXFzyCRJ6hEkMxY01yr0oU4iqZnoH+e9rfD5hmMeQdy8lnWE04cNRedphcowScEtJ7
         pywA0opOpQvDGxpUdHScmTXRZg6hfI3nA+jaDAwAwEA2lIsiosYicYr8+33x3Rxy3n
         qwTzL659/tp9VrDSPsUXyDIWz2rf2Qw5atk7IFtkEZDsVJ5D6YIez/dXPURd7ksxIT
         ZEphC9JVXNpEA==
Date:   Mon, 16 Oct 2023 07:17:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Come On Now <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231016071756.4ac5b865@kernel.org>
In-Reply-To: <20231016095321.4xzKQ5Cd@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
        <20231004154609.6007f1a0@kernel.org>
        <20231007155957.aPo0ImuG@linutronix.de>
        <20231009180937.2afdc4c1@kernel.org>
        <20231016095321.4xzKQ5Cd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 11:53:21 +0200 Sebastian Andrzej Siewior wrote:
> > Do we have reason to believe nobody uses RPS?  
> 
> Not sure what you relate to. I would assume that RPS is used in general
> on actual devices and not on loopback where backlog is used. But it is
> just an assumption.
> The performance drop, which I observed with RPS and stress-ng --udp, is
> within the same range with threads and IPIs (based on memory). I can
> re-run the test and provide actual numbers if you want.

I was asking about RPS because with your current series RPS processing
is forced into threads. IDK how well you can simulate the kind of
workload which requires RPS. I've seen it used mostly on proxyies 
and gateways. For proxies Meta's experiments with threaded NAPI show
regressions across the board. So "force-threading" RPS will most likely
also cause regressions.
