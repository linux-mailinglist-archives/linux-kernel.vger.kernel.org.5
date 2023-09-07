Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ADC796DFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbjIGA2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIGA2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:28:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F510C8;
        Wed,  6 Sep 2023 17:28:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2849AC433C8;
        Thu,  7 Sep 2023 00:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694046528;
        bh=lwdKw3Qf1YKcwjr7eKdfXB/NP6Lq8MHNdgXQ9a66tuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PXb+QyUvr0t6vsv+f/Q3f9znSt3ncrMljOP1OCQmWHIuP+Mvk2WEsTwM9rjxTin5J
         Gz87+uCy509NoNoxj7G8SI1nz8sqbw+VMg/ZU/L1d9Zs96mG/7/lBrEGIp6unKgRye
         5QVmSC1JwQI5rMc6/e6jCowIGw13zd556bfFhEzxqFo5bL4DHSdhU4rjQ9abiI+bop
         freFAttdg0hocam3nCR3e5L68QxN/QyPayx+0aNdMCl0DbQ2QLsA5hHUL0HBiU8B6G
         bpGE55FNtlMwkNCpXDjQnPmHabG2LrgSWU4XjkHcXGvfJgK6ZoZjAMq47dSckgedsU
         eo1m1Puix9mzw==
Date:   Wed, 6 Sep 2023 17:28:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net v2] r8152: avoid the driver drops a lot of packets
Message-ID: <20230906172847.2b3b749a@kernel.org>
In-Reply-To: <20230906031148.16774-421-nic_swsd@realtek.com>
References: <20230906031148.16774-421-nic_swsd@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2023 11:11:48 +0800 Hayes Wang wrote:
> Stop submitting rx, if the driver queue more than 256 packets.
> 
> If the hardware is more fast than the software, the driver would start
> queuing the packets. And, the driver starts dropping the packets, if it
> queues more than 1000 packets.
> 
> Increase the weight of NAPI could improve the situation. However, the
> weight has been changed to 64, so we have to stop submitting rx when the
> driver queues too many packets. Then, the device may send the pause frame
> to slow down the receiving, when the FIFO of the device is full.

Good to see that you can repro the problem.

Before we tweak the heuristics let's make sure rx_bottom() behaves
correctly. Could you make sure that 
 - we don't perform _any_ rx processing when budget is 0
   (see the NAPI documentation under Documentation/networking)
 - finish the current aggregate even if budget run out, return
   work_done = budget in that case.
   With this change the rx_queue thing should be gone completely.
 - instead of copying the head use napi_get_frags() + napi_gro_frags() 
   it gives you an skb, you just attach the page to it as a frag and
   hand it back to GRO. This makes sure you never pull data into head
   rather than just headers.

Please share the performance results with those changes.
-- 
pw-bot: cr
