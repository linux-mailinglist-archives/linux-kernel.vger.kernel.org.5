Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985F477B43B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjHNIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjHNIeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:34:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E281410B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:34:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so37318585e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692002044; x=1692606844;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABhr9xdl4PfhPjffKylsEiPlhHM7MgFT5SzcRJwvV0I=;
        b=Og/oeYBwFfnwkMvs3RMniQ1vd1qkUXae3em95ns+AMfs77qsCMS/Zj3ulyEW9fvmqa
         0bTlH3G7FmRM010n1j7kfHDe966K52OXVkMZ7q+JyDNf8zdb3bGdrWBTH/elBCrqE6v7
         Ul85ERTI1jw1IFwcYom/5GiVYXf/Zs62nShzxXtPCjY4+FLsgSrzQDXKjvi3j+9Sd1E7
         7AaXS5apo29r7DDvGPFYw+zbvRAslZm9J0JYRZKg+SkxOi1gQIu+NWZ5lohqLbFECugg
         bCY1c6JdAiDpJSfNWqumKue4J/oYEOEkPiRc7kP+SPlrS1Q8Ik8tm4x8yOS9o8r9z6v2
         YZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692002044; x=1692606844;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABhr9xdl4PfhPjffKylsEiPlhHM7MgFT5SzcRJwvV0I=;
        b=T3kUxBw1ohSviF3NjyGVqgwAaAd6/Nu+8H3mXRotPgXWYJuYLbe181D6Nbj0IzCjM4
         +JwpBKCd3WcazHWKvIhy2k9fNzOMW4uEqPR1N9dIdLAD/gFmC8BRXVs9qiwx0lf4yANV
         FkpPu4Ll7sFaaGXVIfMaPFA2VAfNYUoxqXVj9LJC1alwiB3vMFZwstWiUG5mX4blH1mW
         o1mM1swM4fOQsF6hO8jJyohpr2+PGQ6BFNYcc9lVnpug3nhrEEgZPoaEIUFd6Y0/42RY
         brjOE4cK4VbFahIhu6prZAtHneX96JFys6HcZ2VztLdO4RgtqQr9/bFe7z7zgG4hRI3i
         iQ3w==
X-Gm-Message-State: AOJu0YyohodOxnoFQMgrvZ2vzTK5CG8y9Uu3udet6oa4OgKSZhONjqjD
        jZwAp9RmiebJxNTr+cMdLqQWOg==
X-Google-Smtp-Source: AGHT+IFNCyAF1MrzrZ7BRHwLfz2xysilZbSytC4O9Hi3KVeUcStr4Y3L/lZ+k3Zyl/e4twFEoScCXA==
X-Received: by 2002:a05:600c:2287:b0:3fe:1cd8:acf3 with SMTP id 7-20020a05600c228700b003fe1cd8acf3mr7321092wmf.17.1692002044384;
        Mon, 14 Aug 2023 01:34:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003fbc30825fbsm13767052wml.39.2023.08.14.01.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:34:03 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Andy Shevchenko <andy@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
References: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
Subject: Re: [PATCH v3 0/3] ARM: oxnas support removal
Message-Id: <169200204339.985309.9800197575088244365.b4-ty@linaro.org>
Date:   Mon, 14 Aug 2023 10:34:03 +0200
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

On Mon, 14 Aug 2023 10:19:51 +0200, Neil Armstrong wrote:
> With [1] removing MPCore SMP support, this makes the OX820 barely usable,
> associated with a clear lack of maintainance, development and migration to
> dt-schema it's clear that Linux support for OX810 and OX820 should be removed.
> 
> In addition, the OX810 hasn't been booted for years and isn't even present
> in an ARM config file.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git (v6.6/final)

[1/3] irqchip: irq-versatile-fpga: remove obsolete oxnas compatible
      https://git.kernel.org/narmstrong/linux-oxnas/c/33e839adabedb3a958efe5d974e38e868f7a8584
[2/3] dt-bindings: interrupt-controller: arm,versatile-fpga-irq: mark oxnas compatible as deprecated
      https://git.kernel.org/narmstrong/linux-oxnas/c/5f784ff8376dd519bbe317174972423508b627c4
[3/3] MAINTAINERS: remove OXNAS entry
      https://git.kernel.org/narmstrong/linux-oxnas/c/b1627ad5f457c8cea08bb2ab6b24d1c0381fbe30

These changes has been applied on the intermediate git tree [1].

The v6.6/final branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

[1] https://git.kernel.org/pub/scm/linux/kernel/git/narmstrong/linux-oxnas.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

