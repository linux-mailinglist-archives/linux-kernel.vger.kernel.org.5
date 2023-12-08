Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980F80A730
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574266AbjLHPSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574257AbjLHPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:18:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5967D198D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:18:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-334b2ffaa3eso2127820f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702048715; x=1702653515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDJhAtFw7QNuGAGl9H/scPLTNO01fU317zwwAd+ymrw=;
        b=cmCicHumTHfM7XCA1bEP2Gwczj6mieywO8Gzo/EamozAXRhnhgoyFWNuJ1YIeX4jIp
         6KtLV4xAzhuaXGsljiyfwMOz8+RcPZilwQIZAIcOtHO+N1UIfUFRjcPKOf6Rq4PS7aN/
         uC1hDnYxZz1DcRxgjSw/nKhUPI5ghgtFASVvLvUwNLiedyX6Z6eUX9WYCP1dBaQZsM1W
         Ms9tkY/ESqUBt+LmxKLakwq2V/KtyphfLhIV2sv9ulDutUO0qNuxwMm5lgjUmjligzwp
         6w8w1XZOc2XQLNTrfJqwhQVwoOjFw0BPYXunf9KbmcB+6arpLdwXqdR1d6TAfGUeHQbC
         nI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048715; x=1702653515;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDJhAtFw7QNuGAGl9H/scPLTNO01fU317zwwAd+ymrw=;
        b=uAxReCvTYSKv9Na/T4JORDlAymw9IJG7EYd7++HXoxwjdmEmFq7zhqaUNrNjkSpUMN
         SWo1fkjWNH/AFAR/zZVQt5fLNNq6g2gH9mPyvLRp7vOPQziI/tvO46FhdVk+9GGBxVxK
         gxJI/ub8CXt9lMrnAFu4HoCbWLvDMOXG0etJydgUcAECVLPWtkeBwgKbLNWadnyMzam7
         ERS9ifawh+24EQjpiF64YAbesOJasiEev3nGNsbfaz+lo6AQeILjkuTfsMuvnyBnRvnH
         PzJmgKNyYXnODBz+vRzCK9zVyq/t1OkwODJylYN6U5lF395htayV2Esx1AwkNFfvaGPX
         CFZA==
X-Gm-Message-State: AOJu0Yy16W9Ql94MXCekz1YQGWs4ZxiaS8Je2VIuClJNt5u9hop7N3Hj
        mygL6oTSChV4PeJUrJnRXvEmmA==
X-Google-Smtp-Source: AGHT+IHVtfBSS4vVLH0cQZZ6RumcjOm6eQYQHcCnYJmcBF3hWLk80BVJqfp3DxIT5UGF1ixTnh6a3A==
X-Received: by 2002:a5d:53c7:0:b0:32d:87c8:b548 with SMTP id a7-20020a5d53c7000000b0032d87c8b548mr111329wrw.21.1702048714704;
        Fri, 08 Dec 2023 07:18:34 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b00336103442d2sm825119wru.76.2023.12.08.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:18:33 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231208-s4-dts-v2-0-5a93fa356c5d@amlogic.com>
References: <20231208-s4-dts-v2-0-5a93fa356c5d@amlogic.com>
Subject: Re: [PATCH v2 0/2] Add some devices nodes for S4.
Message-Id: <170204871348.55256.16571594130908656997.b4-ty@linaro.org>
Date:   Fri, 08 Dec 2023 16:18:33 +0100
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

On Fri, 08 Dec 2023 15:16:25 +0800, Xianwei Zhao wrote:
> Add some device nodes for SoC S4, including periphs clock controller
> node, PLL clock controller node, I2C nodes, SPICC node, NAND
> controller node, Ethernet MAC and PHY node.
> 
> Add reserved memory for board AQ222 which is used by ATF.
> Enable NAND, SPICC nodes for board AQ222.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)

[1/2] arm64: dts: amlogic: add some device nodes for S4
      https://git.kernel.org/amlogic/c/528016cd2b52001564792c4a68483d44a6fbedad
[2/2] arm64: dts: amlogic: enable some nodes for board AQ222
      https://git.kernel.org/amlogic/c/66fdf773ccffcb5b6673f0a5b6693739e33b5181

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

