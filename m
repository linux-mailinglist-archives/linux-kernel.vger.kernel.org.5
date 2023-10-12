Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63E7C7601
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379655AbjJLSgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379707AbjJLSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:36:16 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09360D7;
        Thu, 12 Oct 2023 11:36:11 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Thu, 12 Oct 2023 20:35:59 +0200
MIME-Version: 1.0
Date:   Thu, 12 Oct 2023 20:35:59 +0200
From:   m.brock@vanmierlo.com
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     git@amd.com, michal.simek@amd.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org,
        radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
        shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V2 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
In-Reply-To: <20231011145602.3619616-2-manikanta.guntupalli@amd.com>
References: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
 <20231011145602.3619616-2-manikanta.guntupalli@amd.com>
Message-ID: <c4d6ec9a13807866b7dbc7cbed478494@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manikanta Guntupalli wrote on 2023-10-11 16:56:
> Add optional gpio property to uartps node and reference to rs485.yaml
> 
> On Xilinx/AMD Kria SOM KD240 board rs485 connects via TI ISOW1432
> Transceiver device, where one GPIO is used for driving DE/RE signals.
> With rs485 half duplex configuration, DE and RE shorts to each other,

s/shorts/are connected

> and at a time, any node acts as either a driver or a receiver.
> 
> Here,
> DE - Driver enable. If pin is floating, driver is disabled.
> RE - Receiver enable. If pin is floating, receiver buffer is disabled.

Please use DE and /RE to indicate DE is active high and /RE is active 
low.

> xlnx,phy-ctrl-gpios is optional property, because it is not required
> for uart console node.

How about introducing an rs485 generic gpios property instead of xlnx
private one? See also rs485-term-gpios and rs485-rx-during-tx-gpios.

Also note that every kernel driver expects to use RTS for this purpose.
So why not give this driver the option to choose a gpio instead of its
native RTS? And from there on use the rts route?
What if someone wants to use normal (non-rs485) RTS on a GPIO instead
of the native pin?

@Rob Herring
I am curious to know how the rs485 maintainers look at this.

Maarten

