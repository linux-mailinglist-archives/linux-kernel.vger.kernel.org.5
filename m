Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF3A80C7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjLKLIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjLKLIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:08:13 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655FBC7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:08:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-33610bf5facso2102614f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702292898; x=1702897698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9DvPqcQlYaM5FUDcfAEhxk5sJCrCqHh00lsR9yPqOo=;
        b=oTw288hWDpXK1p0kZ+FFX6t8MIy7xtXaCdkOs+ybJK+4kOlaXKWKKsothEMagwzrfz
         ovsbJ3+M8umW4B7ke6FzIvQ3o0CzoOQm3pGn+E9B8bUUImC5GCYvGN44SItff29Q1XAn
         dzML6JzYZMPN9jEpwCD1139pvXX7HB8oudEV1RLNHn8xGaplDgKoY2JY0zJcV1SmdrQn
         TUMV3tgh8CrL0xCQ/JykKQF0luytOKsS7T3uW95beuzI61jMYm30YMEPloFyF8Bls2wB
         2SVLeX0PerFaRrr9oa/MctRcZc2v4hiYIQfY5ZanWVaYLi7U4PUmJwLUDUoqqff7sm0q
         eqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702292898; x=1702897698;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9DvPqcQlYaM5FUDcfAEhxk5sJCrCqHh00lsR9yPqOo=;
        b=LJMiLTwIqJtIuGvs5JAoR95BlzFMVeYZH1HXYaxiMdtzMs+EEqlw4VHo563AzGyMKa
         Y/MuM/ALSGBehnZNIeLW3HIYUZ2dfUYKAn0iH1b5/iz1oRZVFvRH8+xcXBLIVKvgCpvr
         3Jn11aJSDhnrzp4h94v5oZSk6OnwFVS5szEQ0365RBhFRRspVGciMLECb6hiFRhK0Em/
         kNaZp/a0ruTnz+4JMSyB0RciEhCsq3jFDrpjYjL1FlOyVGJwxvVY2mls9KeQ5Oq6bQ+0
         yPsTx+nVTNJuhXUpcS3jv/n4myA11X1WKXpmfh0Eh3710Gz++dHQc0Nic7GnIHaxZxkA
         jESA==
X-Gm-Message-State: AOJu0YzJl1Ob0JnvnnQUKuihf3TjArk2xHRjK3fuZznIDvEoxwT8Z6yp
        5jmTtNVA/BBa7TfxUvxKY+zKy1+n+GmMXitZaV9rh2Rn
X-Google-Smtp-Source: AGHT+IEvIQdNqsPU6Vrldb/k/LOO5TUqCUhZQ0MOdKli8Hxnu/yo/fE4DCDx+o9W17Y2lPOq6FJYYQ==
X-Received: by 2002:a05:600c:808:b0:40c:2aeb:c758 with SMTP id k8-20020a05600c080800b0040c2aebc758mr1980634wmp.119.1702292897864;
        Mon, 11 Dec 2023 03:08:17 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b004076f522058sm14981765wms.0.2023.12.11.03.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 03:08:17 -0800 (PST)
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
In-Reply-To: <20231209124401.93814-1-krzysztof.kozlowski@linaro.org>
References: <20231209124401.93814-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: amlogic: drop redundant status=okay
Message-Id: <170229289706.2547617.2484626300480503159.b4-ty@linaro.org>
Date:   Mon, 11 Dec 2023 12:08:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sat, 09 Dec 2023 13:44:01 +0100, Krzysztof Kozlowski wrote:
> New device nodes are enabled by default, so no need for status=okay.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)

[1/1] arm64: dts: amlogic: drop redundant status=okay
      https://git.kernel.org/amlogic/c/e3c58a44ea7daef26c8c53c93489888ac983f327

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

