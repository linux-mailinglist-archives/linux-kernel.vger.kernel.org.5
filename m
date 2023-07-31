Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3814476923F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGaJsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjGaJrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:47:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69082199E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so39632245e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690796826; x=1691401626;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qx7Ls/SUOBXHVBMm8UX7N73qmM8FPDs70MQuXYK8erU=;
        b=JAdysYxRIWOzqApA2SmEt9RWP1U+gNpa3LGWAnRD1ZSpjjmjWF1rTf348gp25MwZTs
         eUhb1n9y3CMue2/wKWSGdmXmY+rhTeESB1stJ4bwstrmZ1bt9KsOA7FnXFAVDHVCjS/+
         NCYPny2e/JAvrc3JfSnm8Zem5wDEiK8onfu01IXtk4r55rTnKRwXVhj6TtcaRKs9nmOJ
         8UAdrsTnGpZQRMW8Re6aQT7kOkRK8/qObNnjUNxDqZBEsBcT0OV5Y5ch9xL5z5//ehyT
         d87jXIF7Jdr8n/K36BZDEW9Din2sDqATKOwyVBok62pVe9QOyePcHATrEEvBPRwsLfs5
         4SGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690796826; x=1691401626;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx7Ls/SUOBXHVBMm8UX7N73qmM8FPDs70MQuXYK8erU=;
        b=MA5Og2kkxwEHOxS93jPf+FAsiCq0fZdtPIEGOxwdyOi6pvAlvE332GKy25drAwG2Po
         zig/rjsYIRpF+TyNVJP93MYsd+pD5jbD7Hca4B8Wegnqlm6gSehSEF5z63LON6RZALr9
         ul21aYPD9kcr/jdhrGQ1JmTKlKE7R0ljNNP9pJCo+cIb5X6gOJPE0jeJnzojFijkTW7z
         /6WXJX7xx/zeeH+a+Uh6rvPM5ImljnPukw9aq3OU1fod//azAlLToiKryVTKTGfj/0g3
         R5E8RUH9FE0aPmvTYPH6RupTf/NAKgDoIZJBVW25EePeQ4FGTI9hcpsvxzYSmzjQpCSC
         U6LA==
X-Gm-Message-State: ABy/qLb+qySH4Su/l19zqU0wiqE7lZ/GfxfiLPjV5cS6vmka5KGtVbbM
        NFPNdlbSvJ7gvdA9ISmJ8+1xfg==
X-Google-Smtp-Source: APBJJlGMyipzlfbtXhIMjkoYwIcc3r5BAUwgU9QryvtjkDAzuhRSAYVeC8mZ1DYyi797G4rwyvzJYg==
X-Received: by 2002:a05:600c:230b:b0:3fc:e00:5282 with SMTP id 11-20020a05600c230b00b003fc0e005282mr6426612wmo.0.1690796825930;
        Mon, 31 Jul 2023 02:47:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d48c9000000b0031433443265sm12556878wrs.53.2023.07.31.02.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:47:05 -0700 (PDT)
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
In-Reply-To: <20230731093615.148949-1-krzysztof.kozlowski@linaro.org>
References: <20230731093615.148949-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: amlogic: drop redundant status=okay in
 sound nodes
Message-Id: <169079682486.186625.15061697732696889400.b4-ty@linaro.org>
Date:   Mon, 31 Jul 2023 11:47:04 +0200
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

On Mon, 31 Jul 2023 11:36:15 +0200, Krzysztof Kozlowski wrote:
> status=okay is by default.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm64-dt)

[1/1] arm64: dts: amlogic: drop redundant status=okay in sound nodes
      https://git.kernel.org/amlogic/c/3eced2a20ad5692af6f3f05e89a682c6378a7a74

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

