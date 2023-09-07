Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559F97978ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjIGQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjIGQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:58:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DC9E57;
        Thu,  7 Sep 2023 09:58:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C74C43395;
        Thu,  7 Sep 2023 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694104717;
        bh=doH2Ipa+K30k1xtAqDsX27JKiStd1k7S5/DQ0ZIzSjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=byj3V30uebT2aqsPOpUIcbMHDdf8k+FFiC/OpNOxjPqZdoBrm18qozEfNP3xVbSMT
         rtLWA3im2nzeChLUmdMV/ZOzuUsjHOSxQtohcKxeA4FPNxaqzvpun81yKhD6hgrite
         enypqZyGHGftZFf8xmWZ1iCD7BW34YHrAwvadt0T4Sa8SgMTfDnjnfiYxq1qGwLMXG
         MDEvNx97paTGEktB7oc+StyXTxks755mV7A6uNLfoxJ8NYUgmCJJoANHcMOki11D/R
         QLWQfFNHYORmYEm4C2lD0MXH9fzMqwGtyQeehP5By8UJS5e650TiemlbT0VfD42Q6L
         fKkXRxJzFZ2Pw==
Date:   Thu, 7 Sep 2023 09:38:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net v2] r8152: avoid the driver drops a lot of packets
Message-ID: <20230907093836.3253c0d5@kernel.org>
In-Reply-To: <7f8b32a91f5849c99609f78520b23535@realtek.com>
References: <20230906031148.16774-421-nic_swsd@realtek.com>
        <20230906172847.2b3b749a@kernel.org>
        <7f8b32a91f5849c99609f78520b23535@realtek.com>
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

On Thu, 7 Sep 2023 07:16:50 +0000 Hayes Wang wrote:
> > Before we tweak the heuristics let's make sure rx_bottom() behaves
> > correctly. Could you make sure that
> >  - we don't perform _any_ rx processing when budget is 0
> >    (see the NAPI documentation under Documentation/networking)  
> 
> The work_done would be 0, and napi_complete_done() wouldn't be called.
> However, skb_queue_len(&tp->rx_queue) may be increased. I think it is
> not acceptable, right?

If budget is 0 we got called by netconsole, meaning we may be holding
arbitrary locks. And we can't use napi_alloc_skb() which is for
softirq/bh context only. We should only try to complete Tx in that
case, since r8152_poll() doesn't handle any Tx the right thing seems
to be to add if (!budget) return 0;

> >  - finish the current aggregate even if budget run out, return
> >    work_done = budget in that case.
> >    With this change the rx_queue thing should be gone completely.  
> 
> Excuse me. I don't understand this part. I know that when the packets are
> more than budget, the maximum packets which could be handled is budget.
> That is, return work_done = budget. However, the extra packets would be queued
> to rx_queue. I don't understand what you mean about " the rx_queue thing
> should be gone completely". I think the current driver would return
> work_done = budget, and queue the other packets. I don't sure what you
> want me to change.

Nothing will explode if we process a few more packets than budget
(assuming budget > 0). If we already do allocations and prepare
those skbs - there's no point holding onto them in the driver.
Just sent them up the stack (and then we won't need the local rx_queue).

> >  - instead of copying the head use napi_get_frags() + napi_gro_frags()
> >    it gives you an skb, you just attach the page to it as a frag and
> >    hand it back to GRO. This makes sure you never pull data into head
> >    rather than just headers.  
> 
> I would study about them. Thanks.
> 
> Should I include above changes for this patch?
> I think I have to submit another patches for above.
> 
> > Please share the performance results with those changes.  
> 
> I couldn't reproduce the problem, so I couldn't provide the result
> with the differences.

Hm, if you can't repro my intuition would be to only take the patch for
budget=0 handling into net, and the rest as improvements into net-next.
