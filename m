Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A97B5843
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbjJBQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbjJBQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:15:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06E9E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:15:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FBCC433C8;
        Mon,  2 Oct 2023 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696263333;
        bh=AhZPFxKw6JIAmar3BTlp6KAFMwqOxLDxCPhW4rygFww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrbkQazhVsQR0aAe2Xv3ul3hzgSf1cGt0FJwjroCzNjjAz1l1znBYWl1XOJo96pN0
         idDJth42GnDGl/dVKBqf+DP0S0Oh3LjO7pTXHivmWOQmWf+ZxuP60GfIBJawDF8AF3
         K6wxLOnFNcSmnQNwR1seQdWlkDmZXghcgF+PlcU5pxI70NrTTZ4qkbspQXz0Qk1+vy
         Al07ycPBfUFS6Nkb5Ixzkp2CmhiXWKG1c1XAqzgALMjZKpaPypirr3C00axU1yENrm
         qmYBDJoUcK6Ab2TARJQt4NfGGHc0dS42ZcI3dnsK8YM6xRayV81iOiCjPzYBBX94QG
         +AZpN55EcW4ow==
Received: (nullmailer pid 1883864 invoked by uid 1000);
        Mon, 02 Oct 2023 16:15:31 -0000
Date:   Mon, 2 Oct 2023 11:15:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/12] regulator: dt-bindings: mt6358: Add
 regulator-allowed-modes property
Message-ID: <169626333046.1883804.1497786674123702405.robh@kernel.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
 <20230928085537.3246669-4-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928085537.3246669-4-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Sep 2023 16:55:26 +0800, Chen-Yu Tsai wrote:
> The MT6358 PMIC allows changing operating modes for the buck regulators,
> but not the LDOs. Existing device trees and the Linux implementation
> already utilize this through the standard regulator-allowed-modes
> property.
> 
> The values currently used in existing device trees are simply raw
> numbers. The values in the Linux driver are matching numbers defined
> with macros denoting the two supported modes. Turns out these two
> modes are common across parts of the larger MT63xx PMIC family. The
> MT6397 regulator binding already has macros for the two modes, with
> matching numbers.
> 
> Codify the supported values for regulator-allowed-modes for the MT6358
> in the device tree binding: 0 and 1 are supported for buck regulators,
> and the property should not be present for LDO regulators. Users should
> use the dt-bindings/regulator/mediatek,mt6397-regulator.h header for
> the macros, instead of using raw numbers.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v3:
> - adapt to ldo_vxo22 and ldo_vusb movement to properties
> 
> Changes since v2:
> - new patch
> 
>  .../regulator/mediatek,mt6358-regulator.yaml  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

