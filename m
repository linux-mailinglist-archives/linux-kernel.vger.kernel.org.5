Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A9379AD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjIKUzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbjIKJq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:28 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1CE4A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso73136021fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425582; x=1695030382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji7cbXQJKuEo0ewL5BwKdD6+HJSRYy2wv9gMLGPlepA=;
        b=hOnEE8b+idzGUiEBw4KrTQiXCAunUYYFBj6xCk6nr9W3oLCoF7QnyndOhlzH1Ukog6
         uBfIteQYpxp5xbRfS9NZo6h1A39sVW1kJkQI5NMRCCu31NTsmzbrlSRtQ60CiC5pCk5C
         xvulT6nKSVuCsqAEs4wXki1gZQJN6kmvQPvxfIrx1fEaFB9T/PhXv9Ur29T4KZpDvliN
         uAooGJTkKqN+pwjZCuu2efOZYXBjl8PK/Qz4IHeoCQkmVKxMKmh73LUMZzmDNqAtq/TF
         Z6mubu7zmTpfwpIgUORWCKoKA/WrgoB4BPoSP+PP5v3bZOHHDBTCRQ3iolmxaCXsx+ry
         l+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425582; x=1695030382;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji7cbXQJKuEo0ewL5BwKdD6+HJSRYy2wv9gMLGPlepA=;
        b=qmYSuqAnA4BX5pM4KrBgI/GxiCvUOTqHnaz3ABPeofWSwUbChWUuwGSlDtwSzarBnk
         +fCxvpRLmsYcrFpBM3jJHn9Fnf7Fv+t9iZxOZkaB/uYDDIuXzJ5CcZQxHJtaKZwTNmrm
         Awj/7Dqn0TU1JbMrSlqIWJiikzPqU9uhtsHgm6hRB4KjjZ38uZPxwoXqRxjH6U8O7eyR
         lK6zWxjBjM26efAzu/o/rTK00Eemi9i2dFEE1oRrf+9P+2HO1eOhi+4CdqEZbzDMJA1D
         z8qmwPkIUBZhkG13iYTCT6ezlIKMO5cOfCBUGsv+N5h7aqWYnLUKAoIWabXl00ZV/t4r
         Sq+w==
X-Gm-Message-State: AOJu0Yxrs8MRmsMz1IoXlihdjO6Dc92X7AeCTtwziJdGIBIpwbqWhazd
        YvLnY6eVB9IzpmfLAI8kqOyuVAjSPS5PJDrSMw7M79Ym
X-Google-Smtp-Source: AGHT+IGlNxjxG0h9WOgUYfP5hWmxCEiaQjt2o82oL1F/nht9wLOL5kF0/RgyR87mixTRPaq/opAWQw==
X-Received: by 2002:a05:6512:ba9:b0:500:a3be:1ab6 with SMTP id b41-20020a0565120ba900b00500a3be1ab6mr9050406lfv.6.1694425581969;
        Mon, 11 Sep 2023 02:46:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c205700b003fe1fe56202sm9439659wmg.33.2023.09.11.02.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        miles.chen@mediatek.com, martin.blumenstingl@googlemail.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alexey Romanov <avromanov@salutedevices.com>
Cc:     kernel@sberdevices.ru, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230830140850.17130-1-avromanov@salutedevices.com>
References: <20230830140850.17130-1-avromanov@salutedevices.com>
Subject: Re: [PATCH v1] drivers: meson: sm: correct meson_sm_* API retval
 handling
Message-Id: <169442558108.3235284.15250808268493542664.b4-ty@linaro.org>
Date:   Mon, 11 Sep 2023 11:46:21 +0200
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

On Wed, 30 Aug 2023 17:08:50 +0300, Alexey Romanov wrote:
> 1. Following the ARM SMC32 calling convention, the return value
> from secure monitor is a 32-bit signed integer. This patch changes
> the type of the return value of the function meson_sm_call().
> 
> 2. Now, when meson_sm_call() returns a 32-bit signed integer, we need
> to ensure that this value is not negative. It is important to check
> that the return value is not negative in both the meson_sm_call_read()
> and meson_sm_call_write() functions.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/drivers)

[1/1] drivers: meson: sm: correct meson_sm_* API retval handling
      https://git.kernel.org/amlogic/c/0d423c4a78984dd02f6596d6fd9dd40446eec517

These changes has been applied on the intermediate git tree [1].

The v6.7/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

