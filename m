Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05167BB1AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjJFGn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjJFGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:43:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C4EB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 23:43:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4064867903cso17129345e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 23:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696574603; x=1697179403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHU0p37PqytyDnl9AN/GlxDTVLGaz1pQ2WVuhuaUWKs=;
        b=s4Z7RmXV6lFDFsiq3ERrQ7g5uHMSnQkSZpvHOYIK92p6u5iuB8LAAp5WsE2GXVzTiS
         FnssWNngP9uofqOHA2bYTpNFl8YV6zfui7hY8mbzFBC5qSs908UiAwRr4G7jMGVGBNpP
         LKuGm/7GqZaI2fhxdMaF9MMyr/OpWnCBu/+2VIG3/6xq6kZfrkq4iLW8IXL3NHWghXXq
         s5ET8bBXM4iPppCmweX/1tROCTGxtnzNlciCSMybvaJ2t6NWM1rolXVGBLKPQ7SYHG8S
         iCeaKq8a6kncXRIIeEBNeIlZOTNVuxvkyVdDDyAUQFhp0Dg4BwhV9IReXlGGHCFih7L/
         U5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696574603; x=1697179403;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHU0p37PqytyDnl9AN/GlxDTVLGaz1pQ2WVuhuaUWKs=;
        b=WxNNXfCG+713APlOaGCpE4fvLHz+MpvAqnn4r7fSfHCLtUKMaH8E0Hy2FGzeogfZTw
         7ctIWfei7ClFJpaT0EC5GoqDFpFaiOmCpUjBRrQZeASCSiV9pdOuR8BLFjYzuiim4evd
         b52NuXcWXrUSpoL2q8D20au3rAETfY4HkTlGclYNYkHnI3+mNlu5dELHwweuZT4HPm5t
         m+7u0Vr5vKTj3IyiluYUmzu8OQ/R2JwQQ1smHpqkVRVNm8D5RBu8CAJNKcTycZz6BN3q
         mLa52XLDuAlc4yY4O/aOJk70S64Cf8U9J6pskX5gdTJr5AooxAOQwLuWfb7SdH0Yi7WG
         IhdA==
X-Gm-Message-State: AOJu0Yy8jgZsC5iuDizuBFgN8TT+CcGmbqJhHqFBk7XgfNhKjmdaDlEH
        YlqI/prrGN9or3Ic0nViZd6Bsw==
X-Google-Smtp-Source: AGHT+IGFjacFMG9oC4/CF6EjUVpWFzI0wzWd107RtpaewVuO/PTRmrBZuqIV61r7/hB5J8ky7lhDzQ==
X-Received: by 2002:a1c:ed17:0:b0:406:7d74:a29e with SMTP id l23-20020a1ced17000000b004067d74a29emr6809182wmh.19.1696574602628;
        Thu, 05 Oct 2023 23:43:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id y24-20020a7bcd98000000b004064741f855sm3002073wmj.47.2023.10.05.23.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 23:43:22 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Igor Prusov <ivprusov@salutedevices.com>
Cc:     prusovigor@gmail.com, kernel@sberdevices.ru,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231005195543.380273-1-ivprusov@salutedevices.com>
References: <20231005195543.380273-1-ivprusov@salutedevices.com>
Subject: Re: [PATCH v1 0/2] arm64: dts: meson-a1-ad402: Add SPIFC pins
Message-Id: <169657460179.2128575.1714588194034072969.b4-ty@linaro.org>
Date:   Fri, 06 Oct 2023 08:43:21 +0200
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

On Thu, 05 Oct 2023 22:55:41 +0300, Igor Prusov wrote:
> This series adds SPIFC pins description to A1 pinctrl node and selects
> them in AD402's SPIFC node to make sure that muxed GPIO is properly
> configured.
> 
> Igor Prusov (2):
>   arm64: dts: meson: a1: Add SPIFC mux pins
>   arm64: dts: meson-a1-ad402: set SPIFC pins
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[1/2] arm64: dts: meson: a1: Add SPIFC mux pins
      https://git.kernel.org/amlogic/c/4985d0b308eeec44d2563d7c9d4884bc382d01de
[2/2] arm64: dts: meson-a1-ad402: set SPIFC pins
      https://git.kernel.org/amlogic/c/b50944fe2234a175ace253ed05dfae10caa49566

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

