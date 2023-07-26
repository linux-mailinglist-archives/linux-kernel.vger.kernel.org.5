Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B31763C95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGZQgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjGZQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465FD270F;
        Wed, 26 Jul 2023 09:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA61361BC8;
        Wed, 26 Jul 2023 16:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EB3C433C7;
        Wed, 26 Jul 2023 16:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690389362;
        bh=qQ6AVUJWJdjNPQfxYL0RhqeO/1otPLb61HJR4SjS+tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dULJZnE8SoF5mGG0BRHcdIyw4kxnx3gexg3+oRAC9QPnj1V9UTSo+AcCB6Ms/cJwK
         UX/X5r4uK2lKOmt5r9c6kHVpZ2D84AuUQPJ2Wz6LIQ7Efz54i4NAzD4QNmQRxeEhkm
         IOJ6MDZGCKppuQvcbhacObS3Ev/upuE8jVZuOS1GcuRx2giEicDggw5w/kiRH/sabZ
         t9SWM4qdS5iBSn0qqS1NmxwvHXrJAVv6tNIpk0vu6JgVAb/Ei8v2U9q7/1YZUyMr5f
         CCM3LohTlxEkPaU1JiOWjtwtZUS+9Qf513SejJyJtHeooiq7MNFIHbuTDhEt55ELHq
         VzCczMeENPQDw==
Received: (nullmailer pid 1557052 invoked by uid 1000);
        Wed, 26 Jul 2023 16:36:00 -0000
Date:   Wed, 26 Jul 2023 10:36:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: u-boot,env: Add support for
 u-boot,env-size
Message-ID: <20230726163600.GA1549714-robh@kernel.org>
References: <20230724082632.21133-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724082632.21133-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:26:30AM +0200, Christian Marangi wrote:
> Add support for u-boot,env-size new property.
> 
> Permit to declare a custom size of the U-Boot env that differs than the
> partition size where the U-Boot env is located.
> 
> U-Boot env is validated by calculating the CRC32 on the entire env
> and in some specific case, the env size might differ from the partition
> size resulting in wrong CRC32 calculation than the expected one saved at
> the start of the partition.

Why can't you just change the partition size? There is no size really 
because it is just defined in DT.
> 
> This happens when U-Boot is compiled by hardcoding a specific env size
> but the env is actually placed in a bigger partition, resulting in needing
> to provide a custom value.

If u-boot is compiled that way, then shouldn't it have that size 
contained within it? What happens when the DT doesn't match?

> 
> Declaring this property, this value will be used for NVMEM size instead of
> the mtd partition.
> 
> Add also an example to make it clear the scenario of mismatched
> partition size and actual U-Boot env.

If we do have this, then perhaps there is a generic need for a data 
size property.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> index 36d97fb87865..3970725a2c57 100644
> --- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> @@ -44,6 +44,24 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  u-boot,env-size:
> +    description: |
> +      Permit to declare a custom size of the U-Boot env that differs than the
> +      partition size where the U-Boot env is located.
> +
> +      U-Boot env is validated by calculating the CRC32 on the entire env
> +      and in some specific case, the env size might differ from the partition
> +      size resulting in wrong CRC32 calculation than the expected one saved at
> +      the start of the partition.
> +
> +      This happens when U-Boot is compiled by hardcoding a specific env size
> +      but the env is actually placed in a bigger partition, resulting in needing
> +      to provide a custom value.
> +
> +      Declaring this property, this value will be used for NVMEM size instead of
> +      the mtd partition.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
>    bootcmd:
>      type: object
>      description: Command to use for automatic booting
> @@ -99,3 +117,32 @@ examples:
>              };
>          };
>      };
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            reg = <0x0 0xc80000>;
> +            label = "qcadata";
> +            read-only;
> +        };
> +
> +        partition@c80000 {
> +            label = "APPSBL";
> +            reg = <0xc80000 0x500000>;
> +            read-only;
> +        };
> +
> +        partition@1180000 {
> +            compatible = "u-boot,env";
> +            reg = <0x1180000 0x80000>;
> +
> +            u-boot,env-size = <0x40000>;
> +
> +            mac1: ethaddr {
> +                #nvmem-cell-cells = <1>;
> +            };
> +        };
> +    };
> -- 
> 2.40.1
> 
