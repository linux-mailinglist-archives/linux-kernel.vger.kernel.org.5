Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369DA757BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGRM2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjGRM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86AEE70
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C54761560
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 12:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD00C433C7;
        Tue, 18 Jul 2023 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689683283;
        bh=R8sOcqcXecALVQwiIRsJk5h3MaygnnkPbEwfmlj/MC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1IBPkGMgdov8HhHI+SZXO385pfWvIlMvE3LMSZXQmHfb9Hn+z4mx1uteAhHMMtuP
         G3FImlLNRgGDQ9xzJQea/AoRhq3ZC1kVDCKDjwlY1aR2O+3BnaXC8rHOq2nsdiiwGk
         72qXvFSZTSGzU/0pXQe07bQKfv2y9K0hnm+E5tZ3NZGBIkD6SZHIJXYbd7DelAIAqn
         jPLW5V80CesSSPUj/ldoM0APhDnOJQf11l/+zZ3bUowfJzcPMzZx+XHqsvufaToJN0
         1FUhNZyRgJFNnLkZ9EWkrU0AhXLEQRQR3XWYZvSR1rUViFPp4+/2FrCIO3qqsVumoi
         e+l0/ITnt0ciw==
Date:   Tue, 18 Jul 2023 15:27:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com
Subject: Re: [net-next PATCH V3] octeontx2-af: Install TC filter rules in
 hardware based on priority
Message-ID: <20230718122759.GE8808@unreal>
References: <20230718044049.2546328-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718044049.2546328-1-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:10:49AM +0530, Suman Ghosh wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> v3 changes:
> - Addressed minor review comments from Leon Romanovsky
> 
> v2 changes:
> - Rebased the patch on top of current 'main' branch
> 
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   9 +-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |   9 +-
>  .../marvell/octeontx2/af/rvu_switch.c         |   6 +-
>  .../marvell/octeontx2/nic/otx2_common.h       |  11 +-
>  .../marvell/octeontx2/nic/otx2_devlink.c      |   1 -
>  .../marvell/octeontx2/nic/otx2_ethtool.c      |   1 +
>  .../marvell/octeontx2/nic/otx2_flows.c        |   2 +
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 313 +++++++++++++-----
>  8 files changed, 248 insertions(+), 104 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
