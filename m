Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5379B4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377551AbjIKW1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbjIKJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A96BE4A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401187f8071so26232225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425595; x=1695030395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQuS2BsowzkIWazbpQjvlfNfkQEbmTp9QyiIj+7bzpE=;
        b=q9W3tzqpkq3o2DkIs7037oyM7IGIDDHbM5tD5iMFcVNZblG6H7PKtlEgK3M4zPIdsH
         FPXaKvQtfYgzEte3tkbzTwjdxEu+QvV1GgPxRUXwzEVUDFMSEP6jhpHT7sA4GdwWMvxn
         k+viEzCMVs7BnGrt21Lf4EUaKtQtOKNDPphgwsqeMIKXMbC9r3hEkUWXTbsjChb9nzlV
         Aj9D9H+cr7SPQfApiU7JNcjSAoBaPQqUDKx9quODTwkwhBs+k7IqXuIzjnMXh0rfUpn+
         jfEMUgrOQPFt+uFoQFIJK7wPjkYVA5H8+Em0f5/c5oiPig0Wc+wPSs3qu9oCENEB6iDg
         2o3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425595; x=1695030395;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQuS2BsowzkIWazbpQjvlfNfkQEbmTp9QyiIj+7bzpE=;
        b=kthLtlSJDRr4+tqhIjMuMIrvo7c6a7rQMfBtZRAzej1a9+MXOWDd3zWtFm/fn8CHY8
         Kh1ZOl3xbsuTjXQUuobnfMMXegnE9u4zjJtrUmcopgofAnVn5wllmrpaSDvM63wpFtjo
         IueWJdNLS3f9LsJl7jurGlwqcNUKaehkSvJSnDVgH7pre258pLvVMWAHUEJHOKuhaoGM
         5YqAo+1J6j0NB1U6RyyxYZpndYXcrg2JmmjwbA1d2SzO5pxlmCGgWfRmBuIvcZUgM2qp
         9uBvOtaYDjku+S6vs6lX/qojHDf0jHaRNM6RB72vRoLkRh7IIal9q5S4ekMrjsNJjiMf
         rG7w==
X-Gm-Message-State: AOJu0Yw6Jess9g5Kuj2sxLz8ed3DdE4UYxLSerDmoMNRqoVeLbe9UCqn
        yZqze9kI8eK4WTnW/lf5+UlMtg==
X-Google-Smtp-Source: AGHT+IE+dacoiI3EJshUztkwZYbtUVUfQH+ts8646ie2hzrqg4cqFndrT0+5nykG0OuaI8QpwY44mQ==
X-Received: by 2002:a05:600c:4f02:b0:403:aced:f7f4 with SMTP id l2-20020a05600c4f0200b00403acedf7f4mr839734wmq.12.1694425594969;
        Mon, 11 Sep 2023 02:46:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d13-20020adff84d000000b00317909f9985sm9503496wrq.113.2023.09.11.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        Liang Yang <liang.yang@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230828133647.3712644-1-avkrasnov@salutedevices.com>
References: <20230828133647.3712644-1-avkrasnov@salutedevices.com>
Subject: Re: [PATCH v1] arm64: dts: amlogic: meson-axg: Meson NAND node
Message-Id: <169442559402.3235506.17344571540273411910.b4-ty@linaro.org>
Date:   Mon, 11 Sep 2023 11:46:34 +0200
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

On Mon, 28 Aug 2023 16:36:47 +0300, Arseniy Krasnov wrote:
> Add description of the Meson NAND controller node.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[1/1] arm64: dts: amlogic: meson-axg: Meson NAND node
      https://git.kernel.org/amlogic/c/7ca2ef33179f4e1887727c1b5fac39721db8050e

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

