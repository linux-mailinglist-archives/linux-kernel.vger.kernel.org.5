Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B3F7C7826
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442814AbjJLUwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442748AbjJLUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:52:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D51D7;
        Thu, 12 Oct 2023 13:52:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE15DC433C8;
        Thu, 12 Oct 2023 20:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143920;
        bh=QLs1pQ7YnOXiEEeiGiyU7dSYjD9NCXqhv5FGAzmT5HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVBN+IAMIg9EyB1dJcneervIqpzfHli4MH53ttxXxE0EtlW7bklb/57VAlXHHVFMa
         NE0W4KrMNamD4LfVYR5zGyviIUaSqrD4iEl9u7UA6T+JjwarFR2WCf7yU1OCGWQY8t
         60Ijpgeq/JQKyJy3J1RwQLQ8LSuTwraLiQ95vhxlRa7MIEzk7uHQQ1a3cavD+/RML3
         hLwSpd1GRF5GdR6GPqK3zVTFiJgDn3Lkv7dg+PFcLV4M9I8izLZM9CvLRpq/DXq2qw
         e8fT34ziGMUfe6+pU8FlJ13wZCSt5n3KNe6gnEgxKRB8O767aQ1D/szUG+7MVCJth0
         q7eEDYgdX1XCg==
Received: (nullmailer pid 1717618 invoked by uid 1000);
        Thu, 12 Oct 2023 20:51:58 -0000
Date:   Thu, 12 Oct 2023 15:51:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     m.brock@vanmierlo.com
Cc:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
        michal.simek@amd.com, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org, radhey.shyam.pandey@amd.com,
        srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
        manion05gk@gmail.com
Subject: Re: [PATCH V2 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
Message-ID: <20231012205158.GA1714449-robh@kernel.org>
References: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
 <20231011145602.3619616-2-manikanta.guntupalli@amd.com>
 <c4d6ec9a13807866b7dbc7cbed478494@vanmierlo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d6ec9a13807866b7dbc7cbed478494@vanmierlo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:35:59PM +0200, m.brock@vanmierlo.com wrote:
> Manikanta Guntupalli wrote on 2023-10-11 16:56:
> > Add optional gpio property to uartps node and reference to rs485.yaml
> > 
> > On Xilinx/AMD Kria SOM KD240 board rs485 connects via TI ISOW1432
> > Transceiver device, where one GPIO is used for driving DE/RE signals.
> > With rs485 half duplex configuration, DE and RE shorts to each other,
> 
> s/shorts/are connected
> 
> > and at a time, any node acts as either a driver or a receiver.
> > 
> > Here,
> > DE - Driver enable. If pin is floating, driver is disabled.
> > RE - Receiver enable. If pin is floating, receiver buffer is disabled.
> 
> Please use DE and /RE to indicate DE is active high and /RE is active low.
> 
> > xlnx,phy-ctrl-gpios is optional property, because it is not required
> > for uart console node.
> 
> How about introducing an rs485 generic gpios property instead of xlnx
> private one? See also rs485-term-gpios and rs485-rx-during-tx-gpios.
> 
> Also note that every kernel driver expects to use RTS for this purpose.
> So why not give this driver the option to choose a gpio instead of its
> native RTS? And from there on use the rts route?
> What if someone wants to use normal (non-rs485) RTS on a GPIO instead
> of the native pin?
> 
> @Rob Herring
> I am curious to know how the rs485 maintainers look at this.

Ask them.

We already have 'rts-gpios'. If that's what's always used, then perhaps 
we should use that in the RS485 case too?

Rob
