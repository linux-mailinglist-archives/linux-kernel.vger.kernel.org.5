Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470575F401
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjGXK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjGXK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4951DE49;
        Mon, 24 Jul 2023 03:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A866108E;
        Mon, 24 Jul 2023 10:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DAEC433C7;
        Mon, 24 Jul 2023 10:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690196184;
        bh=Sq8Naj+SLCMOVbiFEc9mTSfYNfyJrtjHPO/jeFnc4H0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Tz+jsQpGP76OVVI/kBOsqmsVFQtqcnY7O+vQHC9NGAIXzV+BaiaDFAIYzI2BE06Up
         C4fnVV+JLd7a7jpBRmZYjJbm+RokcausZDGHsIM5JjRPWC4bB4oXSwkDGkp7eqaIFM
         u0FNUAg+XhjRtxmWOyL9GpLq7A4Advx/HnvrQHH+JJz+V6bpQzn8tMHIdyz7DmJ9k8
         MsFFWDQxgp9CnwFMRK4JoFmvaHaHsFfewr/hwF2ySNy6AyLFkIkILok6D4bJCMxzL+
         InVYotTrsaK2tg4AeXJmFE+iuNt1oD+OUz+GUX1Z2QH3F0tOy7wYUIoxRnCA9ffVT6
         R/l9btkG05pBg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Yang <mmyangfl@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Pengcheng Li <lpc.li@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     dan.carpenter@linaro.org, christophe.jaillet@wanadoo.fr,
        julia.lawall@inria.fr, kernel-janitors@vger.kernel.org,
        error27@gmail.com
In-Reply-To: <20230721090558.3588613-1-harshit.m.mogalapalli@oracle.com>
References: <20230721090558.3588613-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] phy: hisilicon: Fix an out of bounds check in
 hisi_inno_phy_probe()
Message-Id: <169019617956.466731.9761851242432174423.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 16:26:19 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Jul 2023 02:05:55 -0700, Harshit Mogalapalli wrote:
> The size of array 'priv->ports[]' is INNO_PHY_PORT_NUM.
> 
> In the for loop, 'i' is used as the index for array 'priv->ports[]'
> with a check (i > INNO_PHY_PORT_NUM) which indicates that
> INNO_PHY_PORT_NUM is allowed value for 'i' in the same loop.
> 
> This > comparison needs to be changed to >=, otherwise it potentially leads
> to an out of bounds write on the next iteration through the loop
> 
> [...]

Applied, thanks!

[1/1] phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()
      commit: 13c088cf3657d70893d75cf116be937f1509cc0f

Best regards,
-- 
~Vinod


