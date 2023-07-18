Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7137B757D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjGRNUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGRNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96185CA;
        Tue, 18 Jul 2023 06:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B8E661574;
        Tue, 18 Jul 2023 13:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863E9C433C7;
        Tue, 18 Jul 2023 13:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686411;
        bh=xqjXQazVO9SEePrXuz6lqpOOkF2BEvOd7Hgdp6WTGYM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iidl0MyWqHeGsGL5GbpqOlqRyZquKu2lzCzZetWmYnob9h4u+YXmfNiB+cn3GrpIq
         kb8n/GeIaWvMM6KlniYZqARLa6QtCzif35qspy5RWproVTBngDkZtAx7yhvYmeZWKp
         4l6OP/GSV6Maf8rfnynPpaRGjssD6rI4AxdpW++geCbqu3AHly9wAwY86CpfQenzF8
         xShbtzHOkPUzhi0GvMmAYwtQmn5QrxT2VATbmCoMTOFePEYBIdw9818q1TV4uAAoGK
         62lwvsy+1LEFGQ2Ik0C2tlz2scrMi1Ksv59pEbgfT4ZG3znyDPzc5IJaujEC+Gpu3Z
         Wg9DHFWZC92gg==
Received: (nullmailer pid 915865 invoked by uid 1000);
        Tue, 18 Jul 2023 13:20:09 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org
In-Reply-To: <20230328-topic-msgram_mpm-v4-1-bae382dc0f92@linaro.org>
References: <20230328-topic-msgram_mpm-v4-0-bae382dc0f92@linaro.org>
 <20230328-topic-msgram_mpm-v4-1-bae382dc0f92@linaro.org>
Message-Id: <168968640959.915849.5129879096888517309.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: mpm: Pass
 MSG RAM slice through phandle
Date:   Tue, 18 Jul 2023 07:20:09 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 14:19:10 +0200, Konrad Dybcio wrote:
> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
> use 'reg' to point to the MPM's slice of Message RAM without cutting into
> an already-defined RPM MSG RAM node used for GLINK and SMEM.
> 
> Document passing the register space as a slice of SRAM through the
> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
> 
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328-topic-msgram_mpm-v4-1-bae382dc0f92@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

