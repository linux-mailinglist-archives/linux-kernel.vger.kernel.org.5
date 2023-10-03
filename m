Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8E7B656E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbjJCJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbjJCJYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:24:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5858090;
        Tue,  3 Oct 2023 02:24:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 407F16607181;
        Tue,  3 Oct 2023 10:24:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696325081;
        bh=fglFS8/SJTxax6nKCOPR+u+mqyIQq4V/6eD+bn6enag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LscWssJW+MqsWczsrw3nIOSf0rtr6/nbmR7RS2yUbx4aYtZh7s4RCjGNaV3QD6wRu
         QTaHmxzxgPNanqdk82VRO4ntuWMg/MJTewnabeFJibpNUhYJ8mxZZrhqZ61k1tngh5
         M8snckqZak/z4MzsCIfhP+LIFCMaZ9xyx6L1wzxnjameAwUwmvpEwcfRR8mIxakkNZ
         uLj9ZU6lp/D5zdfjSG64mY+kpUMITVqJ275VLFeoWvjsc8XnDAg3aeC97JHefwbgBz
         176JTJWl1BYwnXq/ssMSysUxoSm/zqSF+ORF564joj8juOqkv0Er33JYejrco6J3Az
         GjqvtvLS4QchA==
Message-ID: <1c639f51-a444-c8c8-8585-2e413243c3a6@collabora.com>
Date:   Tue, 3 Oct 2023 11:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Set DSU PMU status to fail
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230720200753.322133-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230720200753.322133-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/23 22:07, Nícolas F. R. A. Prado ha scritto:
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
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


