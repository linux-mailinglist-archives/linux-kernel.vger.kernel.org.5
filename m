Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6A75C216
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGUIyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGUIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:54:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB93A30DB;
        Fri, 21 Jul 2023 01:53:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36FDC6607099;
        Fri, 21 Jul 2023 09:53:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689929629;
        bh=kXBYkev3Jnirv4Zq14dgjAYSbNq7XOepox4imR+0kTE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g5iDMZ26TarTBRiQfhOK6brLdoKOl8wXjZ+BeOUnk7ZmPUwmUmZ8oHLICtRkgzR2x
         uT5rXgJWf9H8lw1deBI5xU5zFiaZKslT3LrQp0IjXRVKpflCAQW9YzaAax9HZnr/Nh
         YaAnC5O8zZQXRHa4W3rmvKt0anBsdhIJPYw0CygiaF0+X/Hj01J5FdbZUrYmWe1Plv
         Ca9+nU7wBLdw8D3ModfsTi33sGefvAEuSFc/L3IezoghtMaimZD6mKEdwYTrBUSL4N
         lyCv+ikqTQNsz2zPG8fJc58f14J7JQXttsxc4TlUARKbcd5nCUbhw2v88iFz4Q/EEs
         MZbLId5jAEIHQ==
Message-ID: <24952eda-9821-4634-aaa4-e636119f99fd@collabora.com>
Date:   Fri, 21 Jul 2023 10:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v2 4/7] regulator: mt6358: Fail probe on unknown
 chip ID
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230721082903.2038975-1-wenst@chromium.org>
 <20230721082903.2038975-5-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230721082903.2038975-5-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/07/23 10:28, Chen-Yu Tsai ha scritto:
> The MT6358 and MT6366 PMICs, and likely many others from MediaTek, have
> a chip ID register, making the chip semi-discoverable.
> 
> The driver currently supports two PMICs and expects to be probed on one
> or the other. It does not account for incorrect mfd driver entries or
> device trees. While these should not happen, if they do, it could be
> catastrophic for the device. The driver should be sure the hardware is
> what it expects.
> 
> Make the driver fail to probe if the chip ID presented is not a known
> one.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Fixes: f0e3c6261af1 ("regulator: mt6366: Add support for MT6366 regulator")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


