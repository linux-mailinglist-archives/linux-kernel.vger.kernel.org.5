Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22B7B254F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjI1ScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjI1ScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:32:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E419D;
        Thu, 28 Sep 2023 11:32:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522B0C433C7;
        Thu, 28 Sep 2023 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695925934;
        bh=JCe7blWVCnsLe70OwN/f81hGjMC1UJQ2rXeecgnmwzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhJS0frvyLcMcO5ihEp2dgsrmmkIfNmL/P36g3iMjXQowr0ubha3wu2dHXdDPA2rE
         ZA1qZFZNSJEAgaASGYSqtAClTsnzS/fyCF2tUDMwNtnF6iWJt7RlA6mJH0xpj5JkKR
         NVedECdLU98YaFvx8vM2uyNVvWWbWL+cbHtFp48YA1bfcVFLZ+pLu3TMMnzS2r+35d
         mn8SRbolpQC6fVFLO06KMrfGtzTaYpLbwKAah/JXTPY0iYlePaK4RxDYpJHmPUPkNG
         CiSLJFchpQ7TuVTbZkM/4Gd9+vg1w88ztbZR1DYp3nogOwM7dk8VVL/eWiQTvA5e4s
         9zif/GWp/lqfw==
Received: (nullmailer pid 1030969 invoked by uid 1000);
        Thu, 28 Sep 2023 18:32:12 -0000
Date:   Thu, 28 Sep 2023 13:32:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2 1/2] spi: renesas,rzv2m-csi: Add CSI (SPI) target
 related property
Message-ID: <169592593187.1030914.2646161997489930237.robh@kernel.org>
References: <20230927162508.328736-1-fabrizio.castro.jz@renesas.com>
 <20230927162508.328736-2-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927162508.328736-2-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 17:25:07 +0100, Fabrizio Castro wrote:
> The CSI IP found inside the Renesas RZ/V2M SoC can also work
> in SPI target mode.
> When working in target mode, the IP will make use of the SS
> (Slave Selection) pin, with "low" as default active level.
> The active level of SS can be changed to "high" upon setting
> property "spi-cs-high" to true.
> By default, the SS will be used in target mode, unless property
> "renesas,csi-no-ss" is set to true, in which case data will be
> shifted in and out purely based on clock activity, and the
> logic level of the SS pin will be completely ignored.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v1->v2: I have dropped properties renesas,csi-ss and
>         renesas,csi-ss-high. I have added property
> 	renesas,csi-no-ss, and to configure SS as active
> 	high one now needs to use property spi-cs-high.
> 	I have also reworded the changelog to use a more
> 	modern terminology (host and target as opposed to
> 	master and slave).
> 
>  .../devicetree/bindings/spi/renesas,rzv2m-csi.yaml       | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

