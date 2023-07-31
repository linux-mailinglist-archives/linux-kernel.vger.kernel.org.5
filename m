Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49C76A01B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGaSNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjGaSNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:13:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57410173B;
        Mon, 31 Jul 2023 11:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87BB961253;
        Mon, 31 Jul 2023 18:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B07AC433C7;
        Mon, 31 Jul 2023 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690827211;
        bh=JgYLR2p0UTU8jfWLZC91aaSiGzPX/p54RufKdswTSfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fv0gjn6meUczIYDumYbwS4gGefpf9Vxw+E9d5BDfhrUMlnDUxyfn3EuMJETmy+vIE
         D1Gy3YcjvM907jdwBmPLtCek+s/7z9wtABc8mjmRl3C168LhTD0HibCXA4nkKDZkXg
         EJ6Sj+JbY2bpyjhR3MpNsc9pZt+vWvtqmxGUp2Zr39DAeWaEJCHekj+DZ2I8MOEOR8
         EBEIOHgzPYW6tu2vdPXSONfD9julemh6ZdDie2H4wJLLsambTyqqyhbzIKiWqbrkdJ
         8rFgrPCQ1oOn71KP6G8IzKbJQhWVmAbCRa5LrgosmibsZFLHUquk0kWVMyBBQj0GMb
         m4L00Bx0bKgnA==
Date:   Mon, 31 Jul 2023 11:13:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     hayeswang@realtek.com, edumazet@google.com,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        davem@davemloft.net, linux-usb@vger.kernel.org, pabeni@redhat.com,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Error 'netif_napi_add_weight() called with weight 256'
Message-ID: <20230731111330.5211e637@kernel.org>
In-Reply-To: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 11:02:40 -0500 Limonciello, Mario wrote:
> Hi,
> 
> I noticed today with 6.5-rc4 and also on 6.1.42 that I'm getting an 
> error from an r8152 based dongle (Framework ethernet expansion card).
> 
> netif_napi_add_weight() called with weight 256
> 
> It seems that this message is likely introduced by
> 8ded532cd1cbe ("r8152: switch to netif_napi_add_weight()")
> 
> which if the card has support_2500full set will program the value to 256:
> 
> 	netif_napi_add_weight(netdev, &tp->napi, r8152_poll,
> 			      tp->support_2500full ? 256 : 64);
> 
> It's err level from
> 82dc3c63c692b ("net: introduce NAPI_POLL_WEIGHT")
> 
> Why is this considered an error but the driver uses the bigger value?
> Should it be downgraded to a warning?

Could you double check that the warning wasn't there before? The code
added by commit 195aae321c82 ("r8152: support new chips") in 5.13 looks
very much equivalent.
The custom weight is probably due to a misunderstanding. We have 200G
adapters using the standard weight of 64, IDK why 2.5G adapter would
need anything special.
