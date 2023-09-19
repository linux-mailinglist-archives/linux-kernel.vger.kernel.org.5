Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFE07A61F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjISMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISMCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:02:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612FA9;
        Tue, 19 Sep 2023 05:02:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F20B66003AF;
        Tue, 19 Sep 2023 13:02:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695124967;
        bh=WqbMfAO//Ooj16UaG3MjBLlfRdTE5RHHSY9kCbs4IbU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dletyGywwkOCWcnz/FvfvmrEVZFb5ZT8J17MakCWaK93yTFNc+HJtCiMeiQ3Z0uUM
         VDNNvcdcmbLGiYyFTDnkQRv+KO8TauLXAks7f+/CySkg/XWVXiB/P93U1XeuHprr36
         hw6Ct0Ua0lJuMCZ+2MXGQ933g9ZDGDr57s4J+znkms65vGPLuY8zWTEt9KlyuuLhG+
         ohWJXgqV6ejRZzYNaJwbNHf/6ANbjgOxmNMOZVgMsqY2YhP/+DiOgrZEKU91NFSLEy
         0lOyrnH7Pw5hVL4WVaMDimemLDm1jn1MokHdQqV5YcC8qUMdaEMxFZGYyyT6PBs41V
         8M7Ur0osWQBag==
Message-ID: <c79766f1-5830-556e-45d5-b45f867bda1c@collabora.com>
Date:   Tue, 19 Sep 2023 14:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] thermal/drivers/mediatek: Fix probe for THERMAL_V2
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>
References: <20230918100706.1229239-1-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230918100706.1229239-1-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/09/23 12:07, Markus Schneider-Pargmann ha scritto:
> Fix the probe function to call mtk_thermal_release_periodic_ts for
> everything != MTK_THERMAL_V1. This was accidentally changed from V1
> to V2 in the original patch.
> 
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Closes: https://lore.kernel.org/lkml/B0B3775B-B8D1-4284-814F-4F41EC22F532@public-files.de/
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Closes: https://lore.kernel.org/lkml/07a569b9-e691-64ea-dd65-3b49842af33d@linaro.org/
> Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

I have no idea how it happened that I didn't notice that mistake.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


