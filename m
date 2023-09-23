Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BCD7ABD43
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 04:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjIWCGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 22:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIWCGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 22:06:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57961C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 19:05:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A12C433C7;
        Sat, 23 Sep 2023 02:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695434754;
        bh=p6evCoFssqFuGsisKlNTxes4uUL1dao28ODNmXXWwJg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KqvuwPYIlU0o0FKqDw41Ed2qxZ8lElH59XB+Vi/GW5MuBI5qmAzwM+zZKsqV1gthF
         8f7rG1IP5BNrS6RBjH5ki9Gbas0sUFXNCldkOdRZz6nVIxf6TQ76WLxB48UVL7Avwm
         tlayms+kBx/vf1bNm5XdjOarL+TYkjrV5jQCVdPlv9DgOKiDTsdm6S9rK0Oo2QSMPl
         d+Nc5MBcszqecggWXWG/4UXJe9u5+wE475gSzr7ZekkkQ2Bkw+aJDQJE6gZGBTw/en
         7w87A+xEbuO+FA82VJztyVBH07WzXuYb8Y0Tzbe34K4BOkGISOBYsjUw7i724fyFJO
         FJ6d6gES9PhXA==
Received: (nullmailer pid 118963 invoked by uid 1000);
        Sat, 23 Sep 2023 02:05:52 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dhruva Gole <d-gole@ti.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org
In-Reply-To: <20230922193417.1697379-1-sjg@chromium.org>
References: <20230922193417.1697379-1-sjg@chromium.org>
Message-Id: <169543475215.118855.13530210565205347052.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mtd: Add a schema for binman
Date:   Fri, 22 Sep 2023 21:05:52 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 13:34:15 -0600, Simon Glass wrote:
> Binman[1] is a tool for creating firmware images. It allows you to
> combine various binaries and place them in an output file.
> 
> Binman uses a DT schema to describe an image, in enough detail that
> it can be automatically built from component parts, disassembled,
> replaced, listed, etc.
> 
> Images are typically stored in flash, which is why this binding is
> targeted at mtd. Previous discussion is at [2] [3].
> 
> This is only a starting point, an attempt to align on the best way to
> add this to the schema.
> 
> [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
> [3] https://www.spinics.net/lists/devicetree/msg626149.html
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Use "binman" for compatible instead of "u-boot,binman"
> - Significantly rework the patch
> - Use make dt_binding_check DT_SCHEMA_FILES=Documentation/../partitions
> 
>  .../bindings/mtd/partitions/binman.yaml       | 59 ++++++++++++++++++
>  .../mtd/partitions/binman/atf-bl31.yaml       | 43 +++++++++++++
>  .../bindings/mtd/partitions/binman/entry.yaml | 62 +++++++++++++++++++
>  .../mtd/partitions/binman/u-boot.yaml         | 43 +++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  MAINTAINERS                                   |  5 ++
>  6 files changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/atf-bl31.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/u-boot.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/partitions/binman/atf-bl31.example.dtb: /example-0/binman/partition@0: failed to match any schema with compatible: ['binman,entry']
Documentation/devicetree/bindings/mtd/partitions/binman/entry.example.dtb: /example-0/binman/partition@0: failed to match any schema with compatible: ['binman,entry']
Documentation/devicetree/bindings/mtd/partitions/binman/entry.example.dtb: /example-0/binman/partition@100000: failed to match any schema with compatible: ['binman,entry']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230922193417.1697379-1-sjg@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

