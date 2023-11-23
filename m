Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44A7F5F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbjKWMud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWMua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:50:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849D91
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:50:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E093FC433C7;
        Thu, 23 Nov 2023 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700743837;
        bh=FGTiolTqE2DDJVOuYCgHW3eC+mUVZ0ruY4vuGK1d2SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cky5QevEsj9ILwZzg+WLV7jqszwXZx0WPOC7JnUAPbl9/fu9d/XPP+XjnYQ3n56Dr
         ymd90mr5H/ry5gJy0pxlqr5LXKqe6lV0j0XH0Q5CiNKuBmP/Ov0SO+yX/yVSvkhFhR
         Lp3lRw/BtLTYM+f97GGE2kJkKaQ7CIQUXncYsMkdw9/fIQYVDTTmoVdHHoDX7W38nS
         PpiiCc9GohQ7QlDA2CMJPUdxLeDLN/+D51SIFNLrMQMPz39FPsmGbK2+W9UkWKFquP
         RsOMTR8yjvbjUzSvNkxRhj3pB+Xn2NT8RgEJyt/eWcUB7Mck6gEuzcS0rvmdXWWCSm
         BkMc5hht0VbRw==
Date:   Thu, 23 Nov 2023 12:50:32 +0000
From:   Simon Horman <horms@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Larysa Zaremba <larysa.zaremba@intel.com>
Subject: Re: [net-next PATCH v2] net: phy: correctly check soft_reset ret
 ONLY if defined for PHY
Message-ID: <20231123125032.GD6339@kernel.org>
References: <20231121135332.1455-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121135332.1455-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:53:32PM +0100, Christian Marangi wrote:
> Introduced by commit 6e2d85ec0559 ("net: phy: Stop with excessive soft
> reset").
> 
> soft_reset call for phy_init_hw had multiple revision across the years
> and the implementation goes back to 2014. Originally was a simple call
> to write the generic PHY reset BIT, it was then moved to a dedicated
> function. It was then added the option for PHY driver to define their
> own special way to reset the PHY. Till this change, checking for ret was
> correct as it was always filled by either the generic reset or the
> custom implementation. This changed tho with commit 6e2d85ec0559 ("net:
> phy: Stop with excessive soft reset"), as the generic reset call to PHY
> was dropped but the ret check was never made entirely optional and
> dependent whether soft_reset was defined for the PHY driver or not.
> 
> Luckly nothing was ever added before the soft_reset call so the ret
> check (in the case where a PHY didn't had soft_reset defined) although
> wrong, never caused problems as ret was init 0 at the start of
> phy_init_hw.
> 
> To prevent any kind of problem and to make the function cleaner and more
> robust, correctly move the ret check if the soft_reset section making it
> optional and needed only with the function defined.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

I agree that it is good to only check for ret if it could be
indicating an error value. And I see that as a bonus we avoid
a now redundant in the case where phydev->drv->soft_reset is set,
which is nice.

FWIIW, in an ideal world, I think that ret would not be initialised to
0 at the top of the function, because it's unnecessary, and such
defensive programming is not in line with how kernel code is done.

In any case, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
