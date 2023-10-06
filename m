Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFA7BB1AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjJFGn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjJFGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:43:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66694E8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:43:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40566f8a093so16083525e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696574602; x=1697179402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHZrwWZAfNjVWk4/AUcfESVqIawgSpGdGoZyI+1qlJk=;
        b=t9QcH4qBdqtSq3VV6Ja74dYsDOzK0D3mF/7SGn2FoA+3rVrWJcMu+5FHLdlYApr8DW
         6TT6qYyj39ktkWH7zPzYipvar42vXzs0Spk6DC86gqiyhvIqJ6a7ARoVWd4g36yJkCPl
         2/gvjntMgaUFG8VWpAUDJy9CwMMtU1MS8D8nX2ZFzezYGOnJrAFOdLxKXyAH+DcQNLJ6
         0FUpiEqjCEfnVwe/O48KwTXsn9MkQqgfaH3P2HZKfxrgYGEVaBfkSQY8Tet4Vv8Rn0y/
         SUJs+MKRPJm6URmATHoowVDplayNIpTi0eveK0s8xUD+yWinULtPPnB85RL5CJmNwyoB
         1KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696574602; x=1697179402;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHZrwWZAfNjVWk4/AUcfESVqIawgSpGdGoZyI+1qlJk=;
        b=whmd6fkjXcwZI7rLI4D/5C2LD8ZGT46q3ibtDVfMPs7a0VTd2RkVI5UgI0Ci8Zc6a7
         Mkvp1meHzfNBuJzNUOAeK129PYY7Zl637A+f0ml183Im5Hcg0gwR3zhyp4d2VyqEo0V0
         R7m3Jpd94XPsa/5J9M91ij9PoeNiG53j23GaedUep12VAe56zJYSQZX3/qCdyeNjmbbJ
         WfcmgSnqfSB87oJrHCxqLhMbY5qFbL34LWIQjdqln/EssfoOwgjbPNT4NEpFSarYhS9J
         4Mq/DXhVJX/9VfmgWj3kIY9KloJ742A8I09dbOxSt/wWS1OZrm9kCttL0D5UpeSMakJN
         4ARA==
X-Gm-Message-State: AOJu0YyGu7Ch1TTSOXQoiBKW7+hZg4jZwPYoxHXsmktj2HeND+ahfrZK
        sDmiA6sOz30vwzmgn8KUe4/wNA==
X-Google-Smtp-Source: AGHT+IEa9D6UEg8Kim6Z9RKpbqTF6yPxbwX33SKhKAYQuYTwCSxIBRvJ5CVQJEe4sosIQ6eGaegeiA==
X-Received: by 2002:a05:600c:b41:b0:405:499a:7fc1 with SMTP id k1-20020a05600c0b4100b00405499a7fc1mr6767148wmr.40.1696574601638;
        Thu, 05 Oct 2023 23:43:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id y24-20020a7bcd98000000b004064741f855sm3002073wmj.47.2023.10.05.23.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 23:43:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     olivia@selenic.com, herbert@gondor.apana.org.au,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, conor@kernel.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        f.fainelli@gmail.com, hkallweit1@gmail.com, lists@kaiser.cx,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alexey Romanov <avromanov@salutedevices.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel@sberdevices.ru
In-Reply-To: <20230929102942.67985-1-avromanov@salutedevices.com>
References: <20230929102942.67985-1-avromanov@salutedevices.com>
Subject: Re: [PATCH v5 0/3] Meson S4 HW RNG Support
Message-Id: <169657460045.2128575.14990345978498318753.b4-ty@linaro.org>
Date:   Fri, 06 Oct 2023 08:43:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 29 Sep 2023 13:29:35 +0300, Alexey Romanov wrote:
> This patch series adds hwrng support for Amlogic S4-series.
> Now, S4 uses a new random number generation algorithm.
> This changes implemnents new algo and also adds description
> to meson-s4.dtsi.
> 
> V2:
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[1/3] drivers: rng: meson: add support for S4
      (no commit info)
[2/3] dt-bindings: rng: meson: add meson-rng-s4 compatible
      (no commit info)
[3/3] arch/arm64: dts: meson-s4: add hwrng node
      https://git.kernel.org/amlogic/c/1e3dbe8006247386592a2fdce3a52cca15625997

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

