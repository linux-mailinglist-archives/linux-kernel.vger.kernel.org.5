Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF9979308D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbjIEU6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjIEU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:58:03 -0400
X-Greylist: delayed 219 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:57:59 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7CF132;
        Tue,  5 Sep 2023 13:57:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2813C433CC;
        Tue,  5 Sep 2023 20:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693947260;
        bh=SEebsU0bIwz3C7Fask0Blp/8ke6yGxBzEffMu1BzfxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOweapDIV4kvmx+SXiwXd0QH6P0/m29hyXMMX7WwdRbaeGb7fSrecZ6lX0J8WhHwW
         J9XfA9D3ab1EHgux0ExH0VYGzatpfxx5MlQDc1st0gSuWsFYk4LZeDBto8Mo0w1EnC
         acVoMB/XpjVCvbd7L4K6GcbGubh8YXrrdGbgpQTGecIzDNL/gmJQUyk3FlxT7ppwGP
         9Y/yzrz5RtTCuWa/VOoj5oaxklG6TBN64KLQ2k1/Nx8cjuJ7ugzTQQFuQ2euYNYFU0
         QFSV5WbvjCYR/PBqp7ncWX16WV+uL8tWny2nQPXhAk36gDm/Sgncngw71NduzEgRpj
         4FDaqsNA0Ka3g==
Received: (nullmailer pid 3997795 invoked by uid 1000);
        Tue, 05 Sep 2023 20:54:17 -0000
Date:   Tue, 5 Sep 2023 15:54:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2] media: dt-bindings: Merge OV5695 into OV5693 binding
Message-ID: <169394725610.3997729.730832978386837870.robh@kernel.org>
References: <20230817202647.2179609-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817202647.2179609-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Aug 2023 15:26:46 -0500, Rob Herring wrote:
> The OV5695 binding is almost the same as the OV5693 binding. The only
> difference is 'clock-names' is defined for OV5695. However, the lack of
> clock-names is an omission as the Linux OV5693 driver expects the same
> 'xvclk' clock name.
> 
> 'link-frequencies' is required by OV5693, but not OV5695, so make that
> conditional. Really, this shouldn't vary by device, but we're stuck with
> the existing binding use.
> 
> The rockchip-isp1 binding example is missing required properties, so it
> has to be updated as well.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Make link-frequencies conditionally required
> ---
>  .../devicetree/bindings/media/i2c/ov5695.txt  | 41 -------------------
>  .../bindings/media/i2c/ovti,ov5693.yaml       | 31 ++++++++++----
>  .../bindings/media/rockchip-isp1.yaml         |  1 +
>  3 files changed, 25 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5695.txt
> 

Applied, thanks!

