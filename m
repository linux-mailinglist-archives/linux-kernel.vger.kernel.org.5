Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDD07AA055
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjIUUgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjIUUew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:34:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC557EA1C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879F7C32799;
        Thu, 21 Sep 2023 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695292873;
        bh=l9YKq4Mo9HZomeyWWq8kJ2jlUSxpMR2JEf+l+sajQFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1Bkwrc82xTjn6S9fkfu1yiZ4LfO5ofNvcMcNA8MIGtqd7F7tDfjdpUr1AOtmtnqi
         sFM5ci71SLHRYEDyPlMNnzy5g7ru0idAFa10yaEAHNKLaefUUbzbVuN++DOZQ2RDJm
         ZjSGkQcYMdLfnS/yo/WxfN0TbHiL6s7paewBypixzYOq6u2/tVx/LFQcwQgtjXDrhd
         yGt0IzyAEl93pdCUN9tY+qenaQWhYeIUkeNWjc9iBGrkghsLeTXRqBmmhHLyt+adjG
         cqXsqXx7dDdOhfJ12uftnOzE24YlAVl279KkYhuMIDU5d8w61ySkebprKCKjePIBvY
         lbZX56e425AvQ==
Date:   Thu, 21 Sep 2023 11:41:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 02/11] mfd: mt6358: Add registers for MT6366 specific
 regulators
Message-ID: <20230921104107.GE3449785@google.com>
References: <20230822084520.564937-1-wenst@chromium.org>
 <20230822084520.564937-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230822084520.564937-3-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023, Chen-Yu Tsai wrote:

> The MT6366 PMIC, compared to the MT6358, does away with the VCAM*
> regulators. Two regulators VM18 and VMDDR reuse their register space.
> There's also a VSRAM type regulator VSRAM_CORE thats' split between
> the VCAM* register space and other parts.
> 
> Add register address macros for these MT6366 specific regulators.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  include/linux/mfd/mt6358/registers.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
> index 5ea2590be710..d83e87298ac4 100644
> --- a/include/linux/mfd/mt6358/registers.h
> +++ b/include/linux/mfd/mt6358/registers.h
> @@ -294,4 +294,21 @@
>  #define MT6358_AUD_TOP_INT_CON0               0x2228
>  #define MT6358_AUD_TOP_INT_STATUS0            0x2234
>  
> +/*
> + * MT6366 has no VCAM*, but has other regulators in its place. The names
> + * keep the MT6358 prefix for ease of use in the regulator driver.
> + */
> +#define MT6358_LDO_VSRAM_CON5                 0x1bf8
> +#define MT6358_LDO_VM18_CON0                  MT6358_LDO_VCAMA1_CON0
> +#define MT6358_LDO_VM18_CON1                  MT6358_LDO_VCAMA1_CON1
> +#define MT6358_LDO_VM18_CON2                  MT6358_LDO_VCAMA1_CON2
> +#define MT6358_LDO_VMDDR_CON0                 MT6358_LDO_VCAMA2_CON0
> +#define MT6358_LDO_VMDDR_CON1                 MT6358_LDO_VCAMA2_CON1
> +#define MT6358_LDO_VMDDR_CON2                 MT6358_LDO_VCAMA2_CON2
> +#define MT6358_LDO_VSRAM_CORE_CON0            MT6358_LDO_VCAMD_CON0
> +#define MT6358_LDO_VSRAM_CORE_DBG0            0x1cb6
> +#define MT6358_LDO_VSRAM_CORE_DBG1            0x1cb8
> +#define MT6358_VM18_ANA_CON0                  MT6358_VCAMA1_ANA_CON0
> +#define MT6358_VMDDR_ANA_CON0                 MT6358_VCAMD_ANA_CON0
> +
>  #endif /* __MFD_MT6358_REGISTERS_H__ */
> -- 
> 2.42.0.rc1.204.g551eb34607-goog
> 

-- 
Lee Jones [李琼斯]
