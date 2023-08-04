Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFD7704DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjHDPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjHDPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B7FAC;
        Fri,  4 Aug 2023 08:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCFDF62056;
        Fri,  4 Aug 2023 15:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2B8C433C7;
        Fri,  4 Aug 2023 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691163274;
        bh=7b8Z9uqg0kRIDRb0jE9ESWTCuWtY6TQ0oN6HFgWzH4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmdFy5PGKExcdingq7ge13dtW+D4E8Ec2QaMB5KAnIpPJvK5P3I9YrUixMjjjUTEg
         YjsSk/6AVKHHhH3y97xtI9FtOP7AgHi097QWabcSv3IJ3lyWS5m5rCyqUTuiQ9F765
         zZvVSAbb/0nyMXO8j9FdsKNr9sTZF0yxMtpfuWiGAPka7YfoDDLnAck+aG8BRMj8gy
         829K340hwjY2LDhJ9r4kYIg8L14h8e6Rsmirb7TR568ISpQvE28klCweP0Ej1GFXNW
         TwoEFJb3Pkrz4vuNQCS5NtZ9Uqs+UWxWApOLQYTSgMBesuuVP81Eg7YydE19Z+ZDBT
         wFdeX793kchmw==
Received: (nullmailer pid 1428409 invoked by uid 1000);
        Fri, 04 Aug 2023 15:34:32 -0000
Date:   Fri, 4 Aug 2023 09:34:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt
 optional for more chips
Message-ID: <20230804153432.GA1388331-robh@kernel.org>
References: <20230802141829.522595-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802141829.522595-1-andre.przywara@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 03:18:29PM +0100, Andre Przywara wrote:
> All X-Powers PMICs described by this binding have an IRQ pin, and so
> far (almost) all boards connected this to some NMI pin or GPIO on the SoC
> they are connected to.
> However we start to see boards that omit this connection, and technically
> the IRQ pin is not essential to the basic PMIC operation.
> The existing Linux driver allows skipping an IRQ pin setup for some
> chips already, so update the binding to also make the DT property
> optional for these chips, so that we can actually have DTs describing
> boards with the PMIC interrupt not wired up.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> arguably the IRQ functionality is optional for many more PMICs,
> especially if a board doesn't use GPIOs or a power key.
> So I wonder if the interrupts property should become optional for all?
> After all it's more a board designer's decision to wire up the IRQ pin
> or not, and nothing that's really related to a particular PMIC.

I would say yes. Particularly if it gets rid of a conditional schema.

Rob
