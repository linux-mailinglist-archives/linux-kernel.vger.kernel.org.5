Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101C277837C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjHJWMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjHJWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:12:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC82713;
        Thu, 10 Aug 2023 15:12:21 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2329D6607234;
        Thu, 10 Aug 2023 23:12:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691705540;
        bh=Cjoy1Kbx7vl3aNLQHQODSus0OKCsku5K0lb8+lPAifw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anIuDNjv1Qfh8KjqWhnIaiSGJECftLfLAvKsOBzHvwM9TAWBDKk/3bSlkyLSd7f2i
         rYt14YwiwykTWFYcPwR9/RcOJKEf9OYHLxFi70cCDnwf2VJu2SN1a/0QHl16m1nTue
         QC4QoJejcfBjpaZVJ5E5W6SuE6T5lwz31SVOOwPpu1aNP2Q2FCCR233jNKhrgIEQhq
         83NktOkjTFDYO25yhTXOSyD2UL0Tmd2Q07pWFKEkNDGds94MBSSBu+hTz9aePVAqAz
         Bf9hD8y7yU7Kgc/geWObBPHah+Rn9tovRJ/PnqJQ4Xh+rLAsF7sTIHs2oXjeOswuyE
         Y8nC4GDeJP6/w==
Date:   Thu, 10 Aug 2023 18:12:14 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Set DSU PMU status to fail
Message-ID: <e053e9fe-5d88-44f1-bb24-280113665185@notapiano>
References: <20230720200753.322133-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720200753.322133-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:07:51PM -0400, Nícolas F. R. A. Prado wrote:
> The DSU PMU allows monitoring performance events in the DSU cluster,
> which is done by configuring and reading back values from the DSU PMU
> system registers. However, for write-access to be allowed by ELs lower
> than EL3, the EL3 firmware needs to update the setting on the ACTLR3_EL3
> register, as it is disallowed by default.
> 
> That configuration is not done on the firmware used by the MT8195 SoC,
> as a consequence, booting a MT8195-based machine like
> mt8195-cherry-tomato-r2 with CONFIG_ARM_DSU_PMU enabled hangs the kernel
> just as it writes to the CLUSTERPMOVSCLR_EL1 register, since the
> instruction faults to EL3, and BL31 apparently just re-runs the
> instruction over and over.
> 
> Mark the DSU PMU node in the Devicetree with status "fail", as the
> machine doesn't have a suitable firmware to make use of it from the
> kernel, and allowing its driver to probe would hang the kernel.
> 
> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Hi Matthias,

gentle ping on this patch, as it's not possible to boot MT8195 Chromebooks with
the mainline defconfig without this fix.

Thanks,
Nícolas
