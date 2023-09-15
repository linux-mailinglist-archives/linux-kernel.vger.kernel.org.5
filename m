Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551937A2994
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbjIOVgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbjIOVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:36:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A497118
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:36:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFB3C433C7;
        Fri, 15 Sep 2023 21:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694813776;
        bh=iDMabq0y3kRzHhWEsY8AP/5IBJ6KDlzbVVI5BVMgzAo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VOSLEon6dfQPHrO8mxAZIb8zffSzjRTUL5StIn2IvLTvpMtC0xrokNcFyb3cW6WlD
         2uH7/aYb7j2RJokaA/AduYNAUJdn4qhr4+W7db4aiXxVGcjFwbZgtmG2ReqKq00Nww
         5LHb1APQfYzeD7UdGuhA/TAf54XWLvD5mlGdAIHAfP4frz3293ta7eYeDGqISNeQJd
         nouloNgBuQgWl0kmxI865uf3SPD4+5k623gVetMOEyb6nIRJC76DRS6JgCgfGIdcD/
         U2P9MAJ6YuL0d/yfQqgbbYHIzaQzln9+RsFrRucl0xBIZi+r7NElEBUDPOZO+sXmq9
         0llED0ZYVh3+g==
Received: (nullmailer pid 149234 invoked by uid 1000);
        Fri, 15 Sep 2023 21:36:15 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230915201520.4179115-1-robh@kernel.org>
References: <20230915201520.4179115-1-robh@kernel.org>
Message-Id: <169481377499.149218.2656119781038291714.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: armltd: Move Arm board syscon's to
 separate schema
Date:   Fri, 15 Sep 2023 16:36:15 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 15:15:05 -0500, Rob Herring wrote:
> The Arm Ltd board bindings are a bit unusual in that they define child
> nodes for various syscon's. The schemas are also incomplete as they lack
> constraints on having additional properties and some properties are
> missing. As the bindings for the different platforms only vary by
> compatibles, combine them into a single schema doc.
> 
> Add the "arm,im-pd1-syscon" compatible which was not documented. Add
> "ranges", "#address-cells", and "#size-cells properties which were
> missing.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/arm,integrator.yaml          | 39 -----------
>  .../devicetree/bindings/arm/arm,realview.yaml | 37 ----------
>  .../bindings/arm/arm,versatile.yaml           | 40 +++--------
>  .../mfd/arm,dev-platforms-syscon.yaml         | 67 +++++++++++++++++++
>  4 files changed, 75 insertions(+), 108 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/register-bit-led.example.dtb: syscon@10000000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,realview-pb1176-syscon', 'syscon'] is too short
	'arm,realview-pb1176-syscon' is not one of ['arm,integrator-ap-syscon', 'arm,integrator-cp-syscon', 'arm,integrator-sp-syscon', 'arm,im-pd1-syscon']
	'arm,realview-pb1176-syscon' is not one of ['arm,realview-eb11mp-revb-syscon', 'arm,realview-eb11mp-revc-syscon']
	'arm,realview-eb-syscon' was expected
	from schema $id: http://devicetree.org/schemas/mfd/arm,dev-platforms-syscon.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230915201520.4179115-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

