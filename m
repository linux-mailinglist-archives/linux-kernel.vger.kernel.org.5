Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A37A2154
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjIOOqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjIOOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:46:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031361FCE;
        Fri, 15 Sep 2023 07:46:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FD2C433C8;
        Fri, 15 Sep 2023 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694789162;
        bh=vmWJjbUV9feQTNnTRpzFcWDL7EDviII2F9crbfYB6XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvLP61L5Srj5bBexjD3yccDBzkb0QAHF22eelHc/2Ww0BT7WfYu/CSZ56X9/nE6qu
         5EU6lXh59ctX45FlSf8ZO+l5lfoUDbvLTbKUk8urSmWJYPCjlrJa0HJYtGmscey7ud
         JJmR6bUhBJys4Y9sX0ySY9uue2XHYEWg5OvQFTSeO+jfS66qitFwy0wFjUWg/5/z74
         9d3l/Fz1Yb6hGNZ7AjPBZshOdhPbebdTpEA6sHyVjyMFcZAq5qCKdqOF2CmiFix6c9
         ewzUL0rCnYYgYX1/pLDH+43J//2ZUuVUySuu5a+FGUq8F9mxRS36J01YP5sVQX3st7
         DbM/UIq8Yz2Cw==
Received: (nullmailer pid 3702987 invoked by uid 1000);
        Fri, 15 Sep 2023 14:45:59 -0000
Date:   Fri, 15 Sep 2023 09:45:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain
 dependency
Message-ID: <20230915144559.GA3696959-robh@kernel.org>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de>
 <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
 <20230913065843.GF637806@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230913065843.GF637806@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 08:58:43AM +0200, Sascha Hauer wrote:
> On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Sep 12, 2023 at 4:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > Top posting to bring Saravana Kannan into this discussion.
> > >
> > > This looks like a big hack to me, Saravana has been working
> > > tirelessly to make the device tree probe order "sort itself out"
> > > and I am pretty sure this issue needs to be fixed at the DT
> > > core level and not in a driver.
> > 
> > We could merge all the IO domain stuff into the pinctrl node/driver,
> > like is done for Allwinner? Maybe that would simplify things a bit?
> 
> I thought about this as well. On Rockchip the pinctrl driver and the IO
> domain driver even work on the same register space, so putting these
> into a single node/driver would even feel more natural than what we have
> now.

DT should reflect the hardware. If this is in fact 1 block, then it 
should be 1 DT node. How you want to split the driver or not is up to 
you.

Rob
