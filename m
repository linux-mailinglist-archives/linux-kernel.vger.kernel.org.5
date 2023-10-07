Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4507BC891
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbjJGPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbjJGPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:13:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B372BA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 08:13:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D111C433C7;
        Sat,  7 Oct 2023 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696691612;
        bh=m89gazFfrv75JcJMlTacH3tiK09irLU+A97u2aDkxBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YO9WG4/P5pcHX0L59vCYD0VJkvi8oRSDh7oXwbRb66Emjoem3g9/VIEfrly7YtBqv
         BRzlfWtip+BGlVSHm9QV+n6NdBRIqBWH/6PdT35W4Kb0NKS0zfkdTw4h0/xfrXUTvz
         RJSlqtANVRhvktF5ylJVyf3631CdiGFxEzt494mxuCzzlxthftyfJ5A3xid+FPOnzF
         PjeKRNsdhaiEk5bFGgQqlVSXWWxSgDzMe8Yd3nWo45HPZiXdpwnWb7cr1ATx3fVkF9
         cka8NB/Qou7tV8mUoo8g/11VzP8tQKlVfCjhLVDpPMvD+iWi/nQsB1M8PFxFRYGHQk
         tZWnkRmBe+8xQ==
Date:   Sat, 7 Oct 2023 17:13:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     3chas3@gmail.com, davem@davemloft.net,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] atm: solos-pci: Fix potential deadlock on
 &tx_queue_lock
Message-ID: <20231007151328.GD831234@kernel.org>
References: <20231005074917.65161-1-dg573847474@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005074917.65161-1-dg573847474@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 07:49:17AM +0000, Chengfeng Ye wrote:
> As &card->tx_queue_lock is acquired under softirq context along the
> following call chain from solos_bh(), other acquisition of the same
> lock inside process context should disable at least bh to avoid double
> lock.
> 
> <deadlock #2>
> pclose()
> --> spin_lock(&card->tx_queue_lock)
> <interrupt>
>    --> solos_bh()
>    --> fpga_tx()
>    --> spin_lock(&card->tx_queue_lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> on &card->tx_queue_lock under process context code consistently to
> prevent the possible deadlock scenario.
> 
> Fixes: 213e85d38912 ("solos-pci: clean up pclose() function")
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
> V2: add fix tag, and split into two patches

Reviewed-by: Simon Horman <horms@kernel.org>

