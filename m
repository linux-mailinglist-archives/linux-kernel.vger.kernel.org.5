Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724FD7CB5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjJPVyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjJPVyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:54:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D5FB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:54:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617DDC433C8;
        Mon, 16 Oct 2023 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697493250;
        bh=dsjl7kpO+a5ffvGfGBAiPokx4K+LHRouUIS1choW8ZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jm29Z0ODHKXQvQMr/SDv46IbAojo8d8W/6AhBAQ8gZfdtFkFET16+krmSYQ6sI0Cz
         Lvv6IKu9I0+xoeokkZqjdZiSecQvl20eu9Yaa32r4zAYRPAvnjbNz7rvgyHFQQ0Ysk
         GdmvMal3V/53qgiwUPZ/F9sBZuT4YthtPPiOhqFUJb0Ez8rYAgKpG3p1khGwJ5HxLC
         6Pw88CujJiIx/Wfb4+oJ3kJSuxu0SFwarpr55XDDYOoxrlOHqdoq/4VxXuO+B08E7o
         SSiXEdMZKQaAZJMPh89KWfldNi/7UWolyvReJCDNxKpf+KRCewFiFz1N+E2c/ulRox
         O8eTA3jYe/UwA==
Date:   Mon, 16 Oct 2023 14:54:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <egallen@redhat.com>,
        <hgani@marvell.com>, <mschmidt@redhat.com>,
        <netdev@vger.kernel.org>, <sedara@marvell.com>,
        <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: Re: [net PATCH v2] octeon_ep: update BQL sent bytes before ringing
 doorbell
Message-ID: <20231016145408.539968d1@kernel.org>
In-Reply-To: <20231012101706.2291551-1-srasheed@marvell.com>
References: <PH0PR18MB47342FEB8D57162EE5765E3CC7D3A@PH0PR18MB4734.namprd18.prod.outlook.com>
        <20231012101706.2291551-1-srasheed@marvell.com>
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

On Thu, 12 Oct 2023 03:17:06 -0700 Shinas Rasheed wrote:
> -	netdev_tx_sent_queue(iq->netdev_q, skb->len);
>  	iq->stats.instr_posted++;
>  	skb_tx_timestamp(skb);

The skb_tx_timestamp() here will do the same exact UAF, no?
I think you should move them both.
-- 
pw-bot: cr
