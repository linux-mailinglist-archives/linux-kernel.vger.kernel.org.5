Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B127FB440
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbjK1Ie3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbjK1IeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:34:20 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC62693;
        Tue, 28 Nov 2023 00:32:48 -0800 (PST)
Received: from p200301077700a9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:a900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r7tWN-006nqK-HF; Tue, 28 Nov 2023 09:32:43 +0100
Date:   Tue, 28 Nov 2023 09:32:41 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kristo@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: ti: Convert interface.txt to
 json-schema
Message-ID: <20231128093241.707a4fa0@aktux>
In-Reply-To: <7a62ed8a-b0e3-4881-90d7-b8f5d38e482e@linaro.org>
References: <20231127202359.145778-1-andreas@kemnade.info>
        <7a62ed8a-b0e3-4881-90d7-b8f5d38e482e@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 09:00:16 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> > +required:
> > +  - compatible
> > +  - clocks
> > +  - '#clock-cells'  
> 
> reg is required. Device cannot take "reg" from parent, DTS does not work
> like this.

Well, apparently they do... and I am just dealing with status quo and not
how it should be.
Look at commit 31fc1c63c2ae4a542e3c7ac572a10a59ece45c24
for the reasoning of not having reg.


well, look at drivers/clk/ti/clk.c
ti_clk_get_reg_addr();

...

       if (of_property_read_u32_index(node, "reg", index, &val)) {
                if (of_property_read_u32_index(node->parent, "reg",
                                               index, &val)) {
                        pr_err("%pOFn or parent must have reg[%d]!\n",
                               node, index);
                        return -EINVAL;
                }
        }


We have two usecases here (status quo in dts usage and code):
If these interface clocks are below a ti,clksel then we are describing 
multiple bits in the same register and therefore every child of ti,clksel
would have the same reg.
If the interface clock is not below a ti,clksel then we have reg.

Regards,
Andreas
