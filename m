Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C21B7FD7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjK2NWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjK2NWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:22:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9050810D4;
        Wed, 29 Nov 2023 05:22:48 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 081D36602F2A;
        Wed, 29 Nov 2023 13:22:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264166;
        bh=2GwNXRIpt+9q9FvXsEbR7BizaftPW2Q0mUCzKHvVuxs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X5iBr2YaGQBHXYx+uhtK/eSaiK4+k+UUTVp+Po5fljskLOnTwdBpT3Wt0tFm71D6l
         j7O3mutf2CTJ+XcySQlQyUQqoPdCRrKaV6sS03OGY5clikYvsITTxPItBcNj4M/ovv
         nIFLZz0qmwie614SrWyTscWHK/6yX3JkJDHKU6JyXt8mn8Pt7Ta5OyC8cLu2wac9Lp
         EwkUo/SY1e8mtfVVGe0Xxx2g5rIqymN/lKnLmJ2IsQ5cQSQrB6vbG4ye4AC7m9a/ii
         YsUQ1Uykyoq/JAzCSUl4oClYQTslJAF5Ub4635WJPkvVGaG2gqeNiGQNrPEq80VGkI
         tPvfBRbi+hsSA==
Message-ID: <c9881e63-a52a-4d14-895e-9a14d31004e3@collabora.com>
Date:   Wed, 29 Nov 2023 14:22:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: dts: mediatek: mt8186: Increase CCI
 frequency
Content-Language: en-US
To:     Mark Tseng <chun-jen.tseng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230914121035.17320-1-chun-jen.tseng@mediatek.com>
 <20230914121035.17320-2-chun-jen.tseng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230914121035.17320-2-chun-jen.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/09/23 14:10, Mark Tseng ha scritto:
> The original CCI OPP table's lowest frequency 500 MHz is too low and causes
> system stalls. Increase the frequency range to 1.05 GHz ~ 1.4 GHz and adjust
> the OPPs accordingly.
> 
> Fixes: 32dfbc03fc26 ("arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP table")
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>

You ignored my comment [1] on the v1 of this patch.

Besides, I think that you should at least keep the 500MHz frequency for a
sleep-only/idle OPP to save power.

It would also be helpful to understand why you chose this new frequency range,
so if you can, please put some numbers in the commit description, showing the
stall in terms of requested BW vs actual BW (as I'd imagine that a 2x increase
in CCI frequency means that we need *twice* the bandwidth compared to what we
have for the workloads that are stalling the system).

[1]: https://lore.kernel.org/all/799325f5-29b5-f0c0-16ea-d47c06830ed3@collabora.com/

Regards,
Angelo
