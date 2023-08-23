Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9666E7852FC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjHWIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjHWIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541742139;
        Wed, 23 Aug 2023 01:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76A4617B4;
        Wed, 23 Aug 2023 08:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B18CC433C7;
        Wed, 23 Aug 2023 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692779315;
        bh=kmMIZya07jp0kBo4NYE6vzbjfqHZIMtz0RbugsVw+7Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ukgweX5D9jqhW/B7AYRKE8lmyqmhRN5IlniYNz9xmpmjmraUhHl+ON3I6cQtIeb71
         ZONjoaeNpbm5pLKvZTfZ8CnbyAQrwkmHi6+j1dvLAwGPiXsiybgzkiK3moerGLFoFf
         6qfffl79AS6R+hAm+XYKMI85LrBG0wrZqgpCuUwX1VMeYq47PWRqOTCXudGE2J17c1
         hJMFtM+xZ8HMCgBHb+Zrdx2GVK0fo0bU2l4ptsv52KcWt/kb+mA+2t30rTrESDnUAc
         2xRSSzRPL7zJGc5qgkQaiOIjQXptSDAOmEvzhTHA0GvrcnTsFFiQD8N4L97/rLuEU3
         vbON8RyKsopiA==
Received: (nullmailer pid 1441435 invoked by uid 1000);
        Wed, 23 Aug 2023 08:28:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com,
        festevam@gmail.com, peng.fan@nxp.com, conor+dt@kernel.org,
        V.Sethi@nxp.com, sahil.malhotra@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, clin@suse.com, gaurav.jain@nxp.com,
        linux-imx@nxp.com, robh+dt@kernel.org, ping.bai@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, aisheng.dong@nxp.com,
        xiaoning.wang@nxp.com, devicetree@vger.kernel.org,
        davem@davemloft.net, wei.fang@nxp.com,
        alexander.stein@ew.tq-group.com, pierre.gondois@arm.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20230823073330.1712721-2-pankaj.gupta@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-2-pankaj.gupta@nxp.com>
Message-Id: <169277931130.1441418.1447733552044665055.robh@kernel.org>
Subject: Re: [PATCH v5 01/11] dt-bindings: arm: fsl: add imx-se-fw binding
 doc
Date:   Wed, 23 Aug 2023 03:28:31 -0500
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Aug 2023 13:03:20 +0530, Pankaj Gupta wrote:
> The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
> secure enclave within the SoC boundary to enable features like
> - HSM
> - SHE
> - V2X
> 
> Communicates via message unit with linux kernel. This driver
> is enables communication ensuring well defined message sequence
> protocol between Application Core and enclave's firmware.
> 
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications can communicate on single MU.
> 
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../bindings/firmware/fsl,imx-se-fw.yaml      | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.example.dtb: se-fw: 'mu-id' is a required property
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se-fw.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/firmware/fsl,imx-se-fw.example.dtb: se-fw: 'fsl,mu-id' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/firmware/fsl,imx-se-fw.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230823073330.1712721-2-pankaj.gupta@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

