Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09D806FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378065AbjLFM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFM1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:27:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02F112
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:27:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F61C433C7;
        Wed,  6 Dec 2023 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701865672;
        bh=dlj/YCXcrqa1hzDWlixfpmkm6MqvVIgbXbMVeW4nZlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdeFo0jiIjPqrDwRBwUjKRUeRAWf4059fHqTteSj0VHDrhWaMF+HEv2ZEZXedaDgD
         cfBHYtyFxqH+JV5AqFf3PFYnIKwQyoMzTeMiltUvDH1l0gc/qxW1GK7pIXTfA0T3El
         mGm2yANxGVzo6lPm0xnEorK/v8O5vDSn1LEbPeo6cpvQPXu2c4+U1a1P2kR9gSI7aP
         WjdU8Z01ATLX+YfrqDuGqGiA3gCBLuKP/VezSEx399xilXDYKDIofqpyY3w3mbk3mx
         cDTMB+pPNwGNwwomuaU2RETacF60AKssiVMh8BlQg5d/UF6h+gm2Ddam3/tXBs+euj
         /3e7uFW/S993w==
Date:   Wed, 6 Dec 2023 13:27:38 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Jensen Huang <jensenhuang@friendlyarm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: rk3x: fix potential spinlock recursion on poll
Message-ID: <20231206122738.cnnjxszz4g6zak3w@zenone.zhora.eu>
References: <20231206090641.18849-1-jensenhuang@friendlyarm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206090641.18849-1-jensenhuang@friendlyarm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jensen,

On Wed, Dec 06, 2023 at 05:06:40PM +0800, Jensen Huang wrote:
> Possible deadlock scenario (on reboot):
> rk3x_i2c_xfer_common(polling)
>     -> rk3x_i2c_wait_xfer_poll()
>         -> rk3x_i2c_irq(0, i2c);
>             --> spin_lock(&i2c->lock);
>             ...
>         <rk3x i2c interrupt>
>         -> rk3x_i2c_irq(0, i2c);
>             --> spin_lock(&i2c->lock); (deadlock here)
> 
> Store the IRQ number and disable/enable it around the polling transfer.
> This patch has been tested on NanoPC-T4.
> 
> Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>

Looks good,

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
