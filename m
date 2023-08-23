Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50DD785791
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjHWMJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjHWMJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:09:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B910DA;
        Wed, 23 Aug 2023 05:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4BC624E4;
        Wed, 23 Aug 2023 12:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD99C433C7;
        Wed, 23 Aug 2023 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692792543;
        bh=rrDhfVh1TZzaIbx/miiwAqv8i12Tux6yDTDciKwgPs4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WNM3IPG+OUH3McWxKkTU+SJDTCDLz8KwfnmMRfT5QA7Aq8bsr+3rSS9C5/+ZEqSeA
         8rojZSvVst3UNQvYF8FpBU4VkiXS2XJMpQ99s9PliPeP83K1TfSaJKJe3q0u8wr2Er
         zCtJ2El2H4U5VqSWOvwdBP7EwhXYRsoQFmDEfRNKR95faJDHqKEzROIw0Yib8TodfG
         asN7BvUkIANJD1qrO46qt0NzgdtgCkO27GnXXiaBqzUCWxziz+qSemxHZtroWYIe14
         +DzaPk+H5/K0lti/sb1tNIpdppX1MUo4wXOiWv2MmtOEV6jJadD1NfdrjsIy9azPjE
         bjZQvE98Y99IA==
Received: (nullmailer pid 1995555 invoked by uid 1000);
        Wed, 23 Aug 2023 12:09:00 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v5-1-6e06278896b5@linaro.org>
References: <20230328-topic-msgram_mpm-v5-0-6e06278896b5@linaro.org>
 <20230328-topic-msgram_mpm-v5-1-6e06278896b5@linaro.org>
Message-Id: <169279254054.1995538.6862348951321247068.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: interrupt-controller: mpm: Pass
 MSG RAM slice through phandle
Date:   Wed, 23 Aug 2023 07:09:00 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2023 13:15:31 +0200, Konrad Dybcio wrote:
> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
> use 'reg' to point to the MPM's slice of Message RAM without cutting into
> an already-defined RPM MSG RAM node used for GLINK and SMEM.
> 
> Document passing the register space as a slice of SRAM through the
> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interrupt-controller/qcom,mpm.yaml    | 52 +++++++++++++++-------
>  1 file changed, 35 insertions(+), 17 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dtb: /example-0/remoteproc-rpm: failed to match any schema with compatible: ['qcom,msm8998-rpm-proc', 'qcom,rpm-proc']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dtb: glink-edge: 'label' is a required property
	from schema $id: http://devicetree.org/schemas/remoteproc/qcom,glink-edge.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dtb: glink-edge: 'qcom,remote-pid' is a required property
	from schema $id: http://devicetree.org/schemas/remoteproc/qcom,glink-edge.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dtb: glink-edge: 'compatible', 'qcom,rpm-msg-ram' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/remoteproc/qcom,glink-edge.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328-topic-msgram_mpm-v5-1-6e06278896b5@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

