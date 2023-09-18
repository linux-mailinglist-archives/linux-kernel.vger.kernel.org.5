Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB827A5041
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjIRRCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjIRRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:02:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17B97
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AA5C32789;
        Mon, 18 Sep 2023 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047804;
        bh=IfcPayrszXf2AFTeibhLXb3wqIzPd0LKfNZxtwS2mfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZeWQEtVhgSV6zJLG6o5IXSaR68hUpTRf84ck71DeXjPwJBEuf465kAsXO0OIraKx
         D+Tt3aS4URLcc4nNkBLWeX1CAiMu0KQXOJbwdfZKUQk/waKBE0pxRNBc0pqyC3pbgU
         293RWwkRWfptDXMenR/SBAIzOtwJoIdfy9LL5TS4TJ2KvjuZ+HRuCXebsVkM1Rp1h9
         1LVIwQ3833st29eO+gDgGSDuuq0hqadBFGMmNLphanSXOZkVa9nTy/+c9eXuXOJN4N
         1SWxqmx3Deu5Qp/9fdt8xq3hJZqIjTVSzEB1H9/cWTBXzjRFfexR/nanZPPPKBQtII
         l4OVpDdS4hxmg==
Date:   Mon, 18 Sep 2023 15:36:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: armltd: Move Arm board syscon's to
 separate schema
Message-ID: <20230918143639.GP13143@google.com>
References: <20230915201520.4179115-1-robh@kernel.org>
 <169481377499.149218.2656119781038291714.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169481377499.149218.2656119781038291714.robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, Rob Herring wrote:

> 
> On Fri, 15 Sep 2023 15:15:05 -0500, Rob Herring wrote:
> > The Arm Ltd board bindings are a bit unusual in that they define child
> > nodes for various syscon's. The schemas are also incomplete as they lack
> > constraints on having additional properties and some properties are
> > missing. As the bindings for the different platforms only vary by
> > compatibles, combine them into a single schema doc.
> > 
> > Add the "arm,im-pd1-syscon" compatible which was not documented. Add
> > "ranges", "#address-cells", and "#size-cells properties which were
> > missing.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/arm/arm,integrator.yaml          | 39 -----------
> >  .../devicetree/bindings/arm/arm,realview.yaml | 37 ----------
> >  .../bindings/arm/arm,versatile.yaml           | 40 +++--------
> >  .../mfd/arm,dev-platforms-syscon.yaml         | 67 +++++++++++++++++++
> >  4 files changed, 75 insertions(+), 108 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Errr ... I'm a little torn.

Do I trust the maintainer or his bot? :)

> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/register-bit-led.example.dtb: syscon@10000000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,realview-pb1176-syscon', 'syscon'] is too short
> 	'arm,realview-pb1176-syscon' is not one of ['arm,integrator-ap-syscon', 'arm,integrator-cp-syscon', 'arm,integrator-sp-syscon', 'arm,im-pd1-syscon']
> 	'arm,realview-pb1176-syscon' is not one of ['arm,realview-eb11mp-revb-syscon', 'arm,realview-eb11mp-revc-syscon']
> 	'arm,realview-eb-syscon' was expected
> 	from schema $id: http://devicetree.org/schemas/mfd/arm,dev-platforms-syscon.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230915201520.4179115-1-robh@kernel.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

-- 
Lee Jones [李琼斯]
