Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA6F79B985
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjIKUuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242597AbjIKPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:53:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B56198
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:53:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso4651639f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694447631; x=1695052431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3zHV6iao/svbvabAHUWRziqjkkVulJ/SFHDJG1zdw8=;
        b=Jo1Ez3MVKvg1qxcMEU5pA1KjKQ+RXNTPuCDGSWySWwGVifm9m3pPSGfGHe9//4vDMj
         KBlmdbEuvnGD4jb4Qsgf1M7pRsUx+MshbpHCjbWGvANGPCoGlvGPgvA9mMTX7qNhvifo
         Xo0KAUXBfywtLae4R3KS3QjdzLzgRQeBWliqwHiVjCzZMOT/9nK6mZkYAAJLinNapAnV
         hfYZ7HRJTHg+Dd5yYxGtB5bYSrzxTI/rtwuGeJYrMjXI7Uu28N++OVCHPMX86qdh+s8w
         GHqg7NpNKrOQ7vQVzFdYoIplw0WmH2+U6NxvBMf8QeiOJbMtpwE8UF94qmThlzxAVh1N
         2jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694447631; x=1695052431;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3zHV6iao/svbvabAHUWRziqjkkVulJ/SFHDJG1zdw8=;
        b=eXJSRkV7rpobHlOMPfyuc7gc6p+9JV62iy7Ab3SAKsuzLEcOtiHXyZOCnURP5TpQYd
         6tNyj53uAY0Eo6aLZV1U1iVJD9Y40EVsm0RRCkak07Fq+KGwGGP+YIKMeKZGy3iAgcLc
         LgtePh+kReCweWlJ27Zf0TOQQTNgLv/jNBLwTN+Km/RjWaDQXIcaYFTJoSUu7LeoHjwg
         Ph/0se6yJNaoAELJ9FVopZ32RcxBzYj8WbKdJT5R0n4odYt+KYMWm9fSlOXkxM5T+sWO
         xTI4ygnYGogdzFvz+1TJCdqmI/a4/chjphAaXc0D/vY4eJBgToLsotyApydyaBsonVxK
         OA8A==
X-Gm-Message-State: AOJu0Yxg+mN8nPtbqP/J2Yp1pPSrvkUVHvxchKgbxBLHVZUJqVNfntgk
        PaUt2RWuxtKeICwo1ri4RcRiKA==
X-Google-Smtp-Source: AGHT+IH9qzC3rYF8IeSOT1RPV7CsdG0ReQBfjcjNjLurVYgv7naSOiSTRp7oUKIY9gGW+TXEpd81cQ==
X-Received: by 2002:adf:de8a:0:b0:306:46c4:d313 with SMTP id w10-20020adfde8a000000b0030646c4d313mr7882614wrl.28.1694447630648;
        Mon, 11 Sep 2023 08:53:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b003fe407ca05bsm14047580wms.37.2023.09.11.08.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:53:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230911154541.471484-1-jbrunet@baylibre.com>
References: <20230911154541.471484-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/5] arm64: dts: meson: u200 audio clean up
Message-Id: <169444762970.3994411.2239837675633536062.b4-ty@linaro.org>
Date:   Mon, 11 Sep 2023 17:53:49 +0200
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

On Mon, 11 Sep 2023 17:45:36 +0200, Jerome Brunet wrote:
> This patchset fixes the recently merged audio support for u200 and adds the
> missing onboard audio devices
> 
> Jerome Brunet (5):
>   arm64: dts: meson: u200: fix spdif output pin
>   arm64: dts: meson: u200: add missing audio clock controller
>   arm64: dts: meson: u200: add spdifout b routes
>   arm64: dts: meson: u200: use TDM C for HDMI
>   arm64: dts: meson: u200: add onboard devices
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[1/5] arm64: dts: meson: u200: fix spdif output pin
      https://git.kernel.org/amlogic/c/66561cb158d0a25054bbcf423d59dd782311f60d
[2/5] arm64: dts: meson: u200: add missing audio clock controller
      https://git.kernel.org/amlogic/c/f9dc2d96e1bfb33635df7edf0a1b8572bbb20954
[3/5] arm64: dts: meson: u200: add spdifout b routes
      https://git.kernel.org/amlogic/c/4e47ea869289dab588c0152ec90d6eb5bf7f7169
[4/5] arm64: dts: meson: u200: use TDM C for HDMI
      https://git.kernel.org/amlogic/c/956236a24aec8364a3ee5d287e23c0c01cfb9c7c
[5/5] arm64: dts: meson: u200: add onboard devices
      https://git.kernel.org/amlogic/c/f1decbd5629bf0dbd3af3b2f803f72a27eb01c7f

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

