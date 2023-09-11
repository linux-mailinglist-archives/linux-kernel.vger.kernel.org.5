Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1FF79B4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjIKWiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjIKJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB4E4A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401f68602a8so46049555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425592; x=1695030392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cYuBqqKCr61kF+J0qE32P8LtYpg7LF8EeE5e0c2/vM=;
        b=scTgVjl2fUFekfxFJ1Pyi7jLCxAF+wDLcR3ThvbLUyS1KajGdJE3pDheyMWTdoblWP
         pDZFJhMIhhjTvLnttqxuOcyrANd6dzKVpWluLMsBjwlX4sUlrDGwf8DN84h8p7nayYhO
         NEZgvBGxcxGMApXwDMNEev9y9rC6vmEajY9iPnlgDapmeeH+ESA2yBYhqjjmM8m8l71m
         JmQsg1kRdWmGMNtNFEiFCtk0N8AMbE5R0YnmCk2so0N5+lf4Z/t6XZ3VExPnCu/ZqpAN
         dtfuaO+eHE9N3MKfMe0yq7mo2Lb4hBEic2q+7PHMmbJsg+zx/yKQgpXBZSoAhJV67rvU
         0HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425592; x=1695030392;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cYuBqqKCr61kF+J0qE32P8LtYpg7LF8EeE5e0c2/vM=;
        b=tXllUj5wsbGlTDuAMldUME11BKZy0a7ExfSPwHGjOe4GFFE2aEAYJhcCrQw3H6MpbP
         o6TnZ2IQsE66bbG7xoUUOKMyzYje036TYlxoC5ZfTanscSBHBdGe+fSc6wPizcPAxzg4
         bfiV7YXtMk/SWXA0Mp33KDIbwK1eV2MCu06tMA2UX4CsRRJhnSykVLs48ZmgNycx82VZ
         73Z+Y2nhVnvxHha1OFoyd4kCA8qWzpkzs7r8MZFIjLkc9kHkTVvYO/+v4VfgrNCcPIBX
         AAwomjyGPED3+BlM/AdZZI86E+xg4brYChE0u5GWuV7tb8lQPpBnVVz+4mAliNJPBEpI
         5S+w==
X-Gm-Message-State: AOJu0Yz0wOyo4Vi0ysUCNpvib9kLHlIro9lWYhwSIfKZsiQjeHZ76/Cq
        ZjbQglxZOHBDk0OQPrJyolnarQ==
X-Google-Smtp-Source: AGHT+IF6Db7IOiAAxmcutp4cngm1dQLW31BDJ9vfe4xSUzSt9h7ay34mes/ebYDzWk0PZc1lOgJSnQ==
X-Received: by 2002:a05:600c:2a50:b0:402:bda9:74d1 with SMTP id x16-20020a05600c2a5000b00402bda974d1mr7609095wme.8.1694425591809;
        Mon, 11 Sep 2023 02:46:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d13-20020adff84d000000b00317909f9985sm9503496wrq.113.2023.09.11.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:31 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230815092751.1791195-1-christianshewitt@gmail.com>
References: <20230815092751.1791195-1-christianshewitt@gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: amlogic: add more basic audio support
Message-Id: <169442559097.3235506.12459574457912854518.b4-ty@linaro.org>
Date:   Mon, 11 Sep 2023 11:46:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 15 Aug 2023 09:27:48 +0000, Christian Hewitt wrote:
> This mini-series adds basic audio support to the P200/P201 (GXBB) and U200 (G12A)
> reference boards. Few people likely have the original reference boards which have
> extra audio capabilities, but the device-trees are widely [ab]used by users with
> Android set-top boxes whose hardware is copy/pasted from the reference designs to
> get working installs. Adding basic audio support does no harm to the real boards
> and helps the secondary cause.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[1/3] arm64: dts: meson: add audio playback to p200
      https://git.kernel.org/amlogic/c/61373cc074128c40d53857803371c4a9384d4200
[2/3] arm64: dts: meson: add audio playback to p201
      https://git.kernel.org/amlogic/c/2b2827a19024abcf879c18053ae3f2fc23891ad4
[3/3] arm64: dts: meson: add audio playback to u200
      https://git.kernel.org/amlogic/c/cfae4eadb7cd44cb5f17285e18477bed4ae5f03c

These changes has been applied on the intermediate git tree [1].

The v6.7/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

