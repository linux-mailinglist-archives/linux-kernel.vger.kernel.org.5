Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B27ED5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344870AbjKOVYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:24:07 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2F92
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:24:02 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d0f945893so991036d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700083441; x=1700688241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAMTI965yKRymeplVxBCZKMPT9nQRVKnmgoIwdtDSmk=;
        b=Pnqm4iTI087dHfvyTSuWs8z5/n9x+gvxpaj4AjZtUBgNfATO2vSZy8jPo8Ulv77i6v
         YIxq2hNXR9kc0PD4ZVgaN5xWiAhxk4yeHyM2lxe3g1elBja5GQGYxJTVWfxqmgGbrFMs
         UhSMGqlU5vf4gBkmcXRUGUsqFXH0Xsu3chwlKmOrgX+S0z4M0lp5GsfBLLojOD9KaZl6
         a4UD1cq580KrrwRvHhomTxoKtCvcXcsTxrbRn/XjYKleuDRrpVmI92wcOa+jTzuXBkmc
         rFozNY14Nexga8ejorkI3uu8KUmhyJIW8pkKjgI6uZv/nAz1tSHGWs5+J9jPTC97xec9
         9KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700083441; x=1700688241;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAMTI965yKRymeplVxBCZKMPT9nQRVKnmgoIwdtDSmk=;
        b=jBYX4Ve5bLxRiu/PDQQfFdyv7kcsg0VlKLZ8F+lAWmdecgnUiPC9MxqQusH9r1xMFH
         ET/ToPIp98BTboE6jwAPCCOc5FseH9MEFK+Tkk1KL4nGwrAqzztZAWoW1zlTNcHcntMD
         /wdsYqNVrYIKBShm0TAu5FVFpZ0Ur2JD6/RW+qYB8aBWA3QgarhT0LztN1G93wIPC1zz
         amYbAdpWa+blOHfl2uA6I+IETmwcXtVbgmNxIt8Si+oMqKbdT1NWwAShiIRECcg+k4ru
         lCvkf61bGzC6W9XNrLBQEGq4z7sCwpmdNUT6o3QzED4ymWYWntJB4E5YrX5l4HuAuAdz
         PT+Q==
X-Gm-Message-State: AOJu0YyhYweqqyse8Jg5vI7TusOkwscsxFTtIqSI5/ln7srYtd5v0Qut
        yqFo4RpsfRG8PJQl+7hxnq8vFQ==
X-Google-Smtp-Source: AGHT+IGzygePpmpcWGYG8kJpIBOhG7+gdAgRPvmdp1e3CnzqNyv/Q4OjXwT9P+NL+dlHZ7YhuIa7eA==
X-Received: by 2002:a05:6214:1706:b0:66d:6a92:16c2 with SMTP id db6-20020a056214170600b0066d6a9216c2mr11586371qvb.8.1700083441639;
        Wed, 15 Nov 2023 13:24:01 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id t18-20020a056214119200b00670e0f71ff7sm843262qvv.90.2023.11.15.13.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:24:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230722121719.150094-1-krzysztof.kozlowski@linaro.org>
References: <20230722121719.150094-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/3] ARM: dts: samsung: exynos4x12: replace
 duplicate pmu node with phandle
Message-Id: <170008344099.8771.17170805240532407985.b4-ty@linaro.org>
Date:   Wed, 15 Nov 2023 22:24:00 +0100
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


On Sat, 22 Jul 2023 14:17:17 +0200, Krzysztof Kozlowski wrote:
> Devicetree for the FIMC IS camera included duplicated PMU node as its
> child.  This is not a correct representation of the hardware.  Mapping
> the PMU (Power Management Unit) IO memory should be via syscon-like
> phandle (samsung,pmu-syscon, already used for other drivers), not by
> duplicating "pmu" Devicetree node inside the FIMC IS.
> 
> The change is not compatible with older Linux kernel, which does not
> parse samsung,pmu-syscon property.
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: samsung: exynos4x12: replace duplicate pmu node with phandle
      https://git.kernel.org/krzk/linux/c/797bf47d8a42792762cfc74dc84109d6d893ddf2
[2/3] ARM: dts: samsung: exynos4: fix camera unit addresses/ranges
      https://git.kernel.org/krzk/linux/c/ba2a45a48503665f7e8eeec51f8b40456566b0cd
[3/3] ARM: dts: samsung: s5pv210: fix camera unit addresses/ranges
      https://git.kernel.org/krzk/linux/c/07e6a553c2f1d385edfc9185081dee442a9dd38d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

