Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49118769240
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGaJsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjGaJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:47:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABFA19A2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31771bb4869so4540148f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796827; x=1691401627;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asm9zeLSnj+DVNI/7QpgE3JFU76xoN5im/QuaTgnZIU=;
        b=z37yyX/XzZJlZeZ0lzPgzCwwAL4KvWqVFWgPuxUP4JivmOT3KEY5SrB3EqOjeCkZi2
         byQkVzj2GMQ0k7SrTsn/8gb9zydO866wgbTOZR9qDiezhMvm29h9cdWOJqumB4dCHVSw
         cYO1mZAGNrSh/dnRbaTxdOwRaAaz3FluTVhmnMczAxM/bp80pTeTneLD8XLxvsuD5xGd
         1CXphhUCDq/Vp7XWer5nS4dIUjLCqknd7piSejiK/18clTqs9Ovd1LQer/9SYR8+xN/N
         RC6Q9N3v69wbY7behpuj9wGVARrtPQ+XjsTkqnFXXz8eV38OFGC3tNqCKOmzubtVNW5q
         pmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796827; x=1691401627;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asm9zeLSnj+DVNI/7QpgE3JFU76xoN5im/QuaTgnZIU=;
        b=G2bse9q+sKYjcALbgUaGjF7BXJ3Maec+se+lL7xb7A3ST+DxYFUr0+IBKYqH9KVSn5
         F/r+6wAgJwavjc7C70XFVKrhlvhG9gvHq6K8QPXiS2NdzOo8zBVEzTGp3gvF90QYjGl8
         4GTStd2+q2h6zdP3A16dG8AntoCPDTAGSD18izCkVlGh+XjZpHUeVhbKTChOOz9cvNhf
         psZW53oqgjMIEmENdSq05SHQ9TgHVS1z4sKzpEdA4xJJHu1riBcAq+QobGWTo6GW+v8A
         olgr+1rVtVcABNbSgwFbE4FtV7K1JAsH+OV+zzDwppfnBeaZnd4JLqkU1SsDeToNZnkQ
         727A==
X-Gm-Message-State: ABy/qLbXNQk5pbsaaZyRk3bKzjCNvfQ11yVg871/woAdn4F+xh96lmbX
        LyOXfSBEAJYwUbQ3prILKwcscA==
X-Google-Smtp-Source: APBJJlExt1d8q52X9aHUegudjzzuNNSUxWFxlU+r81ID4axWBk68R+noqcm6gLP//X8Sel6ShEz8DA==
X-Received: by 2002:a5d:640f:0:b0:317:5d1c:9719 with SMTP id z15-20020a5d640f000000b003175d1c9719mr8738160wru.9.1690796827118;
        Mon, 31 Jul 2023 02:47:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b0031433443265sm12556878wrs.53.2023.07.31.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:47:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230706-topic-amlogic-upstream-dt-fixes-take3-v1-0-63ed070eeab2@linaro.org>
References: <20230706-topic-amlogic-upstream-dt-fixes-take3-v1-0-63ed070eeab2@linaro.org>
Subject: Re: [PATCH 0/3] arm64: meson: bunch of DT fixes, take 3
Message-Id: <169079682605.186625.9628829620831683924.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:47:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 06 Jul 2023 10:00:18 +0200, Neil Armstrong wrote:
> This is a bunch of fixes against the current applied and reviewed bindings.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm64-dt)

[1/3] arm64: dts: amlogic: meson-g12b-odroid-n2: fix usb hub hog name
      https://git.kernel.org/amlogic/c/6ae51d90457c93fb2e184ef02ea6f6bcf0199e4f
[2/3] arm64: dtb: amlogic: meson-g12-common: change aobus-pinctrl node name
      https://git.kernel.org/amlogic/c/7bb717411be07405cf750541b731f01fd2a1f8f9
[3/3] arm64: dts: amlogic: drop cooling-[min|max]-state from pwm-fan
      https://git.kernel.org/amlogic/c/cf4befdc463a32cb4a74ed4ca3ba60964e24f7b5

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

