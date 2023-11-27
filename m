Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8917F9B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjK0ITF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjK0IS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:18:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2564813D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:19:05 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso47819231fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701073143; x=1701677943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wu9Mk96O+s9apHEY/wkOo5PiW0m4TNq81XUGjVgZkHY=;
        b=m9SsTyS0s98aHV8ln25YF0JT75N1DxEPM/fBaV5kPlLTgSd4CyS60U/lhKHUFCnqNv
         +DDln2LB7M9cKUtxEwenL+u6Z0VlFU76jWFhGVQFFDQI5aCbrC7RJ2PRaolMhR4dgMvB
         X5VpMRQlwKnDG7HqpTIRa2IwfK8iHf3rMFoGqfom5dMdFo7v8q6EYN3fhEAoetxPDNJ0
         MvTfM11jhDpppWr/YeGHlep6zWgeyVBlZDtlgHnhozN8SDCOWejt/ce2WVlN7XyHlKNv
         CVOl1XUQtmqOFR/ry3KvmslqS97+VDu7Iu/IOfmrDEczYgKRm+lxpVVP1ChoUyXLfBbb
         lOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073143; x=1701677943;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wu9Mk96O+s9apHEY/wkOo5PiW0m4TNq81XUGjVgZkHY=;
        b=ijGxxQzmhqQ0ndP/8DMBqvFk5qy8xPIYRDal0+Rif2VCfY8Dk78oTNKGDObPR1f09c
         5+eIdeb9GcbFjvmbUPHlBcjv/r99UuT4pDn0ttFv5Ztxqx88q7H9ODQzoVFuJzCEtF2z
         4BX2pRTqJjhGdBusSpRusszNIumdsMpxhRkokZrY76DKUPiwmI+S9Fa9c4kjXwO2iQKs
         FvU/EMeZf+QOh4t02YUZCaMcc5PtpT4WEysIzcNeE6UjYN35y0gLAnjVMPYNoxMc9C2L
         VYVWlwVqjqFe09iiHt+OdWnfjFzqsE9KImw2+6e4+0EQGrnvk6qMQW3ABAM8uQ/24Dsy
         9eKQ==
X-Gm-Message-State: AOJu0Yx5/z8RzqEPMyx/OKR9BbxPHJ4VmqEq6MZf94lby78X7WUhhhVM
        o5hQcVf1m7g52oBeQfQg22we0Q==
X-Google-Smtp-Source: AGHT+IGDxcSkbC3AUO/tKAy4+hS1vqUZ4qPAywCnudeSjQUPPsFylnyIVh+mXWyWIPbyzr0UEtVDmA==
X-Received: by 2002:a2e:9d8c:0:b0:2c8:744e:dced with SMTP id c12-20020a2e9d8c000000b002c8744edcedmr6794598ljj.35.1701073143490;
        Mon, 27 Nov 2023 00:19:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm13516568wmb.14.2023.11.27.00.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:19:03 -0800 (PST)
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
In-Reply-To: <20231124094700.58071-1-krzysztof.kozlowski@linaro.org>
References: <20231124094700.58071-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: amlogic: minor whitespace cleanup around
 '='
Message-Id: <170107314264.1083800.3287643351535378638.b4-ty@linaro.org>
Date:   Mon, 27 Nov 2023 09:19:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

On Fri, 24 Nov 2023 10:47:00 +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)

[1/1] arm64: dts: amlogic: minor whitespace cleanup around '='
      https://git.kernel.org/amlogic/c/35b47cefe8955f4c34fe45e5a06cb3376d6a8aa6

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

