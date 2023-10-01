Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182AE7B4973
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjJATfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjJATfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:35:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E75BF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 12:35:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909AFC433C8;
        Sun,  1 Oct 2023 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696188928;
        bh=2fAkwl7Bkul3eesFHp5NXfQdxux8bozgy2kPSkCSopE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNOARcbYjlQr9J1v44b4w03Q78QjwiFErN/19dIHTWjJvTieOjhaSLih78RV4ezpq
         NFn1mOZV4aQDnOTCxsjz9TfXU68StlzPcMqrwdkg0XTFHw9CLke4TFwVr+mkxs8Lhv
         wI5CeQPMLfS2Mc3f8z5Ev1coO3+olABJB0LVmirI2w4kdEcPn5SNnxz8vf2Dr6/2pB
         bBJoWTlb95OvPpxyT+/Y6I0rLNTVJCQrUOO7rtAMgRV/5R4bjwwqjh1zRVPGy8TF6s
         14lWfZXpnSmDpPrYbAtiIy1coTSr5IYW0H14o5uyIaoSpCWC0pEL3p/WT/imdl3ITS
         LYVufo6RBtdWg==
Date:   Sun, 1 Oct 2023 21:35:21 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sonia Sharma <sosha@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
        mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v6] net: hv_netvsc: fix netvsc_send_completion
 to avoid multiple message length checks
Message-ID: <20231001193521.GV92317@kernel.org>
References: <1695849556-20746-1-git-send-email-sosha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695849556-20746-1-git-send-email-sosha@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 02:19:16PM -0700, Sonia Sharma wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases might
> cause a length check to fail when it should not.
> 
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>

