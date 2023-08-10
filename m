Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47742777823
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjHJMVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjHJMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12CE54;
        Thu, 10 Aug 2023 05:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C47265B19;
        Thu, 10 Aug 2023 12:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA801C433C8;
        Thu, 10 Aug 2023 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691670105;
        bh=QjWk+VZwTOpt/1lUR5Y5NL5cgwuHtr6O9YZN0vGY9SE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jPV8eqR5uuDzftQ1M1eBABHa+TRGK3rzrNjQYjDFRwwZ/ngIm3mUT8NrXRyYfgWCk
         wUpAVNUkvyW1H315jlDyepbFEnnSCkRSbArihHaucArdwOT00vSuSR3MoZvVLPAs9n
         oAJLPLUA3GfpOZy2gQjcg1fW1HbLNQCVRMmT3maw/BFrTmQgT1Yt7R2H8tMCYoQh2S
         7knZ6ckt5C/+AVLpd0YRXL9ZBzqlBmcIhSAo0aLKCP040xYmwbzPKfxYP38NRtDJjZ
         axvqEFeVYAEChr8HS3dcK6DLC9ecu81v4wnLtLw++w7XXXtHVDiexMdNXhwa/SavMn
         VufhrvZVGKiGg==
Received: (nullmailer pid 172513 invoked by uid 1000);
        Thu, 10 Aug 2023 12:21:43 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        s-anna@ti.com, mathieu.poirier@linaro.org, robh+dt@kernel.org
In-Reply-To: <20230810110545.11644-1-hnagalla@ti.com>
References: <20230810110545.11644-1-hnagalla@ti.com>
Message-Id: <169167010216.172440.15876896854120844037.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: remoteproc: k3-dsp: correct optional sram
 properties for AM62A SoCs
Date:   Thu, 10 Aug 2023 06:21:43 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 06:05:45 -0500, Hari Nagalla wrote:
> The C7xv-dsp on AM62A have 32KB L1 I-cache and a 64KB L1 D-cache. It
> does not have an addressable l1dram . So, remove this optional sram
> property from the bindings to fix device tree build warnings.
> 
> Also set the 'memory-regions' property as optional. This is because
> the remote processors can function without carveout regions.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml     | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230810110545.11644-1-hnagalla@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

