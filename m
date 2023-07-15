Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA137549CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGOP3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGOP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76981211E;
        Sat, 15 Jul 2023 08:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1052660BBB;
        Sat, 15 Jul 2023 15:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60705C433C8;
        Sat, 15 Jul 2023 15:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689434976;
        bh=k7L1ayBZKtybI81Zfysv/ALpJ/nEdqU+t8HPP2Jxe60=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q7MKda5TDasz3ZKejGTgdnVWeNYlrxq/APC2gXCV+5GY5TbAT0SzDea2PCeY93yEy
         QVX25cOTph80CdVwSvQL10jwWhMX9WN2vKOtWiRGnh+tM784dYK2vy2SFzCwtpkhzl
         2FZKKbNt/JRLYXkLIXGvBXh2hGHPvvo5TLZYVMIVeRPB6zwMWz4HE+Nzkfbpt6Cg8x
         G3yxhEvpE0f2I1Q4TQ025SuCVeUWyGCXHYnbifxrndwY3OZvjr22vGbM2XkyKgyCvE
         xiVWFu9jL3yTYrs2nE+qvyqyWC3KjkPNYjKxubWv1jBF04ccUc5buf2evZEaabbjmj
         SJoR0l+Qq2h0A==
Received: (nullmailer pid 2194917 invoked by uid 1000);
        Sat, 15 Jul 2023 15:29:34 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v3-1-2c72f27b4706@linaro.org>
References: <20230328-topic-msgram_mpm-v3-0-2c72f27b4706@linaro.org>
 <20230328-topic-msgram_mpm-v3-1-2c72f27b4706@linaro.org>
Message-Id: <168943497429.2194881.13400823480172756565.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: mpm: Pass
 MSG RAM slice through phandle
Date:   Sat, 15 Jul 2023 09:29:34 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Jul 2023 16:37:11 +0200, Konrad Dybcio wrote:
> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
> use 'reg' to point to the MPM's slice of Message RAM without cutting into
> an already-defined RPM MSG RAM node used for GLINK and SMEM.
> 
> Document passing the register space as a slice of SRAM through the
> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interrupt-controller/qcom,mpm.yaml    | 44 +++++++++++++---------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dtb: /example-0/remoteproc-rpm: failed to match any schema with compatible: ['qcom,msm8998-rpm-proc', 'qcom,rpm-proc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230328-topic-msgram_mpm-v3-1-2c72f27b4706@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

