Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2271E7F5B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjKWJqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjKWJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:46:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB61910CF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:46:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3546C433C8;
        Thu, 23 Nov 2023 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700732795;
        bh=2l0/Ev7FSIGz1Ko2iOPlx8+jTmBCUrIpJOZuuECMMWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWEgfPproWd+Bw30XkqC6qYT5sQ2f/IvQEXSGPCUgG6MKyWvK6m4++6p+CO4FAxoC
         w3IRyKvlmwdWHbC1lpJe9Wl/ArDiN4QxiGzFdDQS4YN9Vh6ubgT+hRThFKPq8iLfUB
         DPlkOiXdZVzYqTi3v1rMrewYgEwbFn51/CzU53WteZ4uyCAHfaUck6uvJ1B5wqy8/b
         MM0GPsVHuGfBu6xyCBvndkPvkc78Cyh5uskHK8jmxWqJBT171QjLWmZSpPeyjjD3L2
         4VQqyeh23FUodjSPcZ5pgRWi+uQkeUgh7jTsbQpXNraroxSL+wfGcRY22C0uhFdnY6
         LdFYWlAJSqGmg==
Date:   Thu, 23 Nov 2023 09:46:29 +0000
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wojciech.drewek@intel.com
Subject: Re: [net PATCH v2] octeontx2-pf: Fix ntuple rule creation to direct
 packet to VF with higher Rx queue than its PF
Message-ID: <20231123094629.GB46439@kernel.org>
References: <20231121165624.3664182-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121165624.3664182-1-sumang@marvell.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:26:24PM +0530, Suman Ghosh wrote:
> It is possible to add a ntuple rule which would like to direct packet to
> a VF whose number of queues are greater/less than its PF's queue numbers.
> For example a PF can have 2 Rx queues but a VF created on that PF can have
> 8 Rx queues. As of today, ntuple rule will reject rule because it is
> checking the requested queue number against PF's number of Rx queues.
> As a part of this fix if the action of a ntuple rule is to move a packet
> to a VF's queue then the check is removed. Also, a debug information is
> printed to aware user that it is user's responsibility to cross check if
> the requested queue number on that VF is a valid one.
> 
> Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> v2 changes:
> - Removed 'goto' and added the new condition to existing if check.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

