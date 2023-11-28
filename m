Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0BF7FC243
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbjK1RU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345663AbjK1RUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:20:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B912C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:20:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D412CC433C8;
        Tue, 28 Nov 2023 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701192057;
        bh=puusfip924NnsGJF8uNMJlJWB/vurJEyppEM+n1Lj8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcMRcUo3ib8lMWDBEiKlESJpOBqLmCMzpGbDnyYHxYJiJVVG6EO9LB+uIsMNP6riu
         yorYOJJEnjNEGL+E7gIqFRLj+pagLLcb/GTBSlAtxMk1xiFU4lXGf1WSlHjn4GHR2L
         BP3z/4Urpe631EF7o8pKT2NYTcGKvnNNHQkW20MC/6AnyA4S4pcUkQwhP5URZbEWIv
         7VZcnvkisjHDfggVetzKkTGOGJpQEL1F2qu0EY7vq+4yNrDM5i4BsdgiPkESRTzwxS
         U7s+VyKoIBxJE8kh7FK9LA5aK+DxXeSZZAq3ER+G88Aq/F7gRTpSljY3zx7ugE314m
         2kWTYk0Nscnpw==
Date:   Tue, 28 Nov 2023 17:20:53 +0000
From:   Simon Horman <horms@kernel.org>
To:     Subbaraya Sundeep <sbhatta@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, gakula@marvell.com,
        hkelam@marvell.com
Subject: Re: [PATCH net] octeontx2-pf: Add missing mutex lock in
 otx2_get_pauseparam
Message-ID: <20231128172053.GA43811@kernel.org>
References: <1700930141-5568-1-git-send-email-sbhatta@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700930141-5568-1-git-send-email-sbhatta@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 10:05:41PM +0530, Subbaraya Sundeep wrote:
> All the mailbox messages sent to AF needs to be guarded
> by mutex lock. Add the missing lock in otx2_get_pauseparam
> function.
> 
> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause frames via ethtool")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Hi,

I am wondering if the call to otx2_nix_config_bp()
in otx2_dcbnl_ieee_setpfc() also needs to be protected by mbox.lock.

And although not strictly related to this patch, while looking over this, I
noticed that in otx2_init_hw_resources() it appears that &mbox->lock may be
unlocked twice in some error paths.

e.g.
	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
	err = otx2_rq_aura_pool_init(pf);
	if (err) {
		mutex_unlock(&mbox->lock);
		goto err_free_nix_lf;
	}
	...
err_free_nix_lf:
	mutex_lock(&mbox->lock);
	...

...
