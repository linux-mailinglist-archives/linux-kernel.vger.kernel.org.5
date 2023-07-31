Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E059576923B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGaJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjGaJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:47:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D71998
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso11199905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796825; x=1691401625;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAl2fAmeLK7v8jeOjXAM9Im6T80pzlX2872jJ9ooxQg=;
        b=ddol+HfsOqAeoaUJW+6b1004uCV99ldu9gXwPlEqLzDDDzBr0jgA6y05HpRIjmQA84
         ypR7Tf1zF7E+8fTjXwucCOYQZkybryy2dHC18aZDgfiy06ygo1nK59QDGHTdttTvqkMQ
         rx64WsTpsFRy5SFlX2O78Dmi+KSCwKsjXy6jEaNUW0yh3257sORVWELFezeW0C5zKeOa
         CLR8YQDYMbkfYQ2J12d0BhhS2E0uO2168SR2TP0QBq8dS/yAma+YaWj1+Mt0mBo6qimq
         kDtLRheC+kTguXNFoypuG47A69tI7mK2hiVrtnJ0OG0+rRVoNshYtIwyqXp3UZB9OGOh
         UffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796825; x=1691401625;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAl2fAmeLK7v8jeOjXAM9Im6T80pzlX2872jJ9ooxQg=;
        b=C6spXEU37EldrV3KgPvPHcefHEbkzdbdYucqU/7HlLIe+qpA7gbzFvx84ZMhh85wgD
         oqxdPOs3uMk56+grfo0YpPx1veiuyGJVje50GrAvtOByXUM6E4ePwjjvNGCuvuMej6oh
         vzbG72ukz9/Io50+raoDf8k5cgZtZb8EkoPpXBbJOBPgglStHvnCJu8X6fwL38VI6+Bn
         QN/7A672ZFYxsD932UYHIxP6iDeeIgK+pb0ceCxwM6uAlcoV/5Io4M/bJThc0Zu4tt50
         vu4mwqpXKWdfDQX8g2yfkxE8p7j/aeQwTbHQCWcQ9xQsvsXgpHycMOuEowvQJxZEvNxp
         uORA==
X-Gm-Message-State: ABy/qLaiHOSI1E9LD9f8wq87L8BqwqP+zudnnTOuirwvBIUSJ8IgoGIj
        UbmBJygyegc9DYpPCDBbV8Zkzg==
X-Google-Smtp-Source: APBJJlHg2vtNWlg6yP5U99HmeGF+jcWS21EQ/z4CZR4xWJgc03pK6mCEBXO+hfddwRa9kvtHMGMRRg==
X-Received: by 2002:a1c:ed02:0:b0:3fa:8c68:4aba with SMTP id l2-20020a1ced02000000b003fa8c684abamr7857704wmh.25.1690796824720;
        Mon, 31 Jul 2023 02:47:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b0031433443265sm12556878wrs.53.2023.07.31.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:47:04 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725142703.157547-1-krzysztof.kozlowski@linaro.org>
References: <20230725142703.157547-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: amlogic: meson-g12b-bananapi: switch to
 enable-gpios
Message-Id: <169079682340.186625.9070463566453438311.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:47:03 +0200
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

On Tue, 25 Jul 2023 16:27:03 +0200, Krzysztof Kozlowski wrote:
> The recommended name for enable GPIOs property in regulator-gpio is
> enable-gpios.  This is also required by bindings:
> 
>   meson-g12b-bananapi-cm4-cm4io.dtb: regulator-vddio-c: Unevaluated properties are not allowed ('enable-gpio' was unexpected)
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm64-dt)

[1/1] arm64: dts: amlogic: meson-g12b-bananapi: switch to enable-gpios
      https://git.kernel.org/amlogic/c/01457f6fd40b45b6dd394c75317da812bf585a97

These changes has been applied on the intermediate git tree [1].

The v6.6/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

