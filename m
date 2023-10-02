Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4497B4C04
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjJBHBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjJBHBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:01:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9757D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:01:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32799639a2aso1280922f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696230061; x=1696834861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED3nCHgOaahRi3tOePbQGBavpIZHiHZhel+Y9Fp/+p4=;
        b=wfBzL7Ar2gTHJL2ZtNQpNlK4DtZeN0aZIUaM1VD7ZCijTn/jmoJ4G0VQGcGi+tei2j
         +DQAhY2DLxm0AoAH1cyzI2xIViUhHHWGlFtLPw689VlirZrGS+gI2ysKJ1m8nzQkoIae
         iqf9klJp2tPBMWDCphVhxWpEpvOyuovxQ/pbOeBdqnwAtZGnYhPn6HRPAOIw2TR4ka0E
         9KFwKKFOKBlVTH1aIx7Yq8WifNfWyuR5kI7TJLUf59WX5GYvfgr7EV6XjgTJsxP7bS7w
         coYUWlpU73/wn9AAM8gJV5WcIE7mexGPN8xJYDoqwcOJ35wKTrelkVZVyz5h6F6rxa4K
         0n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696230061; x=1696834861;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ED3nCHgOaahRi3tOePbQGBavpIZHiHZhel+Y9Fp/+p4=;
        b=dwz4y2WS8Vi1FISJiq31aA5KIGD4rzP7JP4C6/DyogokNRdJ9Rr+0+8j3mQbqUfP2i
         sFVig/90XWlK6XJQq78KbiXAFJ9gR8JNqpNWY/UY6jTd6GyApXh7hAWCGlmSLKyy8m3D
         YbhEmg3/T2HDXJ0o2ioyo2GTXfumivWgmOOm829Y48oEJbqHhBVe4QPmbd/T22zxpkxi
         aEXVhr0xn+iOBt62jSfmzrqG8RC+yNCvizBeVMiKXnDAq+pEJ3LuuDuknP9xZ/thbgz9
         lGrQByatR5kZfqZTZs0AuDYLXIB41KBvFtlgi+k3kVAMfcGHOeaaKuIuvWLeqtpIQCBG
         XLOQ==
X-Gm-Message-State: AOJu0YxFrcr00i/uADdJ0tyP6a/srIwEerE195vslFn4LYG3dUxDLpWw
        tApmbxE0Z6ILm4hln71r+tzsLw==
X-Google-Smtp-Source: AGHT+IHnVHHnTOhtd/Btr60iU9/eHOnkZf9kPsbDDvwF0leE0UE71ygHUrODFNhJf2LGR0NcKfWECw==
X-Received: by 2002:adf:e48e:0:b0:317:67bf:3376 with SMTP id i14-20020adfe48e000000b0031767bf3376mr8843141wrm.57.1696230061171;
        Mon, 02 Oct 2023 00:01:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id r17-20020adfda51000000b00327c79ca7c6sm2440715wrl.80.2023.10.02.00.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 00:01:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, brgl@bgdev.pl, andy@kernel.org,
        Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230922094342.637251-1-huqiang.qin@amlogic.com>
References: <20230922094342.637251-1-huqiang.qin@amlogic.com>
Subject: Re: (subset) [PATCH V3 0/3] Add pinctrl driver support for Amlogic
 T7 SoCs
Message-Id: <169623006024.3465675.18368876466117698542.b4-ty@linaro.org>
Date:   Mon, 02 Oct 2023 09:01:00 +0200
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

On Fri, 22 Sep 2023 17:43:39 +0800, Huqiang Qin wrote:
> This patch adds pinctrl driver support for Amloigc T7 SoC (A311D2)
> 
> [PATCH 1/3]:
>   V1 -> V2: Rename amlogic-t7-gpio.h to amlogic,t7-periphs-pinctrl.h
>             Corrected indentation format.
>   V2 -> V3: Updated subject.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[3/3] arm64: dts: Add pinctrl node for Amlogic T7 SoCs
      https://git.kernel.org/amlogic/c/d0f3a19a990a8fde6a7730255af74ef8d70c3761

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

