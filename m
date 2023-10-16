Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6AC7CA414
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjJPJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjJPJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:27:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A966E95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:27:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485C2C433C8;
        Mon, 16 Oct 2023 09:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697448426;
        bh=K6N7taMNzX8fRSK+a4h5bAnL1ClZhYOHgnAw8kLuxgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVQMhtgQmEmd5OAjsfBAeqca4uAcYytlr0LvgAArGWkEeBIyQxupcpKwvSJ5y+cD2
         gcAuDvyWNvjEoem4fP/PwlSsFromuX6NrjHd8I1xAQNtM6rPv+cDYd/p+Hk4SGqxSu
         G+6odt9u2IAzgz0QHx69p64eosCwuLnxiE/kQaioCB6Vy2/JHJGuuvb0nZb88l8kv/
         tek7Vr48wkbVNblS63Ts09cNXP3A4fxI3K/Rq9IXnxnJHKOW3M25HZkQxfxSUlomoM
         Pb7E23H35Z0rRA+yG7YMedxdyt2HLBghpMX9Ozy3RiYqlCLlXG3CNHxhZXxyK35pio
         DgR1J89bC++tw==
Date:   Mon, 16 Oct 2023 11:27:00 +0200
From:   Simon Horman <horms@kernel.org>
To:     Takeru Hayasaka <hayatake396@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231016092700.GH1501712@kernel.org>
References: <20231012060115.107183-1-hayatake396@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012060115.107183-1-hayatake396@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 06:01:15AM +0000, Takeru Hayasaka wrote:
> This is a patch that enables RSS functionality for GTP packets using
> ethtool.
> A user can include her TEID and make RSS work for GTP-U over IPv4 by
> doing the following:
> `ethtool -N ens3 rx-flow-hash gtpu4 sde`
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.
> 
> GTP generates a flow that includes an ID called TEID to identify the
> tunnel. This tunnel is created for each UE (User Equipment).
> By performing RSS based on this flow, it is possible to apply RSS for
> each communication unit from the UE.
> Without this, RSS would only be effective within the range of IP
> addresses.
> For instance, the PGW can only perform RSS within the IP range of the
> SGW.
> problematic from a load distribution perspective, especially if there's
> a bias in the terminals connected to a particular base station.
> This case can be solved by using this patch
> 
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> ---
> Added commit messages and options based on reviews

Thanks Hayasaka-san,

Overall this looks good to me. And I see that the review of v1
has been addressed - by adding information about the need for
this to the commit message.

Reviewed-by: Simon Horman <horms@kernel.org>
