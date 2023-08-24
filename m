Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E364786D25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjHXKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjHXKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:51:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BFA910DA;
        Thu, 24 Aug 2023 03:51:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16F861042;
        Thu, 24 Aug 2023 03:52:22 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA0503F740;
        Thu, 24 Aug 2023 03:51:39 -0700 (PDT)
Date:   Thu, 24 Aug 2023 11:51:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        oleksii_moisieiev@epam.com, Sudeep Holla <sudeep.holla@arm.com>,
        aisheng.dong@nxp.com, festevam@gmail.com, ping.bai@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] scmi: pinctrl: support i.MX9
Message-ID: <20230824105137.xqkwi4xvmjoidexh@bogus>
References: <20230824070611.3335107-1-peng.fan@oss.nxp.com>
 <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYU7MRXRV3Uw1w300sdxv=9XT=P1vFFarHfpSM6BT20Hg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks a lot for the quick response.

On Thu, Aug 24, 2023 at 10:43:20AM +0200, Linus Walleij wrote:
> On Thu, Aug 24, 2023 at 9:01 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> 
> > This patch is just to introduce i.MX support to see whether people have
> > comments for the design.
> 
> Very interesting!
> 
> > The binding format:
> > <mux_reg conf_reg input_reg mux_mode input_val>
> > dts:
> >         pinctrl_uart1: uart1grp {
> >                 fsl,pins = <
> >                         MX93_PAD_UART1_RXD__LPUART1_RX                  0x31e
> >                         MX93_PAD_UART1_TXD__LPUART1_TX                  0x31e
> >                 >;
> >         };
> >
> > i.MX pinctrl not use generic pinconf, this has been agreeed by
> > maintainers before.
> 
> Yes, it has historical reasons.
>

Good to know.

> > So after moving to SCMI, we will still
> > keep the same binding format, and i.MX SCMI firmware also use same
> > format when configure registers. So we need to use i.MX specific
> > dt_node_to_map function.
> 
> I thought the idea with SCMI was to abstract and hide the characteristics of
> the underlying hardware. I.e. the firmware is to present groups and
> functions and generic config options and then the driver will use these.
>

Correct.

> This patch, it seems, creates a hybrid between the old freescale driver
> and the SCMI firmware communication link where the SCMI is just a
> transport mechanism to something inside SCMI that poke the same
> registers that userspace could poke, if it could only access these
> registers.
>
> I.e using SCMI on this platform isn't creating any abstraction of the
> pin control hardware, it is merely making things more complex and
> also slower bymaking the registers only accessible from this SCMI link.
>

Agreed.

I don't have much knowledge on generic pinmux conf and suggested Peng
to post the RFC to start the discussion instead of getting blocked by me
during some internal/private discussions as the main intention for him
was upstreaming the changes. I am against the idea of mixing platform
specific changes the way it is done here but since I didn't have much
knowledge on pinmux conf to suggest/provide any useful feedback I suggested
to trigger this discussion.

> But I could have misunderstood it, so please correct me!

+1

-- 
Regards,
Sudeep
