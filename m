Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6AD7F9B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjK0ITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjK0ITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:19:00 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21573191
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:19:06 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5098e423ba2so5611480e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701073144; x=1701677944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs07zuoQmAQlRSgbig0SCdsAbx9/nOr4gfcDOPBJj+A=;
        b=hEoezoIYrHIQnXHF6g7PR+aabNPKYDD/p8tELEkg6ooQz9dA/O2gRXeu+MMbmzwl47
         0uDXoXsfoZZg4IhTLBEfvCK4Swv84hWigQvRWaivq41Po/cVX5X5xzXCp5ldmBtm8ood
         C/dmW6UVBmLU/3OtWa+54/cwYRdu1INPYs0nVuWaMLHl6ag7TGg/Mfqr+a2ITv3YBf8S
         r/RTyzuTtcR1Kou+RgLQcUWghV8u+XVrzwu+VEqhC2dNVJfw79jpAUcPfD8CAtiHj4SB
         sEqYk/H3fUpUGhzh79Cx7CdqL25StV9LpcreLVBbQnvNE62cotCoVUEeegRSTyctCEkx
         hauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073144; x=1701677944;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xs07zuoQmAQlRSgbig0SCdsAbx9/nOr4gfcDOPBJj+A=;
        b=S6ZmQiiqGobk2f6VXfKcevA/yqJ29D8qXY6+OfUPGI+2L4YlHtvkPQ98L7v1jjdTel
         hq7J/3f1VywcAiq4/QFNgeGGwjaxPQVy/4Ub0tYWB0gSxsVPJ+9tyKrEk5TDDFaKAk/p
         KajC+zF4eqHRiBxKWa/831cJz2WhCaEti9oVWAd4e1PljB1UW8pOpJDDE/ETpaWSLzsi
         2qB9ut1ws/vTYmtdWMHo6Iek/CNP90o+TVP1/kR8Nwv6W//AOMwF4dmmyTEDuVX2JhCN
         /oN8GWfB1xT/LECqwwBKiVkxKZXGXxJwQlQz8yw/XKsFNftIYp4C4g8YquurqIcNpoZC
         ROIA==
X-Gm-Message-State: AOJu0YwYZUgS/a/gsvo5yvYNpVlFmEsYRg7aFBcd1n6WeHfdm2Bqq7b6
        kPDC8vvP84uTsmaxwXrvWMJzDA==
X-Google-Smtp-Source: AGHT+IGLBJFBAZK5eRCtgNcccOOkWkb/cH80/RtLQ3yUvcwtP6JjS3eHdJ6g8KAlW6EZ53bLEaIggA==
X-Received: by 2002:a05:6512:ad1:b0:509:46ff:6e57 with SMTP id n17-20020a0565120ad100b0050946ff6e57mr8815118lfu.8.1701073144477;
        Mon, 27 Nov 2023 00:19:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm13516568wmb.14.2023.11.27.00.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:19:04 -0800 (PST)
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
In-Reply-To: <20231109094504.131265-1-avkrasnov@salutedevices.com>
References: <20231109094504.131265-1-avkrasnov@salutedevices.com>
Subject: Re: [PATCH v2] arm64: dts: amlogic: meson-axg: pinctrl node for
 NAND
Message-Id: <170107314359.1083800.4264228970569502392.b4-ty@linaro.org>
Date:   Mon, 27 Nov 2023 09:19:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 09 Nov 2023 12:45:04 +0300, Arseniy Krasnov wrote:
> Add pinctrl node for the Meson NAND controller.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)

[1/1] arm64: dts: amlogic: meson-axg: pinctrl node for NAND
      https://git.kernel.org/amlogic/c/be18d53c32b2bbb211f4be599cafdb9d9ecab040

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

