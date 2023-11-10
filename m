Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7789A7E8029
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjKJSH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjKJSEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:04:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA286AF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:47:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2439C433C8;
        Fri, 10 Nov 2023 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699602467;
        bh=eNPMLFSId0QrwBhmYQ8Tp1C473yK+iDSdTu+mEwhyjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBU4iTMx3DS8Yyjn8ht5Nc7BRgS29IkwuFzg6YNSP2o4BrnhmSc01w8MBEnT6S4VK
         1N2CDcaE6LrEyUUr7JcnFBKeVX/svtqbHnTGE4XGk5SVxmClSzIdLdyVmrjdRqXU7S
         sQniXG+0zlJ99NLBjuAma7TZwP+NQco3D0OAevhz+Tg1oOdPwP1+Pt3bPaGnK5iQD+
         N9ikgeH0NI/u4I4vTJSXzfAg2x3MT6T7xFrEYirFo4VEVFtq3c5kb8CMAIZZpEjOz3
         YyYg1Kb8zbx4Zf405nRZWfzpo+5msTg3ZCfVlkJmhJ314c3IO2IFe2/UFUN3PWHaPq
         3HBR2KDdmdREQ==
Received: from johan by theta with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r1MEv-0000TU-2N;
        Fri, 10 Nov 2023 08:47:41 +0100
Date:   Fri, 10 Nov 2023 08:47:41 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Roy Luo <royluo@google.com>,
        Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/4] phy: realtek: usb: add new driver for the Realtek
 RTD SoC USB 2.0 PHY
Message-ID: <ZU3gHcugq9FxBG4P@hovoldconsulting.com>
References: <20231110054738.23515-1-stanley_chang@realtek.com>
 <20231110054738.23515-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110054738.23515-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 01:45:13PM +0800, Stanley Chang wrote:
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the USB 2.0 PHY transceivers.
> 
> Note: New driver,remove the port status notification on legacy USB PHY.
> Use the generic PHY to notify the usb device connect and disconnect.
> To avoid using these PHYs would require describing the very same
> PHY using both the generic "phy" property and the deprecated "usb-phy"
> property.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v1 to v2 change:
>     rebase the driver to include the revert part on
>     7a784bcdd7e54f0599da3b2360e472238412623e
> v2 to v3 change:
>     remove MODULE_ALIAS

Don't send out a new version of a patch series immediately just to fix
something small like this.

In this case I'd suggest you wait at least until you've gotten feedback
on the new notification implementation.

Johan
