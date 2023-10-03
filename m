Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421A37B6454
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjJCIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjJCIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:36:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2E97;
        Tue,  3 Oct 2023 01:36:17 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 013D16606EE0;
        Tue,  3 Oct 2023 09:36:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696322175;
        bh=SViJ5J9CMGr2sf0Etj/ajk/FEUe0ldzSz/SBtVJR1CY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nyX4WA7uzIcmi5pybEkyZnUwPiTBFzZYejRx/MLOlcfkl6XywcQildvHrg8AQmmkq
         zcxfPSuah6Z6eGD7q6RGIhvHPHxmKtnhZ9R6Z3ypU1EumEY7487FfWFIK7zwmdgW5Q
         FdXEs749Ch24rAKkHbiNOhHSMUP/m7yC+SdOc1orYw3Z12UmXz4aMFdDbYBCRemW98
         Fn9zzW9oNPWyrerZNoW1ZNMtxrmHUKn7MjknT6DgOaSi5vjCZN9/CGymiPIYxkbqft
         T3BdgzWirXH7mwybgThh4Sa13MWRaCRDoPHOaU53eSi1HTCUf/VY5uLAgl3hUu2QWM
         3NcqMHT9t5EiQ==
Message-ID: <23f32b2a-a1fc-da13-e36d-c385abaa9d78@collabora.com>
Date:   Tue, 3 Oct 2023 10:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/2] arm64: dts: mt7986: fix emmc hs400 mode without
 uboot initialization
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Woudstra <ericwouds@gmail.com>, stable@vger.kernel.org
References: <20230629184318.551317-1-linux@fw-web.de>
 <20230629184318.551317-3-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230629184318.551317-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/06/23 20:43, Frank Wunderlich ha scritto:
> From: Eric Woudstra <ericwouds@gmail.com>
> 
> Eric reports errors on emmc with hs400 mode when booting linux on bpi-r3
> without uboot [1]. Booting with uboot does not show this because clocks
> seem to be initialized by uboot.
> 
> Fix this by adding assigned-clocks and assigned-clock-parents like it's
> done in uboot [2].
> 
> [1] https://forum.banana-pi.org/t/bpi-r3-kernel-fails-setting-emmc-clock-to-416m-depends-on-u-boot/15170
> [2] https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/mt7986.dtsi#L287
> 
> Cc: stable@vger.kernel.org
> Fixes: 513b49d19b34 ("arm64: dts: mt7986: add mmc related device nodes")
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


