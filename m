Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C2F7A21EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbjIOPIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbjIOPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:08:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2CA30C3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:05:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A668EC433CA;
        Fri, 15 Sep 2023 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694790352;
        bh=HTR0jnRq7Qok2GBZIdglCxy34OjHIAkdXarc7/JXfQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKmJvd6jL5PxazkTqlOPvFB6fgldVOUnGXxbFUr04cSxCmFPH5GpvF++pTgucnCpP
         jl6LYtMflhK/860BedJQYoaBhwn66cSl+4JI0A87Lcv15+OpRf395MJ6dt3Hza0iEe
         I2qekF3WCEAsu4sDY1eyoDRoQaLq0nrA1+37c121d/qiaw72tD5lO839W/hgilSWI1
         3kvGBDYAqvBndv1iH+ummMArHJ0ScNqrpiRLJcMUINwQNZrUS9iMC1zhTjbn8RqAa5
         JYFVkc5wPpn1H1fo+OCOhKPlO2k0bSUR97YEek0AgPw7cJl8Z2VPjlyU8Q2jo/cng0
         A7wkuJcZtkJBA==
Received: (nullmailer pid 3732603 invoked by uid 1000);
        Fri, 15 Sep 2023 15:05:49 -0000
Date:   Fri, 15 Sep 2023 10:05:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wang Chen <unicornxw@gmail.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH 06/12] dt-bindings: timer: Add Sophgo sg2042 clint
Message-ID: <20230915150549.GA3731700-robh@kernel.org>
References: <20230915072415.118100-1-wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915072415.118100-1-wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:24:15PM +0800, Wang Chen wrote:
> From: Inochi Amaoto <inochiama@outlook.com>
> 
> The timer and ipi(mswi) of sg2042 are on different addresses. With the
> same compatible string, this will cause a mismatch when is processed by
> SBI.
> 
> Add two new compatible string formatted like `C9xx-clint-xxx` to identify
> the timer and ipi device separately, and do not allow c900-clint as the
> fallback to avoid conflict.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>

Missing your S-o-b as any patch you send should have yours (last).

> ---
>  .../bindings/timer/sifive,clint.yaml          | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index a0185e15a42f..2a86b80c3f1e 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -39,6 +39,14 @@ properties:
>                - allwinner,sun20i-d1-clint
>                - thead,th1520-clint
>            - const: thead,c900-clint
> +      - items:
> +          - enum:
> +              - sophgo,sg2042-clint-mtimer
> +          - const: thead,c900-clint-mtimer
> +      - items:
> +          - enum:
> +              - sophgo,sg2042-clint-mswi
> +          - const: thead,c900-clint-mswi
>        - items:
>            - const: sifive,clint0
>            - const: riscv,clint0
> @@ -74,4 +82,22 @@ examples:
>                              <&cpu4intc 3>, <&cpu4intc 7>;
>         reg = <0x2000000 0x10000>;
>      };
> +  - |
> +    clint-mtimer@ac010000 {
> +      compatible = "sophgo,sg2042-clint-mtimer", "thead,c900-clint-mtimer";
> +      interrupts-extended = <&cpu1intc 7>,
> +                            <&cpu2intc 7>,
> +                            <&cpu3intc 7>,
> +                            <&cpu4intc 7>;
> +      reg = <0xac010000 0x00007ff8>;
> +    };
> +  - |
> +    clint-mswi@94000000 {
> +      compatible = "sophgo,sg2042-clint-mswi", "thead,c900-clint-mswi";
> +      interrupts-extended = <&cpu1intc 3>,
> +                            <&cpu2intc 3>,
> +                            <&cpu3intc 3>,
> +                            <&cpu4intc 3>;
> +      reg = <0x94000000 0x00004000>;
> +    };
>  ...
> -- 
> 2.25.1
> 
