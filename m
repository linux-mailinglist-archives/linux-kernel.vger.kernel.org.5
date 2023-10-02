Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1C7B5844
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbjJBQSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbjJBQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:18:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B593
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:18:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5FDC433C7;
        Mon,  2 Oct 2023 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696263486;
        bh=nJBI4YMCnC7wDFeIOxGfChOrML2/pMEaV/ZwChIjZ0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hd6+n9d3cL6sS4epqQxPT3In6FHseHl4Tr/15EvSnkLFzUZeaNDKmpABlDYnhTfoY
         bSOArQC43S/RpmLBICYs613yn5gEdrMek+nX4s9dryr2UMMBBva9Cy58Zg2qD8aks2
         yEVoUMy/bsQibanK2WFHJYEo4ut7fGK03EW7PgC9LweLAngCNQrZJ6syu4GQvIsaCX
         xrw8pQkGbPGK38Td2Yj4i7VgfQWXgnsYZCBFGx+Gy+apMSECwWQCdyJdOzHg/9CaIc
         PctG23Wy+u2aZL1tFbPlaPFBhI3pKbbWU/kpQj5rnpZrBe7H1zb3CcT3IIzU50xfmi
         0RhgLeNFGaqBQ==
Received: (nullmailer pid 1886811 invoked by uid 1000);
        Mon, 02 Oct 2023 16:18:03 -0000
Date:   Mon, 2 Oct 2023 11:18:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 05/12] regulator: dt-bindings: mt6358: Add MT6366 PMIC
Message-ID: <169626348288.1886756.17093504896321888644.robh@kernel.org>
References: <20230928085537.3246669-1-wenst@chromium.org>
 <20230928085537.3246669-6-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928085537.3246669-6-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Sep 2023 16:55:28 +0800, Chen-Yu Tsai wrote:
> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> 
> The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
> to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators and
> 29 LDO regulators, not counting ones that feed internally and basically
> have no controls. The regulators are named after their intended usage
> for the SoC and system design, thus not named generically as ldoX or
> dcdcX, but as vcn33 or vgpu.
> 
> The differences compared to the MT6358 are minimal:
> - Regulators removed: VCAMA1, VCAMA2, VCAMD, VCAMIO, VLDO28
> - Regulators added: VM18, VMDDR, VSRAM_CORE
> 
> Both PMIC models contain a chip ID register at the same address that
> can be used to differentiate the actual model. Thus, even though the
> MT6366 is not fully backward compatible with the MT6358, it still falls
> back on the MT6358 compatible string. It is up to the implementation
> to use the chip ID register as a probing mechanism.
> 
> Update the MT6358 regulator binding and add entries for all the MT6366's
> regulators and their supplies. The regulator node names follow a cleaned
> up style without type prefixes and with underscores replaced with hyphens.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> [wens@chromium.org: major rework and added commit message]
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v3:
> - Expanded commit message to mention why a fallback compatible is used
> - Adapted to ldo_vxo22 and ldo_vusb movement to properties in previous
>   patch
> - Split example into two, one for each variant
> - Renamed regulator node in examples to just "regulator"
> 
> Changes since v2:
> - Merged all the propertyPatterns together; the if-then sections now
>   only block out invalid properties
> 
> Changes since v1:
> - Replaced underscores in supply names to hyphens
> - Merged with MT6358 regulator binding
> - Added MT6358 fallback compatible to MT6366 regulator
> 
> Changes since Zhiyong's last version (v4) [1]:
> - simplified regulator names
> - added descriptions to regulators
> - removed bogus regulators (*_sshub)
> - merged vcn33-wifi and vcn33-bt as vcn33
> - added missing regulators (vm18, vmddr, vsram-core)
> - cut down examples to a handful of cases and made them complete
> - expanded commit message a lot
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/
> 
>  .../regulator/mediatek,mt6358-regulator.yaml  | 149 ++++++++++++++----
>  1 file changed, 120 insertions(+), 29 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

