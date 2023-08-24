Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F25788203
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbjHYI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243017AbjHYI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:26:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4D1FDB;
        Fri, 25 Aug 2023 01:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB8B063DF3;
        Fri, 25 Aug 2023 08:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C897CC433C7;
        Fri, 25 Aug 2023 08:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692951982;
        bh=fbssi10KHPpHQrchGVRvapO9aMUTdbU6J3cD+61Z/y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEq2wWYsUfmzADOSTjZuBixsX+xrbFkwZLfVB39KuPkKQpdDqij/apEvF8FTbBFGa
         MQBjvvbOhioC9dbGhnvjQ/tqCCyQ2Zkz25IYrHka8sgka6Yhq8twIqBR0L3t+ptFzY
         N2x2wHl74giNhRSODm9+HMTC1A6eGO/SzSVznYfg=
Date:   Thu, 24 Aug 2023 21:23:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Pankaj Gupta <pankaj.gupta@nxp.com>,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <2023082422-proofing-dispense-1a1a@gregkh>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-2-pankaj.gupta@nxp.com>
 <20230823124340.GA2022486-robh@kernel.org>
 <574e93da-ec74-f1a2-7170-c16bb225a2bb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574e93da-ec74-f1a2-7170-c16bb225a2bb@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:45:41PM +0200, Krzysztof Kozlowski wrote:
> On 23/08/2023 14:43, Rob Herring wrote:
> >> +                                                          |
> >> +  +------------------------------------------------------ |
> >> +                     |             |           |          |
> >> +  userspace     /dev/ele_muXch0    |           |          |
> >> +                           /dev/ele_muXch1     |          |
> >> +                                         /dev/ele_muXchY  |
> >> +                                                          |
> >> +
> >> +  When a user sends a command to the firmware, it registers its device_ctx
> >> +  as waiter of a response from firmware.
> >> +
> >> +  A user can be registered as receiver of command from the ELE.
> >> +  Create char devices in /dev as channels of the form /dev/ele_muXchY with X
> >> +  the id of the driver and Y for each users. It allows to send and receive
> >> +  messages to the NXP EdgeLock Enclave IP firmware on NXP SoC, where current
> >> +  possible value, i.e., supported SoC(s) are imx8ulp, imx93.
> > 
> > Looks like a bunch of Linux details which don't belong in the binding.
> > 
> > Why do you need your own custom interface to userspace? No one else has 
> > a similar feature in their platforms? Something like virtio or rpmsg 
> > doesn't work?
> 
> +Cc Greg,
> 
> I doubt they care. This is some stub-driver to pass messages from
> user-space to the firmware. The interface is undocumented, without
> examples and no user-space user.

Great, no user?  Let's delete the code then :)

thanks,

greg k-h
