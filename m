Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBF0799EC3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjIJPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346736AbjIJPEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:04:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EABCF2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 08:04:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07270C433C8;
        Sun, 10 Sep 2023 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694358247;
        bh=cJBelSkt6YU5+Pe0SigO495hI7+BDh2yPucVWdt/8JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwmyS0nY7on0/YMi1AXOdOOzDsdX8XaOTMkt9QlECR8qFb1EV8f9zJFk2rTNmY12T
         p2ukMoWaVVVlaREg4nKw5TQ7VShCDwcPiHOdeBVL8Fo9hqhDOfxMO2SST/vWqLbK8e
         13ocJTRNDS36MgU7rECL7fbOT5ns+cEr8o5FZIqAJKKtvVmCinFKpS41TKojYEKFT0
         YCXXlipBVsORkHptmjv+22SRNqIsbojw0fZQypwuQkr9RxxgJf706tYLUPjT2C8Wl8
         reF1bGAZSjY+dPqDdRENAOZZ26Qu+YW/3MbQUl4AvOr/1CQpVVMm674nJa688/KDH2
         k2bCIqeJdzmsw==
Date:   Sun, 10 Sep 2023 17:04:02 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Lennart Franzen <lennart@lfdomain.com>, netdev@vger.kernel.org
Subject: Re: [net] net:ethernet:adi:adin1110: Fix forwarding offload
Message-ID: <20230910150402.GH775887@kernel.org>
References: <20230908125813.1715706-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908125813.1715706-1-ciprian.regus@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:58:08PM +0300, Ciprian Regus wrote:
> Currently, when a new fdb entry is added (with both ports of the
> ADIN2111 bridged), the driver configures the MAC filters for the wrong
> port, which results in the forwarding being done by the host, and not
> actually hardware offloaded.
> 
> The ADIN2111 offloads the forwarding by setting filters on the
> destination MAC address of incoming frames. Based on these, they may be
> routed to the other port. Thus, if a frame has to be forwarded from port
> 1 to port 2, the required configuration for the ADDR_FILT_UPRn register
> should set the APPLY2PORT1 bit (instead of APPLY2PORT2, as it's
> currently the case).
> 
> Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

I think the subject prefix might be better written as:
'net: ethernet: adi: adin1110: '.
But that notwithstanding this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

