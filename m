Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED47F9B82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjK0ITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjK0IS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:18:57 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65202184
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:19:03 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9947f488fso22560621fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701073141; x=1701677941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2uKGv73n9zPoCLwWnUxIRJtwy7BLdOeRGasRuwlLaI=;
        b=uE4A3wjMo4CkVq103Rlpv7zNjK9hI+Pn3XTN6sxwxdVjZywhlMvFiJB6zCqt1ywf5L
         opZqbGY1r7GTU3UlNPymHDtyW1lBOy7DS+cw+caJFlaOtTDKLY2LKLhm5Fr523d/hkHV
         eiVhgaPEkbKFuUHjR+dEI001nmcAIx7gUshpKnK3RQpnczryRhcDGzVX6iaKhYy9yLk+
         kwQAEopheE9qHtDZE3HmtwnC0XpQnl7puWz9hLQDQw6gUQ0nYAVdlGKcyDjZZZK6SqDU
         i3roQYHBDUum7kjiJZhUlcEJdmp6OCaMTZ6+Z5E6aZwe2FX8iBiYXVIVr7eiDp4OUGOU
         qv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073141; x=1701677941;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2uKGv73n9zPoCLwWnUxIRJtwy7BLdOeRGasRuwlLaI=;
        b=D52doXxyI4jWYXlnQYrlPK3bjkUQH4zpRThALKlC3NjuGUiLdI9yhuFn1voDYY8dTt
         o/3eKiSDifOYrrrHaUICKI1o8hpKpWMnjt3uDrM1qGGIEdp4pJbMxvmSZXt738Is5YF2
         PhZQBVoehaVQi1gopkPP21epUFJFu57VsrrKYnFGv1ISkEELos7c4cOEhC1vc539ei8u
         /RA2sUwO/pdLyub7ijOlusi4juBhgqHpsDRo/fpm9udzis7fwx6T6zkvsisWKwbQyvdY
         SLhzkxeSRjpCFj+EQOGVdq7VduB5LqbFae3sUAuY+jQ//ckfms93/ryM33r0VYplOHug
         Z3Pg==
X-Gm-Message-State: AOJu0Yz/B1+KHS9xyF74JotGrhvTN1CBppQ+5d3YnAuyBi8XIkZR0JmH
        +OJLsIuKVtJ1tUZn4NKE2p0Dpw==
X-Google-Smtp-Source: AGHT+IF1gTyhMEF3F7i1LRqkM6Hdwo5CzhiNmHsO3on2+Ni4UBjAsOeQokHh2iH61R/I1gEzM9biJw==
X-Received: by 2002:a2e:b5d3:0:b0:2c9:a05c:547d with SMTP id g19-20020a2eb5d3000000b002c9a05c547dmr1718714ljn.34.1701073141585;
        Mon, 27 Nov 2023 00:19:01 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm13516568wmb.14.2023.11.27.00.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:19:01 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Lukas F. Hartmann" <lukas@mntre.com>
In-Reply-To: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
Subject: Re: (subset) [PATCH v9 00/12] drm/meson: add support for MIPI DSI
 Display
Message-Id: <170107314034.1083800.1585049254380328915.b4-ty@linaro.org>
Date:   Mon, 27 Nov 2023 09:19:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 Nov 2023 09:41:11 +0100, Neil Armstrong wrote:
> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
> glue on the same Amlogic SoCs.
> 
> This is a follow-up of v5  now the DRM patches are applied, the clk & DT changes
> remains for a full DSI support on G12A & SM1 platforms.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)

[02/12] dt-bindings: soc: amlogic,meson-gx-hhi-sysctrl: add example covering meson-axg-hhi-sysctrl
        https://git.kernel.org/amlogic/c/beb9c30ba4188e481991d91124c554f61a7ec121

These changes has been applied on the intermediate git tree [1].

The v6.8/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

